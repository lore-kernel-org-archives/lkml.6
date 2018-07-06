Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABAAC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D39022B26
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D39022B26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754484AbeGFWja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 18:39:30 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:55174 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754279AbeGFWjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 18:39:04 -0400
Received: by mail-io0-f197.google.com with SMTP id p12-v6so10694929iog.21
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 15:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=dH4asiwjv1hiVwfPNmnmuTlC1+LLyrAZWHbUe/2OpOs=;
        b=YKg9KI/F/5J2jsJqjE0Qivb2YOgf/F6D39oaHczgc0cruG/s/XknvTiR5Zcn/nZvUN
         x+2wyjHLENo8vGh2kkLND+DRPsHNqA1D9LgLj5i7027NTiyDj7VjwAKE9T6gjRUm1+dP
         oRsLH8j/SkXmS1nRRzeY4SNWvfDOG5sBBioMWkNoBfmoWhbCBH5RbShsoj0Y8VYfMpt2
         1rsdTWASFdLeML+37oCTjn40TKrh+7W/4iNO831gTRnDIXNDPARs1BDq29X3msIziFoF
         2gbPNzFO8EIP1xL/Xd9r7pgTi67Ss9/3BqACUb/qk2VBnPKgEiEWbR3rg5LjENqhYmQM
         epdA==
X-Gm-Message-State: APt69E3vapYlVD6cEolI4KCU7PlQz6/749WEl6NOOOrqEb/2yojBErUe
        gc4eQvBOx+soZKggiLgvPfJWIwOiYEEJG2gbLqtqVeTySRZl
X-Google-Smtp-Source: AAOMgpdg48BxkUgNCtxVPTFgKXHk2uMumveNosPWTezovv2GxbvPrI6KPplqr/ROToPO70u9cxhPjiAjLsdX2D1rc0hVXdePixlr
MIME-Version: 1.0
X-Received: by 2002:a24:700a:: with SMTP id f10-v6mr2898341itc.40.1530916744305;
 Fri, 06 Jul 2018 15:39:04 -0700 (PDT)
Date:   Fri, 06 Jul 2018 15:39:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b9a32405705c54c2@google.com>
Subject: BUG: bad usercopy in __check_heap_object (3)
From:   syzbot <syzbot+4b712dce5cbce6700f27@syzkaller.appspotmail.com>
To:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    526674536360 Add linux-next specific files for 20180706
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12d51a2c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8d1cfc0cb798e48
dashboard link: https://syzkaller.appspot.com/bug?extid=4b712dce5cbce6700f27
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=14b05afc400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17594968400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4b712dce5cbce6700f27@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): bond0: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): team0: link is not ready
8021q: adding VLAN 0 to HW filter on device team0
usercopy: Kernel memory exposure attempt detected from SLAB  
object 'kmalloc-4096' (offset 2399, size 2626)!
------------[ cut here ]------------
kernel BUG at mm/usercopy.c:100!
invalid opcode: 0000 [#1] SMP KASAN
CPU: 1 PID: 4718 Comm: syz-executor688 Not tainted  
4.18.0-rc3-next-20180706+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:usercopy_abort+0xbb/0xbd mm/usercopy.c:88
Code: c0 e8 37 ec b8 ff ff 75 c8 48 8b 55 c0 4d 89 f9 ff 75 d0 4d 89 e8 48  
89 d9 4c 89 e6 41 56 48 c7 c7 e0 4c f3 87 e8 37 a0 9f ff <0f> 0b e8 0c ec  
b8 ff e8 97 42 f7 ff 4c 89 e1 8b 95 14 ff ff ff 31
RSP: 0018:ffff8801d33a78b0 EFLAGS: 00010286
RAX: 000000000000006b RBX: ffffffff88c10e70 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81634381 RDI: 0000000000000001
RBP: ffff8801d33a7908 R08: ffff8801d1e2a200 R09: ffffed003b5e4fc0
R10: ffffed003b5e4fc0 R11: ffff8801daf27e07 R12: ffffffff87f34bc0
R13: ffffffff87f34a80 R14: ffffffff87f34a40 R15: ffffffff88c0c905
FS:  00007f56a6072700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001000 CR3: 00000001b8fdf000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __check_heap_object+0xb5/0xb5 mm/slab.c:4445
  check_heap_object mm/usercopy.c:236 [inline]
  __check_object_size+0x4db/0x5f2 mm/usercopy.c:259
  check_object_size include/linux/thread_info.h:119 [inline]
  check_copy_size include/linux/thread_info.h:150 [inline]
  copy_to_user include/linux/uaccess.h:154 [inline]
  seq_read+0x578/0x10e0 fs/seq_file.c:211
  do_loop_readv_writev fs/read_write.c:700 [inline]
  do_iter_read+0x49e/0x650 fs/read_write.c:924
  vfs_readv+0x175/0x1c0 fs/read_write.c:986
  do_readv+0x11a/0x310 fs/read_write.c:1019
  __do_sys_readv fs/read_write.c:1106 [inline]
  __se_sys_readv fs/read_write.c:1103 [inline]
  __x64_sys_readv+0x75/0xb0 fs/read_write.c:1103
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446c09
Code: e8 1c bc 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 5b 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f56a6071d18 EFLAGS: 00000246 ORIG_RAX: 0000000000000013
RAX: ffffffffffffffda RBX: 00000000006dcc5c RCX: 0000000000446c09
RDX: 0000000000000002 RSI: 00000000200021c0 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dcc58
R13: 00007f56a6071d20 R14: 6f72746e6f632f2e R15: 0000000000000007
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 532b9c3f493b2e4d ]---
RIP: 0010:usercopy_abort+0xbb/0xbd mm/usercopy.c:88
Code: c0 e8 37 ec b8 ff ff 75 c8 48 8b 55 c0 4d 89 f9 ff 75 d0 4d 89 e8 48  
89 d9 4c 89 e6 41 56 48 c7 c7 e0 4c f3 87 e8 37 a0 9f ff <0f> 0b e8 0c ec  
b8 ff e8 97 42 f7 ff 4c 89 e1 8b 95 14 ff ff ff 31
RSP: 0018:ffff8801d33a78b0 EFLAGS: 00010286
RAX: 000000000000006b RBX: ffffffff88c10e70 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81634381 RDI: 0000000000000001
RBP: ffff8801d33a7908 R08: ffff8801d1e2a200 R09: ffffed003b5e4fc0
R10: ffffed003b5e4fc0 R11: ffff8801daf27e07 R12: ffffffff87f34bc0
R13: ffffffff87f34a80 R14: ffffffff87f34a40 R15: ffffffff88c0c905
FS:  00007f56a6072700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001000 CR3: 00000001b8fdf000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
