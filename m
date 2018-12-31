Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F26C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 07:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27FA2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 07:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeLaHKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 02:10:05 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:40414 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbeLaHKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 02:10:05 -0500
Received: by mail-it1-f199.google.com with SMTP id 135so31299421itk.5
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 23:10:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=8t0KDMdy9Zeg4plPT0vxgN/PwCFX6d2UmIiIfq3Hoj0=;
        b=DxG4614Q+py/f142nAf3HfreS8v7PASa7eg6V/8C/thUdoHUAsk77J8sd/Pc36AENz
         O33dBBgcEggazT2mdTM5Z0nZQA+rOrn4OxXe4dpBjzXGa1b8NmNo4aAcQOUvTrl386xI
         iofHwaLvuVtFpKP1nQxELRkoa0sxfJiU/DGxViiVGsIaq7ec5bUuqhAsP1Yxs6TIdnlt
         r/K3M1yN4Y0dtx4Y+c+IQWK9BxuYNzAH8tqc+DziLpWkW0gJFFvuAZxtKYiHOnDhLwFT
         qXAc2oLPkOYRF5d427nayfgWWwcKCcfTOzrm1FToY3WyhYAiK4oEG7zfm3R+MiTnw6Xw
         alCA==
X-Gm-Message-State: AA+aEWYY2ESp2fR83zS3kELR4WVsu0ZohevnKd6B1qkEu5aTwzzJOBUs
        ouooSI6zwPX6pE7qiwxGdD30HlpSZsZB6Pewsk8YvO3hYU0I
X-Google-Smtp-Source: AFSGD/WtmXOVk3uQhDprmpKyqJTVEDfNe/ZKjADGdipUGch7epQXjNITQEKkDSV4A/6oaGJoYZUrByw7s5WFq6j6JDEFvIdOip9k
MIME-Version: 1.0
X-Received: by 2002:a24:50c:: with SMTP id 12mr26750292itl.18.1546240204136;
 Sun, 30 Dec 2018 23:10:04 -0800 (PST)
Date:   Sun, 30 Dec 2018 23:10:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001aea21057e4c1ab5@google.com>
Subject: BUG: corrupted list in account_entity_enqueue
From:   syzbot <syzbot+14005fa30c9a07192934@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    00c569b567c7 Merge tag 'locks-v4.21-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=136d858f400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fbee5876573727cd
dashboard link: https://syzkaller.appspot.com/bug?extid=14005fa30c9a07192934
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+14005fa30c9a07192934@syzkaller.appspotmail.com

attempt to access beyond end of device
list_add corruption. next->prev should be prev (ffff8880ae62d8d8), but was  
0000000000000000. (next=ffff8880a9e1e330).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:25!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 9 Comm: ksoftirqd/0 Not tainted 4.20.0+ #393
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__list_add_valid.cold.0+0xf/0x25 lib/list_debug.c:23
Code: e8 23 0b 32 fe e9 68 ff ff ff e8 19 0b 32 fe eb c9 4c 89 e7 e8 0f 0b  
32 fe eb 97 48 89 d9 48 c7 c7 40 c3 80 88 e8 32 ef d4 fd <0f> 0b 48 89 f1  
48 c7 c7 00 c4 80 88 48 89 de e8 1e ef d4 fd 0f 0b
RSP: 0018:ffff8880ae607218 EFLAGS: 00010082
RAX: 0000000000000075 RBX: ffff8880a9e1e330 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81683015 RDI: 0000000000000005
RBP: ffff8880ae607230 R08: ffff8880a9e1c240 R09: ffffed1015cc5020
R10: ffffed1015cc5020 R11: ffff8880ae628107 R12: ffff888059bac2f0
R13: 1ffff11015cc0e4b R14: ffff8880ae6072b8 R15: ffff888059bac2f0
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe5cdd85018 CR3: 000000008679a000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  __list_add include/linux/list.h:60 [inline]
  list_add include/linux/list.h:79 [inline]
  account_entity_enqueue+0x3a3/0x660 kernel/sched/fair.c:2679
  enqueue_entity+0x2af/0x1ff0 kernel/sched/fair.c:3903
  enqueue_task_fair+0x288/0x11f0 kernel/sched/fair.c:5134
  enqueue_task kernel/sched/core.c:730 [inline]
  activate_task+0x136/0x430 kernel/sched/core.c:751
  ttwu_activate kernel/sched/core.c:1643 [inline]
  ttwu_do_activate+0xd5/0x1f0 kernel/sched/core.c:1702
  ttwu_queue kernel/sched/core.c:1847 [inline]
  try_to_wake_up+0x9a3/0x1460 kernel/sched/core.c:2057
  wake_up_process+0x10/0x20 kernel/sched/core.c:2129
  hrtimer_wakeup+0x48/0x60 kernel/time/hrtimer.c:1637
  __run_hrtimer kernel/time/hrtimer.c:1389 [inline]
  __hrtimer_run_queues+0x41c/0x10d0 kernel/time/hrtimer.c:1451
  hrtimer_interrupt+0x313/0x780 kernel/time/hrtimer.c:1509
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1035 [inline]
  smp_apic_timer_interrupt+0x1a1/0x760 arch/x86/kernel/apic/apic.c:1060
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  </IRQ>
Modules linked in:
---[ end trace 8b80f5ec9872c871 ]---
RIP: 0010:__list_add_valid.cold.0+0xf/0x25 lib/list_debug.c:23
Code: e8 23 0b 32 fe e9 68 ff ff ff e8 19 0b 32 fe eb c9 4c 89 e7 e8 0f 0b  
32 fe eb 97 48 89 d9 48 c7 c7 40 c3 80 88 e8 32 ef d4 fd <0f> 0b 48 89 f1  
48 c7 c7 00 c4 80 88 48 89 de e8 1e ef d4 fd 0f 0b
RSP: 0018:ffff8880ae607218 EFLAGS: 00010082
RAX: 0000000000000075 RBX: ffff8880a9e1e330 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81683015 RDI: 0000000000000005
RBP: ffff8880ae607230 R08: ffff8880a9e1c240 R09: ffffed1015cc5020
R10: ffffed1015cc5020 R11: ffff8880ae628107 R12: ffff888059bac2f0
R13: 1ffff11015cc0e4b R14: ffff8880ae6072b8 R15: ffff888059bac2f0
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe5cdd85018 CR3: 000000008679a000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
