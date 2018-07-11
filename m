Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80896C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3540B20871
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3540B20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389047AbeGKT6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:58:54 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:43431 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732921AbeGKT6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:58:54 -0400
Received: by mail-io0-f197.google.com with SMTP id n18-v6so23026314iog.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 12:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=YKX645I2TcBHBCXedIIuWTDUdLL3RS8/l2FFDAVnrXo=;
        b=gLm+vJamAsFsy7ss01Yq0ofA/OEY1c7ttav5RNYA+9nwr69pINf+obr769CAFFV/Zq
         awFqubvE7T3ZDKoEJ1G9jJTfzTqutFr0PrOScl3L2KIIaKtl05ouXNkGYfYaCUQZzXbK
         5Mq3r6iz1c+t/y4ci3UBJFWPbEza1H549Xthh19q9lyD3+HlcAl3ANOEv8Xv9bVQP8RZ
         NJYwUfsXB/xx6ksbPI/IHMOhaB/yqyEEHAH8YzuyodLBveaQhQk62cqsxvOYgNRTOLtm
         A+EQW1Xyd3FAQx3GW0lswD8vxkINj1Fi8BX90LwOApjHAOBMXbmBMJuYNaIfU49QBt6+
         5ESw==
X-Gm-Message-State: AOUpUlHP3ICbfiQCYcjwkpV9uZCvRb0oqvrbaUWKt0Xf7esxPfmTHNEh
        48d4NMsiLCaVCL9r2xx7xMOvRQzcTVoBN0vTbm0bhYS5oN6t
X-Google-Smtp-Source: AAOMgpeFXxafXd5N4FiFqpYxRvf/s0c54VA/pR9LLUHPxjk2EpYfUb02pU3/zvYWV7dVORkl2gBAH3RZ6THkCZfXpbhG1DwHGP8B
MIME-Version: 1.0
X-Received: by 2002:a24:b602:: with SMTP id g2-v6mr22223itf.16.1531338781864;
 Wed, 11 Jul 2018 12:53:01 -0700 (PDT)
Date:   Wed, 11 Jul 2018 12:53:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001fc22e0570be981a@google.com>
Subject: BUG: corrupted list in p9_fd_request
From:   syzbot <syzbot+47b2e3c10a15caedad75@syzkaller.appspotmail.com>
To:     davem@davemloft.net, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, rminnich@sandia.gov,
        syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    30c2c32d7f70 Merge tag 'drm-fixes-2018-07-10' of git://ano..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1776dac2400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
dashboard link: https://syzkaller.appspot.com/bug?extid=47b2e3c10a15caedad75
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+47b2e3c10a15caedad75@syzkaller.appspotmail.com

