Date: Fri, 20 Apr 2018 10:14:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: daelyong jeong <daelyong.jeong@gmail.com>
Cc: jslaby@suse.com, LKML <linux-kernel@vger.kernel.org>,
	Byoungyoung Lee <lifeasageek@gmail.com>,
	Kyungtae Kim <kt0755@gmail.com>, basavesh@purdue.edu
Subject: Re: [PATCH] tty: Fix data race in tty_insert_flip_string_fixed_flag()
Message-ID: <20180420081401.GA23019@kroah.com>
References: <CAARE==e6obTMLBeo3t2oJuwwtv3zfei7sUhREJwDcqUEGFPdAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAARE==e6obTMLBeo3t2oJuwwtv3zfei7sUhREJwDcqUEGFPdAg@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 04:40:56PM +0900, daelyong jeong wrote:
> tty_insert_flip_string_fixed_flag() copies chars to the buffer indicated
> by th->used and updates tb->used.
> But it is possible that tty_insert_flip_string_fixed_flag() is executed
> concurrently and tb->used is updated improperly.
> It leads slab-out-of-bound write in tty_insert_flip_string_fixed_flag or
> slab-out-of-bounds read in flush_to_ldisc.
> 
> BUG: KASAN: slab-out-of-bounds in
> tty_insert_flip_string_fixed_flag+0xb5/0x130
> drivers/tty/tty_buffer.c:316 at addr ffff880114fcc121
> Write of size 1792 by task syz-executor0/30017
> CPU: 1 PID: 30017 Comm: syz-executor0 Not tainted 4.8.0 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
>  0000000000000000 ffff88011638f888 ffffffff81694cc3 ffff88007d802140
>  ffff880114fcb300 ffff880114fcc300 ffff880114fcb300 ffff88011638f8b0
>  ffffffff8130075c ffff88011638f940 ffff88007d802140 ffff880194fcc121
> Call Trace:
>  [<ffffffff81694cc3>] __dump_stack lib/dump_stack.c:15 [inline]
>  [<ffffffff81694cc3>] dump_stack+0xb3/0x110 lib/dump_stack.c:51
>  [<ffffffff8130075c>] kasan_object_err+0x1c/0x70 mm/kasan/report.c:156
>  [<ffffffff813009f7>] print_address_description mm/kasan/report.c:194 [inline]
>  [<ffffffff813009f7>] kasan_report_error+0x1f7/0x4e0 mm/kasan/report.c:283
>  [<ffffffff81301076>] kasan_report+0x36/0x40 mm/kasan/report.c:303
>  [<ffffffff812ff9ce>] check_memory_region_inline mm/kasan/kasan.c:292 [inline]
>  [<ffffffff812ff9ce>] check_memory_region+0x13e/0x1a0 mm/kasan/kasan.c:299
>  [<ffffffff812ffea7>] memcpy+0x37/0x50 mm/kasan/kasan.c:335
>  [<ffffffff817f19f5>] tty_insert_flip_string_fixed_flag+0xb5/0x130
> drivers/tty/tty_buffer.c:316
>  [<ffffffff817f4d6f>] tty_insert_flip_string
> include/linux/tty_flip.h:35 [inline]
>  [<ffffffff817f4d6f>] pty_write+0x7f/0xc0 drivers/tty/pty.c:115
>  [<ffffffff817f83c4>] n_hdlc_send_frames+0x1d4/0x3b0 drivers/tty/n_hdlc.c:419
>  [<ffffffff817f8613>] n_hdlc_tty_wakeup+0x73/0xa0 drivers/tty/n_hdlc.c:496
>  [<ffffffff817dea32>] tty_wakeup+0x92/0xb0 drivers/tty/tty_io.c:601
>  [<ffffffff817e06c6>] __start_tty.part.26+0x66/0x70 drivers/tty/tty_io.c:1018
>  [<ffffffff817e5114>] __start_tty+0x34/0x40 drivers/tty/tty_io.c:1013
>  [<ffffffff817efbb6>] n_tty_ioctl_helper+0x146/0x1e0
> drivers/tty/tty_ioctl.c:1138
>  [<ffffffff817f9443>] n_hdlc_tty_ioctl+0xb3/0x2b0 drivers/tty/n_hdlc.c:794
>  [<ffffffff817e4415>] tty_ioctl+0xa85/0x16d0 drivers/tty/tty_io.c:2992
>  [<ffffffff8133500e>] vfs_ioctl fs/ioctl.c:43 [inline]
>  [<ffffffff8133500e>] do_vfs_ioctl+0x13e/0xba0 fs/ioctl.c:679
>  [<ffffffff81335aff>] SYSC_ioctl fs/ioctl.c:694 [inline]
>  [<ffffffff81335aff>] SyS_ioctl+0x8f/0xc0 fs/ioctl.c:685
>  [<ffffffff8230de3c>] entry_SYSCALL_64_fastpath+0x1f/0xbd
> 
> Call sequences are as follows.
> CPU0                                    CPU1
> n_tty_ioctl_helper                      n_tty_ioctl_helper
> __start_tty                             tty_send_xchar
> tty_wakeup                              pty_write
> n_hdlc_tty_wakeup                       tty_insert_flip_string
> n_hdlc_send_frames                      tty_insert_flip_string_fixed_flag
> pty_write
> tty_insert_flip_string
> tty_insert_flip_string_fixed_flag
> 
> Acquire tty->atomic_write_lock by calling tty_write_lock() before
> __start_tty() since __start_tty() can sends frames.
> 
> Signed-off-by: Daelyong Jeong <daelyong.jeong@gmail.com>
> ---
> Rationale:
> - Since tty_wakeup() called by __start_tty() sends frames, call
>   tty_write_lock() before __start_tty().
> - Since tty_write_lock() might sleep, locate tty_write_lock() before
>   spin_lock_irq(&tty->flow_lock).
> - Since wake_up_interruptible_poll() is called by both tty_write_unlock()
>   and __start_tty(), Prevent calling wake_up_interruptible_poll() twice
>   by adding the wakeup flag to tty_write_unlock()
> 
> ---
>  drivers/tty/tty_io.c    | 16 +++++++++-------
>  drivers/tty/tty_ioctl.c |  5 +++++
>  include/linux/tty.h     |  2 ++
>  3 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 63114ea..41f83bd 100644
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

Patch is still totally corrupted :(

Please read the kernel documentation for how to handle broken email
clients (like gmail), and send the patch to yourself first to verify
that it works before sending it out to everyone else.

thanks,

greg k-h
