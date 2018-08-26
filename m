Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071B7C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 13:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9619C208E8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 13:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9619C208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbeHZRcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 13:32:41 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:43407 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbeHZRcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 13:32:41 -0400
Received: by mail-io0-f199.google.com with SMTP id w19-v6so11672375ioa.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 06:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wVcK1679bOTmxcD6z0jsUQj6zJ1j5aFY4Rf9zVSkwLE=;
        b=RznTeqySsn3MXLhllGtpskA+MAcoa0miQO4WBWIgZ4+gD719Iyues46Sw6EgerxFj1
         u2D15BDENSo2evcpxme8UaaYm/x8WRu9odM/2QCCrkvGGmmxCpv/6EGRWu3lJHfEP6vT
         GzWYvPJXXPCSiZ/HKJPr37OC5Bl6QBKNEf/vSKJ6/TFyCeBHXOzgzOQSCut0gPv6vOm4
         x+vn+2VVH4IInUL+TsH+4NfHRR290LdwoHdY1cbWVs0FrgVJTOWNlr50TWV/w+n8r2kZ
         sb8g0sYsaj83twvQdlpPUCcMlu8d2+9L/ShMcmrbl88QXn3RsB58KgKbKUd60+tWH2BX
         bm9Q==
X-Gm-Message-State: APzg51DrCLG95CqZshnU1UzmsZe8iQkTLy5dpgmXRUjXoC1GNYLJLzTs
        UmhBa6ZWRtK+IK0xm6o2gslBtNtuqn3bq9jCdOIaYyKCH5rT
X-Google-Smtp-Source: ANB0VdYo3VuIlH4+cCv205FyhP5DF+/Rnt/OBxOGoYY6W9YvIkS9CLQcFuAiZaUjLEANtoiBXSzK3mlXBL9GeGzrIpD1a2dDZeKE
MIME-Version: 1.0
X-Received: by 2002:a02:8c38:: with SMTP id l53-v6mr4054601jak.53.1535291402703;
 Sun, 26 Aug 2018 06:50:02 -0700 (PDT)
Date:   Sun, 26 Aug 2018 06:50:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af648b057456e234@google.com>
Subject: KASAN: invalid-free in p9stat_free
From:   syzbot <syzbot+d4252148d198410b864f@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, davem@davemloft.net, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e27bc174c9c6 Add linux-next specific files for 20180824
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15dc19a6400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28446088176757ea
dashboard link: https://syzkaller.appspot.com/bug?extid=d4252148d198410b864f
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f8efba400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1178256a400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d4252148d198410b864f@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
==================================================================
BUG: KASAN: double-free or invalid-free in p9stat_free+0x35/0x100  
net/9p/protocol.c:48

CPU: 0 PID: 4499 Comm: syz-executor922 Not tainted 4.18.0-next-20180824+ #47
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_invalid_free+0x64/0xa0 mm/kasan/report.c:336
  __kasan_slab_free+0x150/0x170 mm/kasan/kasan.c:501
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x210 mm/slab.c:3813
  p9stat_free+0x35/0x100 net/9p/protocol.c:48
  v9fs_dir_readdir+0x68e/0xbc0 fs/9p/vfs_dir.c:153
  iterate_dir+0x48b/0x5d0 fs/readdir.c:51
  __do_sys_getdents fs/readdir.c:231 [inline]
  __se_sys_getdents fs/readdir.c:212 [inline]
  __x64_sys_getdents+0x29f/0x510 fs/readdir.c:212
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4406a9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffc1b13808 EFLAGS: 00000217 ORIG_RAX: 000000000000004e
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00000000004406a9
RDX: 0000000000000008 RSI: 0000000020000180 RDI: 0000000000000005
RBP: 64663d736e617274 R08: 0000000000401f30 R09: 0000000000401f30
R10: 0000000000401f30 R11: 0000000000000217 R12: 0000000000401f30
R13: 0000000000401fc0 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 4499:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc mm/slab.c:3718 [inline]
  __kmalloc+0x14e/0x720 mm/slab.c:3727
  kmalloc include/linux/slab.h:518 [inline]
  p9pdu_vreadf net/9p/protocol.c:157 [inline]
  p9pdu_readf+0x526/0x2170 net/9p/protocol.c:536
  p9pdu_vreadf net/9p/protocol.c:208 [inline]
  p9pdu_readf+0xd5c/0x2170 net/9p/protocol.c:536
  p9stat_read+0x194/0x5d0 net/9p/protocol.c:565
  v9fs_dir_readdir+0x63d/0xbc0 fs/9p/vfs_dir.c:149
  iterate_dir+0x48b/0x5d0 fs/readdir.c:51
  __do_sys_getdents fs/readdir.c:231 [inline]
  __se_sys_getdents fs/readdir.c:212 [inline]
  __x64_sys_getdents+0x29f/0x510 fs/readdir.c:212
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 4499:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x210 mm/slab.c:3813
  p9stat_free+0x35/0x100 net/9p/protocol.c:48
  p9pdu_vreadf net/9p/protocol.c:220 [inline]
  p9pdu_readf+0xd90/0x2170 net/9p/protocol.c:536
  p9stat_read+0x194/0x5d0 net/9p/protocol.c:565
  v9fs_dir_readdir+0x63d/0xbc0 fs/9p/vfs_dir.c:149
  iterate_dir+0x48b/0x5d0 fs/readdir.c:51
  __do_sys_getdents fs/readdir.c:231 [inline]
  __se_sys_getdents fs/readdir.c:212 [inline]
  __x64_sys_getdents+0x29f/0x510 fs/readdir.c:212
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801b3006700
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes inside of
  32-byte region [ffff8801b3006700, ffff8801b3006720)
The buggy address belongs to the page:
page:ffffea0006cc0180 count:1 mapcount:0 mapping:ffff8801dac001c0  
index:0xffff8801b3006fc1
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffff8801dac01238 ffffea0006cc6548 ffff8801dac001c0
raw: ffff8801b3006fc1 ffff8801b3006000 0000000100000037 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801b3006600: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8801b3006680: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
> ffff8801b3006700: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
                    ^
  ffff8801b3006780: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8801b3006800: fb fb fb fb fc fc fc fc 05 fc fc fc fc fc fc fc
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
