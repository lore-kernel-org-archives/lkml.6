Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E09C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 04:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF93C208B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 04:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF93C208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbeH1Ibw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 04:31:52 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:50502 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbeH1Ibw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 04:31:52 -0400
Received: by mail-io0-f199.google.com with SMTP id z25-v6so250917iog.17
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 21:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=SE9uESpg2eVl0woGPsjKseZJOkI9dNd3wozfqZrRYa4=;
        b=EAmY4UTAJTWm3g/Dk9vH9He73dJiwKA6sSvYzFCcvQir406PEpOzIFwG1kKM3iQuoL
         PVDotb2DHRJhM/svj+AfoaD0Pq9dW/bo63PBaiJu3xI04/u3a4+LT96Ss2ndUrjac7SM
         VbAPhgvjvh3xTkfjcOI4s7SXelR26q180h9NBdUOIyZ8lMmSwDIHdDzqVXrY2TL24H4T
         mL2sanNvaEikuOzOY6L4ZmioCAJAQe2ZC4bmEnGWDh49IVCmrG0pNYe7x3Ckk6WItfGY
         JboaS4g40r8bQizHMIk4b6nd+ZekXJobk0NdMpvhBuw/Q9rQGbkbRAopZWXuch5BuzMq
         8Bug==
X-Gm-Message-State: APzg51AYdQmiawJFVpwD9Cw+79Yg+VW3VQDYX+t7syJb1ZRBZsNjxuXR
        6xOLeMwEv4FrlCS4cJplR6N/XQ25BJIjKG2GT31M9o9ZuJlh
X-Google-Smtp-Source: ANB0VdYBkfmfLjHCCr7FVH6V5YkpqHBZXpdTYltPr0y6QV8OHckW0su08eErTpxPyaX7qD2SIh25BP1D6WcYhQmaTNJX2lqDs14J
MIME-Version: 1.0
X-Received: by 2002:a24:7d03:: with SMTP id b3-v6mr77920itc.52.1535431323816;
 Mon, 27 Aug 2018 21:42:03 -0700 (PDT)
Date:   Mon, 27 Aug 2018 21:42:03 -0700
In-Reply-To: <0000000000002a2fdf0573107004@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a21e9a0574777616@google.com>
Subject: Re: BUG: corrupted list in p9_write_work
From:   syzbot <syzbot+1788bd5d4e051da6ec08@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, davem@davemloft.net, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, rminnich@sandia.gov,
        syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    050cdc6c9501 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1386bce1400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=49927b422dcf0b29
dashboard link: https://syzkaller.appspot.com/bug?extid=1788bd5d4e051da6ec08
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1196b7ba400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1022391e400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1788bd5d4e051da6ec08@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
list_add corruption. prev->next should be next (ffff8801c5b17ab0), but was  
ffff8801c5b17ac0. (prev=ffff8801a92d1b58).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:28!
invalid opcode: 0000 [#1] SMP KASAN
CPU: 0 PID: 13 Comm: kworker/0:1 Not tainted 4.19.0-rc1+ #212
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
FS-Cache: Duplicate cookie detected
Workqueue: events p9_write_work
FS-Cache: O-cookie c=000000008e4eb276 [p=000000002fd7b0b4 fl=222 nc=0 na=1]
RIP: 0010:__list_add_valid.cold.0+0x23/0x25 lib/list_debug.c:26
Code: e8 4f 2b 5a fe eb 97 48 89 d9 48 c7 c7 60 b2 3a 87 e8 62 05 02 fe 0f  
0b 48 89 f1 48 c7 c7 20 b3 3a 87 48 89 de e8 4e 05 02 fe <0f> 0b 4c 89 e2  
48 89 de 48 c7 c7 60 b4 3a 87 e8 3a 05 02 fe 0f 0b
RSP: 0018:ffff8801d9f17590 EFLAGS: 00010282
FS-Cache: O-cookie d=0000000068a887e4 n=00000000257e8f2f
RAX: 0000000000000075 RBX: ffff8801c5b17ab0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8163ac01 RDI: 0000000000000001
RBP: ffff8801d9f175a8 R08: ffff8801d9f06340 R09: ffffed003b605010
FS-Cache: O-key=[10] '
R10: ffffed003b605010 R11: ffff8801db028087 R12: ffff8801a92d1b58
R13: ffff8801a92d1b58 R14: ffff8801c5b17b04 R15: ffff8801a92d1b58
FS:  0000000000000000(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
34
CR2: 00000000006dc138 CR3: 00000001c845c000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
32
Call Trace:
  __list_add include/linux/list.h:60 [inline]
  list_add_tail include/linux/list.h:93 [inline]
  list_move_tail include/linux/list.h:183 [inline]
  p9_write_work+0x34e/0xd50 net/9p/trans_fd.c:470
39
34
37
  process_one_work+0xc73/0x1aa0 kernel/workqueue.c:2153
38
31
36
31
39
'
FS-Cache: N-cookie c=00000000da38e585 [p=000000002fd7b0b4 fl=2 nc=0 na=1]
FS-Cache: N-cookie d=0000000068a887e4 n=000000005afa2e39
FS-Cache: N-key=[10] '
34
32
39
  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
34
37
38
31
36
31
39
'
  kthread+0x35a/0x420 kernel/kthread.c:246
FS-Cache: Duplicate cookie detected
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace c3e56d8d2cc1f8a2 ]---
FS-Cache: O-cookie c=000000008e4eb276 [p=000000002fd7b0b4 fl=222 nc=0 na=1]
RIP: 0010:__list_add_valid.cold.0+0x23/0x25 lib/list_debug.c:26
FS-Cache: O-cookie d=0000000068a887e4 n=00000000257e8f2f
Code: e8 4f 2b 5a fe eb 97 48 89 d9 48 c7 c7 60 b2 3a 87 e8 62 05 02 fe 0f  
0b 48 89 f1 48 c7 c7 20 b3 3a 87 48 89 de e8 4e 05 02 fe <0f> 0b 4c 89 e2  
48 89 de 48 c7 c7 60 b4 3a 87 e8 3a 05 02 fe 0f 0b
FS-Cache: O-key=[10] '
RSP: 0018:ffff8801d9f17590 EFLAGS: 00010282
34
32
RAX: 0000000000000075 RBX: ffff8801c5b17ab0 RCX: 0000000000000000
39
RDX: 0000000000000000 RSI: ffffffff8163ac01 RDI: 0000000000000001
34
RBP: ffff8801d9f175a8 R08: ffff8801d9f06340 R09: ffffed003b605010
37
R10: ffffed003b605010 R11: ffff8801db028087 R12: ffff8801a92d1b58
38
R13: ffff8801a92d1b58 R14: ffff8801c5b17b04 R15: ffff8801a92d1b58
31
FS:  0000000000000000(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
36
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
3139'
CR2: 00000000006dc138 CR3: 00000001c845c000 CR4: 00000000001406f0
FS-Cache: N-cookie c=00000000c3d88b67 [p=000000002fd7b0b4 fl=2 nc=0 na=1]
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
FS-Cache: N-cookie d=0000000068a887e4 n=00000000c137bf7f
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
FS-Cache: N-key=[10] '

