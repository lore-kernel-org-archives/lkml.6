Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4BFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1557F214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMOswsu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1557F214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732253AbeKNTGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:06:06 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36076 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeKNTGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 14:06:06 -0500
Received: by mail-it1-f196.google.com with SMTP id w7-v6so22798070itd.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 01:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=OQ63Dkph1ZeurRFVKrW9Du5IqPOwtlYuQhEv39Dp/HU=;
        b=IMOswsu1qRqtjz2/sMiHTljbRR/3dhz7V5m0F9vaBWyr0FNBvfVLga1t8Uivk22Sim
         tYTwqVm6Typ1L0EVScnHQ4AxqySqCJw+S5h04zRF9IaQNzzAEq4S1asY3X5dpsVtehNo
         UzMndbG9OX75Icqo71Syf1I48sexj+HP013tcGemk9N24eY7qkTdVsu1qeXRnnLJ6uTJ
         /u7HBMTk+J5dbvETj2gJC/q7PU1WtBBBG2te1efOak5HrXzFEWD5SMixcAdR7uMxldm+
         WPRvW93ICUmz/YGephanGn3+rubAQuUSR9E+MFom22z1dnNrGlc5KQKrtt92w3XgChb6
         W/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=OQ63Dkph1ZeurRFVKrW9Du5IqPOwtlYuQhEv39Dp/HU=;
        b=XuwTw8erOiY+rO1YXDdWsbw4Uo4TfGicKiULuOBKQ1QQWSClZMD+wTuEaPXek1DIH/
         eSEHC6yxH/ifNCkqS0a4C9SEYYqCT5bXQKF+NR4kofLsKkdz6QN9lbo/fxy7F0YjUDK7
         uaJZ9uBSCr054JHaXCs5+3hTudZGqDMzGuwElLXIWcGmN9X/41kdS9Q+/FQqzfwB7ZSc
         CM2ObONcTJSdoIJ2GLxS9L5YKBuu/4r6ubfbAe4LKSgqOR8oJTKcZf+q4FrZcAzh7ACO
         a7clw5xFq2D6tFS3blSANR5s/PVgcluFmtnDt0jSCNVQrjj8xk3T8IGTDBExvIP95G+E
         QSLw==
X-Gm-Message-State: AGRZ1gIR+Fn6OW9muk1uSmv2aVYj//xcwLPYrQdro39ENw2SPlrX50Zh
        qYhz4t4pNdjxasaX0YcUasEry6yiFUVDpyNmqWg=
X-Google-Smtp-Source: AJdET5czPMMTfOKTBlqSY/NmdsrFGZLV7cEH02qxtlYq4l7uuLunKiZUPhRurPoPr8UA06WOnWdnVuf024AKOCI+4iw=
X-Received: by 2002:a02:8a69:: with SMTP id e38mr892272jal.81.1542186224705;
 Wed, 14 Nov 2018 01:03:44 -0800 (PST)
MIME-Version: 1.0
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Wed, 14 Nov 2018 04:03:33 -0500
Message-ID: <CAEAjamtSGa6hVqe2QDTONjHp7H8qCvMYYuFSTswiSEnx5oUAeQ@mail.gmail.com>
Subject: KMSAN: uninit-value in rcu_accelerate_cbs / KMSAN: uninit-value in rcu_process_callbacks
To:     paulmck@linux.vnet.ibm.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Cc:     Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        syzkaller@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We report two crashes in v4.19-rc8 (4.20-rc1 as well, I guess):
(Unfortunately, there is no repro for those.)

The two crashes seem to share the same issue.
In both cases, (uninitialized) memory access violation occurs
when "rdp->cblist" is about to be accessed (kernel/rcu/tree.c:2838,1728).
I guess those are freed before the use, but I still haven't figured
out the reason why.
I'm looking forward to some help.

