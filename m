Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B39C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 04:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B111220843
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 04:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B111220843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeIBIz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 04:55:27 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:34799 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbeIBIz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 04:55:27 -0400
Received: by mail-it0-f69.google.com with SMTP id k204-v6so6343380ite.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 21:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=IdJKrmjqDcppGg22tEjhBy9dmooOhWSx9yXIL1JEODA=;
        b=DR9AiP4IdIUik7f+xGTnBPvNU1+eADiRdAcn+brv0ckzzMbJIkxKNomBmu/rrAuSa3
         mSZCndLy3B3sM+S/ofrmnpOlDJ1gvFglquXMN8boCvh7QwaIDHRB8nQAGzlu6UqA3M8d
         1V71zRHNibloOmdh2layHmeK2cVsC84xhPCCB+/15INvmIAo0PBNPJkdPio/8AJ/t0pZ
         LPUb4p1dyx4yi5rqV50k+RZSVk6JRVUH91OkpBdA1x980T90FoC6OWvMjzFuOUPAILLS
         WzmELcQmxWF1uweJNBSZSutrPwTeEYCOw112Sqa9lKG3ZsGIiAYQZWQJU8lR1lqguxFv
         WWow==
X-Gm-Message-State: APzg51DtBPhbc3mX1QihJSHqHqECKSWfaJ+oLZOeGqD+oNhfLCS/fw7p
        GJj5KlBZNyRqv1HGNB5LZv9ogArUTIW7QfB/zwjMKzYFxiIn
X-Google-Smtp-Source: ANB0VdZL+xeVf7HvtY7HaH2NzMI/69ZXhUAnsbM1bh0BO+CTARlUUIbbzH0SgYzVQbyHgfz+BCTvxLae02J3z9oDVw41LzPboc9H
MIME-Version: 1.0
X-Received: by 2002:a24:364e:: with SMTP id l75-v6mr1629488itl.46.1535863262955;
 Sat, 01 Sep 2018 21:41:02 -0700 (PDT)
Date:   Sat, 01 Sep 2018 21:41:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003658b00574dc08cc@google.com>
Subject: KASAN: slab-out-of-bounds Read in _decode_session6
From:   syzbot <syzbot+acffccec848dc13fe459@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, steffen.klassert@secunet.com,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    93ee30f3e8b4 xsk: i40e: get rid of useless struct xdp_umem..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11f2115a400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
dashboard link: https://syzkaller.appspot.com/bug?extid=acffccec848dc13fe459
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116b3492400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+acffccec848dc13fe459@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
BUG: KASAN: slab-out-of-bounds in _decode_session6+0x1331/0x14e0  
net/ipv6/xfrm6_policy.c:161
Read of size 1 at addr ffff8801d882eec7 by task syz-executor1/6667

CPU: 0 PID: 6667 Comm: syz-executor1 Not tainted 4.19.0-rc1+ #86
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
  _decode_session6+0x1331/0x14e0 net/ipv6/xfrm6_policy.c:161
  __xfrm_decode_session+0x71/0x140 net/xfrm/xfrm_policy.c:2299
  xfrm_decode_session include/net/xfrm.h:1232 [inline]
  vti6_tnl_xmit+0x3c3/0x1bc1 net/ipv6/ip6_vti.c:542
  __netdev_start_xmit include/linux/netdevice.h:4313 [inline]
  netdev_start_xmit include/linux/netdevice.h:4322 [inline]
  xmit_one net/core/dev.c:3217 [inline]
  dev_hard_start_xmit+0x272/0xc10 net/core/dev.c:3233
  __dev_queue_xmit+0x2ab2/0x3870 net/core/dev.c:3803
  dev_queue_xmit+0x17/0x20 net/core/dev.c:3836
  __bpf_tx_skb net/core/filter.c:2012 [inline]
  __bpf_redirect_common net/core/filter.c:2050 [inline]
  __bpf_redirect+0x5b7/0xae0 net/core/filter.c:2057
  ____bpf_clone_redirect net/core/filter.c:2090 [inline]
  bpf_clone_redirect+0x2f6/0x490 net/core/filter.c:2062
  bpf_prog_c39d1ba309a769f7+0x749/0x1000

Allocated by task 6667:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc_node mm/slab.c:3682 [inline]
  __kmalloc_node_track_caller+0x47/0x70 mm/slab.c:3696
  __kmalloc_reserve.isra.41+0x3a/0xe0 net/core/skbuff.c:137
  pskb_expand_head+0x230/0x10e0 net/core/skbuff.c:1463
  skb_ensure_writable+0x3dd/0x640 net/core/skbuff.c:5129
  __bpf_try_make_writable net/core/filter.c:1633 [inline]
  bpf_try_make_writable net/core/filter.c:1639 [inline]
  bpf_try_make_head_writable net/core/filter.c:1647 [inline]
  ____bpf_clone_redirect net/core/filter.c:2084 [inline]
  bpf_clone_redirect+0x14a/0x490 net/core/filter.c:2062
  bpf_prog_c39d1ba309a769f7+0x749/0x1000

Freed by task 5493:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x210 mm/slab.c:3813
  skb_free_head+0x99/0xc0 net/core/skbuff.c:550
  skb_release_data+0x6a4/0x880 net/core/skbuff.c:570
  skb_release_all+0x4a/0x60 net/core/skbuff.c:627
  __kfree_skb net/core/skbuff.c:641 [inline]
  consume_skb+0x190/0x4e0 net/core/skbuff.c:701
  netlink_dump+0xb14/0xd50 net/netlink/af_netlink.c:2269
  netlink_recvmsg+0xf84/0x1490 net/netlink/af_netlink.c:1991
  sock_recvmsg_nosec net/socket.c:794 [inline]
  sock_recvmsg+0xd0/0x110 net/socket.c:801
  ___sys_recvmsg+0x2b6/0x680 net/socket.c:2276
  __sys_recvmsg+0x11a/0x290 net/socket.c:2325
  __do_sys_recvmsg net/socket.c:2335 [inline]
  __se_sys_recvmsg net/socket.c:2332 [inline]
  __x64_sys_recvmsg+0x78/0xb0 net/socket.c:2332
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801d882ecc0
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 7 bytes to the right of
  512-byte region [ffff8801d882ecc0, ffff8801d882eec0)
The buggy address belongs to the page:
page:ffffea0007620b80 count:1 mapcount:0 mapping:ffff8801dac00940 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea00070fc048 ffffea00075f9c08 ffff8801dac00940
raw: 0000000000000000 ffff8801d882e040 0000000100000006 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d882ed80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8801d882ee00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff8801d882ee80: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
                                            ^
  ffff8801d882ef00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801d882ef80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
