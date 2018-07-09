Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6059EC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 02:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4F5208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 02:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4F5208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754407AbeGICaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 22:30:04 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:36282 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754317AbeGICaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 22:30:03 -0400
Received: by mail-io0-f198.google.com with SMTP id y13-v6so3366269iop.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 19:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=eJ9v5xfiVEXXcyoUvHET8OFpCz9AM6k2KT40AbvZlrY=;
        b=tAZWbkFaOTZR2jBxhX3gLC5s3hR1nnblY8RUxIvQuZWYlvbKVm5AhQn4fKlSTwzFHY
         1tozWhcKCvpCWNnRMVXuET65GdA0U6hltjy1g5ZLZCbHwsyfJJcrcGn2nc4ByHVWhUtJ
         BMbKF5MRjn/kSZWIHr/6Z1qYroWXCSV8MO6WBRdhalRVsnj3SBv81lcE73XWhUJd9P5o
         YvnkUADnSZCfWZQ0canCVofAFfGlxP0tippWiA+8oNUeRE3PuuggOFpULpHkhhTS2OoM
         Nimk2m8duoAcnQexU4SfuDt1bVWoVuLgNQ/hhWwdEiQ4+5wUAlIxTbokL9elILWZ4bQj
         27tA==
X-Gm-Message-State: APt69E1TioH9FiBQzKkp/5QdIjuKm38tha6t1Hii7g5V+lhdRe8HJZEt
        9VP1sAQ/bVY8mnbpm16mz7B0ROwGuFrzbKX3w1xeP4hckIvu
X-Google-Smtp-Source: AAOMgpdlvJyKyUu0fx6JMZ24b26jBjUIMvHsAaSOrFfJDpftL4CDYUO/XsnP0aWWnQ0RkDc7SDhdA7y+EqFnWoz8DZp8RmuimtAR
MIME-Version: 1.0
X-Received: by 2002:a24:228c:: with SMTP id o134-v6mr8254693ito.30.1531103402339;
 Sun, 08 Jul 2018 19:30:02 -0700 (PDT)
Date:   Sun, 08 Jul 2018 19:30:02 -0700
In-Reply-To: <00000000000032412205706753b5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000693c7d057087caf3@google.com>
Subject: Re: BUG: corrupted list in cpu_stop_queue_work
From:   syzbot <syzbot+d8a8e42dfba0454286ff@syzkaller.appspotmail.com>
To:     bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        matt@codeblueprint.co.uk, mingo@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    526674536360 Add linux-next specific files for 20180706
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11ac81b2400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8d1cfc0cb798e48
dashboard link: https://syzkaller.appspot.com/bug?extid=d8a8e42dfba0454286ff
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1507ca2c400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10431a2c400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d8a8e42dfba0454286ff@syzkaller.appspotmail.com

