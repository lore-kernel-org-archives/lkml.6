Date: Sun, 6 May 2018 13:17:51 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: syzbot <syzbot+995c889cef82be5ccddf@syzkaller.appspotmail.com>
Cc: jslaby@suse.com, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: BUG: soft lockup in commit_echoes
Message-ID: <20180506201751.GA8924@kroah.com>
References: <000000000000ea358d056b8c0547@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ea358d056b8c0547@google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, May 06, 2018 at 09:27:02AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:

Meta comment on the format of all of this:

> 
> HEAD commit:    c1c07416cdd4 Merge tag 'kbuild-fixes-v4.17' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=138afde7800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5a1dc06635c10d27
> dashboard link: https://syzkaller.appspot.com/bug?extid=995c889cef82be5ccddf
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1355fc37800000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1033f657800000

First off, great job, that's a nice summary.

You might want to put the "dashboard link" at the top somewhere, it is
burried in there and I totally missed it and wrote a long paragraph
asking that you add something like that to this report, before I noticed
that it was already there :)

> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+995c889cef82be5ccddf@syzkaller.appspotmail.com

Nit, should you have < > around that email address?

> watchdog: BUG: soft lockup - CPU#0 stuck for 135s! [kworker/u4:3:4495]
> Modules linked in:
> irq event stamp: 916736
> hardirqs last  enabled at (916735): [<ffffffff878009d5>]
> restore_regs_and_return_to_kernel+0x0/0x2b
> hardirqs last disabled at (916736): [<ffffffff87800905>]
> interrupt_entry+0xb5/0xf0 arch/x86/entry/entry_64.S:625
> softirqs last  enabled at (746274): [<ffffffff87a00778>]
> __do_softirq+0x778/0xaf5 kernel/softirq.c:311
> softirqs last disabled at (746209): [<ffffffff81475281>] invoke_softirq
> kernel/softirq.c:365 [inline]
> softirqs last disabled at (746209): [<ffffffff81475281>]
> irq_exit+0x1d1/0x200 kernel/softirq.c:405

As a script generates this, why is it being line-wrapped?


> CPU: 0 PID: 4495 Comm: kworker/u4:3 Not tainted 4.17.0-rc3+ #34
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: events_unbound flush_to_ldisc
> RIP: 0010:echo_buf drivers/tty/n_tty.c:144 [inline]
> RIP: 0010:__process_echoes+0x1fd/0x8d0 drivers/tty/n_tty.c:733
> RSP: 0018:ffff8801adbc7268 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
> RAX: ffff8801ad126280 RBX: 00000001fda8cfee RCX: ffffffff8397b54c
> RDX: 0000000000000000 RSI: ffffffff8397b46d RDI: 0000000000000001
> RBP: ffff8801adbc72d0 R08: ffff8801ad126280 R09: 0000000000000006
> R10: ffff8801ad126280 R11: 0000000000000000 R12: ffffc90001eec000
> R13: 0000000000001a02 R14: 00000001fda8cfef R15: 00000000000000ff
> FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000021000000 CR3: 00000001ada40000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  commit_echoes+0x163/0x1d0 drivers/tty/n_tty.c:764
>  n_tty_receive_char_fast drivers/tty/n_tty.c:1416 [inline]
>  n_tty_receive_buf_fast drivers/tty/n_tty.c:1576 [inline]
>  __receive_buf drivers/tty/n_tty.c:1611 [inline]
>  n_tty_receive_buf_common+0x2048/0x2c50 drivers/tty/n_tty.c:1709
>  n_tty_receive_buf2+0x33/0x40 drivers/tty/n_tty.c:1744
>  tty_ldisc_receive_buf+0xb0/0x190 drivers/tty/tty_buffer.c:456
>  tty_port_default_receive_buf+0x110/0x170 drivers/tty/tty_port.c:38
>  receive_buf drivers/tty/tty_buffer.c:475 [inline]
>  flush_to_ldisc+0x3e9/0x560 drivers/tty/tty_buffer.c:524
>  process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
>  worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
>  kthread+0x345/0x410 kernel/kthread.c:238
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
> Code: 48 83 c3 01 48 b9 00 00 00 00 00 fc ff df 48 c1 e8 03 80 3c 08 00 0f
> 85 17 06 00 00 4d 8b 6c 24 20 e9 db fe ff ff e8 73 7b e1 fd <41> 81 e6 ff 0f
> 00 00 48 b9 00 00 00 00 00 fc ff df 4b 8d bc 34

Anyway, keep up the great work, I'll add this to my every-growing list
of stuff to look at...

greg k-h
