Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A4EC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 03:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC6D208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 03:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC6D208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933092AbeGIDJa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 23:09:30 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:41296 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932720AbeGIDJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 23:09:05 -0400
Received: by mail-io0-f200.google.com with SMTP id p12-v6so1166647iog.8
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 20:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=TeKoTv30eXAcqYxvdt7BD7ozUa5m56P+dm4EUklDZK8=;
        b=GA0AVudmn8mf4HmrpgctHZwqVydTnUbNlLEUFPNqhICEsLZkMW2Zr8tjLnnKnWq//Z
         4s676w4vsh1gdp6JfsqXOkByUCFkKNVu4KjM3iJqZRHD/7VaMXfLRulPrLTNcUwMMGB2
         IU0d8lzK8+cx8MvYY7mMTviY79vQ15jSjAOCjGC2I+KuyA5S60mfBvsDY8jSYy2xuhWa
         C8Vcdq7PPqmvAJ3Dvwd/iLnauHQbngn5uTGi2P+EJJKSfBNV54HS53F30auvr5dxAUwZ
         Sd415d1u80rG6+I8dMgO2GSIM/ohE4q8C2XsNjYRfYUw4d9MwfRcygCGq8c12D1cJfmX
         s4PA==
X-Gm-Message-State: APt69E0Ir57sCvfh8BJZ8qaOG+YH0X/BzENX1/FPJNEaoFqg9Sq1XOlm
        SOnRnS16cylKIaCWYCIkxfjazTPTyqikBpFxFN6m2KWtc+lU
X-Google-Smtp-Source: AAOMgpcCAbCQB3sR/nqjuBPd6kCv6VKJ3MZopnPIiQIRIAPI+eaSCVOpU575y1nbf+4ysJ4NuKDYQ8r8Dge/cFK725bwoeYJrwru
MIME-Version: 1.0
X-Received: by 2002:a24:ee4d:: with SMTP id b74-v6mr8128821iti.9.1531105744454;
 Sun, 08 Jul 2018 20:09:04 -0700 (PDT)
Date:   Sun, 08 Jul 2018 20:09:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000311c905708856bf@google.com>
Subject: KASAN: stack-out-of-bounds Read in add_wait_queue
From:   syzbot <syzbot+b1b8812f7c2ce78da0e5@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, ebiederm@xmission.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        sudipm.mukherjee@gmail.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, zhongjiang@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ca04b3cca11a Merge tag 'armsoc-fixes' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=123180c8400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca6c7a31d407f86
dashboard link: https://syzkaller.appspot.com/bug?extid=b1b8812f7c2ce78da0e5
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=16dc56d0400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170f4f48400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b1b8812f7c2ce78da0e5@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
IPVS: ftp: loaded support on port[0] = 21
==================================================================
BUG: KASAN: stack-out-of-bounds in __lock_acquire+0x3829/0x5020  
kernel/locking/lockdep.c:3314
Read of size 8 at addr ffff8801a91dc738 by task syz-executor471/4532

CPU: 0 PID: 4532 Comm: syz-executor471 Not tainted 4.18.0-rc3+ #137
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __lock_acquire+0x3829/0x5020 kernel/locking/lockdep.c:3314
  lock_acquire+0x1e4/0x540 kernel/locking/lockdep.c:3924
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
  add_wait_queue+0x92/0x2b0 kernel/sched/wait.c:22
  do_wait+0x1bf/0xb80 kernel/exit.c:1505
  kernel_wait4+0x247/0x3f0 kernel/exit.c:1665
  __do_sys_wait4+0x137/0x150 kernel/exit.c:1677
  __se_sys_wait4 kernel/exit.c:1673 [inline]
  __x64_sys_wait4+0x97/0xf0 kernel/exit.c:1673
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x405faa
Code: c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 8b 05 0e cc 2d 00 85  
c0 75 36 45 31 d2 48 63 d2 48 63 ff b8 3d 00 00 00 0f 05 <48> 3d 00 f0 ff  
ff 77 06 c3 0f 1f 44 00 00 48 c7 c2 d0 ff ff ff f7
RSP: 002b:00007fff2e852408 EFLAGS: 00000246 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 00000000000007b5 RCX: 0000000000405faa
RDX: 0000000040000001 RSI: 00007fff2e85241c RDI: ffffffffffffffff
RBP: 00000000000007b5 R08: 0000000000000001 R09: 00000000023e4880
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000291
R13: 000000000001b4c3 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 4531:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x760 mm/slab.c:3554
  kmem_cache_zalloc include/linux/slab.h:697 [inline]
  copy_signal+0x175/0xc10 kernel/fork.c:1443
  copy_process.part.39+0x2137/0x7220 kernel/fork.c:1800
  copy_process kernel/fork.c:1616 [inline]
  _do_fork+0x291/0x12a0 kernel/fork.c:2099
  __do_sys_clone kernel/fork.c:2206 [inline]
  __se_sys_clone kernel/fork.c:2200 [inline]
  __x64_sys_clone+0xbf/0x150 kernel/fork.c:2200
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 0:
(stack is not available)

The buggy address belongs to the object at ffff8801a91dc700
  which belongs to the cache signal_cache of size 1296
The buggy address is located 56 bytes inside of
  1296-byte region [ffff8801a91dc700, ffff8801a91dcc10)
The buggy address belongs to the page:
page:ffffea0006a47700 count:1 mapcount:0 mapping:ffff8801da97be40 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffffea0006b3ca88 ffffea0006b2f888 ffff8801da97be40
raw: 0000000000000000 ffff8801a91dc140 0000000100000005 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801a91dc600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8801a91dc680: 00 00 00 00 f1 f1 f1 f1 00 f2 f2 f2 f2 f2 f2 f2
> ffff8801a91dc700: 00 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 f2 f2 f2 f2
                                         ^
  ffff8801a91dc780: f8 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 00 00 00 00
  ffff8801a91dc800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
