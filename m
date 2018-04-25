Date: Wed, 25 Apr 2018 14:53:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: DaeRyong Jeong <threeearcat@gmail.com>
Cc: Byoungyoung Lee <byoungyoung@purdue.edu>,
	Kyungtae Kim <kt0755@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>, basavesh@purdue.edu
Subject: Re: KASAN: slab-out-of-bounds Write in
 tty_insert_flip_string_fixed_flag
Message-ID: <20180425125308.GB30021@kroah.com>
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

<snip>

What ever happened to this patch, did you end up resending it in a
non-corrupted way?

thanks,

greg k-h
