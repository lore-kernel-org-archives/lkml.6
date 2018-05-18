Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752716AbeERKXn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:23:43 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:38449 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752306AbeERKXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:23:41 -0400
Subject: Re: INFO: task hung in isig
To: syzbot <syzbot+904e84db8111c6b813a5@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        syzkaller-bugs@googlegroups.com
References: <0000000000007dce01056c7616f7@google.com>
Cc: linux-kernel@vger.kernel.org
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <17cc55a0-59fd-875e-bdd9-f561b7d79224@I-love.SAKURA.ne.jp>
Date: Fri, 18 May 2018 19:22:50 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <0000000000007dce01056c7616f7@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot wrote:
> INFO: task kworker/u4:1:22 blocked for more than 120 seconds.
>       Not tainted 4.17.0-rc5+ #55
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> kworker/u4:1    D21192    22      2 0x80000000
> Workqueue: events_unbound flush_to_ldisc
> Call Trace:
>  context_switch kernel/sched/core.c:2859 [inline]
>  __schedule+0x801/0x1e30 kernel/sched/core.c:3501
>  schedule+0xef/0x430 kernel/sched/core.c:3545
>  __rwsem_down_write_failed_common+0x919/0x15d0 kernel/locking/rwsem-xadd.c:566
>  rwsem_down_write_failed+0xe/0x10 kernel/locking/rwsem-xadd.c:595
>  call_rwsem_down_write_failed+0x17/0x30 arch/x86/lib/rwsem.S:117
>  __down_write arch/x86/include/asm/rwsem.h:142 [inline]
>  down_write+0xa2/0x120 kernel/locking/rwsem.c:72

kworker/u4:1(PID=22) got stuck at

  down_write(&tty->termios_rwsem);

>  isig+0xcd/0x4e0 drivers/tty/n_tty.c:1098
>  n_tty_receive_signal_char+0x22/0x120 drivers/tty/n_tty.c:1210
>  n_tty_receive_char_special+0x1c27/0x31c0 drivers/tty/n_tty.c:1259
>  n_tty_receive_buf_fast drivers/tty/n_tty.c:1577 [inline]
>  __receive_buf drivers/tty/n_tty.c:1611 [inline]
>  n_tty_receive_buf_common+0x20ca/0x2c50 drivers/tty/n_tty.c:1709
>  n_tty_receive_buf2+0x33/0x40 drivers/tty/n_tty.c:1744
>  tty_ldisc_receive_buf+0xb0/0x190 drivers/tty/tty_buffer.c:456
>  tty_port_default_receive_buf+0x110/0x170 drivers/tty/tty_port.c:38
>  receive_buf drivers/tty/tty_buffer.c:475 [inline]
>  flush_to_ldisc+0x3e9/0x560 drivers/tty/tty_buffer.c:524
>  process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
>  worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
>  kthread+0x345/0x410 kernel/kthread.c:240
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

waiting for syz-executor3(PID=8572) which is stalling inside __process_echoes()

> CPU: 0 PID: 8572 Comm: syz-executor3 Not tainted 4.17.0-rc5+ #55
> Call Trace:
>  __process_echoes+0x2dc/0x8d0 drivers/tty/n_tty.c:732
>  flush_echoes drivers/tty/n_tty.c:799 [inline]
>  __receive_buf drivers/tty/n_tty.c:1615 [inline]

after

  down_read(&tty->termios_rwsem);

in n_tty_receive_buf_common().

>  n_tty_receive_buf_common+0x11d5/0x2c50 drivers/tty/n_tty.c:1709
>  n_tty_receive_buf+0x30/0x40 drivers/tty/n_tty.c:1738
>  tiocsti drivers/tty/tty_io.c:2171 [inline]
>  tty_ioctl+0x7e7/0x1870 drivers/tty/tty_io.c:2557
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:500 [inline]
>  do_vfs_ioctl+0x1cf/0x16a0 fs/ioctl.c:684
>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
>  __do_sys_ioctl fs/ioctl.c:708 [inline]
>  __se_sys_ioctl fs/ioctl.c:706 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Therefore, this will be a dup of below report.

#syz dup: INFO: rcu detected stall in __process_echoes