list_add double add: new=ffff880195f68818, prev=ffff880195f68818,  
next=ffff8801d8b8ad40.
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455c97
------------[ cut here ]------------
Code: 48
kernel BUG at lib/list_debug.c:31!
83
invalid opcode: 0000 [#1] SMP KASAN
c4
CPU: 0 PID: 6511 Comm: syz-executor1 Not tainted 4.18.0-rc4+ #140
08
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
48
RIP: 0010:__list_add_valid+0xaa/0xb0 lib/list_debug.c:29
89
Code:
d8
e8
5b
eb
5d
a9
c3
48
66
89 f7
0f
48
1f
89
84
75
00
e8
00
e8
00 00
61 52
00
59
48 89
fe
e8
48
48
8b
f7
75
d8
e8
48
eb bb
39
48
c3
89
0f
f2
92
48
c0
89
eb
d9
92
4c
66
89
90 b8
e6
10
48
00
c7
00
c7
00
60
0f
65 1a
05 <48>
88
3d
e8 7a
01
6f
f0 ff
02 fe
ff
<0f>
0f
0b 0f
83
1f 40
7d
00
bb fb
48 b8
ff
00
c3 66
00 00
2e
00 00
0f
fc ff
1f
df
84 00
55
00 00
48
00
89
e5
RSP: 002b:00007f836516da88 EFLAGS: 00000246
41 55
  ORIG_RAX: 0000000000000010
RSP: 0018:ffff88017fd573d0 EFLAGS: 00010282
RAX: ffffffffffffffda RBX: 00007f836516db30 RCX: 0000000000455c97
RAX: 0000000000000058 RBX: ffff8801d8b8ad40 RCX: ffffc90002236000
RDX: 0000000000000000 RSI: 0000000000004c01 RDI: 0000000000000016
RDX: 0000000000000000 RSI: ffffffff81631821 RDI: 0000000000000001
RBP: 0000000020000040 R08: 00007f836516db30 R09: 00007f836516dad0
RBP: ffff88017fd573e8 R08: ffff880191e48100 R09: ffffed003b5c4fc0
R10: ffffed003b5c4fc0 R11: ffff8801dae27e07 R12: ffff880195f68818
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000015
R13: ffff880199a8ee00 R14: ffff880195f687f0 R15: ffff880195f68818
FS:  00007f8135acb700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
R13: 0000000000000000 R14: 00000000004d3e38 R15: 0000000000000028
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdb706a040 CR3: 00000001aa239000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __list_add include/linux/list.h:60 [inline]
  list_add_tail include/linux/list.h:93 [inline]
  p9_fd_request+0x145/0x440 net/9p/trans_fd.c:667
  p9_client_rpc+0x290/0x1400 net/9p/client.c:768
  p9_client_clunk+0x93/0x180 net/9p/client.c:1488
  v9fs_dentry_release+0x68/0xd0 fs/9p/vfs_dentry.c:73
  __dentry_kill+0x4c0/0x7a0 fs/dcache.c:573
  dentry_kill+0xc9/0x5a0 fs/dcache.c:687
  dput.part.26+0x66b/0x7a0 fs/dcache.c:848
  dput fs/dcache.c:831 [inline]
  do_one_tree+0x37/0x40 fs/dcache.c:1531
  shrink_dcache_for_umount+0xc7/0x2b0 fs/dcache.c:1545
  generic_shutdown_super+0xd5/0x530 fs/super.c:438
  kill_anon_super+0x3c/0x50 fs/super.c:1046
  v9fs_kill_super+0x3e/0xa0 fs/9p/vfs_super.c:230
  deactivate_locked_super+0x97/0x100 fs/super.c:326
  deactivate_super+0x193/0x1c0 fs/super.c:357
  cleanup_mnt+0xbf/0x160 fs/namespace.c:1174
  __cleanup_mnt+0x16/0x20 fs/namespace.c:1181
  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:192 [inline]
  exit_to_usermode_loop+0x313/0x370 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455e29
Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f8135acac68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007f8135acb6d4 RCX: 0000000000455e29
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 00000000200002c0
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004c2aa8 R14: 00000000004d4510 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace dfed325e11645735 ]---
RIP: 0010:__list_add_valid+0xaa/0xb0 lib/list_debug.c:29
Code: e8 eb a9 48 89 f7 48 89 75 e8 e8 61 52 59 fe 48 8b 75 e8 eb bb 48 89  
f2 48 89 d9 4c 89 e6 48 c7 c7 60 65 1a 88 e8 7a 6f 02 fe <0f> 0b 0f 1f 40  
00 48 b8 00 00 00 00 00 fc ff df 55 48 89 e5 41 55
RSP: 0018:ffff88017fd573d0 EFLAGS: 00010282
RAX: 0000000000000058 RBX: ffff8801d8b8ad40 RCX: ffffc90002236000
RDX: 0000000000000000 RSI: ffffffff81631821 RDI: 0000000000000001
RBP: ffff88017fd573e8 R08: ffff880191e48100 R09: ffffed003b5c4fc0
R10: ffffed003b5c4fc0 R11: ffff8801dae27e07 R12: ffff880195f68818
R13: ffff880199a8ee00 R14: ffff880195f687f0 R15: ffff880195f68818
FS:  00007f8135acb700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdb706a040 CR3: 00000001aa239000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
