Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360F9C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2704223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2704223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbeKNF5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:57:44 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:51518 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbeKNF5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:57:43 -0500
Received: by mail-it1-f197.google.com with SMTP id h126-v6so5174589ita.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 11:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ALDjCrqdxS2Sgnn73LoAY8zu+lhjPqsvCrQqSgXlyUE=;
        b=sza0ZDbaOpSwww3eJOd7AzjImxpznfTEPRZtD420Sw+ciIHzoqrknRO9WGgPQdBvoU
         CoWMYm0hYP5wyLUlOPEdv383bgpnZE/0O8Dk4va5Hv/RPiTLEgU89CUNNrYvQ91lSk7y
         icyveRExsIpohGcl3DzAQAy4w6qLYI607KGFRcW+9N10TuI3c5SVtYqEJfSZd/83YV9U
         grFvPX6sSAcVMkxygqzHJr/YeLtZqBvjiEXc7qRSW0TxWh5qYDdKdm8ytFepG23ouLxb
         YnTJPIwAfDvtXdf7d2Fq1Iq71WotetMzgG5K8elcvt//kanZFKZpFZDwWqT4fuLajpUk
         K3bQ==
X-Gm-Message-State: AGRZ1gJVseHKada7MpWllTL5VEWOhc06Ev7bpq+SmaiG6923GR6PJaEO
        aNF9qdT+a/Qu0mkZRiAckfnCsG7n7NYZgXbiNkzLg3UYeYT5
X-Google-Smtp-Source: AJdET5eEvQ8VMQIJSfAaoxocATpdCC1Mb7mfbgfPJhUz1lXnoQXmEj4Tn8ci/PryYf2xlMttx3Kp483OIrK6goZE3qtU7jvOsPdI
MIME-Version: 1.0
X-Received: by 2002:a02:1685:: with SMTP id a127-v6mr5012074jaa.9.1542139083554;
 Tue, 13 Nov 2018 11:58:03 -0800 (PST)
Date:   Tue, 13 Nov 2018 11:58:03 -0800
In-Reply-To: <000000000000222b58057a7d9f39@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000451262057a913cb5@google.com>
Subject: Re: KASAN: use-after-free Read in locks_delete_block
From:   syzbot <syzbot+a4a3d526b4157113ec6a@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        neilb@suse.de, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    442b8cea2477 Add linux-next specific files for 20181109
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12fbd905400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f72bdb11df9fbe8
dashboard link: https://syzkaller.appspot.com/bug?extid=a4a3d526b4157113ec6a
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10480d33400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a4a3d526b4157113ec6a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __list_del_entry_valid+0xf1/0x100  
lib/list_debug.c:51
Read of size 8 at addr ffff8801b27c7c70 by task syz-executor0/6767

CPU: 1 PID: 6767 Comm: syz-executor0 Not tainted 4.20.0-rc1-next-20181109+  
#110
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __list_del_entry_valid+0xf1/0x100 lib/list_debug.c:51
  __list_del_entry include/linux/list.h:117 [inline]
  list_del_init include/linux/list.h:159 [inline]
  __locks_delete_block fs/locks.c:683 [inline]
  locks_delete_block+0xce/0x3d0 fs/locks.c:716
  locks_mandatory_area+0x48b/0x6a0 fs/locks.c:1398
  locks_verify_truncate include/linux/fs.h:2361 [inline]
  do_sys_ftruncate+0x4b2/0x550 fs/open.c:190
  __do_sys_ftruncate fs/open.c:204 [inline]
  __se_sys_ftruncate fs/open.c:202 [inline]
  __x64_sys_ftruncate+0x59/0x80 fs/open.c:202
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f4319e97c78 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 0000000000457569
RDX: 0000000000000000 RSI: 0000000000000039 RDI: 0000000000000004
RBP: 000000000072c040 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f4319e986d4
R13: 00000000004bde51 R14: 00000000004cd048 R15: 00000000ffffffff

The buggy address belongs to the page:
page:ffffea0006c9f1c0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0x2fffc0000000000()
raw: 02fffc0000000000 0000000000000000 ffffffff06c90101 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801b27c7b00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff8801b27c7b80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ffff8801b27c7c00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                                              ^
  ffff8801b27c7c80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff8801b27c7d00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================

