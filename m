Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F928C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C762208AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C762208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754430AbeGIGTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 02:19:04 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:52965 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbeGIGTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 02:19:02 -0400
Received: by mail-io0-f198.google.com with SMTP id y26-v6so14612115iob.19
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 23:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Kp/OJTDSpj2c4kfbca+q3H305d3MyfWVgXabLIuKe+Q=;
        b=UatZ3DV69WD6JqNiwe0qY4FEeK3cSn07k1Z8Np1TKZklamgyBVaxcPTcBdBi6jLuze
         W0cRxNrrcTlcti/u/qmeO1mbc3u5wXmNc/wlwA0bf6Cgc6j8hT65tMjlYlBL4AdBIUJ2
         EPZvbB2CZvKD2SeJ1+r4X6DsKbnJDwsw7uNc6irakM7NrM+tPw0uIv5amm4TcJJmqv7X
         8YomE2jlnMd6FoxAaxzVgxpLj1+u2FU+BYkcTx8F8zYQTzVDAsLmNM8VCB1kvpsMoPNM
         kxje0N7tMLUjhULbiAJms423n5HlctL7DYTb/VDfws9PYNttUgKW8cH2DEBx4+Unh8vZ
         uqWg==
X-Gm-Message-State: APt69E0KpDgG/luH2GJDd35hZnO4Yk/+X3PcMeTbG4V6E6hNetzKdnrw
        x559LKwsCbdmtbw6rfIb8y9RqCmKLC1bEWXAteil1RoLoy4q
X-Google-Smtp-Source: AAOMgpdFXkFuk++UwUHaEHgayYDScWKVrX2haJ8YEv7zEbs9MlhVOtIWtOZkYrsh+jIl1xnKIxhi/oLYBK9OeUumRgwt3KR7BKHh
MIME-Version: 1.0
X-Received: by 2002:a02:9874:: with SMTP id x49-v6mr8764021jaj.61.1531117142314;
 Sun, 08 Jul 2018 23:19:02 -0700 (PDT)
Date:   Sun, 08 Jul 2018 23:19:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060a21905708afd42@google.com>
Subject: KASAN: use-after-free Read in bpf_test_finish
From:   syzbot <syzbot+709412e651e55ed96498@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d90c936fb318 Merge branch 'bpf-nfp-mul-div-support'
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12d50594400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a501a01deaf0fe9
dashboard link: https://syzkaller.appspot.com/bug?extid=709412e651e55ed96498
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=111146dc400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16932970400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+709412e651e55ed96498@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
==================================================================
BUG: KASAN: use-after-free in _copy_to_user+0xe9/0x110 lib/usercopy.c:27
Read of size 1006 at addr ffff8801a6fffff2 by task syz-executor153/4459

CPU: 0 PID: 4459 Comm: syz-executor153 Not tainted 4.18.0-rc3+ #48
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
  kasan_check_read+0x11/0x20 mm/kasan/kasan.c:272
  _copy_to_user+0xe9/0x110 lib/usercopy.c:27
  copy_to_user include/linux/uaccess.h:155 [inline]
  bpf_test_finish.isra.7+0xee/0x1f0 net/bpf/test_run.c:59
  bpf_prog_test_run_skb+0x7d7/0xa30 net/bpf/test_run.c:144
  bpf_prog_test_run+0x130/0x1a0 kernel/bpf/syscall.c:1686
  __do_sys_bpf kernel/bpf/syscall.c:2323 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:2267 [inline]
  __x64_sys_bpf+0x3d8/0x510 kernel/bpf/syscall.c:2267
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440319
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffeb9114388 EFLAGS: 00000213 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440319
RDX: 0000000000000028 RSI: 00000000200001c0 RDI: 000000000000000a
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000213 R12: 0000000000401ba0
R13: 0000000000401c30 R14: 0000000000000000 R15: 0000000000000000

The buggy address belongs to the page:
page:ffffea00069bffc0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0x2fffc0000000000()
raw: 02fffc0000000000 ffffea00069bffc8 ffffea00069bffc8 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801a6fffe80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff8801a6ffff00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ffff8801a6ffff80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                                              ^
  ffff8801a7000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8801a7000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
