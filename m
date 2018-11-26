Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE35C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6DC20855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6DC20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbeK0HeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 02:34:25 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:39485 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbeK0HeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 02:34:25 -0500
Received: by mail-io1-f69.google.com with SMTP id q23so18283240ior.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 12:39:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=u9dqxVZINJx4qR3cJdQHJ3FhfRpOVRzgpQq8KEa+JFw=;
        b=pXDm3tZenYJQPTe9QtxMyruvkBcEBKlIojII+JVVd6qpBBB+AQyBx6UICSCvMp/o0L
         nu7UAb7eeLfvIpoSGWXDCjS3j5OARWdeX0PAov8w3FJ1DMeDfH4EN9G92L4+0l3QPDrC
         L9/bDJBItOfbxdexKIPplrgXtzbLqiSlBPLOlbvEd2uu3uSDeYQkNIy1LmyoTq8yC4Id
         rcEhaFiRyNM1FELdttN5EBuh2DLg08oUFp2bDIUvmkT0tlEj7Y4peMI5hjfzHFgZaXBQ
         9CGAySGCj1nn64SJrIZq1kZ+ROqJrPwdX8wLd4+VTtRIFzKAamdpLL79+8Yg/6Xuh+NC
         V4bA==
X-Gm-Message-State: AA+aEWbwTZUxzh83C1c8Kf9OVe75jSXlQ+4FXdzspto5Rsjbi9Dq/4Dq
        +IbuNUv+MKxrdAlkM6oPegmv5/eLRPBR/sA114GakL2bO9lH
X-Google-Smtp-Source: AFSGD/VUl91lxycYWNV/0BW8aFRny/WYa25hLzIsOfQM4Z34ybSUASSU1fjjNZobwDY9gJo5wlixiR3vqJhWU+eh6P03HywHklm0
MIME-Version: 1.0
X-Received: by 2002:a6b:8e83:: with SMTP id q125mr18285845iod.9.1543264745175;
 Mon, 26 Nov 2018 12:39:05 -0800 (PST)
Date:   Mon, 26 Nov 2018 12:39:05 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ee41d6057b975283@google.com>
Subject: KASAN: stack-out-of-bounds Read in refcount_sub_and_test_checked
From:   syzbot <syzbot+d3ed975648421c381ca4@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    358be656406d selftests/net: add txring_overwrite
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=113f8ed5400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c36a72af2123e78a
dashboard link: https://syzkaller.appspot.com/bug?extid=d3ed975648421c381ca4
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d3ed975648421c381ca4@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: stack-out-of-bounds in atomic_read  
include/asm-generic/atomic-instrumented.h:21 [inline]
BUG: KASAN: stack-out-of-bounds in refcount_sub_and_test_checked+0x9d/0x310  
lib/refcount.c:179
Read of size 4 at addr ffff8881da9c0bf0 by task udevd/15453

CPU: 1 PID: 15453 Comm: udevd Not tainted 4.20.0-rc3+ #313
PANIC: double fault, error_code: 0x0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
CPU: 0 PID: 18956 Comm: syz-executor1 Not tainted 4.20.0-rc3+ #313
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__udp4_lib_lookup+0x25/0x870 net/ipv4/udp.c:466
Code: ff 0f 1f 40 00 55 48 89 e5 41 57 41 56 41 55 49 bd 00 00 00 00 00 fc  
ff df 41 54 53 44 89 c3 48 81 ec 00 01 00 00 48 8b 45 20 <48> 89 bd 28 ff  
ff ff 66 c1 c3 08 4c 8b 65 18 89 b5 1c ff ff ff 89
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
RSP: 0018:ffff8881d9a8af98 EFLAGS: 00010282
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
RAX: 0000000000000000 RBX: 000000000000e5be RCX: 00000000111414ac
RDX: 000000000000224e RSI: 00000000aa1414ac RDI: ffff88818b3fc340
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
RBP: ffff8881d9a8b0c0 R08: 000000000000e5be R09: 0000000000000001
  kasan_check_read+0x11/0x20 mm/kasan/kasan.c:272
R10: 0000000000000000 R11: ffff8881dae2db3b R12: ffff8881d7835800
  atomic_read include/asm-generic/atomic-instrumented.h:21 [inline]
  refcount_sub_and_test_checked+0x9d/0x310 lib/refcount.c:179
R13: dffffc0000000000 R14: ffff8881d78357ec R15: 0000000000000003
FS:  00007f18ebe99700(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8881d9a8af88 CR3: 000000014f1a9000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  refcount_dec_and_test_checked+0x1a/0x20 lib/refcount.c:212
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  kref_put include/linux/kref.h:69 [inline]
  aa_put_label security/apparmor/include/label.h:447 [inline]
  aa_free_file_ctx security/apparmor/include/file.h:75 [inline]
  apparmor_file_free_security+0x115/0x1a0 security/apparmor/lsm.c:450
Call Trace:


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
