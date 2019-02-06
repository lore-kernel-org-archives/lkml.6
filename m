Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C26C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 05:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771C120844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 05:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfBFFBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 00:01:05 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:51291 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfBFFBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 00:01:05 -0500
Received: by mail-it1-f198.google.com with SMTP id 2so2577646itf.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 21:01:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=X4F/sDIZEdS7NwnVbe37i/9aMAfDzAT04hQIjzToG34=;
        b=hvqZOzH7sxdy+cIBiNjJDq4y5sexYnubzaZeis4bIRz/D+LbrneiRlzNZy+1iy2AYD
         OfXgD8XPOwieVD5ZZcqv3UvWcOJskMnpWoLexxY0dkFMIsJRYlBZVofxAgU86XWtCe4W
         Ei0gKZ2fp3+TCz54xQRtgEZnKElWLi5WNz9WjkaJ8cWLuCqG8FgbuWVbsnP3jGBB/FuV
         9kGChBy/SBRlDtVXloyCjtW3tSO8J96E1YTaAy62yLP2af6j7+xxj6VhDD2NrIjjsYq7
         wAxUufMvJ0+YoF3y8s3b82lp0IAyKw4EKxaszoNZ4BzKZh8PeaHV+jF2+GMZKNpU3Q5M
         GI2A==
X-Gm-Message-State: AHQUAubYGitMBtq8y3riAkpeSM5DuBBi4dvUVadxBZftGXdoPDsF75lA
        Z18YqSgWF1sda3asoqaqwaVJkyMD1hlM+oL4qwOqTrvhNfVy
X-Google-Smtp-Source: AHgI3IZFdy8CGW8wNkpS7+qG0QlGTFG7zYp6KLzvliHgJJjD6m0fcAaZq44goiktGIt74bOQZiYz04U4Qox5hoRbBtW0hsXoo9rQ
MIME-Version: 1.0
X-Received: by 2002:a6b:d11a:: with SMTP id l26mr5882908iob.34.1549429263674;
 Tue, 05 Feb 2019 21:01:03 -0800 (PST)
Date:   Tue, 05 Feb 2019 21:01:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ddb37c0581329cc5@google.com>
Subject: KASAN: use-after-free Read in tcp_sk_exit
From:   syzbot <syzbot+f797267da5e5012d0920@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    33a0efa4baec devlink: Use DIV_ROUND_UP_ULL in DEVLINK_HEAL..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14e2e55f400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=505743eba4e4f68
dashboard link: https://syzkaller.appspot.com/bug?extid=f797267da5e5012d0920
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f797267da5e5012d0920@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in inet_ctl_sock_destroy  
include/net/inet_common.h:56 [inline]
BUG: KASAN: use-after-free in tcp_sk_exit+0x203/0x230  
net/ipv4/tcp_ipv4.c:2588
Read of size 8 at addr ffff888064de4378 by task kworker/u4:3/131

CPU: 0 PID: 131 Comm: kworker/u4:3 Not tainted 5.0.0-rc3+ #17
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: netns cleanup_net
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
  inet_ctl_sock_destroy include/net/inet_common.h:56 [inline]
  tcp_sk_exit+0x203/0x230 net/ipv4/tcp_ipv4.c:2588
  ops_exit_list.isra.0+0xb0/0x160 net/core/net_namespace.c:153
  cleanup_net+0x51d/0xb10 net/core/net_namespace.c:551
  process_one_work+0xd0c/0x1ce0 kernel/workqueue.c:2153
  worker_thread+0x143/0x14a0 kernel/workqueue.c:2296
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Allocated by task 5864:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_kmalloc mm/kasan/common.c:496 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:469
  kasan_kmalloc mm/kasan/common.c:504 [inline]
  kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:411
  kmem_cache_alloc+0x12d/0x710 mm/slab.c:3543
  getname_flags fs/namei.c:140 [inline]
  getname_flags+0xd6/0x5b0 fs/namei.c:129
  getname+0x1a/0x20 fs/namei.c:211
  do_sys_open+0x3a5/0x7c0 fs/open.c:1057
  __do_sys_open fs/open.c:1081 [inline]
  __se_sys_open fs/open.c:1076 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1076
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 5864:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:458
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:466
  __cache_free mm/slab.c:3487 [inline]
  kmem_cache_free+0x86/0x260 mm/slab.c:3749
  putname+0xef/0x130 fs/namei.c:261
  do_sys_open+0x3f4/0x7c0 fs/open.c:1072
  __do_sys_open fs/open.c:1081 [inline]
  __se_sys_open fs/open.c:1076 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1076
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff888064de4180
  which belongs to the cache names_cache of size 4096
The buggy address is located 504 bytes inside of
  4096-byte region [ffff888064de4180, ffff888064de5180)
The buggy address belongs to the page:
page:ffffea0001937900 count:1 mapcount:0 mapping:ffff88821bc45380 index:0x0  
compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea0001931108 ffffea0001796b88 ffff88821bc45380
raw: 0000000000000000 ffff888064de4180 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888064de4200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888064de4280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff888064de4300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                 ^
  ffff888064de4380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888064de4400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
