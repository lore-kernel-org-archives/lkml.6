Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A515BC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BEE2208D8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BEE2208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935813AbeFMWRE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 18:17:04 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:44674 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754541AbeFMWRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 18:17:03 -0400
Received: by mail-it0-f72.google.com with SMTP id 202-v6so3708727itw.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 15:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=IkRG8C1CPab5iv1lnOLLg10dxIDRw9GAtp5ATLFENNU=;
        b=AhTGnk+T02l+KFTe3PoqBazsPPTXXryPFh7T7304Ijsw0qCWLEHaxAJz1w4ISJv6TJ
         cb9HNIGFn5+1ZkGw5yPDDbQeSbrzm1H1hWF0PSLcflCL18JRda6khsb4KKuKir6DEzex
         pbbXcs9jGh0D9rZkleMbxCs7y3xhfjug973VF7pBMpLUNIyj2keaphkYkxAnQeIv/Pbb
         h5GoybQDHX7XmDGJeXalSrWtGLup+oQlWl9i2MeoWhFVwjr/640aQlgIRHbx6VIQKJs+
         oeGQQu63E4hgs1OpdyrCt0vtciIIiaUqWor0RmFJzAU7gHgnwtNEom5A8y8+2hLtGIB5
         QUPw==
X-Gm-Message-State: APt69E2+iKSnXk0E/r90itCa71JRE/FHakX5LhbclnacBCsfyZlvkKek
        PYhsYOrMbMI7EzOOpY02QlVA7WsLpvVxKwNRlapsDzl+X7+9
X-Google-Smtp-Source: ADUXVKI6Zp5xLA1Lnz50xM0wfYw1ajPSPyvqbTrO/c1O0Qr/6wqe8IwrlwIc0aTKs/AchRh5kQYbLVgC4it8NBnFQDUBEESbLNAj
MIME-Version: 1.0
X-Received: by 2002:a6b:3b06:: with SMTP id i6-v6mr3006811ioa.131.1528928222647;
 Wed, 13 Jun 2018 15:17:02 -0700 (PDT)
Date:   Wed, 13 Jun 2018 15:17:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009920d3056e8d57a9@google.com>
Subject: KASAN: slab-out-of-bounds Read in bpf_skb_change_head
From:   syzbot <syzbot+567faa843005dda30737@syzkaller.appspotmail.com>
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

HEAD commit:    75d4e704fa8d netdev-FAQ: clarify DaveM's position for stab..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16bd21af800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a601a80fec461d44
dashboard link: https://syzkaller.appspot.com/bug?extid=567faa843005dda30737
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1039185f800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11e85cff800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+567faa843005dda30737@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
==================================================================
BUG: KASAN: slab-out-of-bounds in ____bpf_skb_change_head  
net/core/filter.c:2921 [inline]
BUG: KASAN: slab-out-of-bounds in bpf_skb_change_head+0x80c/0x9d0  
net/core/filter.c:2917
Read of size 4 at addr ffff8801d94ea680 by task syz-executor991/4551

CPU: 0 PID: 4551 Comm: syz-executor991 Not tainted 4.17.0-rc7+ #38
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
  ____bpf_skb_change_head net/core/filter.c:2921 [inline]
  bpf_skb_change_head+0x80c/0x9d0 net/core/filter.c:2917

Allocated by task 0:
(stack is not available)

Freed by task 0:
(stack is not available)

The buggy address belongs to the object at ffff8801d94ea580
  which belongs to the cache skbuff_head_cache of size 232
The buggy address is located 24 bytes to the right of
  232-byte region [ffff8801d94ea580, ffff8801d94ea668)
The buggy address belongs to the page:
page:ffffea0007653a80 count:1 mapcount:0 mapping:ffff8801d94ea080 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffff8801d94ea080 0000000000000000 000000010000000c
raw: ffffea0006b2e720 ffffea00076595e0 ffff8801d9450e40 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d94ea580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801d94ea600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8801d94ea680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                    ^
  ffff8801d94ea700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801d94ea780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
