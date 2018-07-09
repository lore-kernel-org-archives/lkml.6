Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3DBC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B68B20873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B68B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754525AbeGIMoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:44:04 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:52262 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754459AbeGIMoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:44:02 -0400
Received: by mail-it0-f72.google.com with SMTP id b132-v6so15542569iti.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 05:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2rrFWXZlt29cfeJJGnBBTslYJEc+TuGdIpD+BQs+kiY=;
        b=RhmhbbX93P4wgxzIjCgRQ7l5JijOVwDfeJNmYS4CPYStgoJYG3A9eUVzwhUlLjXUYY
         jrm8whH6wjURz5MUS0iF/6PSQNj35S73D01eTlI9ngkKPLLm1Y6B2ahTr/P9RriyyScJ
         Yk8H7B6KZvWdr57khutnfUYlv3USEruCVf/L0xCkbf8kuFbQbeqqxvbTM88tfPmfIphx
         j+0LcoMKWd1z5AyVlhq24Q6DW+saY71A3+sHBDbXsrkkTlsBKqO8TtfuRBgdA7QK2jUT
         apJH/3yfJLwBaYusC4cyKeEntXvWBsKxQRHky0R0Tmtyw7HoUcciFfue6IU650vS/AVh
         o0JA==
X-Gm-Message-State: APt69E0cMFfTx5AfLH5sn3KqH9FFaY4Ny/yG+u8R9L6qGvLiSZqXXwuB
        wOTa+vOhGGSWXEEtv1nXqLq/QfcVMiogltpx+Iu14sY7Ddki
X-Google-Smtp-Source: AAOMgpdWpFQFb4gd3OaOoBiKbPDEcn9XqnZieuBeGdYF6pNNKkG3yJaj01EiVcuPYhPtAA4cvmIks0HyaJzdRmONqldQ2yIee32q
MIME-Version: 1.0
X-Received: by 2002:a02:98eb:: with SMTP id c40-v6mr9251818jak.32.1531140242370;
 Mon, 09 Jul 2018 05:44:02 -0700 (PDT)
Date:   Mon, 09 Jul 2018 05:44:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003f78f30570905ed6@google.com>
Subject: KASAN: out-of-bounds Read in bpf_test_finish
From:   syzbot <syzbot+54f39d6ab58f39720a55@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=16b88a78400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a501a01deaf0fe9
dashboard link: https://syzkaller.appspot.com/bug?extid=54f39d6ab58f39720a55
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+54f39d6ab58f39720a55@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: out-of-bounds in _copy_to_user+0xe9/0x110 lib/usercopy.c:27
Read of size 924 at addr ffff880192bffff2 by task syz-executor1/6688

CPU: 1 PID: 6688 Comm: syz-executor1 Not tainted 4.18.0-rc3+ #48
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
RIP: 0033:0x455e29
Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f95802f1c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f95802f26d4 RCX: 0000000000455e29
RDX: 0000000000000028 RSI: 0000000020000380 RDI: 000000000000000a
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004bbaee R14: 00000000004c8d20 R15: 0000000000000000

The buggy address belongs to the page:
page:ffffea00064a8000 count:1 mapcount:1 mapping:ffff8801ceeda041  
index:0x20200 compound_mapcount: 1
flags: 0x2fffc0000048068(uptodate|lru|active|head|swapbacked)
raw: 02fffc0000048068 ffffea0006d642c8 ffffea0006e14288 ffff8801ceeda041
raw: 0000000000020200 0000000000000000 00000001ffffffff ffff8801d285e900
page dumped because: kasan: bad access detected
page->mem_cgroup:ffff8801d285e900

Memory state around the buggy address:
  ffff880192c00280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff880192c00300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff880192c00380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                          ^
  ffff880192c00400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff880192c00480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
