Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67498C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349C920675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731475AbeLQGLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 01:11:06 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:45475 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbeLQGLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 01:11:05 -0500
Received: by mail-io1-f69.google.com with SMTP id r65so11163012iod.12
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 22:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=YMxXTHzjsQCwIcah2nzwn+FIb9FdSCHvGCBR2joJIKI=;
        b=g1ep2b1wTFoFOP16CKkPxLUNOi79vYVn6UhTrDARdFxThCIoTidhFdXpskBsToOpbO
         IfoSX6CiTf/sFPalziAW1G7VHDd5GdIsAbicy6kw9n9LubkDeuQ/kW7pl6IBsr4eBFoj
         C1jvK7pJ1P2hIom3PtJwLFg2cVfqV66q91zdKHLhSbDcjy2H0oRQAfuCpVk6h7+OFH3u
         koFYfw4jKAh/oBbrs1OEoSSzM7mKjNQD2eSl71IO0B1elHLS+53PL/5DypFUI0BoyPAw
         3Mdf2HJvx22DLJVgCT3NLVUy/i1v1cnTwuraQ3kI/x7VYQar8U2MNwrK7cTbbqwKRkGD
         QHJg==
X-Gm-Message-State: AA+aEWb+nwZ4QY3T+9CO5Sl56IHANcECwYfSZsp3CU7sYjbYbk7Wn7XU
        B4qsbr43x/hhleaFvcMJD7ee3tZOf5nYfokRvdOBCjAIuNxr
X-Google-Smtp-Source: AFSGD/Vf938menufu3BlLnWZ8PIcZtODIplgrd5ixCjzoH20DNd5KDG32E3Km9pYYqwySFDSYBpR1kahiL/PPwSmtAqJY0pbnS9u
MIME-Version: 1.0
X-Received: by 2002:a5d:8d81:: with SMTP id b1mr10543537ioj.27.1545027064238;
 Sun, 16 Dec 2018 22:11:04 -0800 (PST)
