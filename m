Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78C1C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 10:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49852184E
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 10:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbeL2KbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 05:31:05 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:53085 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729250AbeL2KbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 05:31:04 -0500
Received: by mail-io1-f70.google.com with SMTP id h7so27785456iof.19
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 02:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=z55u1vAKdIh8sMTmZY09f6iWbgsq5UIRCtzj2XUFo2w=;
        b=NTn+y5Pxo0sA74yMoy9yfY2VcpSmFoNUm0wG56vH7pDSw5jv04GBFxzW0LKuWaHtW6
         0qxZvut2yAOdiKE8y8HDiXj4LONJ1I+CjL+z5C1mBB3i9LfiyYB0tUCd5sUxopJTxrj8
         Czjfjt2T3p6Sg482535svLae22sir148bfMmWFksabacfrhAXiwh6F8dsZkQP92ngyy/
         Y+euxzvZB66iLGJ6xF5xIaPPpU7kD+iqpWgUDE1CJFQOTH0ZNlpijFBANsgaOi5KysW5
         oI3shlMtoRrgRROny0QH9ZJv0SUp57MgX57sRH41WFNKZ5T7RM1t1S8CNUPlskhKfHgs
         KiRg==
X-Gm-Message-State: AJcUukcb/vfZplG9vCiT2Dfr/1u03zFoL2VyOLFcwr7zT8gI5//1uo9u
        sbcS/Zx6Nreknb3Tf+Z7ColS3Oc/IotXmdewjuH4jG5dW9TA
X-Google-Smtp-Source: ALg8bN4dxd6nIrGSHCLLroUEn9ViP7pWbnBz31BAgd1OSt05CN/ZZE+jovrXp0gppbf1PYEwXcD65AT9pN9zaWtAmNxh5ChCZGJq
MIME-Version: 1.0
X-Received: by 2002:a5d:9ad7:: with SMTP id x23mr738525ion.21.1546079462954;
 Sat, 29 Dec 2018 02:31:02 -0800 (PST)
Date:   Sat, 29 Dec 2018 02:31:02 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002f1f80057e26addf@google.com>
Subject: inconsistent lock state in nr_find_socket
From:   syzbot <syzbot+f621cda8b7e598908efa@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ralf@linux-mips.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    5694cecdb092 Merge tag 'arm64-upstream' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=129ee73f400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91a256823ef17263
dashboard link: https://syzkaller.appspot.com/bug?extid=f621cda8b7e598908efa
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b2b42d400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1220489f400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f621cda8b7e598908efa@syzkaller.appspotmail.com


================================
WARNING: inconsistent lock state
4.20.0+ #389 Not tainted
--------------------------------
inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
syz-executor820/11913 [HC0[0]:SC0[0]:HE1:SE1] takes:
000000003a3617a7 (slock-AF_NETROM){+.?.}, at: spin_lock  
include/linux/spinlock.h:329 [inline]
000000003a3617a7 (slock-AF_NETROM){+.?.}, at: nr_find_socket+0x113/0x160  
net/netrom/af_netrom.c:177
{IN-SOFTIRQ-W} state was registered at:
   lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
   _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
   spin_lock include/linux/spinlock.h:329 [inline]
   nr_find_listener net/netrom/af_netrom.c:156 [inline]
   nr_rx_frame+0x5f8/0x1db0 net/netrom/af_netrom.c:955
   nr_loopback_timer+0x79/0x160 net/netrom/nr_loopback.c:62
   call_timer_fn+0x272/0x920 kernel/time/timer.c:1325
   expire_timers kernel/time/timer.c:1362 [inline]
   __run_timers+0x7e5/0xc70 kernel/time/timer.c:1681
   run_timer_softirq+0x52/0xb0 kernel/time/timer.c:1694
   __do_softirq+0x30c/0xb2e kernel/softirq.c:292
   invoke_softirq kernel/softirq.c:373 [inline]
   irq_exit+0x17f/0x1c0 kernel/softirq.c:413
   exiting_irq arch/x86/include/asm/apic.h:536 [inline]
   smp_apic_timer_interrupt+0x1cb/0x760 arch/x86/kernel/apic/apic.c:1061
   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
   arch_local_irq_restore arch/x86/include/asm/paravirt.h:761 [inline]
   lock_acquire+0x268/0x520 kernel/locking/lockdep.c:3847
   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
   _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
   spin_lock include/linux/spinlock.h:329 [inline]
   do_anonymous_page mm/memory.c:2947 [inline]
   handle_pte_fault mm/memory.c:3763 [inline]
   __handle_mm_fault+0x298c/0x5670 mm/memory.c:3889
   handle_mm_fault+0x54f/0xc70 mm/memory.c:3926
   do_user_addr_fault arch/x86/mm/fault.c:1423 [inline]
   __do_page_fault+0x5e8/0xe60 arch/x86/mm/fault.c:1489
   do_page_fault+0xf2/0x7e0 arch/x86/mm/fault.c:1520
   page_fault+0x1e/0x30 arch/x86/entry/entry_64.S:1143
