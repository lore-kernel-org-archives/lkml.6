Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500ADC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E2D20BEC
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E2D20BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390072AbeGLAz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 20:55:57 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:56941 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733280AbeGLAz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 20:55:57 -0400
Received: by mail-it0-f71.google.com with SMTP id g4-v6so3128602itf.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 17:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=l0XEJ9r3s3mXUE4cb+IkHZ1ZE33n7Jw2U3RCza0Ilk8=;
        b=H/4M6nZStHHX5/64HNDixKpEuJws+5OVjtwrMehb70YWNVh7ozU3vaxcidbsg5C8YR
         BAPTBIdRkaw4cJ0RG8sqXX+X4l9ZILFVcDIvrT3JMlJSmNrusYAedqew8SNofLPTi0CB
         yFUsoRUO4PO3ZhTqjYAUEUULJJ8ciIuV0yEUo4iDIbQAUtNM4SS+jDdEbCdlcIbnCFeE
         iWy1Sy7s2QdQruf0blB8uo67VWmPn4/rYFBsj6cIWqK52M9m+0kXPRSTrTSS4zwEM04V
         QJc+vMq45PZnRHzqaWVHdIAzKlnP8J6DWguVfyxuh8wPoHLLuAIHjQiXD1qk278plJgV
         m/vA==
X-Gm-Message-State: AOUpUlEKpNuVTiL3QcHU1ZaDmbhmi0aTTzELzQv5zjgh2tCwwjLDvsqy
        CTo0YMAfvWe89l96sq5PSgTD6v2AuP7Q9KAKjmZEjwplFrhs
X-Google-Smtp-Source: AAOMgpdLkKqKFQXBXxTs2cmmGEk5jmAZVFRgoOFBr7Q7GN4IeS7N9Pxq33voVBEzuJH0nLO2H0fTzrJZ5qBBEdxxkVKZWNNqtTCP
MIME-Version: 1.0
X-Received: by 2002:a02:3d43:: with SMTP id n64-v6mr42905jan.51.1531356541513;
 Wed, 11 Jul 2018 17:49:01 -0700 (PDT)
Date:   Wed, 11 Jul 2018 17:49:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae783b0570c2ba09@google.com>
Subject: KASAN: use-after-free Write in tls_push_record (2)
From:   syzbot <syzbot+6c4e6ecbf9a2797be67c@syzkaller.appspotmail.com>
To:     aviadye@mellanox.com, borisp@mellanox.com, davejwatson@fb.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1e09177acae3 Merge tag 'mips_fixes_4.18_3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=128903b2400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
dashboard link: https://syzkaller.appspot.com/bug?extid=6c4e6ecbf9a2797be67c
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=12312678400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ef76c2400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6c4e6ecbf9a2797be67c@syzkaller.appspotmail.com

RDX: 00000000fffffdef RSI: 00000000200005c0 RDI: 0000000000000003
RBP: 00000000006cb018 R08: 0000000020000000 R09: 000000000000001c
R10: 0000000000000040 R11: 0000000000000212 R12: 0000000000000005
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
==================================================================
BUG: KASAN: use-after-free in tls_fill_prepend include/net/tls.h:339  
[inline]
BUG: KASAN: use-after-free in tls_push_record+0x1091/0x1400  
net/tls/tls_sw.c:239
Write of size 1 at addr ffff8801ae430000 by task syz-executor589/4567

CPU: 0 PID: 4567 Comm: syz-executor589 Not tainted 4.18.0-rc4+ #141
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_store1_noabort+0x17/0x20 mm/kasan/report.c:435
  tls_fill_prepend include/net/tls.h:339 [inline]
  tls_push_record+0x1091/0x1400 net/tls/tls_sw.c:239
  tls_sw_push_pending_record+0x22/0x30 net/tls/tls_sw.c:276
  tls_handle_open_record net/tls/tls_main.c:164 [inline]
  tls_sk_proto_close+0x74c/0xae0 net/tls/tls_main.c:264
  inet_release+0x104/0x1f0 net/ipv4/af_inet.c:427
  inet6_release+0x50/0x70 net/ipv6/af_inet6.c:459
  __sock_release+0xd7/0x260 net/socket.c:599
  sock_close+0x19/0x20 net/socket.c:1150
  __fput+0x355/0x8b0 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1b08/0x2750 kernel/exit.c:865
  do_group_exit+0x177/0x440 kernel/exit.c:968
  __do_sys_exit_group kernel/exit.c:979 [inline]
  __se_sys_exit_group kernel/exit.c:977 [inline]
  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:977
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x43f358
Code: Bad RIP value.
RSP: 002b:00007fff51750198 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043f358
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004bf448 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 0000000000000040 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d1180 R14: 0000000000000000 R15: 0000000000000000

The buggy address belongs to the page:
page:ffffea0006b90c00 count:0 mapcount:-128 mapping:0000000000000000  
index:0x0
flags: 0x2fffc0000000000()
raw: 02fffc0000000000 ffffea0006b96408 ffff88021fffac18 0000000000000000
raw: 0000000000000000 0000000000000003 00000000ffffff7f 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801ae42ff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801ae42ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8801ae430000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                    ^
  ffff8801ae430080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff8801ae430100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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
