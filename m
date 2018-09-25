Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00A7C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707B620895
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707B620895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeIZGEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 02:04:05 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:58440 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbeIZGEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 02:04:05 -0400
Received: by mail-it1-f198.google.com with SMTP id d194-v6so713071itb.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 16:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ReUU9GMMSiK2fME3/XVbL95NLZOdYumWqCnlQXlyNto=;
        b=m7/9XfzQRO9/l9hF0JXnMk7Pjh6HsVTQNsDzIW3RdIGsuoJWDfxtNbOprf0KjytXnP
         EJH02NQ9DGc8GBGiYm8ITrW9ujzMiYIYQWlvLCPe8KuNxlVoJAkwxIb1axfEEGDCn1+5
         NTQNKKd42ZaxJwRV5vNse+fZUGA2G+oiUDjaL7bk25emnJ+quKRiAv6C+rZYRO8U2cw9
         vbZF8fvRoPei6ZUoSCHM1BhFML/1khfUenP64x9tS4laG0Fb8tavGbNVyfe3gMz6vRSv
         3kfqP7kmFSm6n5RaCYFL1UpGZx8IgA4eoAhqif1ZKgC+aYjlcGfA44TAkflQi1f63g4a
         Qehw==
X-Gm-Message-State: ABuFfojLFdD0C34D9xwqX+vy8kKbEYy8bsipngkZdD1UPv0a22CJ7X1I
        pWRkxQ3BBLtWqYMS0bs0PMy1OmSe5CsLfNakOq+vfcY4w7Fj
X-Google-Smtp-Source: ACcGV6086RNULXp29YLaeTioucknkam1kSiofvrjgODNYSWTAdnUe/98/Pe125ZZRaN21kia2UhnWIKRayyl7G1qaX5bkgKcwAqW
MIME-Version: 1.0
X-Received: by 2002:a6b:4a16:: with SMTP id w22-v6mr2642773iob.132.1537919643439;
 Tue, 25 Sep 2018 16:54:03 -0700 (PDT)
Date:   Tue, 25 Sep 2018 16:54:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a5b840576bad225@google.com>
Subject: KASAN: slab-out-of-bounds Read in tls_write_space
From:   syzbot <syzbot+12638b747fd208f6cff0@syzkaller.appspotmail.com>
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

HEAD commit:    bd4d08daeb95 Merge branch 'net-dsa-b53-SGMII-modes-fixes'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=110b6a1a400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e79b9299baeb2298
dashboard link: https://syzkaller.appspot.com/bug?extid=12638b747fd208f6cff0
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=167d9b9e400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c4003a400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+12638b747fd208f6cff0@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
TCP: request_sock_TCPv6: Possible SYN flooding on port 20002. Sending  
cookies.  Check SNMP counters.
==================================================================
BUG: KASAN: slab-out-of-bounds in __swab64p include/uapi/linux/swab.h:192  
[inline]
BUG: KASAN: slab-out-of-bounds in __be64_to_cpup  
include/uapi/linux/byteorder/little_endian.h:74 [inline]
BUG: KASAN: slab-out-of-bounds in is_tx_ready include/net/tls.h:354 [inline]
BUG: KASAN: slab-out-of-bounds in tls_write_space+0x29d/0x2d0  
net/tls/tls_main.c:236
Read of size 8 at addr ffff8801bc3c9ff0 by task ksoftirqd/1/18

CPU: 1 PID: 18 Comm: ksoftirqd/1 Not tainted 4.19.0-rc4+ #227
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __swab64p include/uapi/linux/swab.h:192 [inline]
  __be64_to_cpup include/uapi/linux/byteorder/little_endian.h:74 [inline]
  is_tx_ready include/net/tls.h:354 [inline]
  tls_write_space+0x29d/0x2d0 net/tls/tls_main.c:236
  tcp_new_space net/ipv4/tcp_input.c:5154 [inline]
  tcp_check_space+0x53f/0x920 net/ipv4/tcp_input.c:5165
  tcp_data_snd_check net/ipv4/tcp_input.c:5175 [inline]
  tcp_rcv_established+0xde8/0x2120 net/ipv4/tcp_input.c:5656
  tcp_v6_do_rcv+0x4b3/0x13c0 net/ipv6/tcp_ipv6.c:1326
  tcp_v6_rcv+0x2f7a/0x38a0 net/ipv6/tcp_ipv6.c:1555
  ip6_input_finish+0x3fc/0x1aa0 net/ipv6/ip6_input.c:384
  NF_HOOK include/linux/netfilter.h:287 [inline]
  ip6_input+0xe9/0x600 net/ipv6/ip6_input.c:427
  dst_input include/net/dst.h:450 [inline]
  ip6_rcv_finish+0x17a/0x330 net/ipv6/ip6_input.c:76
  NF_HOOK include/linux/netfilter.h:287 [inline]
  ipv6_rcv+0x113/0x640 net/ipv6/ip6_input.c:272
  __netif_receive_skb_one_core+0x14d/0x200 net/core/dev.c:4894
  __netif_receive_skb+0x2c/0x1e0 net/core/dev.c:5004
  process_backlog+0x217/0x760 net/core/dev.c:5808
  napi_poll net/core/dev.c:6228 [inline]
  net_rx_action+0x7c5/0x1950 net/core/dev.c:6294
  __do_softirq+0x30b/0xad8 kernel/softirq.c:292
  run_ksoftirqd+0x94/0x100 kernel/softirq.c:653
  smpboot_thread_fn+0x68b/0xa00 kernel/smpboot.c:164
  kthread+0x35a/0x420 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413

Allocated by task 3559:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
  kmalloc include/linux/slab.h:513 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  kernfs_fop_open+0x358/0xf90 fs/kernfs/file.c:648
  do_dentry_open+0x499/0x1250 fs/open.c:771
  vfs_open+0xa0/0xd0 fs/open.c:880
  do_last fs/namei.c:3418 [inline]
  path_openat+0x12bf/0x5160 fs/namei.c:3534
  do_filp_open+0x255/0x380 fs/namei.c:3564
  do_sys_open+0x568/0x700 fs/open.c:1063
  __do_sys_open fs/open.c:1081 [inline]
  __se_sys_open fs/open.c:1076 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1076
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 3559:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3813
  kernfs_fop_release+0x12b/0x1a0 fs/kernfs/file.c:783
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801bc3c9c80
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 368 bytes to the right of
  512-byte region [ffff8801bc3c9c80, ffff8801bc3c9e80)
The buggy address belongs to the page:
page:ffffea0006f0f240 count:1 mapcount:0 mapping:ffff8801da800940 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea0006ee1408 ffffea0007619c08 ffff8801da800940
raw: 0000000000000000 ffff8801bc3c9000 0000000100000006 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801bc3c9e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801bc3c9f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8801bc3c9f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                              ^
  ffff8801bc3ca000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801bc3ca080: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
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
