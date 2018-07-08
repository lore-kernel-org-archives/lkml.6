Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA61C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 23:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88638208D9
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 23:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88638208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933402AbeGHXzF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 19:55:05 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:51900 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932833AbeGHXzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 19:55:03 -0400
Received: by mail-io0-f200.google.com with SMTP id w23-v6so5583827iob.18
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 16:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=qsrRNTLH4IbN1rUonOBbdoTSCaWIH2S/IcuYTPUmriI=;
        b=BqSdOM494J2frOY64/W2MfzxHeKp3vtcYFgjIppqtejq9N+R0EDZcn/7ZxbUkJHUU0
         JsDJUah2EO7qKXIRfLOGE0xHE/Z9Tr/t/iiIJm+U2gAMNUVweIQR64kurJc9PDztV1jW
         6V/hjkPK7bdtmMd3N2eOIeHX+rsBFmSX40zTsrj/2VUt/EOSar+vhsZEhCRnztUmohpd
         HtCEClFONMaq7jaNEZEClTIyWfDp3ZDa9aYMInZKtqeRvoGa7cCkEEfMzoiZRqpFty/g
         ZeGeZ5pNRbJpSt1RFyYQfRNA/FRL98AEYDaKRh0AJ5iN5h2/DJVNGr73LAw38F9sq8Et
         hYvA==
X-Gm-Message-State: AOUpUlG1/+TKZ1SpnT/IZlDLw5CW7Ja3Xybql9hH2ZSsPSaAvFZCY3qa
        QD8Wr6/kz63X8CQWfYWM9iOeawHQ5wAdFyYCDjm+ergzLyah
X-Google-Smtp-Source: AAOMgpdZ/614uafN7D6gcEt74JHKHUBw1MebqzNCO031IPuzzlGbHSTZicYW6j572dp415WuKn8tB/nQdiuiWHTffLAFIgK4Za/B
MIME-Version: 1.0
X-Received: by 2002:a6b:5015:: with SMTP id e21-v6mr8428699iob.67.1531094102741;
 Sun, 08 Jul 2018 16:55:02 -0700 (PDT)
Date:   Sun, 08 Jul 2018 16:55:02 -0700
In-Reply-To: <0000000000003dab1605704fb71d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c9aa1057085a0bc@google.com>
Subject: Re: KASAN: use-after-free Read in tls_write_space
From:   syzbot <syzbot+2134b6b74dec9f8c760f@syzkaller.appspotmail.com>
To:     aviadye@mellanox.com, borisp@mellanox.com, davejwatson@fb.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    c47078d6a33f tcp: remove redundant SOCK_DONE checks
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=120012c2400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a501a01deaf0fe9
dashboard link: https://syzkaller.appspot.com/bug?extid=2134b6b74dec9f8c760f
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=16950594400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d180c8400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2134b6b74dec9f8c760f@syzkaller.appspotmail.com

TCP: request_sock_TCPv6: Possible SYN flooding on port 20002. Sending  
cookies.  Check SNMP counters.
TCP: request_sock_TCPv6: Possible SYN flooding on port 20002. Sending  
cookies.  Check SNMP counters.
TCP: request_sock_TCPv6: Possible SYN flooding on port 20002. Sending  
cookies.  Check SNMP counters.
TCP: request_sock_TCPv6: Possible SYN flooding on port 20002. Sending  
cookies.  Check SNMP counters.
==================================================================
BUG: KASAN: use-after-free in tls_write_space+0x2c2/0x360  
net/tls/tls_main.c:225
Read of size 1 at addr ffff8801aebdd420 by task ksoftirqd/1/18

CPU: 1 PID: 18 Comm: ksoftirqd/1 Not tainted 4.18.0-rc3+ #113
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
  tls_write_space+0x2c2/0x360 net/tls/tls_main.c:225
  tcp_new_space net/ipv4/tcp_input.c:5081 [inline]
  tcp_check_space+0x551/0x930 net/ipv4/tcp_input.c:5092
  tcp_data_snd_check net/ipv4/tcp_input.c:5102 [inline]
  tcp_rcv_established+0x8db/0x2180 net/ipv4/tcp_input.c:5581
  tcp_v6_do_rcv+0x4b2/0x1450 net/ipv6/tcp_ipv6.c:1325
  tcp_v6_rcv+0x342a/0x3a70 net/ipv6/tcp_ipv6.c:1554
  ip6_input_finish+0x407/0x1a40 net/ipv6/ip6_input.c:383
  NF_HOOK include/linux/netfilter.h:287 [inline]
  ip6_input+0xe9/0x600 net/ipv6/ip6_input.c:426
  dst_input include/net/dst.h:450 [inline]
  ip6_rcv_finish+0x17a/0x330 net/ipv6/ip6_input.c:76
  NF_HOOK include/linux/netfilter.h:287 [inline]
  ipv6_rcv+0x11e/0x650 net/ipv6/ip6_input.c:271
  __netif_receive_skb_one_core+0x14d/0x200 net/core/dev.c:4767
  __netif_receive_skb+0x2c/0x1e0 net/core/dev.c:4872
  process_backlog+0x219/0x760 net/core/dev.c:5663
  napi_poll net/core/dev.c:6078 [inline]
  net_rx_action+0x7a5/0x1950 net/core/dev.c:6144
  __do_softirq+0x2e8/0xb17 kernel/softirq.c:288
  run_ksoftirqd+0x86/0x100 kernel/softirq.c:649
  smpboot_thread_fn+0x417/0x870 kernel/smpboot.c:164
  kthread+0x345/0x410 kernel/kthread.c:240
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

Allocated by task 8159:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
  kmalloc include/linux/slab.h:513 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  create_ctx net/tls/tls_main.c:535 [inline]
  tls_init+0x1e7/0xb20 net/tls/tls_main.c:659
  tcp_set_ulp+0x1bc/0x520 net/ipv4/tcp_ulp.c:153
  do_tcp_setsockopt.isra.41+0x44a/0x2680 net/ipv4/tcp.c:2748
  tcp_setsockopt+0xc1/0xe0 net/ipv4/tcp.c:3059
  sock_common_setsockopt+0x9a/0xe0 net/core/sock.c:3083
  __sys_setsockopt+0x1c5/0x3b0 net/socket.c:1911
  __do_sys_setsockopt net/socket.c:1922 [inline]
  __se_sys_setsockopt net/socket.c:1919 [inline]
  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1919
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 8159:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  tls_sk_proto_close+0x712/0xae0 net/tls/tls_main.c:297
  inet_release+0x104/0x1f0 net/ipv4/af_inet.c:427
  inet6_release+0x50/0x70 net/ipv6/af_inet6.c:459
  __sock_release+0xd7/0x260 net/socket.c:599
  sock_close+0x19/0x20 net/socket.c:1150
  __fput+0x355/0x8b0 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:192 [inline]
  exit_to_usermode_loop+0x313/0x370 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801aebdd340
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 224 bytes inside of
  512-byte region [ffff8801aebdd340, ffff8801aebdd540)
The buggy address belongs to the page:
page:ffffea0006baf740 count:1 mapcount:0 mapping:ffff8801da800940  
index:0xffff8801aebdd5c0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea00073b1fc8 ffffea0006cd3448 ffff8801da800940
raw: ffff8801aebdd5c0 ffff8801aebdd0c0 0000000100000002 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801aebdd300: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
  ffff8801aebdd380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801aebdd400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                ^
  ffff8801aebdd480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801aebdd500: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================

