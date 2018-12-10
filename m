Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DC7C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 05:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2251920821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 05:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2251920821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbeLJFBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 00:01:05 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:52382 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbeLJFBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 00:01:04 -0500
Received: by mail-it1-f198.google.com with SMTP id o205so12561622itc.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 21:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=oBFbwG1Ab28PXk8XYYWCckVGZX0FALlRzh7lWdKUnVE=;
        b=oNYiNL1iFrFvnUwtrJGX0G1Rvn2rU3EXk6c+LqkMw7GRT90SdDRBRNw2FfJ6XCcBT1
         R+4TM8SFsxzNIdq/U2XmH3oqjv/5P+SBdKz7tS3h9p1CQYNmPFuX9l1CdKSWQG2nxY9t
         PcD2YyReJZ2fxFZsnBNjnGI3vzGLLd6CahXRsONRNjvtJR/BP7lzJ8dRkLj13qzk7lda
         WcJJGLWePeRzoNSQAnfqZ+fpwzrZm+prWaYHWMGqSRT+xQ7Ik5mgD2r4e1m/lyEe/GF2
         tBSdMt+zbj/WRHoy3PIwHtAwMkv17gFfCnKV6ZozliuJzXJ+AqjShlWhxK4nxIn2ucb0
         D+jQ==
X-Gm-Message-State: AA+aEWYV/A/FKIFmzacSHnhJ9/1zdSF7u0NukwrO0lFtVow99nheBV0d
        //EWt4PH+UHH1RjfteRGDmTs8Jj9LVBPy1wBKzx7nboSIVcX
X-Google-Smtp-Source: AFSGD/W1IQk6eBL3v1CpY+djQqtAw5s0Ja5PALKX86YYBtSJHls+CoLv0gIJ6wLogSFiXe/U4xuQCQrtVFD1LWvZBo2rR/BISJhr
MIME-Version: 1.0
X-Received: by 2002:a24:5755:: with SMTP id u82mr9590403ita.16.1544418063481;
 Sun, 09 Dec 2018 21:01:03 -0800 (PST)
Date:   Sun, 09 Dec 2018 21:01:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000f05cb057ca3dad0@google.com>
Subject: KASAN: use-after-free Read in tipc_group_bc_cong
From:   syzbot <syzbot+10a9db47c3a0e13eb31c@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    0844895a2e51 Merge tag 'char-misc-4.20-rc6' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=153c1925400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8110fb1cd164e8f
dashboard link: https://syzkaller.appspot.com/bug?extid=10a9db47c3a0e13eb31c
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177a927d400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b59da3400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+10a9db47c3a0e13eb31c@syzkaller.appspotmail.com

audit: type=1400 audit(1544417020.270:36): avc:  denied  { map } for   
pid=6121 comm="syz-executor870" path="/root/syz-executor870904155"  
dev="sda1" ino=16484 scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023  
tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file permissive=1
==================================================================
BUG: KASAN: use-after-free in tipc_group_bc_cong+0x327/0x3f0  
net/tipc/group.c:448
Read of size 2 at addr ffff8881d7bc1674 by task syz-executor870/6139

CPU: 0 PID: 6139 Comm: syz-executor870 Not tainted 4.20.0-rc5+ #149
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load2_noabort+0x14/0x20 mm/kasan/report.c:431
  tipc_group_bc_cong+0x327/0x3f0 net/tipc/group.c:448
  tipc_send_group_bcast+0x50a/0xd90 net/tipc/socket.c:1023
  __tipc_sendmsg+0xeec/0x1d40 net/tipc/socket.c:1307
  tipc_sendmsg+0x50/0x70 net/tipc/socket.c:1272
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x51d/0x930 net/socket.c:2116
  __sys_sendmmsg+0x246/0x6d0 net/socket.c:2211
  __do_sys_sendmmsg net/socket.c:2240 [inline]
  __se_sys_sendmmsg net/socket.c:2237 [inline]
  __x64_sys_sendmmsg+0x9d/0x100 net/socket.c:2237
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446339
Code: e8 2c b3 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b 09 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ff1bd83bdb8 EFLAGS: 00000297 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00000000006dac38 RCX: 0000000000446339
RDX: 0000000000000142 RSI: 0000000020000000 RDI: 0000000000000006
RBP: 00000000006dac30 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000297 R12: 00000000006dac3c
R13: 00007ffea6d1565f R14: 00007ff1bd83c9c0 R15: 00000000006dad2c

Allocated by task 6139:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
  kmalloc include/linux/slab.h:546 [inline]
  kzalloc include/linux/slab.h:741 [inline]
  tipc_group_create+0x152/0xa70 net/tipc/group.c:171
  tipc_sk_join net/tipc/socket.c:2829 [inline]
  tipc_setsockopt+0x2d1/0xd70 net/tipc/socket.c:2944
  __sys_setsockopt+0x1ba/0x3c0 net/socket.c:1902
  __do_sys_setsockopt net/socket.c:1913 [inline]
  __se_sys_setsockopt net/socket.c:1910 [inline]
  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1910
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 6140:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  tipc_group_delete+0x2e4/0x3f0 net/tipc/group.c:227
  tipc_sk_leave+0x113/0x220 net/tipc/socket.c:2863
  tipc_setsockopt+0x97d/0xd70 net/tipc/socket.c:2947
  __sys_setsockopt+0x1ba/0x3c0 net/socket.c:1902
  __do_sys_setsockopt net/socket.c:1913 [inline]
  __se_sys_setsockopt net/socket.c:1910 [inline]
  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1910
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881d7bc1600
  which belongs to the cache kmalloc-192 of size 192
The buggy address is located 116 bytes inside of
  192-byte region [ffff8881d7bc1600, ffff8881d7bc16c0)
The buggy address belongs to the page:
page:ffffea00075ef040 count:1 mapcount:0 mapping:ffff8881da800040 index:0x0
flags: 0x2fffc0000000200(slab)
raw: 02fffc0000000200 ffffea00075e7e88 ffffea00075d5c08 ffff8881da800040
raw: 0000000000000000 ffff8881d7bc1000 0000000100000010 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881d7bc1500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881d7bc1580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> ffff8881d7bc1600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                              ^
  ffff8881d7bc1680: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff8881d7bc1700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