RBP: 00000000006cb018 R08: 0000000000000002 R09: 00007fff6f890032
R10: 0000000020377000 R11: 0000000000000246 R12: 0000000000000003
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
list_add corruption. prev->next should be next (ffff8801daf26708), but was  
0000000000000000. (prev=ffff8801daf26740).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:28!
invalid opcode: 0000 [#1] SMP KASAN
CPU: 1 PID: 4449 Comm: syz-executor507 Not tainted  
4.18.0-rc3-next-20180706+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__list_add_valid.cold.0+0x23/0x25 lib/list_debug.c:26
Code: e8 9f 72 57 fe eb 97 48 89 d9 48 c7 c7 60 80 1a 88 e8 72 b8 ff fd 0f  
0b 48 89 f1 48 c7 c7 20 81 1a 88 48 89 de e8 5e b8 ff fd <0f> 0b 4c 89 e2  
48 89 de 48 c7 c7 60 82 1a 88 e8 4a b8 ff fd 0f 0b
RSP: 0018:ffff8801daf079c0 EFLAGS: 00010086
RAX: 0000000000000075 RBX: ffff8801daf26708 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81634381 RDI: 0000000000000001
RBP: ffff8801daf079d8 R08: ffff8801ad2464c0 R09: ffffed003b5e4fc0
R10: ffffed003b5e4fc0 R11: ffff8801daf27e07 R12: ffff8801daf26740
R13: ffff8801daf07ab8 R14: ffff8801daf26740 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000203e8008 CR3: 0000000008e6a000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  __list_add include/linux/list.h:60 [inline]
  list_add_tail include/linux/list.h:93 [inline]
  __cpu_stop_queue_work kernel/stop_machine.c:72 [inline]
  cpu_stop_queue_work+0x248/0x460 kernel/stop_machine.c:87
  stop_one_cpu_nowait+0xd3/0x100 kernel/stop_machine.c:341
  watchdog_timer_fn+0x93/0x2e0 kernel/watchdog.c:367
  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
  __hrtimer_run_queues+0x3eb/0x10c0 kernel/time/hrtimer.c:1460
  hrtimer_interrupt+0x2f3/0x750 kernel/time/hrtimer.c:1518
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
  smp_apic_timer_interrupt+0x165/0x730 arch/x86/kernel/apic/apic.c:1050
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:867
  </IRQ>
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x50 kernel/kcov.c:146
Code: 14 dd 28 00 00 00 4d 39 d0 72 1b 49 83 c1 01 4a 89 7c 10 e0 4a 89 74  
10 e8 4a 89 54 10 f0 4a 89 4c d8 20 4c 89 08 5d c3 66 90 <55> 65 48 8b 04  
25 40 ee 01 00 65 8b 15 5f 73 85 7e 48 89 e5 81 e2
RSP: 0018:ffff8801ad79e208 EFLAGS: 00000292 ORIG_RAX: ffffffffffffff13
RAX: ffff8801ad2464c0 RBX: ffffea000701e000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff819b034f RDI: 0000000000000007
RBP: ffff8801ad79e5a8 R08: ffff8801ad2464c0 R09: fffff94000e03c06
R10: fffff94000e03c06 R11: ffffea000701e037 R12: ffff8801ad79e580
R13: 1ffff10035af3c68 R14: dffffc0000000000 R15: 0000000000000000
  shmem_undo_range+0x38e/0x29a0 mm/shmem.c:795
  shmem_truncate_range+0x27/0xa0 mm/shmem.c:971
  shmem_evict_inode+0x3b2/0xcb0 mm/shmem.c:1071
  evict+0x4ae/0x990 fs/inode.c:558
  iput_final fs/inode.c:1508 [inline]
  iput+0x635/0xaa0 fs/inode.c:1534
  dentry_unlink_inode+0x4ae/0x640 fs/dcache.c:377
  __dentry_kill+0x44c/0x7a0 fs/dcache.c:569
  dentry_kill+0xc9/0x5a0 fs/dcache.c:688
  dput.part.26+0x66b/0x7a0 fs/dcache.c:849
  dput+0x15/0x20 fs/dcache.c:831
  __fput+0x558/0x930 fs/file_table.c:235
  ____fput+0x15/0x20 fs/file_table.c:251
  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1b08/0x2750 kernel/exit.c:869
  do_group_exit+0x177/0x440 kernel/exit.c:972
  __do_sys_exit_group kernel/exit.c:983 [inline]
  __se_sys_exit_group kernel/exit.c:981 [inline]
  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:981
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x43f0f8
Code: Bad RIP value.
RSP: 002b:00007fff6f8995b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043f0f8
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004bf1e8 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 0000000020377000 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d1180 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 599d79740552877c ]---
RIP: 0010:__list_add_valid.cold.0+0x23/0x25 lib/list_debug.c:26
Code: e8 9f 72 57 fe eb 97 48 89 d9 48 c7 c7 60 80 1a 88 e8 72 b8 ff fd 0f  
0b 48 89 f1 48 c7 c7 20 81 1a 88 48 89 de e8 5e b8 ff fd <0f> 0b 4c 89 e2  
48 89 de 48 c7 c7 60 82 1a 88 e8 4a b8 ff fd 0f 0b
RSP: 0018:ffff8801daf079c0 EFLAGS: 00010086
RAX: 0000000000000075 RBX: ffff8801daf26708 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81634381 RDI: 0000000000000001
RBP: ffff8801daf079d8 R08: ffff8801ad2464c0 R09: ffffed003b5e4fc0
R10: ffffed003b5e4fc0 R11: ffff8801daf27e07 R12: ffff8801daf26740
R13: ffff8801daf07ab8 R14: ffff8801daf26740 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000043f0ce CR3: 0000000008e6a000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

