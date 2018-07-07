Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC72BC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87CDF224F8
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87CDF224F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753864AbeGGHQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 03:16:04 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:56788 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753605AbeGGHQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 03:16:02 -0400
Received: by mail-io0-f199.google.com with SMTP id n11-v6so11328253ioa.23
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 00:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=SV6WB5ULvRGy1la4J0TRzqmxRnN2i5hT2zXQdCMSyWY=;
        b=SECc6DT0mxIc86IUpgdSP7RfWpPadBE+tkFFRRWEgyYCXb6UgtYWjH44OaMHHO5dlR
         +kokaoiAQmVSHWOWi4vdZDFlV8lfi/Q/XhP10OnI4mTYjZEZtOR1izmzlFKMWtRowg4T
         /67SGGvYPcL9kyCHJdlflEcgVF5S0aCYpQjur3pdBN/8TEP6A1ayJDm87sraB88uVrI+
         yNwmT8gUMvEDyTvLXw22TfE/TJAblQIy3foOhwy3Yx8WmvYVYk+H5iSYto+630OFvLjr
         fVlzqKtLe8s7ECAWWisfJfDrAcZJTrs8o1ChwzOwpsgkxhOSdJg394AoQLaGej4g/aCO
         ujGw==
X-Gm-Message-State: APt69E2y2+3sqE4nzSbWK1OvhQ/BoMxRDvb5stQRyK9oFkh8vgH1YpOU
        3tVdkW2lq6SWHDndNXtxWnL2w+FfBan99w6SBqMjq0JcIMHb
X-Google-Smtp-Source: AAOMgpe1oaD88zeb7JGMZRnPKChQiBu30fyY7LGkk6W8u9HwNgYv+F32ew8u1X6k7LGkSRPWIsbDSzaZkE/4yWkKYO/+48FJvBE8
MIME-Version: 1.0
X-Received: by 2002:a6b:2491:: with SMTP id k139-v6mr5636479iok.70.1530947762323;
 Sat, 07 Jul 2018 00:16:02 -0700 (PDT)
Date:   Sat, 07 Jul 2018 00:16:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b09c20570638d45@google.com>
Subject: kernel BUG at mm/vmscan.c:LINE!
From:   syzbot <syzbot+93c67806397421af04d5@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, aryabinin@virtuozzo.com, guro@fb.com,
        hannes@cmpxchg.org, jbacik@fb.com, ktkhai@virtuozzo.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        penguin-kernel@I-love.SAKURA.ne.jp, rientjes@google.com,
        sfr@canb.auug.org.au, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com, vdavydov.dev@gmail.com,
        willy@infradead.org, ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    526674536360 Add linux-next specific files for 20180706
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13853f48400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8d1cfc0cb798e48
dashboard link: https://syzkaller.appspot.com/bug?extid=93c67806397421af04d5
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+93c67806397421af04d5@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at mm/vmscan.c:593!
invalid opcode: 0000 [#1] SMP KASAN
CPU: 0 PID: 5039 Comm: syz-executor5 Not tainted 4.18.0-rc3-next-20180706+  
#1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:shrink_slab_memcg mm/vmscan.c:593 [inline]
RIP: 0010:shrink_slab+0xb3e/0xdb0 mm/vmscan.c:672
Code: 8d a8 fd ff ff f0 48 0f b3 08 e8 3d b8 da ff 48 8b 85 c0 fd ff ff c7  
00 f8 f8 f8 f8 c6 40 04 f8 e9 5d fb ff ff e8 22 b8 da ff <0f> 0b e8 1b b8  
da ff 48 8b 9d d8 fd ff ff 31 ff 48 89 de e8 3a b9
RSP: 0018:ffff88019aa0eb50 EFLAGS: 00010212
RAX: 0000000000040000 RBX: ffff88019aa0eda0 RCX: ffffc90001e24000
RDX: 0000000000000b7a RSI: ffffffff81a1c23e RDI: 0000000000000007
RBP: ffff88019aa0edc8 R08: ffff88019ed86340 R09: ffffed00399ff4b8
R10: ffffed00399ff4b8 R11: ffff8801ccffa5c7 R12: dffffc0000000000
R13: ffff8801cc3231f0 R14: 0000000000000000 R15: ffff88019aa0ebe0
FS:  00007fa51a834700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa51a803008 CR3: 00000001ad011000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  shrink_node+0x429/0x16a0 mm/vmscan.c:2736
  shrink_zones mm/vmscan.c:2965 [inline]
  do_try_to_free_pages+0x3e7/0x1290 mm/vmscan.c:3027
  try_to_free_mem_cgroup_pages+0x49d/0xc90 mm/vmscan.c:3325
  memory_high_write+0x283/0x310 mm/memcontrol.c:5597
  cgroup_file_write+0x31f/0x840 kernel/cgroup/cgroup.c:3500
  kernfs_fop_write+0x2ba/0x480 fs/kernfs/file.c:316
  __vfs_write+0x117/0x9f0 fs/read_write.c:485
  __kernel_write+0x10c/0x370 fs/read_write.c:506
  write_pipe_buf+0x181/0x240 fs/splice.c:798
  splice_from_pipe_feed fs/splice.c:503 [inline]
  __splice_from_pipe+0x38e/0x7c0 fs/splice.c:627
  splice_from_pipe+0x1ea/0x340 fs/splice.c:662
  default_file_splice_write+0x3c/0x90 fs/splice.c:810
  do_splice_from fs/splice.c:852 [inline]
  direct_splice_actor+0x128/0x190 fs/splice.c:1019
  splice_direct_to_actor+0x318/0x8f0 fs/splice.c:974
  do_splice_direct+0x2d4/0x420 fs/splice.c:1062
  do_sendfile+0x62a/0xe20 fs/read_write.c:1440
  __do_sys_sendfile64 fs/read_write.c:1495 [inline]
  __se_sys_sendfile64 fs/read_write.c:1487 [inline]
  __x64_sys_sendfile64+0x15d/0x250 fs/read_write.c:1487
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455ba9
Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fa51a833c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fa51a8346d4 RCX: 0000000000455ba9
RDX: 0000000020000040 RSI: 0000000000000015 RDI: 0000000000000015
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004c0dc5 R14: 00000000004d0e78 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 607c0e9f278af1e6 ]---
RIP: 0010:shrink_slab_memcg mm/vmscan.c:593 [inline]
RIP: 0010:shrink_slab+0xb3e/0xdb0 mm/vmscan.c:672
Code: 8d a8 fd ff ff f0 48 0f b3 08 e8 3d b8 da ff 48 8b 85 c0 fd ff ff c7  
00 f8 f8 f8 f8 c6 40 04 f8 e9 5d fb ff ff e8 22 b8 da ff <0f> 0b e8 1b b8  
da ff 48 8b 9d d8 fd ff ff 31 ff 48 89 de e8 3a b9
RSP: 0018:ffff88019aa0eb50 EFLAGS: 00010212
RAX: 0000000000040000 RBX: ffff88019aa0eda0 RCX: ffffc90001e24000
RDX: 0000000000000b7a RSI: ffffffff81a1c23e RDI: 0000000000000007
RBP: ffff88019aa0edc8 R08: ffff88019ed86340 R09: ffffed00399ff4b8
R10: ffffed00399ff4b8 R11: ffff8801ccffa5c7 R12: dffffc0000000000
R13: ffff8801cc3231f0 R14: 0000000000000000 R15: ffff88019aa0ebe0
FS:  00007fa51a834700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa51a803008 CR3: 00000001ad011000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
