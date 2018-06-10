Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Kf9VH0tDHVvfGgAAmS7hNA
	; Sun, 10 Jun 2018 15:27:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5446F606FA; Sun, 10 Jun 2018 15:27:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEXHASH_WORD,MAILING_LIST_MULTI autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BCCA0601C3;
	Sun, 10 Jun 2018 15:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BCCA0601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753586AbeFJP1E (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 11:27:04 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:47577 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753375AbeFJP1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 11:27:02 -0400
Received: by mail-io0-f197.google.com with SMTP id 140-v6so14038540iou.14
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 08:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=1B/uhX25LUt4UokdYUp+JeZXSC4wwA4m+mZU7nAw43U=;
        b=D3+9AuDu0OubZXoP/2whhKoOa430zbNQKVSEfKWv0n9wu7g0Nl5Z7VVAeYpO+54h3v
         MGtrMw3SW/Ltl4WPCTi9IxuHVjXIjE3Lq1CFMllCJoao/yhM6HdyMnq0MZZXedwVjMJb
         s/KA2PibOjOOq/sWFA+hoydoM/F0hK4+wqrcCbSzPFRMD/LWkDt3ty5Ous8XpHOhjRTO
         iuq8/I5xOk0pzDqIzDLv3qtudO5+K+3u5zTbKcyKYZKPViQDWfQvzmBlg2JDrawbMUp1
         fsutIW3Zu3pfuZMxiPm8FqdVRvEiOTYYG7JIVinN0dhswvvi/lta88Q2DkO1L/KlvV2I
         /o0w==
X-Gm-Message-State: APt69E0EGs1GuQ6pe67hf5lwMhyB0KlzO8o7Qx6QNa7r7/KgsMX5Pfzb
        hIODFxpq6qxS0T32wb/mLrHNClD/clpt5M7T6NH1/+n2dr2N
X-Google-Smtp-Source: ADUXVKJEbaEePViI1CHMynJHjBRYa8tqIisXWmIe82Qk5cA2LMwBG/8eSvGmArr7RuilbV5BaK4EBO6/2rK9DBzf4ByzxWxl1bGL
MIME-Version: 1.0
X-Received: by 2002:a24:1a44:: with SMTP id 65-v6mr6781675iti.20.1528644422221;
 Sun, 10 Jun 2018 08:27:02 -0700 (PDT)
Date: Sun, 10 Jun 2018 08:27:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c64842056e4b4326@google.com>
Subject: KASAN: slab-out-of-bounds Read in bpf_skb_change_proto
From: syzbot <syzbot+d2d729bdde65dee3eae6@syzkaller.appspotmail.com>
To: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    a16afaf7928b Merge tag 'for-v4.18' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1338f6bf800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=314f2150f36c16ca
dashboard link: https://syzkaller.appspot.com/bug?extid=d2d729bdde65dee3eae6
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1173381f800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171f90cf800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d2d729bdde65dee3eae6@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
==================================================================
BUG: KASAN: slab-out-of-bounds in bpf_skb_proto_xlat net/core/filter.c:2637  
[inline]
BUG: KASAN: slab-out-of-bounds in ____bpf_skb_change_proto  
net/core/filter.c:2675 [inline]
BUG: KASAN: slab-out-of-bounds in bpf_skb_change_proto+0xe37/0x1300  
net/core/filter.c:2650
Read of size 2 at addr ffff8801b04646c0 by task syz-executor241/4519

CPU: 0 PID: 4519 Comm: syz-executor241 Not tainted 4.17.0+ #93
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load2_noabort+0x14/0x20 mm/kasan/report.c:431
  bpf_skb_proto_xlat net/core/filter.c:2637 [inline]
  ____bpf_skb_change_proto net/core/filter.c:2675 [inline]
  bpf_skb_change_proto+0xe37/0x1300 net/core/filter.c:2650

Allocated by task 0:
(stack is not available)

Freed by task 0:
(stack is not available)

The buggy address belongs to the object at ffff8801b04646c0
  which belongs to the cache skbuff_head_cache of size 232
The buggy address is located 0 bytes inside of
  232-byte region [ffff8801b04646c0, ffff8801b04647a8)
The buggy address belongs to the page:
page:ffffea0006c11900 count:1 mapcount:0 mapping:ffff8801d9a0d080 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea0006c49388 ffffea0006ae5c48 ffff8801d9a0d080
raw: 0000000000000000 ffff8801b0464080 000000010000000c 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801b0464580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801b0464600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8801b0464680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                            ^
  ffff8801b0464700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801b0464780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