Crash log 1
=========================================
BUG: KMSAN: uninit-value in __rcu_process_callbacks
kernel/rcu/tree.c:2838 [inline]
BUG: KMSAN: uninit-value in rcu_process_callbacks+0x5ac/0x1cb0
kernel/rcu/tree.c:2864
CPU: 0 PID: 20 Comm: kauditd Not tainted 4.19.0-rc8+ #18
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x305/0x460 lib/dump_stack.c:113
 kmsan_report+0x1a2/0x2e0 mm/kmsan/kmsan.c:917
 __msan_warning+0x7d/0xe0 mm/kmsan/kmsan_instr.c:500
 __rcu_process_callbacks kernel/rcu/tree.c:2838 [inline]
 rcu_process_callbacks+0x5ac/0x1cb0 kernel/rcu/tree.c:2864
 __do_softirq+0x5ff/0xa55 kernel/softirq.c:292
 invoke_softirq kernel/softirq.c:373 [inline]
 irq_exit+0x22d/0x270 kernel/softirq.c:414
 exiting_irq+0xe/0x10 arch/x86/include/asm/apic.h:536
 smp_apic_timer_interrupt+0x64/0x90 arch/x86/kernel/apic/apic.c:1059
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:869
 </IRQ>
RIP: 0010:finish_lock_switch+0x2b/0x40 kernel/sched/core.c:2578
Code: 48 89 e5 53 48 89 fb e8 e3 43 9a 00 8b b8 88 0c 00 00 48 8b 00
48 85 c0 75 12 48 89 df e8 7d 38 9a 00 c6 00 00 c6 03 00 fb 5b <5d> c3
e8 de 42 9a 00 eb e7 66 66 66 2e 0f 1f 84 00 00 00 00 00 55
RSP: 0018:ffff88010622fca0 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
RAX: ffff8801105bcc40 RBX: ffff8801061554c0 RCX: ffff8801105bdc40
RDX: ffff8801105bdc40 RSI: aaaaaaaaaaaab000 RDI: ffffea00077ec560
RBP: ffff88010622fca0 R08: ffffffff7fffffff R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8800751cb880
R13: 0000000000000000 R14: ffff880106155db8 R15: ffff88013fcb9c40
 finish_task_switch+0xe3/0x270 kernel/sched/core.c:2679
 context_switch kernel/sched/core.c:2832 [inline]
 __schedule+0x78f/0x8f0 kernel/sched/core.c:3479
 schedule+0x1cc/0x300 kernel/sched/core.c:3523
 kauditd_thread+0xc64/0xee0 kernel/audit.c:889
 kthread+0x5b1/0x5f0 kernel/kthread.c:247
 ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:416

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:255 [inline]
 kmsan_internal_alloc_meta_for_pages+0x157/0x730 mm/kmsan/kmsan.c:693
 kmsan_alloc_page+0x80/0xe0 mm/kmsan/kmsan_hooks.c:320
 __alloc_pages_nodemask+0x128c/0x69b0 mm/page_alloc.c:4416
 alloc_pages_current+0x51f/0x760 mm/mempolicy.c:2093
 alloc_pages include/linux/gfp.h:511 [inline]
 alloc_slab_page mm/slub.c:1459 [inline]
 allocate_slab mm/slub.c:1604 [inline]
 new_slab+0x552/0x1f30 mm/slub.c:1675
 new_slab_objects mm/slub.c:2438 [inline]
 ___slab_alloc+0x1414/0x1dd0 mm/slub.c:2590
 __slab_alloc mm/slub.c:2630 [inline]
 slab_alloc_node mm/slub.c:2693 [inline]
 slab_alloc mm/slub.c:2735 [inline]
 kmem_cache_alloc+0xc9b/0xda0 mm/slub.c:2740
 kmem_cache_zalloc include/linux/slab.h:697 [inline]
 avc_alloc_node+0x109/0xb90 security/selinux/avc.c:572
 avc_update_node+0x172/0x1ee0 security/selinux/avc.c:859
 avc_denied+0x312/0x360 security/selinux/avc.c:1024
 avc_has_perm_noaudit+0x733/0x770 security/selinux/avc.c:1155
 avc_has_perm+0x172/0x480 security/selinux/avc.c:1184
 sock_has_perm security/selinux/hooks.c:4539 [inline]
 selinux_socket_sendmsg+0x297/0x360 security/selinux/hooks.c:4875
 security_socket_sendmsg+0x127/0x200 security/security.c:1410
 sock_sendmsg net/socket.c:628 [inline]
 ___sys_sendmsg+0xd5f/0x1290 net/socket.c:2116
 __sys_sendmsg net/socket.c:2154 [inline]
 __do_sys_sendmsg net/socket.c:2163 [inline]
 __se_sys_sendmsg+0x307/0x460 net/socket.c:2161
 __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2161
 do_syscall_64+0xb8/0x100 arch/x86/entry/common.c:291
 entry_SYSCALL_64_after_hwframe+0x63/0xe7
