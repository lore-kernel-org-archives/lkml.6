Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14D0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB06B2177B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbfAJRDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:03:06 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:35595 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbfAJRDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:03:06 -0500
Received: by mail-io1-f71.google.com with SMTP id x12so10453692ioj.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:03:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=q3/b7ctL3EfmnlaMuYGMLe973HhALm+0afuZshfPZ3o=;
        b=pdOoEomw3ck+wNaq0kMa6pTZ86vkhs2r3FAVAOyc1Acz2MshC0u0mgF8SXdOwokLMF
         Fr5rLCwKGXBProCw5qN0GmSe7TBdNRxbV7L49O8qzUDAr6/J0d/oE04qJe8TXJarC2zO
         q7v7xVf9Dzfyv2aiVPzt8G7McKrINYmfUuHX987CeDFzCvCfhSudjswX0GAKIkMwQvTp
         BMb1Wdcke6BdgJEFA3kzSAO+AgyzWij1rwQGe9ABo5SALle8+Bd+RJv0ztnhBboIE6Vq
         66/lMish+rX3RvdjtsCTWJxE86gqijfFSPonK72yoNbE1clkAOQTnqBrQFWVSwixR+fs
         Lxbw==
X-Gm-Message-State: AJcUukdTvtzjTCfJxEkHW9kPg3Tg95LZILftpRhsTdbzggWwXdgELGan
        EWfGDLgQ1eQL4Z2M8yBqBKznteauJ6c5eNzbiqmo0ZG8u0lr
X-Google-Smtp-Source: ALg8bN5S1Gqk1xvS8TeAi0E79BDxF/BPl2kRDAyq52cNGYKNbpWaSnHMDRipQXXzLCAPHF5nKDS+mTWX6JiYBqwWHmVGcudKDGdD
MIME-Version: 1.0
X-Received: by 2002:a24:4ac3:: with SMTP id k186mr4745912itb.37.1547139784707;
 Thu, 10 Jan 2019 09:03:04 -0800 (PST)
Date:   Thu, 10 Jan 2019 09:03:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000491844057f1d8d2f@google.com>
Subject: KASAN: null-ptr-deref Read in reclaim_high
From:   syzbot <syzbot+fa11f9da42b46cea3b4a@syzkaller.appspotmail.com>
To:     cgroups@vger.kernel.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, syzkaller-bugs@googlegroups.com,
        vdavydov.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6cab33afc3dd Add linux-next specific files for 20190110
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=178b287b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=611f89e5b6868db
dashboard link: https://syzkaller.appspot.com/bug?extid=fa11f9da42b46cea3b4a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14259017400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141630a0c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fa11f9da42b46cea3b4a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in atomic64_read  
include/generated/atomic-instrumented.h:836 [inline]
BUG: KASAN: null-ptr-deref in atomic_long_read  
include/generated/atomic-long.h:28 [inline]
BUG: KASAN: null-ptr-deref in page_counter_read  
include/linux/page_counter.h:47 [inline]
BUG: KASAN: null-ptr-deref in reclaim_high.constprop.0+0xa6/0x1e0  
mm/memcontrol.c:2149
Read of size 8 at addr 0000000000000138 by task syz-executor037/7964

CPU: 1 PID: 7964 Comm: syz-executor037 Not tainted 5.0.0-rc1-next-20190110  
#9
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  kasan_report.cold+0x5/0x40 mm/kasan/report.c:321
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x123/0x190 mm/kasan/generic.c:191
  kasan_check_read+0x11/0x20 mm/kasan/common.c:100
  atomic64_read include/generated/atomic-instrumented.h:836 [inline]
  atomic_long_read include/generated/atomic-long.h:28 [inline]
  page_counter_read include/linux/page_counter.h:47 [inline]
  reclaim_high.constprop.0+0xa6/0x1e0 mm/memcontrol.c:2149
  mem_cgroup_handle_over_high+0xc1/0x180 mm/memcontrol.c:2178
  tracehook_notify_resume include/linux/tracehook.h:190 [inline]
  exit_to_usermode_loop+0x299/0x3b0 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath+0x519/0x5f0 arch/x86/entry/common.c:268
  ret_from_fork+0x15/0x50 arch/x86/entry/entry_64.S:344
RIP: 0033:0x44034a
Code: Bad RIP value.
RSP: 002b:00007ffc31cd3040 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000044034a
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007ffc31cd3060 R08: 0000000000000001 R09: 0000000002027880
R10: 0000000002027b50 R11: 0000000000000246 R12: 0000000000000001
R13: 000000000000cc59 R14: 0000000000000000 R15: 0000000000000000
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
