Date: Thu, 19 Apr 2018 16:07:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: DaeRyong Jeong <threeearcat@gmail.com>
Cc: Byoungyoung Lee <byoungyoung@purdue.edu>,
	Kyungtae Kim <kt0755@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>, basavesh@purdue.edu
Subject: Re: KASAN: slab-out-of-bounds Write in
 tty_insert_flip_string_fixed_flag
Message-ID: <20180419140751.GA19001@kroah.com>
References: <CACsK=jfSRSLYvPJKzFrRQgNa10DsF8xLLKGYfqqE_hF9ucX-yw@mail.gmail.com>
 <20180419081735.GA28287@kroah.com>
 <CACsK=jfmwcLA9bsPAPEgvg72C2Cpc-U1oGhi+fO-rN543RKUbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsK=jfmwcLA9bsPAPEgvg72C2Cpc-U1oGhi+fO-rN543RKUbQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 09:25:08PM +0900, DaeRyong Jeong wrote:
> The patch is attached at the end of this email and can be downloaded from here.
> https://kiwi.cs.purdue.edu/static/race-fuzzer/tty_insert_flip_string_fixed_flag.patch
> 
> We applied the patch to v4.16 and tested our reproducer. we can't see the
> crash any longer.
> 
> Our rationale is
>   - Since tty_wakeup() called by __start_tty() sends frames, call
>     tty_write_lock() before __start_tty().
>   - Since tty_write_lock() might sleep, locate tty_write_lock() before
>     spin_lock_irq(&tty->flow_lock).
>   - Since wake_up_interruptible_poll() is called by both tty_write_unlock()
>     and __start_tty(), Prevent calling wake_up_interruptible_poll() twice by
>     adding the wakeup flag to tty_write_unlock()
> 
> If there is something that we are missing or we are wrong, please let us know.
> 
> 
> Thank you.
> 
> Best regards,
> Daeryong Jeong
> 
> 
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 63114ea..09c76d3 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -873,13 +873,15 @@ static ssize_t tty_read(struct file *file, char
> __user *buf, size_t count,
>   return i;
>  }
> 
> -static void tty_write_unlock(struct tty_struct *tty)
> +void tty_write_unlock(struct tty_struct *tty, int wakeup)
>  {
>   mutex_unlock(&tty->atomic_write_lock);
> - wake_up_interruptible_poll(&tty->write_wait, EPOLLOUT);
> + if (wakeup) {
> + wake_up_interruptible_poll(&tty->write_wait, EPOLLOUT);
> + }
>  }
> 
> -static int tty_write_lock(struct tty_struct *tty, int ndelay)
> +int tty_write_lock(struct tty_struct *tty, int ndelay)
>  {
>   if (!mutex_trylock(&tty->atomic_write_lock)) {
>   if (ndelay)
> @@ -973,7 +975,7 @@ static inline ssize_t do_tty_write(
>   ret = written;
>   }
>  out:
> - tty_write_unlock(tty);
> + tty_write_unlock(tty, 1);
>   return ret;
>  }
> 
> @@ -997,7 +999,7 @@ void tty_write_message(struct tty_struct *tty, char *msg)
>   if (tty->ops->write && tty->count > 0)
>   tty->ops->write(tty, msg, strlen(msg));
>   tty_unlock(tty);
> - tty_write_unlock(tty);
> + tty_write_unlock(tty, 1);
>   }
>   return;
>  }
> @@ -1092,7 +1094,7 @@ int tty_send_xchar(struct tty_struct *tty, char ch)
>   if (was_stopped)
>   stop_tty(tty);
>   up_read(&tty->termios_rwsem);
> - tty_write_unlock(tty);
> + tty_write_unlock(tty, 1);
>   return 0;
>  }
> 
> @@ -2395,7 +2397,7 @@ static int send_break(struct tty_struct *tty,
> unsigned int duration)
>   msleep_interruptible(duration);
>   retval = tty->ops->break_ctl(tty, 0);
>  out:
> - tty_write_unlock(tty);
> + tty_write_unlock(tty, 1);
>   if (signal_pending(current))
>   retval = -EINTR;
>   }
> diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
> index d9b561d..f331e99 100644
> --- a/drivers/tty/tty_ioctl.c
> +++ b/drivers/tty/tty_ioctl.c
> @@ -911,12 +911,17 @@ int n_tty_ioctl_helper(struct tty_struct *tty,
> struct file *file,
>   spin_unlock_irq(&tty->flow_lock);
>   break;
>   case TCOON:
> + if (tty_write_lock(tty, 0) < 0)
> + return -ERESTARTSYS;
> +
>   spin_lock_irq(&tty->flow_lock);
>   if (tty->flow_stopped) {
>   tty->flow_stopped = 0;
>   __start_tty(tty);
>   }
>   spin_unlock_irq(&tty->flow_lock);
> +
> + tty_write_unlock(tty, 0);
>   break;
>   case TCIOFF:
>   if (STOP_CHAR(tty) != __DISABLED_CHAR)
> diff --git a/include/linux/tty.h b/include/linux/tty.h
> index 47f8af2..5bdf928 100644
> --- a/include/linux/tty.h
> +++ b/include/linux/tty.h
> @@ -458,6 +458,8 @@ static inline struct tty_struct
> *tty_kref_get(struct tty_struct *tty)
>   return tty;
>  }
> 
> +extern void tty_write_unlock(struct tty_struct *tty, int wakeup);
> +extern int tty_write_lock(struct tty_struct *tty, int ndelay);
>  extern const char *tty_driver_name(const struct tty_struct *tty);
>  extern void tty_wait_until_sent(struct tty_struct *tty, long timeout);
>  extern int __tty_check_change(struct tty_struct *tty, int sig);
> 

Can you please submit this in a form that I can properly review it and
apply it if needed?  Documentation/SubmittingPatches has all of the
details.

thanks,

greg k-h
