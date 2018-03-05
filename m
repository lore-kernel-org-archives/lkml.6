Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbeCESVp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 13:21:45 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34699 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbeCESVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 13:21:43 -0500
X-Google-Smtp-Source: AG47ELu7r1D7pZbkSzLJOnWN1cMceV8fHttYiOZyQQkfPuWZWHggomc1FMhYctkqTUnWY+XYteneQA==
Message-ID: <1520274101.109662.7.camel@gmail.com>
Subject: Re: WARNING: kobject bug in netdev_queue_update_kobjects
From: Eric Dumazet <eric.dumazet@gmail.com>
To: syzbot <syzbot+7fb6d9525a4528104e05@syzkaller.appspotmail.com>,
        adobriyan@gmail.com, davem@davemloft.net, decot@googlers.com,
        dwindsor@gmail.com, elena.reshetova@intel.com, fw@strlen.de,
        ktkhai@virtuozzo.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, roopa@cumulusnetworks.com,
        stephen@networkplumber.org, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com
Date: Mon, 05 Mar 2018 10:21:41 -0800
In-Reply-To: <001a113ac54eb1617d0566ae146d@google.com>
References: <001a113ac54eb1617d0566ae146d@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-05 at 09:59 -0800, syzbot wrote:
> Hello,
> 
> syzbot hit the following crash on upstream commit
> 661e50bc853209e41a5c14a290ca4decc43cbfd1 (Sun Mar 4 22:54:11 2018
> +0000)
> Linux 4.16-rc4
> 
> So far this crash happened 2 times on upstream.
> C reproducer is attached.
> syzkaller reproducer is attached.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the
> commit:
> Reported-by: syzbot+7fb6d9525a4528104e05@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer
> for  
> details.
> If you forward the report, please keep this part and the footer.
> 
> RBP: 00007ffd67c73e10 R08: 0000000000000001 R09: 00007ffd67c70032
> R10: 0000000000000000 R11: 0000000000000246 R12: 74656e2f7665642f
> R13: ffffffffffffffff R14: 0000000000000008 R15: 0000000000000000
> ------------[ cut here ]------------
> kobject_add_internal failed for tx-3 (error: -12 parent: queues)
> WARNING: CPU: 1 PID: 4119 at lib/kobject.c:242  
> kobject_add_internal+0x3f6/0xbc0 lib/kobject.c:240
> Kernel panic - not syncing: panic_on_warn set ...
> 
> CPU: 1 PID: 4119 Comm: syzkaller952529 Not tainted 4.16.0-rc4+ #341
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS  
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:17 [inline]
>   dump_stack+0x194/0x24d lib/dump_stack.c:53
>   panic+0x1e4/0x41c kernel/panic.c:183
>   __warn+0x1dc/0x200 kernel/panic.c:547
>   report_bug+0x211/0x2d0 lib/bug.c:184
>   fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:178
>   fixup_bug arch/x86/kernel/traps.c:247 [inline]
>   do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
>   do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
>   invalid_op+0x1b/0x40 arch/x86/entry/entry_64.S:986
> RIP: 0010:kobject_add_internal+0x3f6/0xbc0 lib/kobject.c:240
> RSP: 0018:ffff8801d2d9f488 EFLAGS: 00010286
> RAX: dffffc0000000008 RBX: ffff8801d1ec0618 RCX: ffffffff815abb7e
> RDX: 0000000000000000 RSI: 1ffff1003a5b3e41 RDI: 1ffff1003a5b3e16
> RBP: ffff8801d2d9f580 R08: 1ffff1003a5b3dd8 R09: 0000000000000000
> R10: ffff8801d2d9f248 R11: 0000000000000000 R12: 1ffff1003a5b3e97
> R13: 00000000fffffff4 R14: ffff8801d0ce8d48 R15: ffffffff8684c720
>   kobject_add_varg lib/kobject.c:364 [inline]
>   kobject_init_and_add+0xf9/0x150 lib/kobject.c:436
>   netdev_queue_add_kobject net/core/net-sysfs.c:1332 [inline]
>   netdev_queue_update_kobjects+0x148/0x480 net/core/net-sysfs.c:1360
>   netif_set_real_num_tx_queues+0x185/0x790 net/core/dev.c:2397
>   tun_set_real_num_queues drivers/net/tun.c:638 [inline]
>   tun_attach+0x7bd/0x1220 drivers/net/tun.c:863
>   tun_set_queue drivers/net/tun.c:2750 [inline]
>   __tun_chr_ioctl+0x8f5/0x40d0 drivers/net/tun.c:2814
>   tun_chr_ioctl+0x2a/0x40 drivers/net/tun.c:3084
>   vfs_ioctl fs/ioctl.c:46 [inline]
>   do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
>   SYSC_ioctl fs/ioctl.c:701 [inline]
>   SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
>   do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>   entry_SYSCALL_64_after_hwframe+0x42/0xb7
> RIP: 0033:0x444229
> RSP: 002b:00007ffd67c73e08 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000444229
> RDX: 0000000020000200 RSI: 00000000400454d9 RDI: 0000000000000006
> RBP: 00007ffd67c73e10 R08: 0000000000000001 R09: 00007ffd67c70032
> R10: 0000000000000000 R11: 0000000000000246 R12: 74656e2f7665642f
> R13: ffffffffffffffff R14: 0000000000000008 R15: 0000000000000000
> Dumping ftrace buffer:
>     (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
> 
> 
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug
> is  
> merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title
> If you want to test a patch for this bug, please reply with:
> #syz test: git://repo/address.git branch
> and provide the patch inline or as an attachment.
> To mark this as a duplicate of another syzbot report, please reply
> with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new
> bug  
> report.
> Note: all commands must start from beginning of the line in the email
> body.

kobject_init_internal() simply is noisy when an error happen (in this
case a memory allocation error was injected)

It seems it is intended.

commit 282029c005e65ffdce3aa9f8220f88a8bbbc4dae
Author: Dan Williams <dan.j.williams@intel.com>
Date:   Fri Apr 6 13:41:15 2012 -0700

    kobject: provide more diagnostic info for kobject_add_internal()
failures
    
    1/ convert open-coded KERN_ERR+dump_stack() to WARN(), so that
automated
       tools pick up this warning.
    
    2/ include the 'child' and 'parent' kobject names.  This
information was
       useful for tracking down the case where scsi invoked
device_del() on a
       parent object and subsequently invoked device_add() on a
child.  Now the
       warning looks like:
    
         kobject_add_internal failed for target8:0:16 (error: -2
parent: end_device-8:0:24)
         Pid: 2942, comm: scsi_scan_8 Not tainted 3.3.0-rc7-isci+ #2
         Call Trace:
          [<ffffffff8125e551>] kobject_add_internal+0x1c1/0x1f3
          [<ffffffff81075149>] ? trace_hardirqs_on+0xd/0xf
          [<ffffffff8125e659>] kobject_add_varg+0x41/0x50
          [<ffffffff8125e723>] kobject_add+0x64/0x66
          [<ffffffff8131124b>] device_add+0x12d/0x63a
          [<ffffffff8125e0ef>] ? kobject_put+0x4c/0x50
          [<ffffffff8132f370>] scsi_sysfs_add_sdev+0x4e/0x28a
          [<ffffffff8132dce3>] do_scan_async+0x9c/0x145
    
    Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Cc: James Bottomley <JBottomley@parallels.com>
    Signed-off-by: Dan Williams <dan.j.williams@intel.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