irq event stamp: 294
hardirqs last  enabled at (292): [<ffffffff81007da1>]  
trace_hardirqs_on_thunk+0x1a/0x1c
hardirqs last disabled at (293): [<ffffffff8149f9f0>]  
__local_bh_enable_ip+0x120/0x260 kernel/softirq.c:171
softirqs last  enabled at (294): [<ffffffff86fc0d68>] spin_unlock_bh  
include/linux/spinlock.h:374 [inline]
softirqs last  enabled at (294): [<ffffffff86fc0d68>]  
nr_find_socket+0x128/0x160 net/netrom/af_netrom.c:183
softirqs last disabled at (290): [<ffffffff86fc0c64>] spin_lock_bh  
include/linux/spinlock.h:334 [inline]
softirqs last disabled at (290): [<ffffffff86fc0c64>]  
nr_find_socket+0x24/0x160 net/netrom/af_netrom.c:172

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(slock-AF_NETROM);
   <Interrupt>
     lock(slock-AF_NETROM);

  *** DEADLOCK ***

1 lock held by syz-executor820/11913:
  #0: 000000003a3617a7 (slock-AF_NETROM){+.?.}, at: spin_lock  
include/linux/spinlock.h:329 [inline]
  #0: 000000003a3617a7 (slock-AF_NETROM){+.?.}, at:  
nr_find_socket+0x113/0x160 net/netrom/af_netrom.c:177

stack backtrace:
CPU: 0 PID: 11913 Comm: syz-executor820 Not tainted 4.20.0+ #389
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
  print_usage_bug.cold.59+0x320/0x41a kernel/locking/lockdep.c:2472
  valid_state kernel/locking/lockdep.c:2485 [inline]
  mark_lock_irq kernel/locking/lockdep.c:2679 [inline]
  mark_lock+0x1114/0x1cc0 kernel/locking/lockdep.c:3059
  mark_held_locks+0xc7/0x130 kernel/locking/lockdep.c:2737
  __trace_hardirqs_on_caller kernel/locking/lockdep.c:2766 [inline]
  lockdep_hardirqs_on+0x421/0x5c0 kernel/locking/lockdep.c:2811
  trace_hardirqs_on+0xbd/0x310 kernel/trace/trace_preemptirq.c:30
  __local_bh_enable_ip+0x160/0x260 kernel/softirq.c:194
  __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:176 [inline]
  _raw_spin_unlock_bh+0x30/0x40 kernel/locking/spinlock.c:200
  spin_unlock_bh include/linux/spinlock.h:374 [inline]
  nr_find_socket+0x128/0x160 net/netrom/af_netrom.c:183
  nr_find_next_circuit+0x71/0x90 net/netrom/af_netrom.c:225
  nr_connect+0x6cb/0x1350 net/netrom/af_netrom.c:704
  __sys_connect+0x37d/0x4c0 net/socket.c:1664
  __do_sys_connect net/socket.c:1675 [inline]
  __se_sys_connect net/socket.c:1672 [inline]
  __x64_sys_connect+0x73/0xb0 net/socket.c:1672
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4482e9
Code: e8 cc e7 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 0b 01 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f6fed5b1cc8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00000000006ddc28 RCX: 00000000004482e9
RDX: 0000000000000048 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00000000006ddc20 R08: 00007ffd44256f4f R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006ddc2c
R13: 00007ffd44256f4f R14: 00007f6fed5b29c0 R15: 00000000006ddc20


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
