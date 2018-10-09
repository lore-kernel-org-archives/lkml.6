Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04258C67879
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 01:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5033205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 01:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5033205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbeJIIV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 04:21:26 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:54893 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbeJIIV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 04:21:26 -0400
Received: by mail-io1-f71.google.com with SMTP id l24-v6so21189863iok.21
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 18:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=SlHmKsBol4IlccEcvKBO/mAwvUoSpimbySEIUUeJkb8=;
        b=hDRBm/pbPFIGP3XoJkjH836qHhHFCfrU2QVcVMqCvVwnCsbV3kMWQxgU0J2StxpJHH
         V8dy2wq9KpElXxK2u7d842HHSFnCN2Scj8BbEIVtJw9DABbI4wzXffoAk2/nkEHAhSb5
         vozZqTkKjonHjC5oRFJbE8A7FzD+uf8H64tN4RUcQh+6FgflJd9iLmYlbikOLVGgwdD5
         TjX+KtuvEdkC9kI1tFbhLCDqdmQSsJfJaWrAksE1Wr8cGO1B7kLGZZZudhKeVWKUW67X
         ubXZXfK76QfG1NWE5lCyl+Wdz70zPxLjxKiiGN/ZkEIsG6eOPmL6aYo6wVlVnCNunnHe
         /C4g==
X-Gm-Message-State: ABuFfohHs34RChEoG3RUjwZwr3C5l0FFvzTCQNkcs1hI8zGXSmCWYVqh
        o0eF+4MB/s1KynxR0HVEPAR97nx605d1EKSURhfgRBQTf/2H
X-Google-Smtp-Source: ACcGV60H/FFAtLYYyKnl7/zhTe7eEQeu262T+4acZ71/VuIyfOdj6eoriK1Sr9aD9KZO/f39q5KnIBsyYG6MvjQHAM/3jwXsXRnj
MIME-Version: 1.0
X-Received: by 2002:a24:d49:: with SMTP id 70-v6mr307453itx.5.1539047222527;
 Mon, 08 Oct 2018 18:07:02 -0700 (PDT)
Date:   Mon, 08 Oct 2018 18:07:02 -0700
In-Reply-To: <000000000000ca61cd0571178677@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fddb150577c15af6@google.com>
Subject: Re: BUG: corrupted list in p9_read_work
From:   syzbot <syzbot+2222c34dc40b515f30dc@syzkaller.appspotmail.com>
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

HEAD commit:    0854ba5ff5c9 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1514ec06400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
dashboard link: https://syzkaller.appspot.com/bug?extid=2222c34dc40b515f30dc
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b91685400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2222c34dc40b515f30dc@syzkaller.appspotmail.com

FS-Cache: N-cookie d=000000000a092700 n=00000000d8ee0022
FS-Cache: N-key=[10] '34323935303034313132'
list_del corruption, ffff88019ae36ee8->next is LIST_POISON1  
(dead000000000100)
------------[ cut here ]------------
kobject: '9p-11043': free name
kernel BUG at lib/list_debug.c:47!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 2686 Comm: kworker/1:2 Not tainted 4.19.0-rc7+ #274
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
kobject: '9p-11049' (0000000096206f7a): kobject_add_internal:  
parent: 'bdi', set: 'devices'
Workqueue: events p9_read_work
RIP: 0010:__list_del_entry_valid.cold.1+0x26/0x58 lib/list_debug.c:45
Code: d7 fd 0f 0b 4c 89 e2 48 89 de 48 c7 c7 40 92 40 88 e8 7a a2 d7 fd 0f  
0b 4c 89 ea 48 89 de 48 c7 c7 e0 91 40 88 e8 66 a2 d7 fd <0f> 0b 48 89 de  
48 c7 c7 00 93 40 88 e8 55 a2 d7 fd 0f 0b 48 89 de
RSP: 0018:ffff8801cc5975b8 EFLAGS: 00010282
kobject: '9p-11049' (0000000096206f7a): kobject_uevent_env
RAX: 000000000000004e RBX: ffff88019ae36ee8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81650405 RDI: 0000000000000005
RBP: ffff8801cc5975d0 R08: ffff8801cc58a4c0 R09: ffffed003b5e4fe8
R10: ffffed003b5e4fe8 R11: ffff8801daf27f47 R12: dead000000000200
R13: dead000000000100 R14: ffff8801c8931050 R15: ffff8801c8931010
FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fef196c1000 CR3: 00000001ccff7000 CR4: 00000000001406e0
Call Trace:
kobject: '9p-11049' (0000000096206f7a): fill_kobj_path: path  
= '/devices/virtual/bdi/9p-11049'
  __list_del_entry include/linux/list.h:117 [inline]
  list_del include/linux/list.h:125 [inline]
  p9_read_work+0xab6/0x10e0 net/9p/trans_fd.c:379
kobject: 'loop4' (00000000513f3e2f): kobject_uevent_env
FS-Cache: Duplicate cookie detected
  process_one_work+0xc90/0x1b90 kernel/workqueue.c:2153
FS-Cache: O-cookie c=00000000911358e4 [p=000000006545c95d fl=222 nc=0 na=1]
FS-Cache: O-cookie d=000000000a092700 n=000000007635356b
FS-Cache: O-key=[10] '
34
32
39
35
30
30
34
31
32
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
36
'
FS-Cache: N-cookie c=00000000abaeee81 [p=000000006545c95d fl=2 nc=0 na=1]
FS-Cache: N-cookie d=000000000a092700 n=00000000ee16a363
FS-Cache: N-key=[10] '
34
32
39
35
30
30
34
  kthread+0x35a/0x420 kernel/kthread.c:246
31
32
36
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
'
Modules linked in:
---[ end trace 41e06641f5c3c814 ]---
kobject: '9p-11050' (000000002a096aa2): kobject_add_internal:  
parent: 'bdi', set: 'devices'
RIP: 0010:__list_del_entry_valid.cold.1+0x26/0x58 lib/list_debug.c:45
Code: d7 fd 0f 0b 4c 89 e2 48 89 de 48 c7 c7 40 92 40 88 e8 7a a2 d7 fd 0f  
0b 4c 89 ea 48 89 de 48 c7 c7 e0 91 40 88 e8 66 a2 d7 fd <0f> 0b 48 89 de  
48 c7 c7 00 93 40 88 e8 55 a2 d7 fd 0f 0b 48 89 de
RSP: 0018:ffff8801cc5975b8 EFLAGS: 00010282
RAX: 000000000000004e RBX: ffff88019ae36ee8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81650405 RDI: 0000000000000005
RBP: ffff8801cc5975d0 R08: ffff8801cc58a4c0 R09: ffffed003b5e4fe8
R10: ffffed003b5e4fe8 R11: ffff8801daf27f47 R12: dead000000000200
R13: dead000000000100 R14: ffff8801c8931050 R15: ffff8801c8931010
FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fef196c1000 CR3: 00000001ccff7000 CR4: 00000000001406e0

