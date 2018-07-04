Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA0AC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10694224E6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10694224E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752682AbeGDPOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:14:37 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:52759 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752381AbeGDPND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:13:03 -0400
Received: by mail-it0-f72.google.com with SMTP id b132-v6so4782645iti.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 08:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3N5391NXF7Io+vFg0uta192HTq5kqTNOmDnntRFNogI=;
        b=hhp62QIM0huC3nadwA6Mk06GjXwUfgbkmQ3xyRtTvl0Kb33QnYq8jaY+cIMeCbl0pw
         9vaI1pBxi4qn6qCvvIdkVTly8k39ALwQH4sI+NWE5kr6U7pWB88qz2nTw2zTuOifW+wX
         TbQEH4tqHl5bkBAV4QkjCFPfPoHFpvNmLGFDlEEpV14Z1ZSf8m7/PWOU7AZF5y1MKXFR
         D5xwuMZM8PY00ldnNoYdsGpZciEmUxvISq1BjVhY0276ZMFwsco1fqn8m2vbsUf2lIq5
         QmxEepjCX1lHrlTHc3dYKi323PMJsakKRaJ4pL+uTsc2a6rDObP+EPTM4clJzbKTWggN
         oWOQ==
X-Gm-Message-State: APt69E2w4dJ5Oj0xs05MDbKqIgKFunctdqKLwqHgxrhjtj2IAs8u0HPy
        gI73XHX2zTVoXMXBFXnaDrCf3cIJtrjjpDkemNuCUibcAasx
X-Google-Smtp-Source: AAOMgpfoTvQ+kDVPfgGDeCIBuYnfQbt69+ih+PLeYopIUFJZebNuXSp7zfBUxyT52QdsSPCs6JlpN5QRRBpKedqYAHzHZeU4zklQ
MIME-Version: 1.0
X-Received: by 2002:a6b:1d87:: with SMTP id d129-v6mr866262iod.17.1530717182606;
 Wed, 04 Jul 2018 08:13:02 -0700 (PDT)
Date:   Wed, 04 Jul 2018 08:13:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ebc8e405702ddd18@google.com>
Subject: KASAN: use-after-scope Read in __hrtimer_run_queues
From:   syzbot <syzbot+7f73a81393d3b3777fb0@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    2bdea157b999 Merge branch 'sctp-fully-support-for-dscp-and..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14339f42400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f62553dc846b0692
dashboard link: https://syzkaller.appspot.com/bug?extid=7f73a81393d3b3777fb0
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7f73a81393d3b3777fb0@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-scope in lookup_object lib/debugobjects.c:157 [inline]
BUG: KASAN: use-after-scope in debug_object_deactivate+0x425/0x450  
lib/debugobjects.c:540
Read of size 8 at addr ffff88019d1a5ec0 by task syz-executor3/13445

CPU: 0 PID: 13445 Comm: syz-executor3 Not tainted 4.18.0-rc3+ #45
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
PANIC: double fault, error_code: 0x0
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
CPU: 1 PID: 13451 Comm: syz-executor7 Not tainted 4.18.0-rc3+ #45
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__lock_acquire+0x2e/0x5020 kernel/locking/lockdep.c:3294
Code:
41 57
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
41 89
cf 41
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
56 41
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
55
  lookup_object lib/debugobjects.c:157 [inline]
  debug_object_deactivate+0x425/0x450 lib/debugobjects.c:540
49 89
fd
41 54
45
  debug_hrtimer_deactivate kernel/time/hrtimer.c:421 [inline]
  debug_deactivate kernel/time/hrtimer.c:471 [inline]
  __run_hrtimer kernel/time/hrtimer.c:1368 [inline]
  __hrtimer_run_queues+0x2bf/0x10c0 kernel/time/hrtimer.c:1460
89 cc
53
65
4c 8b
34 25
40
ee
01
00
48
  hrtimer_interrupt+0x2f3/0x750 kernel/time/hrtimer.c:1518
83 e4
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
  smp_apic_timer_interrupt+0x165/0x730 arch/x86/kernel/apic/apic.c:1050
f0
48
81 ec
60
03 00
00 48
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
8b
  </IRQ>
45
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:783  
[inline]
RIP: 0010:kmem_cache_free+0xb3/0x2d0 mm/slab.c:3757
10 <89>
Code:
94 24
84
80
f1 00
00 00
00
00
00
48
41
ba 00
f7
00
c5
00
00
00
02
00 fc
00
ff
00
df
0f
48
84
89
c2
84 24
00
98
00
00
RSP: 0018:ffff880199163ec0 EFLAGS: 00010086
e8
b0
RAX: 0000000000000000 RBX: 1ffff1003322c855 RCX: 0000000000000002
fb
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff88f92620
a4
RBP: ffff880199164250 R08: 0000000000000000 R09: 0000000000000000
ff
R10: ffff88019e5171b8 R11: ffff8801daf236b3 R12: 0000000000000000
48
R13: ffffffff88f92620 R14: ffff8801b1e00080 R15: 0000000000000002
83
FS:  00007f6b584e4700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
3d
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
e0
CR2: ffff880199163eb8 CR3: 0000000008e6a000 CR4: 00000000001406e0
03
DR0: 00000000200001c0 DR1: 0000000000000000 DR2: 0000000000000000
38
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
07
Call Trace:
00


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
