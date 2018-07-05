Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0B3C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 04:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A45A24163
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 04:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A45A24163
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752551AbeGEEtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 00:49:04 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:38544 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751421AbeGEEtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 00:49:03 -0400
Received: by mail-io0-f197.google.com with SMTP id s24-v6so5941534iob.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 21:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=hdRhdt/W0t/QjzJsCGImjVT9pQPcVJyTX8MIRZcNpyc=;
        b=llBVMekzg7LeOUmEhD4g0UnimwhSg2KkjgheBe4DhaeX3a0e2169Xn2DGq5CSgKD45
         Se0b9NosI55J+wm5kZQqnZYmtWmwmAw2mEtjhlGRQsR3+POYKXzpmiaFR0elhuEYs3AM
         xwJQPaIzspyLWWSyPXpr4sKWJGiMXZ66Sm/v1kak9NxT5epFL57T1QFy0PLpdAdM+ike
         AseTneH3LT6TyWmtutFtoqKTJzLWmUabilHGYa2yv8qy2iJOGU60xW0+c/pr/8+wu305
         vbamhcW6u/AKjHr5wdpmxqWYoMoOM4AmTRBhHK3pE8JGe7XV8nBc4Ok9ZsLm7KR/lf4R
         ca/g==
X-Gm-Message-State: APt69E03NLrgUblXFE/CBGYAa17PjiGiYqvwJ8KfONug41Bypzt0TWuL
        cdjwgz7P0/A5bTbjm4QUd07h4/+Em4JA6UDUc8idzhL5dhZs
X-Google-Smtp-Source: AAOMgpc4o6AYCLOXIh+WD5OFo1Hyee5itvJhE12OXYWgkiatTEVRe1OwJh6XJxYtmtcnVB8OUJR1mQcbUEqqFOHtAQcOJsTRavAm
MIME-Version: 1.0
X-Received: by 2002:a24:69c2:: with SMTP id e185-v6mr2033695itc.55.1530766142429;
 Wed, 04 Jul 2018 21:49:02 -0700 (PDT)
Date:   Wed, 04 Jul 2018 21:49:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002769a90570394450@google.com>
Subject: KASAN: stack-out-of-bounds Read in move_expired_inodes
From:   syzbot <syzbot+eb366f9430d25498f0f6@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    2bdea157b999 Merge branch 'sctp-fully-support-for-dscp-and..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17d35aa4400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f62553dc846b0692
dashboard link: https://syzkaller.appspot.com/bug?extid=eb366f9430d25498f0f6
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=149e9e0c400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17464278400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+eb366f9430d25498f0f6@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
IPVS: ftp: loaded support on port[0] = 21
==================================================================
BUG: KASAN: stack-out-of-bounds in move_expired_inodes+0xcb5/0xd80  
fs/fs-writeback.c:1120
Read of size 8 at addr ffff8801a802c750 by task kworker/u4:4/849

CPU: 0 PID: 849 Comm: kworker/u4:4 Not tainted 4.18.0-rc3+ #45
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  move_expired_inodes+0xcb5/0xd80 fs/fs-writeback.c:1120
  queue_io+0x309/0x860 fs/fs-writeback.c:1169
  wb_writeback+0xaf9/0xf80 fs/fs-writeback.c:1761
  wb_check_old_data_flush fs/fs-writeback.c:1867 [inline]
  wb_do_writeback fs/fs-writeback.c:1920 [inline]
  wb_workfn+0xfb7/0x1760 fs/fs-writeback.c:1949
  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
  kthread+0x345/0x410 kernel/kthread.c:240
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

Allocated by task 2170490192:
BUG: unable to handle kernel paging request at ffffffff8c430958
PGD 8e6d067 P4D 8e6d067 PUD 8e6e063 PMD 0
Oops: 0000 [#1] SMP KASAN
CPU: 0 PID: 849 Comm: kworker/u4:4 Not tainted 4.18.0-rc3+ #45
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: writeback wb_workfn (flush-8:0)
RIP: 0010:depot_fetch_stack+0x10/0x30 lib/stackdepot.c:201
Code: e8 65 30 47 fe e9 b3 fd ff ff e8 5b 30 47 fe e9 55 fd ff ff 90 90 90  
90 90 90 89 f8 c1 ef 11 25 ff ff 1f 00 81 e7 f0 3f 00 00 <48> 03 3c c5 60  
09 43 8b 8b 47 0c 48 83 c7 18 c7 46 10 00 00 00 00
RSP: 0018:ffff8801d7dae930 EFLAGS: 00010006
RAX: 00000000001fffff RBX: ffff8801a802cbb4 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff8801d7dae938 RDI: 0000000000003ff0
RBP: ffff8801d7dae960 R08: ffff8801d7c4e380 R09: ffffed003b5c3ec2
R10: ffffed003b5c3ec2 R11: ffff8801dae1f617 R12: ffff8801a802c400
R13: ffff8801a802c750 R14: ffff8801d3f30e40 R15: ffff8801a802cbb0
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff8c430958 CR3: 00000001bb012000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  describe_object mm/kasan/report.c:243 [inline]
  print_address_description+0xfb/0x20b mm/kasan/report.c:263
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  move_expired_inodes+0xcb5/0xd80 fs/fs-writeback.c:1120
  queue_io+0x309/0x860 fs/fs-writeback.c:1169
  wb_writeback+0xaf9/0xf80 fs/fs-writeback.c:1761
PANIC: double fault, error_code: 0x0
CPU: 1 PID: 8116 Comm: syz-executor725 Not tainted 4.18.0-rc3+ #45
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__lock_acquire+0x2e/0x5020 kernel/locking/lockdep.c:3294
Code: 41
57
41 89
  wb_check_old_data_flush fs/fs-writeback.c:1867 [inline]
  wb_do_writeback fs/fs-writeback.c:1920 [inline]
  wb_workfn+0xfb7/0x1760 fs/fs-writeback.c:1949
  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
cf
41 56
41 55
49 89
fd 41
54 45
89 cc
53 65
4c 8b
34 25
40 ee
01 00
  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
48 83
e4 f0
48 81
ec 60
03 00
00 48
8b
45 10
<89>
94 24
80 00
00 00
  kthread+0x345/0x410 kernel/kthread.c:240
48 ba
00 00
00
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
00 00
Modules linked in:
fc ff
df 48
Dumping ftrace buffer:
89 84
    (ftrace buffer empty)
24 98
CR2: ffffffff8c430958
RSP: 0018:ffff8800fffffed0 EFLAGS: 00010082
---[ end trace 565e600e75d0194b ]---
RIP: 0010:depot_fetch_stack+0x10/0x30 lib/stackdepot.c:201
RAX: 0000000000000000 RBX: 1ffff10020000056 RCX: 0000000000000002
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff88f92620
Code:
RBP: ffff880100000258 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: dffffc0000000000 R12: 0000000000000000
e8
R13: ffffffff88f92620 R14: ffff8801cf4343c0 R15: 0000000000000002
FS:  00007f2e19c1b700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
65
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8800fffffec8 CR3: 0000000008e6a000 CR4: 00000000001406e0
30
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
47
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
fe


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
