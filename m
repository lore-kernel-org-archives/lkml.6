Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B923C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49626219AC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49626219AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934241AbeGFRwF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:52:05 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:53072 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933775AbeGFRwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:52:02 -0400
Received: by mail-it0-f70.google.com with SMTP id b132-v6so10241316iti.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 10:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=xz3Eew5UEGJAzYp5AWUh4DnS2+PyaroiiKht6BMsNE8=;
        b=JH6vnDOPYOyZ6euyCYVFBHwLQYFQtyIrqpODLWHA/GdF1jVV7rM/pn4XcxBXyLmpD6
         WvyzmuoDy8gq8XF29BmZz2gF0MqAoU2PxMKEyZ4I29vnRv2EQzNQH60opmFHz/vKEU/S
         ufgGIxXPKuDJWaAqlhSkvjh/0RCsCDO07F3qjVlA7b1LD7I2BwMwSc/oAD6BpGIXAcXU
         yMGObdPA2AA1G0grguLBHC/vmESqDme9R/wUwl75a6uPRnB1gPFxZQagHDLi42zWmZKv
         GFxMWy/zC5Ssln3ZTqjIV75suiwpDIRBNyi72PAWU+eypMgRMwuTdvqco6K5pradBJmS
         VKpw==
X-Gm-Message-State: AOUpUlH5WCA1AUoDMsRLhGWNfRR7gcC6rYgEP+UpcMze7oGnFnJuviTM
        AzOnTX3BasyxQ/LQ9bmVTUM2mZnzy5c8xZ+3iJP3IGiXKt/s
X-Google-Smtp-Source: AAOMgpe9IYILj41O2UOaSQmpDWR4ka4p73F1Up844V0XFq5nRlXxaxVl1UtpDzfEZ3lbY0ZktizSmhK7FR4BAfjkPD7bJ5f7YzfD
MIME-Version: 1.0
X-Received: by 2002:a6b:c648:: with SMTP id w69-v6mr4714045iof.108.1530899522120;
 Fri, 06 Jul 2018 10:52:02 -0700 (PDT)
Date:   Fri, 06 Jul 2018 10:52:02 -0700
In-Reply-To: <000000000000b0ee7a056eea93a7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000033f8440570585207@google.com>
Subject: Re: KASAN: use-after-free Read in ipv6_gso_pull_exthdrs
From:   syzbot <syzbot+7b9ed9872dab8c32305d@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    70ba5b6db96f ipv4: Return EINVAL when ping_group_range sys..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=13cd2970400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca6c7a31d407f86
dashboard link: https://syzkaller.appspot.com/bug?extid=7b9ed9872dab8c32305d
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=15dfb748400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a1050c400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7b9ed9872dab8c32305d@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): bond0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
BUG: KASAN: use-after-free in ipv6_gso_pull_exthdrs+0x57a/0x5f0  
net/ipv6/ip6_offload.c:45
Read of size 1 at addr ffff8801ce17f3a9 by task syz-executor655/4567

CPU: 1 PID: 4567 Comm: syz-executor655 Not tainted 4.18.0-rc3+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
  ipv6_gso_pull_exthdrs+0x57a/0x5f0 net/ipv6/ip6_offload.c:45
  ipv6_gso_segment+0x37a/0x11e0 net/ipv6/ip6_offload.c:87
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  __skb_gso_segment+0x3c3/0x880 net/core/dev.c:2865
  skb_gso_segment include/linux/netdevice.h:4099 [inline]
  validate_xmit_skb+0x640/0xf30 net/core/dev.c:3104
  __dev_queue_xmit+0xc14/0x3910 net/core/dev.c:3561
  dev_queue_xmit+0x17/0x20 net/core/dev.c:3602
  packet_snd net/packet/af_packet.c:2919 [inline]
  packet_sendmsg+0x428e/0x6130 net/packet/af_packet.c:2944
  sock_sendmsg_nosec net/socket.c:641 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:651
  __sys_sendto+0x3d7/0x670 net/socket.c:1797
  __do_sys_sendto net/socket.c:1809 [inline]
  __se_sys_sendto net/socket.c:1805 [inline]
  __x64_sys_sendto+0xe1/0x1a0 net/socket.c:1805
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441de9
Code: 25 02 00 85 c0 b8 00 00 00 00 48 0f 44 c3 5b c3 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 8b 0d fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00000000007dfe28 EFLAGS: 00000212 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000021 RCX: 0000000000441de9
RDX: 0000000000000012 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00000000004a3f10 R08: 00000000200000c0 R09: 000000000000001c
R10: 0000000000000000 R11: 0000000000000212 R12: 00000000007dff68
R13: 0000000000403090 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 3516:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x760 mm/slab.c:3554
  kmem_cache_zalloc include/linux/slab.h:697 [inline]
  get_empty_filp+0x12d/0x530 fs/file_table.c:122
  path_openat+0x11e/0x4e10 fs/namei.c:3516
  do_filp_open+0x255/0x380 fs/namei.c:3574
  do_sys_open+0x584/0x760 fs/open.c:1101
  __do_sys_open fs/open.c:1119 [inline]
  __se_sys_open fs/open.c:1114 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1114
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 3519:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x86/0x2d0 mm/slab.c:3756
  file_free_rcu+0x6f/0x90 fs/file_table.c:49
  __rcu_reclaim kernel/rcu/rcu.h:178 [inline]
  rcu_do_batch kernel/rcu/tree.c:2558 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2818 [inline]
  __rcu_process_callbacks kernel/rcu/tree.c:2785 [inline]
  rcu_process_callbacks+0xed5/0x1850 kernel/rcu/tree.c:2802
  __do_softirq+0x2e8/0xb17 kernel/softirq.c:288

The buggy address belongs to the object at ffff8801ce17f280
  which belongs to the cache filp of size 456
The buggy address is located 297 bytes inside of
  456-byte region [ffff8801ce17f280, ffff8801ce17f448)
The buggy address belongs to the page:
page:ffffea0007385fc0 count:1 mapcount:0 mapping:ffff8801da987940  
index:0xffff8801ce17f780
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea0007368048 ffffea0007368148 ffff8801da987940
raw: ffff8801ce17f780 ffff8801ce17f000 0000000100000005 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801ce17f280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801ce17f300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801ce17f380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                   ^
  ffff8801ce17f400: fb fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc
  ffff8801ce17f480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

