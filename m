Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752949AbeCaP61 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 11:58:27 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38894 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752358AbeCaP6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 11:58:25 -0400
X-Google-Smtp-Source: AIpwx4+i79Xr9N+ZXGVQ8t6OL+zvy5aH9EJuopzqyCbwSutl3xM4ILMZAKVcY4OVtfaOSzlf9ww5ZA3qORzL1satXEg=
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZJ2QD7MPy4hB-M=mz2LuVu3bRbLg1QdY=z=+Su1QWMqg@mail.gmail.com>
References: <000000000000f2c42e05688f3ab6@google.com> <20180329123225.3a8fd6f5@gandalf.local.home>
 <CACT4Y+ZJ2QD7MPy4hB-M=mz2LuVu3bRbLg1QdY=z=+Su1QWMqg@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sat, 31 Mar 2018 17:58:04 +0200
Message-ID: <CACT4Y+Y6dbPntNcMXt0Vfsf=jgoQM8uVfQ6dJSKuTTHWPas3iA@mail.gmail.com>
Subject: Re: general protection fault in try_to_wake_up
To: Steven Rostedt <rostedt@goodmis.org>
Cc: syzbot <syzbot+d1fe9b7b917f2715c7d4@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller-bugs@googlegroups.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 6:53 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Thu, Mar 29, 2018 at 6:32 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>> Not sure why we are being Cc'd on this crash.
>>
>> On Thu, 29 Mar 2018 09:01:02 -0700
>> syzbot <syzbot+d1fe9b7b917f2715c7d4@syzkaller.appspotmail.com> wrote:
>>
>>> Hello,
>>>
>>> syzbot hit the following crash on upstream commit
>>> bcfc1f4554662d8f2429ac8bd96064a59c149754 (Sat Mar 24 16:50:12 2018 +0000)
>>> Merge tag 'pinctrl-v4.16-3' of
>>> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
>>> syzbot dashboard link:
>>> https://syzkaller.appspot.com/bug?extid=d1fe9b7b917f2715c7d4
>>>
>>> syzkaller reproducer:
>>> https://syzkaller.appspot.com/x/repro.syz?id=4649457446551552
>>> Raw console output:
>>> https://syzkaller.appspot.com/x/log.txt?id=4909621332410368
>>> Kernel config:
>>> https://syzkaller.appspot.com/x/.config?id=-5034017172441945317
>>> compiler: gcc (GCC) 7.1.1 20170620
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+d1fe9b7b917f2715c7d4@syzkaller.appspotmail.com
>>> It will help syzbot understand when the bug is fixed. See footer for
>>> details.
>>> If you forward the report, please keep this part and the footer.
>>>
>>> IPVS: ftp: loaded support on port[0] = 21
>>> kasan: CONFIG_KASAN_INLINE enabled
>>> kasan: GPF could be caused by NULL-ptr deref or user memory access
>>> kasan: CONFIG_KASAN_INLINE enabled
>>> kasan: GPF could be caused by NULL-ptr deref or user memory access
>>> general protection fault: 0000 [#1] SMP KASAN
>>> Dumping ftrace buffer:
>>>     (ftrace buffer empty)
>>> Modules linked in:
>>> CPU: 0 PID: 4170 Comm: syz-executor0 Not tainted 4.16.0-rc6+ #1
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>>> Google 01/01/2011
>>> RIP: 0010:__lock_acquire+0x209/0x3e00 kernel/locking/lockdep.c:3320
>>
>> Something is totally messed up here if you took a GPF in lockdep itself.
>>
>>> RSP: 0018:ffff8801db206f60 EFLAGS: 00010002
>>> RAX: 078e0401078e0401 RBX: 0000000000000000 RCX: 0000000000000000
>>> RDX: 1ffff100389fe583 RSI: 0000000000000000 RDI: ffff8801c4ff2c18
>>> RBP: ffff8801db2072f0 R08: ffffffff814d839c R09: 0000000000000001
>>> R10: 0000000000000000 R11: ffff8801c4ff2c10 R12: 0000000000000000
>>> R13: 0000000000000001 R14: 0000000000000000 R15: ffff8801b793c440
>>> FS:  00000000014fa940(0000) GS:ffff8801db200000(0000) knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 00000000004cb4e0 CR3: 00000001b7980002 CR4: 00000000001606f0
>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> Call Trace:
>>>   <IRQ>
>>>   lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:3920
>>>   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>>>   _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
>>>   try_to_wake_up+0xbc/0x15f0 kernel/sched/core.c:1989
>>>   default_wake_function+0x30/0x50 kernel/sched/core.c:3693
>>>   autoremove_wake_function+0x78/0x350 kernel/sched/wait.c:377
>>>   __wake_up_common+0x18e/0x780 kernel/sched/wait.c:97
>>>   __wake_up_common_lock+0x1b4/0x310 kernel/sched/wait.c:125
>>>   __wake_up+0xe/0x10 kernel/sched/wait.c:149
>>>   wake_up_klogd_work_func+0x4a/0x70 kernel/printk/printk.c:2869
>>>   irq_work_run_list+0x184/0x240 kernel/irq_work.c:155
>>>   irq_work_tick+0x136/0x1a0 kernel/irq_work.c:181
>>>   update_process_times+0x48/0x60 kernel/time/timer.c:1639
>>>   tick_sched_handle+0x85/0x160 kernel/time/tick-sched.c:162
>>>   tick_sched_timer+0x42/0x120 kernel/time/tick-sched.c:1194
>>>   __run_hrtimer kernel/time/hrtimer.c:1349 [inline]
>>>   __hrtimer_run_queues+0x39c/0xec0 kernel/time/hrtimer.c:1411
>>>   hrtimer_interrupt+0x2a5/0x6f0 kernel/time/hrtimer.c:1469
>>>   local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
>>>   smp_apic_timer_interrupt+0x14a/0x700 arch/x86/kernel/apic/apic.c:1050
>>>   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:857
>>>   </IRQ>
>>> RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:778
>>> [inline]
>>> RIP: 0010:console_unlock+0xb18/0xfb0 kernel/printk/printk.c:2403
>>
>> Perhaps this is the reason we are being Cc'd?
>>
>> But this looks to be a side-effect of the first bug. If your box is
>> crashing within lockdep, I'm betting the system is hosed, and you will
>> get crashes in random locations after that.
>>
>> I doubt this is a printk issue.
>
> Hi Steven,
>
> You were CCed because this crash was attributed to
> kernel/printk/printk.c (higher frames are in very common code, and
> these are skipped for the purpose of bug attribution).
>
> The box was perfectly fine before running the provided reproducer, the
> kernel is not tainted and nothing was executed before this program
> (except for common init code).
>
> +Eric, from the reproducer this looks like the known bug in tun. Is
> there any progress on that bug, it seems to cause a bunch of assorted
> crashes.


#syz fix: vlan: Fix vlan insertion for packets without ethernet header


>>> RSP: 0018:ffff8801b79068d8 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff12
>>> RAX: ffff8801b793c440 RBX: 0000000000000200 RCX: ffffffff815a8d6f
>>> RDX: 0000000000000000 RSI: 1ffff10036f279af RDI: 0000000000000293
>>> RBP: ffff8801b7906a40 R08: 1ffff10036f20ce9 R09: 0000000000000000
>>> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>>> R13: 0000000000000000 R14: ffffffff83ba15e0 R15: dffffc0000000000
>>>   vprintk_emit+0x5c3/0xb90 kernel/printk/printk.c:1907
>>>   vprintk_default+0x28/0x30 kernel/printk/printk.c:1947
>>>   vprintk_func+0x57/0xc0 kernel/printk/printk_safe.c:379
>>>   printk+0xaa/0xca kernel/printk/printk.c:1980
>>>   kasan_die_handler+0x3d/0x3f arch/x86/mm/kasan_init_64.c:248
>>>   notifier_call_chain+0x136/0x2c0 kernel/notifier.c:93
>>>   __atomic_notifier_call_chain kernel/notifier.c:183 [inline]
>>>   atomic_notifier_call_chain+0x77/0x140 kernel/notifier.c:193
>>>   notify_die+0x18c/0x280 kernel/notifier.c:549
>>>   do_general_protection+0x331/0x3e0 arch/x86/kernel/traps.c:558
>>>   general_protection+0x25/0x50 arch/x86/entry/entry_64.S:1150
>>> RIP: 0010:find_entry.isra.14+0x9f/0x1d0 fs/proc/proc_sysctl.c:119
>>> RSP: 0018:ffff8801b7906fc8 EFLAGS: 00010202
>>> RAX: 00f1c08020f1c080 RBX: ffff8801c4f95058 RCX: ffffffff81d29eae
>>> RDX: 0000000000000000 RSI: ffff8801b8991678 RDI: ffff8801c4f95070
>>> RBP: ffff8801b7907008 R08: 1ffff10036f20d55 R09: 0000000000000004
>>> R10: ffff8801b7906f70 R11: 0000000000000000 R12: ffff8801b89915f8
>>> R13: dffffc0000000000 R14: 078e0401078e0401 R15: ffff8801b8991678
>>>   find_subdir+0xa8/0x170 fs/proc/proc_sysctl.c:923
>>>   get_subdir fs/proc/proc_sysctl.c:977 [inline]
>>>   __register_sysctl_table+0x6d5/0x10b0 fs/proc/proc_sysctl.c:1327
>>>   register_net_sysctl+0x29/0x30 net/sysctl_net.c:120
>>>   mpls_dev_sysctl_register+0x1cf/0x2e0 net/mpls/af_mpls.c:1369
>>>   mpls_add_dev net/mpls/af_mpls.c:1420 [inline]
>>>   mpls_dev_notify+0x2af/0x980 net/mpls/af_mpls.c:1542
>>>   notifier_call_chain+0x136/0x2c0 kernel/notifier.c:93
>>>   __raw_notifier_call_chain kernel/notifier.c:394 [inline]
>>>   raw_notifier_call_chain+0x2d/0x40 kernel/notifier.c:401
>>>   call_netdevice_notifiers_info+0x32/0x70 net/core/dev.c:1707
>>>   call_netdevice_notifiers net/core/dev.c:1725 [inline]
>>>   register_netdevice+0xd40/0x1020 net/core/dev.c:7929
>>>   register_netdev+0x1a/0x30 net/core/dev.c:8014
>>>   sit_init_net+0x384/0xa70 net/ipv6/sit.c:1852
>>>   ops_init+0x10a/0x570 net/core/net_namespace.c:118
>>>   setup_net+0x351/0x760 net/core/net_namespace.c:302
>>>   copy_net_ns+0x238/0x580 net/core/net_namespace.c:426
>>>   create_new_namespaces+0x425/0x880 kernel/nsproxy.c:107
>>>   unshare_nsproxy_namespaces+0xae/0x1e0 kernel/nsproxy.c:206
>>>   SYSC_unshare kernel/fork.c:2407 [inline]
>>>   SyS_unshare+0x653/0xfa0 kernel/fork.c:2357
>>>   do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>>>   entry_SYSCALL_64_after_hwframe+0x42/0xb7
>>> RIP: 0033:0x457327
>>> RSP: 002b:00007ffdd0bf1928 EFLAGS: 00000202 ORIG_RAX: 0000000000000110
>>> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000457327
>>> RDX: 0000000000000000 RSI: 00007ffdd0bf1900 RDI: 0000000040000000
>>> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
>>> R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000410710
>>> R13: 00000000004107a0 R14: 0000000000000000 R15: 0000000000000000
>>> Code: 48 85 c0 4c 8b 9d e8 fc ff ff 8b 8d e0 fc ff ff 44 8b 8d d8 fc ff ff
>>> 4c 8b 85 d0 fc ff ff 44 8b 95 c8 fc ff ff 0f 84 9b 07 00 00 <f0> ff 80 38
>>> 01 00 00 49 8d bf 70 08 00 00 48 ba 00 00 00 00 00
>>> RIP: __lock_acquire+0x209/0x3e00 kernel/locking/lockdep.c:3320 RSP:
>>> ffff8801db206f60
>>> ---[ end trace b962f2b4a8ee2930 ]---
>>>
>>>
>>> ---
>>> This bug is generated by a dumb bot. It may contain errors.
>>> See https://goo.gl/tpsmEJ for details.
>>> Direct all questions to syzkaller@googlegroups.com.
>>>
>>> syzbot will keep track of this bug report.
>>> If you forgot to add the Reported-by tag, once the fix for this bug is
>>> merged
>>> into any tree, please reply to this email with:
>>> #syz fix: exact-commit-title
>>> If you want to test a patch for this bug, please reply with:
>>> #syz test: git://repo/address.git branch
>>> and provide the patch inline or as an attachment.
>>> To mark this as a duplicate of another syzbot report, please reply with:
>>> #syz dup: exact-subject-of-another-report
>>> If it's a one-off invalid bug report, please reply with:
>>> #syz invalid
>>> Note: if the crash happens again, it will cause creation of a new bug
>>> report.
>>> Note: all commands must start from beginning of the line in the email body.
>>
>> --
>> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20180329123225.3a8fd6f5%40gandalf.local.home.
>> For more options, visit https://groups.google.com/d/optout.