Date:   Sun, 16 Dec 2018 22:11:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000551b80057d31a5f7@google.com>
Subject: KASAN: slab-out-of-bounds Read in tick_sched_handle
From:   syzbot <syzbot+09d51a30df9fe76edb2a@syzkaller.appspotmail.com>
To:     fweisbec@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c151acc6e9ff l2tp: Add protocol field decompression
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1231955d400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9655b05acfc97ff
dashboard link: https://syzkaller.appspot.com/bug?extid=09d51a30df9fe76edb2a
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e68f6d400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1737c943400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+09d51a30df9fe76edb2a@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
kasan: CONFIG_KASAN_INLINE enabled
==================================================================
BUG: KASAN: slab-out-of-bounds in tick_sched_handle+0x16c/0x180  
kernel/time/tick-sched.c:164
kasan: GPF could be caused by NULL-ptr deref or user memory access
Read of size 8 at addr ffff8881d8b67b70 by task syz-executor132/5936
general protection fault: 0000 [#1] PREEMPT SMP KASAN

CPU: 0 PID: 5936 Comm: syz-executor132 Not tainted 4.20.0-rc6+ #347
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.20.0-rc6+ #347
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
RIP: 0010:lookup_object lib/debugobjects.c:156 [inline]
RIP: 0010:debug_object_deactivate+0x191/0x450 lib/debugobjects.c:542
  <IRQ>
Code: 02 00 00 48 8b 1b 41 bf 01 00 00 00 48 85 db 74 46 48 b8 00 00 00 00  
00 fc ff df 48 8d 7b 18 41 83 c7 01 48 89 fe 48 c1 ee 03 <80> 3c 06 00 0f  
85 04 02 00 00 48 3b 53 18 0f 84 53 01 00 00 48 89
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
RSP: 0018:ffff8881daf078b0 EFLAGS: 00010807
RAX: dffffc0000000000 RBX: da3ef506c4b2a03d RCX: ffffffff83939c1a
RDX: ffff8881bb4ed108 RSI: 1b47dea0d896540a RDI: da3ef506c4b2a055
RBP: ffff8881daf07968 R08: ffffed103b5e0f03 R09: ffffed103b5e0f02
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
R10: ffffed103b5e0f02 R11: 0000000000000003 R12: 1ffff1103b5e0f18
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
R13: ffffffff8b23e7a8 R14: ffffffff895a5980 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  tick_sched_handle+0x16c/0x180 kernel/time/tick-sched.c:164
CR2: 0000000000619570 CR3: 00000001c3506000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1274
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
  __hrtimer_run_queues+0x41c/0x10d0 kernel/time/hrtimer.c:1460
Call Trace:
  <IRQ>
  debug_timer_deactivate kernel/time/timer.c:714 [inline]
  debug_deactivate kernel/time/timer.c:770 [inline]
  detach_timer kernel/time/timer.c:815 [inline]
  expire_timers kernel/time/timer.c:1353 [inline]
  __run_timers+0x56f/0xc70 kernel/time/timer.c:1682
  hrtimer_interrupt+0x313/0x780 kernel/time/hrtimer.c:1518
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1034 [inline]
  smp_apic_timer_interrupt+0x1a1/0x760 arch/x86/kernel/apic/apic.c:1059
  run_timer_softirq+0x52/0xb0 kernel/time/timer.c:1695
  __do_softirq+0x308/0xb7e kernel/softirq.c:292
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  </IRQ>

Allocated by task 5092:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x730 mm/slab.c:3554
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x17f/0x1c0 kernel/softirq.c:413
  getname_flags+0xd0/0x590 fs/namei.c:140
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0x1cb/0x760 arch/x86/kernel/apic/apic.c:1061
  user_path_at_empty+0x2d/0x50 fs/namei.c:2608
  user_path_at include/linux/namei.h:57 [inline]
  do_faccessat+0x254/0x800 fs/open.c:378
  __do_sys_access fs/open.c:430 [inline]
  __se_sys_access fs/open.c:428 [inline]
  __x64_sys_access+0x59/0x80 fs/open.c:428
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 5092:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x83/0x290 mm/slab.c:3760
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  putname+0xf2/0x130 fs/namei.c:261
  </IRQ>
  filename_lookup+0x39a/0x520 fs/namei.c:2357
RIP: 0010:native_safe_halt+0x6/0x10 arch/x86/include/asm/irqflags.h:58
  user_path_at_empty+0x40/0x50 fs/namei.c:2608
Code: e9 2c ff ff ff 48 89 c7 48 89 45 d8 e8 d3 ac e5 f9 48 8b 45 d8 e9 ca  
fe ff ff 48 89 df e8 c2 ac e5 f9 eb 82 55 48 89 e5 fb f4 <5d> c3 0f 1f 84  
00 00 00 00 00 55 48 89 e5 f4 5d c3 90 90 90 90 90
  user_path_at include/linux/namei.h:57 [inline]
  do_faccessat+0x254/0x800 fs/open.c:378
RSP: 0018:ffff8881d9b27cb8 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
  __do_sys_access fs/open.c:430 [inline]
  __se_sys_access fs/open.c:428 [inline]
  __x64_sys_access+0x59/0x80 fs/open.c:428
RAX: dffffc0000000000 RBX: 1ffff1103b364f9b RCX: 0000000000000000
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
RDX: 1ffffffff12a4021 RSI: 0000000000000001 RDI: ffffffff89520108
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RBP: ffff8881d9b27cb8 R08: ffff8881d9b14340 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8881d9b27d78

R13: ffffffff8a166760 R14: 0000000000000000 R15: 0000000000000001
The buggy address belongs to the object at ffff8881d8b66100
  which belongs to the cache names_cache of size 4096
  arch_safe_halt arch/x86/include/asm/paravirt.h:151 [inline]
  default_idle+0xbf/0x490 arch/x86/kernel/process.c:561
The buggy address is located 2672 bytes to the right of
  4096-byte region [ffff8881d8b66100, ffff8881d8b67100)
The buggy address belongs to the page:
page:ffffea000762d980 count:1 mapcount:0 mapping:ffff8881da980e00 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000010200(slab|head)
raw: 02fffc0000010200 ffffea0007628f08 ffffea000762dc88 ffff8881da980e00
raw: 0000000000000000 ffff8881d8b66100 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881d8b67a00: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
  ffff8881d8b67a80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:552
> ffff8881d8b67b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  default_idle_call+0x6d/0x90 kernel/sched/idle.c:93
                                                              ^
  cpuidle_idle_call kernel/sched/idle.c:153 [inline]
  do_idle+0x49b/0x5c0 kernel/sched/idle.c:262
  ffff8881d8b67b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8881d8b67c00: fc fc fc fc fc 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