=========================================================

Crash log 2
=========================================================
BUG: KMSAN: uninit-value in rcu_accelerate_cbs+0x821/0x990
kernel/rcu/tree.c:1728
CPU: 0 PID: 10 Comm: rcu_sched Not tainted 4.19.0-rc8+ #18
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x305/0x460 lib/dump_stack.c:113
 kmsan_report+0x1a2/0x2e0 mm/kmsan/kmsan.c:917
 __msan_warning+0x7d/0xe0 mm/kmsan/kmsan_instr.c:500
 rcu_accelerate_cbs+0x821/0x990 kernel/rcu/tree.c:1728
 __note_gp_changes+0x2ac/0x9e0 kernel/rcu/tree.c:1807
 rcu_gp_cleanup kernel/rcu/tree.c:2109 [inline]
 rcu_gp_kthread+0x3019/0x3990 kernel/rcu/tree.c:2236
 kthread+0x5b1/0x5f0 kernel/kthread.c:247
 ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:416

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:255 [inline]
 kmsan_internal_alloc_meta_for_pages+0x157/0x730 mm/kmsan/kmsan.c:693
 kmsan_alloc_page+0x80/0xe0 mm/kmsan/kmsan_hooks.c:320
 __alloc_pages_nodemask+0x128c/0x69b0 mm/page_alloc.c:4416
 alloc_pages_current+0x51f/0x760 mm/mempolicy.c:2093
 alloc_pages include/linux/gfp.h:511 [inline]
 alloc_slab_page mm/slub.c:1459 [inline]
 allocate_slab mm/slub.c:1604 [inline]
 new_slab+0x552/0x1f30 mm/slub.c:1675
 new_slab_objects mm/slub.c:2438 [inline]
 ___slab_alloc+0x1414/0x1dd0 mm/slub.c:2590
 __slab_alloc mm/slub.c:2630 [inline]
 slab_alloc_node mm/slub.c:2693 [inline]
 slab_alloc mm/slub.c:2735 [inline]
 kmem_cache_alloc+0xc9b/0xda0 mm/slub.c:2740
 kmem_cache_zalloc include/linux/slab.h:697 [inline]
 avc_alloc_node+0x109/0xb90 security/selinux/avc.c:572
 avc_insert security/selinux/avc.c:696 [inline]
 avc_compute_av+0x31e/0x1050 security/selinux/avc.c:1008
 avc_has_perm_noaudit+0x516/0x770 security/selinux/avc.c:1149
 avc_has_perm+0x172/0x480 security/selinux/avc.c:1184
 selinux_socket_create+0x248/0x3c0 security/selinux/hooks.c:4560
 security_socket_create+0x146/0x210 security/security.c:1372
 __sock_create+0x26b/0xf30 net/socket.c:1232
 sock_create net/socket.c:1317 [inline]
 __sys_socket+0x180/0x670 net/socket.c:1347
 __do_sys_socket net/socket.c:1356 [inline]
 __se_sys_socket+0x8d/0xb0 net/socket.c:1354
 __x64_sys_socket+0x4a/0x70 net/socket.c:1354
 do_syscall_64+0xb8/0x100 arch/x86/entry/common.c:291
 entry_SYSCALL_64_after_hwframe+0x63/0xe7
=========================================================

Thanks,
Kyungtae Kim
