Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95161C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663C92147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfBTQXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:23:06 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:38370 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfBTQXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:23:05 -0500
Received: by mail-it1-f199.google.com with SMTP id r136so11681560ith.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 08:23:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=CAIiaGXByzjptiSrbRLB6xY7uJffPVF4i/uIxI9EqfU=;
        b=Pr5XLsbLX7k9YqjmDir4jKaRq4T0yAXOQeRKv3RzDXuv8QG2q65Hu7u/X7KooRNHj8
         lwW3uMFuS8jJ6mni/6ubsR37fJIe5sRqbJ7ty8qdRlAKyWc5/8id1nJ2wMAAf9NM2m96
         YgNgAbKwhtt/mktsoIIlhHpBEE3V4BvzUjobJzzocMbMwwW4NiVrUhyhzUpwYBItsHlB
         7ZRtatz8OCFxuVYvl1NvMu5gexw/SiOVHw8Jn866Qo8nvNVyBtb3zCJkvo8fkbe5pnXD
         uqrPPauFPWAjGf10yeTpyXwosOwoOxJsy/3tyilwEWhjjJIqn1IyeRJKrsw/VhK+JQxJ
         vCHw==
X-Gm-Message-State: AHQUAuYV79zZ6VBhC+FcusdfTP1nfFlKakmauP5aPV2AWwwv5VeUkHa6
        zteCpbqj15uvR9rpCoJZXLhNy0BAE7UzOIrUP9XCYE3ML27r
X-Google-Smtp-Source: AHgI3IY9XKG+t51sWIojR85YZOnmXckMQ8T+8GyggJqNCY69wCH+CzaUzzYsoCVdwh7OM3WSJyWKNXh8wSG412iaCBeA0clLqkA/
MIME-Version: 1.0
X-Received: by 2002:a24:1303:: with SMTP id 3mr584181itz.40.1550679784303;
 Wed, 20 Feb 2019 08:23:04 -0800 (PST)
Date:   Wed, 20 Feb 2019 08:23:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b436ad058255c528@google.com>
Subject: KASAN: use-after-free Read in icmp_sk_exit
From:   syzbot <syzbot+3d7fa0f0de0f86d0eb4f@syzkaller.appspotmail.com>
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

HEAD commit:    1f43f400a2cb net: netcp: Fix ethss driver probe issue
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1276fea2c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee434566c893c7b1
dashboard link: https://syzkaller.appspot.com/bug?extid=3d7fa0f0de0f86d0eb4f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3d7fa0f0de0f86d0eb4f@syzkaller.appspotmail.com

IPVS: set_ctl: invalid protocol: 63 172.20.20.187:20002
kernel msg: ebtables bug: please report to author: entries_size too small
kernel msg: ebtables bug: please report to author: entries_size too small
==================================================================
BUG: KASAN: use-after-free in inet_ctl_sock_destroy  
include/net/inet_common.h:56 [inline]
BUG: KASAN: use-after-free in icmp_sk_exit+0x1ce/0x1f0 net/ipv4/icmp.c:1187
Read of size 8 at addr ffff8880847adc50 by task kworker/u4:1/21

CPU: 0 PID: 21 Comm: kworker/u4:1 Not tainted 5.0.0-rc6+ #85
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: netns cleanup_net
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
  inet_ctl_sock_destroy include/net/inet_common.h:56 [inline]
  icmp_sk_exit+0x1ce/0x1f0 net/ipv4/icmp.c:1187
  ops_exit_list.isra.0+0xb0/0x160 net/core/net_namespace.c:153
  cleanup_net+0x3fb/0x960 net/core/net_namespace.c:551
  process_one_work+0x98e/0x1790 kernel/workqueue.c:2173
  worker_thread+0x98/0xe40 kernel/workqueue.c:2319
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Allocated by task 25570:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_kmalloc mm/kasan/common.c:496 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:469
  kasan_kmalloc mm/kasan/common.c:504 [inline]
  kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:411
  kmem_cache_alloc+0x12d/0x710 mm/slab.c:3543
  sk_prot_alloc+0x67/0x2e0 net/core/sock.c:1471
  sk_alloc+0x39/0xf70 net/core/sock.c:1531
  inet_create net/ipv4/af_inet.c:321 [inline]
  inet_create+0x36a/0xe10 net/ipv4/af_inet.c:247
  __sock_create+0x3e6/0x750 net/socket.c:1275
  sock_create_kern+0x3b/0x50 net/socket.c:1321
  inet_ctl_sock_create+0x9d/0x1f0 net/ipv4/af_inet.c:1614
  icmp_sk_init net/ipv4/icmp.c:1203 [inline]
  icmp_sk_init+0x120/0x680 net/ipv4/icmp.c:1192
  ops_init+0xb6/0x410 net/core/net_namespace.c:129
  setup_net+0x2c5/0x730 net/core/net_namespace.c:314
  copy_net_ns+0x1d9/0x340 net/core/net_namespace.c:437
  create_new_namespaces+0x400/0x7b0 kernel/nsproxy.c:107
  unshare_nsproxy_namespaces+0xc2/0x200 kernel/nsproxy.c:206
  ksys_unshare+0x440/0x980 kernel/fork.c:2550
  __do_sys_unshare kernel/fork.c:2618 [inline]
  __se_sys_unshare kernel/fork.c:2616 [inline]
  __x64_sys_unshare+0x31/0x40 kernel/fork.c:2616
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 21:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:458
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:466
  __cache_free mm/slab.c:3487 [inline]
  kmem_cache_free+0x86/0x260 mm/slab.c:3749
  sk_prot_free net/core/sock.c:1512 [inline]
  __sk_destruct+0x4b6/0x6d0 net/core/sock.c:1596
  sk_destruct+0x7b/0x90 net/core/sock.c:1604
  __sk_free+0xce/0x300 net/core/sock.c:1615
  sk_free+0x42/0x50 net/core/sock.c:1626
  sock_put include/net/sock.h:1707 [inline]
  sk_common_release+0x224/0x330 net/core/sock.c:3042
  raw_close+0x22/0x30 net/ipv4/raw.c:708
  inet_release+0x105/0x1f0 net/ipv4/af_inet.c:428
  __sock_release+0x1d3/0x250 net/socket.c:579
  sock_release+0x18/0x20 net/socket.c:598
  inet_ctl_sock_destroy include/net/inet_common.h:56 [inline]
  icmp_sk_exit+0x11f/0x1f0 net/ipv4/icmp.c:1187
  ops_exit_list.isra.0+0xb0/0x160 net/core/net_namespace.c:153
  cleanup_net+0x3fb/0x960 net/core/net_namespace.c:551
  process_one_work+0x98e/0x1790 kernel/workqueue.c:2173
  worker_thread+0x98/0xe40 kernel/workqueue.c:2319
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff8880847ad840
  which belongs to the cache RAW(97:syz4) of size 1320
The buggy address is located 1040 bytes inside of
  1320-byte region [ffff8880847ad840, ffff8880847add68)
The buggy address belongs to the page:
page:ffffea000211eb00 count:1 mapcount:0 mapping:ffff8880a84bf1c0  
index:0xffff8880847ac140 compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffff8880a4cd5b38 ffff8880a4cd5b38 ffff8880a84bf1c0
raw: ffff8880847ac140 ffff8880847ac140 0000000100000003 ffff888067b1a1c0
page dumped because: kasan: bad access detected
page->mem_cgroup:ffff888067b1a1c0

Memory state around the buggy address:
  ffff8880847adb00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880847adb80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8880847adc00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                  ^
  ffff8880847adc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880847add00: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
