Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BD41CC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FC720891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66FC720891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934949AbeFMQRF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 12:17:05 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:42867 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934632AbeFMQRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 12:17:03 -0400
Received: by mail-io0-f199.google.com with SMTP id w24-v6so2574177ioc.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 09:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=HYR2ODYKUBShlC/92tdBl/V4r8ChT2BhCLpNHjv4MmE=;
        b=TdbzxrgXv8+cYwmXT05zrYSHf5GWroq54cyjRm3sDfuLWlXcubX+pTToK/0tcI6XJt
         M6h1Yi33toLW+npXM2TqPblTIQaNysmSUVAWpktDSf38jYCtT77ciIG6QmUYP2uoDe+b
         YGf6yrCYYo5Qc6XTEuTDDr0nDOgXNBhPHpFpL3FQfwon2SDWS5N1u23UyvgL5oFW34sn
         cRCI8kyFWQqW5WPfSWWnXMZyNj8PmVFQ2v9o9n+j8IPPIPjb7mqnW8EXeYE3m1RGIXVa
         we/KAX7J4bphzJ6mV/z+rfWlmP6gZ+jYOZq0i1T03+wmSJh3z+RtlqUrBAxXrbpPgInB
         M59A==
X-Gm-Message-State: APt69E03VC/ZDy5Cg+jRv+zi8fZEDChscpWzinONW3Tx9bKNriGHoZL1
        RZA40izO9pWSE8sXpsCqsy5I5P6uJ8KUJvssMFyB9elOiOvZ
X-Google-Smtp-Source: ADUXVKLGi91gLXQ4x3i0uFeGeTRgTqWf5xbWLAZdHcNeV34u+G106V+P3vpHqRsT5wkCx4fh+6SC+/1GrRfgx3AQ5CCkB3YrTmkJ
MIME-Version: 1.0
X-Received: by 2002:a5e:8d11:: with SMTP id m17-v6mr2297082ioj.132.1528906622538;
 Wed, 13 Jun 2018 09:17:02 -0700 (PDT)
Date:   Wed, 13 Jun 2018 09:17:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000219be6056e8850fa@google.com>
Subject: KASAN: slab-out-of-bounds Read in bpf_skb_vlan_push
From:   syzbot <syzbot+76de61614cb1abdd73fc@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1754783f800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a601a80fec461d44
dashboard link: https://syzkaller.appspot.com/bug?extid=76de61614cb1abdd73fc
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=12c1e1bf800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+76de61614cb1abdd73fc@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
BUG: KASAN: slab-out-of-bounds in skb_at_tc_ingress  
include/net/sch_generic.h:535 [inline]
BUG: KASAN: slab-out-of-bounds in bpf_push_mac_rcsum net/core/filter.c:1625  
[inline]
BUG: KASAN: slab-out-of-bounds in ____bpf_skb_vlan_push  
net/core/filter.c:2446 [inline]
BUG: KASAN: slab-out-of-bounds in bpf_skb_vlan_push+0x6b7/0x720  
net/core/filter.c:2437
Read of size 5 at addr ffff8801b77347d0 by task syz-executor6/6529

CPU: 1 PID: 6529 Comm: syz-executor6 Not tainted 4.17.0-rc7+ #38
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load_n_noabort+0xf/0x20 mm/kasan/report.c:443
  skb_at_tc_ingress include/net/sch_generic.h:535 [inline]
  bpf_push_mac_rcsum net/core/filter.c:1625 [inline]
  ____bpf_skb_vlan_push net/core/filter.c:2446 [inline]
  bpf_skb_vlan_push+0x6b7/0x720 net/core/filter.c:2437

Allocated by task 6523:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc_node+0x144/0x780 mm/slab.c:3644
  __alloc_skb+0x111/0x780 net/core/skbuff.c:193
  alloc_skb include/linux/skbuff.h:987 [inline]
  netlink_alloc_large_skb net/netlink/af_netlink.c:1182 [inline]
  netlink_sendmsg+0xb01/0xfa0 net/netlink/af_netlink.c:1876
  sock_sendmsg_nosec net/socket.c:629 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:639
  ___sys_sendmsg+0x805/0x940 net/socket.c:2117
  __sys_sendmsg+0x115/0x270 net/socket.c:2155
  __do_sys_sendmsg net/socket.c:2164 [inline]
  __se_sys_sendmsg net/socket.c:2162 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2162
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 5303:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x86/0x2d0 mm/slab.c:3756
  kfree_skbmem+0x13c/0x210 net/core/skbuff.c:582
  __kfree_skb net/core/skbuff.c:642 [inline]
  consume_skb+0x193/0x550 net/core/skbuff.c:701
  netlink_dump+0xafa/0xd20 net/netlink/af_netlink.c:2262
  netlink_recvmsg+0xe97/0x1450 net/netlink/af_netlink.c:1984
  sock_recvmsg_nosec net/socket.c:802 [inline]
  sock_recvmsg+0xd0/0x110 net/socket.c:809
  ___sys_recvmsg+0x2b6/0x680 net/socket.c:2279
  __sys_recvmsg+0x112/0x260 net/socket.c:2328
  __do_sys_recvmsg net/socket.c:2338 [inline]
  __se_sys_recvmsg net/socket.c:2335 [inline]
  __x64_sys_recvmsg+0x78/0xb0 net/socket.c:2335
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801b77346c0
  which belongs to the cache skbuff_head_cache of size 232
The buggy address is located 40 bytes to the right of
  232-byte region [ffff8801b77346c0, ffff8801b77347a8)
The buggy address belongs to the page:
page:ffffea0006ddcd00 count:1 mapcount:0 mapping:ffff8801b7734080 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffff8801b7734080 0000000000000000 000000010000000c
raw: ffffea00073a2da0 ffffea0006ddc060 ffff8801d942b840 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801b7734680: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
  ffff8801b7734700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff8801b7734780: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
                                                  ^
  ffff8801b7734800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801b7734880: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
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
