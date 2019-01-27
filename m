Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042EEC282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 21:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98FC2133D
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 21:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="MPTrFM50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfA0VeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 16:34:11 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36727 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfA0VeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 16:34:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id p6so11787454wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 13:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=A0EHerfZLtY170iK3Acs12XMeS75bvOLGpiGFWVHsmM=;
        b=MPTrFM50y2XKkHvmq/a4nxS1jQsr6VKr6JU7ErhrPsqVMXxYUPC/yuzUpySM1WYoN1
         irTVhEYgovR50NRJUOVdbdrAlaZrMZYhmGzvGHM0XvCVvWspm65gRUCNa7tB/j8IwANk
         ncyvgIwYFhk0SQ2rtX9ZDj5nkvnOSH7ZEvtvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A0EHerfZLtY170iK3Acs12XMeS75bvOLGpiGFWVHsmM=;
        b=pZuIqGdn/Ocv6F5MabNjIpb1TZJ3g+r/Cij80emnV6wBFtMqyK1z52q6kSUnf2d3xc
         /ZS013p0uoACm4HuftEjr8M4cptCspSbzaQQ2dxo/ns84yE5H2IoTjgTivTm/BcFXA9d
         GGTdPh2Jw6eT08iNf0/pnDL11oB/7/jrn1mDhKiUDDKIATQWlE/yXZUG9dRGlpZcU+7f
         hCtB9rF5BW4EdJP9XojztAKvq4E5lRMSyicXbLr3LnXSzqxn5PqOGBACB5OGL9EMXPov
         sL6RkjFUYY2N3ppbNfJKuyRhg8exu4PivgDzHZN7TXo5Ws4/hWvM2z25ivtpZPaPPezp
         irfQ==
X-Gm-Message-State: AJcUukcq9yTEEMj3CDhmHZhSF17raMTSjO3S1jvmmjtR4L1u58mjEgqN
        2DgcnhXTOtwTILXra7vx7Ey59A==
X-Google-Smtp-Source: ALg8bN4PYd1uziFOUaSThanTFbgTLcGWaRryrbKH8crpSk1Lu/S8sOMSTE+j8mW1KlniLNEDCGVBcQ==
X-Received: by 2002:a1c:9183:: with SMTP id t125mr14203982wmd.79.1548624848738;
        Sun, 27 Jan 2019 13:34:08 -0800 (PST)
Received: from [192.168.0.107] (79-100-158-105.ip.btc-net.bg. [79.100.158.105])
        by smtp.gmail.com with ESMTPSA id y14sm12718928wro.92.2019.01.27.13.34.07
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 13:34:07 -0800 (PST)
Subject: Re: KASAN: use-after-free Read in br_mdb_ip_get
To:     syzbot <syzbot+bc5ab0af2dbf3b0ae897@syzkaller.appspotmail.com>,
        bridge@lists.linux-foundation.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        roopa@cumulusnetworks.com, syzkaller-bugs@googlegroups.com
References: <000000000000862b160580765e94@google.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <3c44c1ff-2790-ec06-35c6-3572b92170c7@cumulusnetworks.com>
Date:   Sun, 27 Jan 2019 23:34:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <000000000000862b160580765e94@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2019 22:26, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    ba6069759381 Merge tag 'mmc-v5.0-rc2' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17b342c4c00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=505743eba4e4f68
> dashboard link: https://syzkaller.appspot.com/bug?extid=bc5ab0af2dbf3b0ae897
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+bc5ab0af2dbf3b0ae897@syzkaller.appspotmail.com
> 
> bridge0: port 2(bridge_slave_1) entered blocking state
> bridge0: port 2(bridge_slave_1) entered forwarding state
> bridge0: port 1(bridge_slave_0) entered blocking state
> bridge0: port 1(bridge_slave_0) entered forwarding state
> ==================================================================
> BUG: KASAN: use-after-free in memcmp+0xb3/0xc0 lib/string.c:862
> Read of size 1 at addr ffff88809f1efe70 by task syz-executor1/8111
> 
[snip]
> 
> Allocated by task 8111:
>  save_stack+0x45/0xd0 mm/kasan/common.c:73
>  set_track mm/kasan/common.c:85 [inline]
>  __kasan_kmalloc mm/kasan/common.c:496 [inline]
>  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:469
>  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:504
>  kmem_cache_alloc_trace+0x151/0x760 mm/slab.c:3609
>  kmalloc include/linux/slab.h:545 [inline]
>  kzalloc include/linux/slab.h:740 [inline]
>  br_multicast_new_group.part.0+0xdc/0x1a40 net/bridge/br_multicast.c:476
>  br_multicast_new_group+0x19d/0x200 net/bridge/br_multicast.c:471
>  br_multicast_add_group+0x4ce/0x7d0 net/bridge/br_multicast.c:552
>  br_ip6_multicast_add_group net/bridge/br_multicast.c:626 [inline]
>  br_ip6_multicast_mld2_report net/bridge/br_multicast.c:1043 [inline]
>  br_multicast_ipv6_rcv net/bridge/br_multicast.c:1667 [inline]
>  br_multicast_rcv+0x24aa/0x4270 net/bridge/br_multicast.c:1705
>  br_dev_xmit+0x7f4/0x1780 net/bridge/br_device.c:93
>  __netdev_start_xmit include/linux/netdevice.h:4382 [inline]
>  netdev_start_xmit include/linux/netdevice.h:4391 [inline]
>  xmit_one net/core/dev.c:3278 [inline]
>  dev_hard_start_xmit+0x261/0xc70 net/core/dev.c:3294
>  __dev_queue_xmit+0x2f8a/0x3a60 net/core/dev.c:3864
>  dev_queue_xmit+0x18/0x20 net/core/dev.c:3897
>  neigh_resolve_output net/core/neighbour.c:1476 [inline]
>  neigh_resolve_output+0x6a0/0xb30 net/core/neighbour.c:1456
>  neigh_output include/net/neighbour.h:508 [inline]
>  ip6_finish_output2+0xc56/0x28e0 net/ipv6/ip6_output.c:120
>  ip6_finish_output+0x577/0xc30 net/ipv6/ip6_output.c:154
>  NF_HOOK_COND include/linux/netfilter.h:278 [inline]
>  ip6_output+0x23c/0xa00 net/ipv6/ip6_output.c:171
>  dst_output include/net/dst.h:444 [inline]
>  NF_HOOK include/linux/netfilter.h:289 [inline]
>  NF_HOOK include/linux/netfilter.h:283 [inline]
>  mld_sendpack+0xa44/0xfd0 net/ipv6/mcast.c:1683
>  mld_send_cr net/ipv6/mcast.c:1979 [inline]
>  mld_ifc_timer_expire+0x449/0x8a0 net/ipv6/mcast.c:2478
>  call_timer_fn+0x254/0x900 kernel/time/timer.c:1325
>  expire_timers kernel/time/timer.c:1362 [inline]
>  __run_timers+0x6fc/0xd50 kernel/time/timer.c:1681
>  run_timer_softirq+0x52/0xb0 kernel/time/timer.c:1694
>  __do_softirq+0x30b/0xb11 kernel/softirq.c:292
> 
> Freed by task 8111:
>  save_stack+0x45/0xd0 mm/kasan/common.c:73
>  set_track mm/kasan/common.c:85 [inline]
>  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:458
>  kasan_slab_free+0xe/0x10 mm/kasan/common.c:466
>  __cache_free mm/slab.c:3487 [inline]
>  kfree+0xcf/0x230 mm/slab.c:3806
>  br_multicast_new_group.part.0+0x1489/0x1a40 net/bridge/br_multicast.c:486


Weird, this is the kfree() on the error path of br_multicast_new_group()
when rhashtable_lookup_insert_fast() fails, which means the entry should
not be linked in the rhashtable or the hlist.
All other frees are via kfree_rcu. I'll keep looking.. 

>  br_multicast_new_group+0x19d/0x200 net/bridge/br_multicast.c:471
>  br_multicast_add_group+0x4ce/0x7d0 net/bridge/br_multicast.c:552
>  br_ip6_multicast_add_group net/bridge/br_multicast.c:626 [inline]
>  br_ip6_multicast_mld2_report net/bridge/br_multicast.c:1043 [inline]
>  br_multicast_ipv6_rcv net/bridge/br_multicast.c:1667 [inline]
>  br_multicast_rcv+0x24aa/0x4270 net/bridge/br_multicast.c:1705
>  br_dev_xmit+0x7f4/0x1780 net/bridge/br_device.c:93
>  __netdev_start_xmit include/linux/netdevice.h:4382 [inline]
>  netdev_start_xmit include/linux/netdevice.h:4391 [inline]
>  xmit_one net/core/dev.c:3278 [inline]
>  dev_hard_start_xmit+0x261/0xc70 net/core/dev.c:3294
>  __dev_queue_xmit+0x2f8a/0x3a60 net/core/dev.c:3864
>  dev_queue_xmit+0x18/0x20 net/core/dev.c:3897
>  neigh_resolve_output net/core/neighbour.c:1476 [inline]
>  neigh_resolve_output+0x6a0/0xb30 net/core/neighbour.c:1456
>  neigh_output include/net/neighbour.h:508 [inline]
>  ip6_finish_output2+0xc56/0x28e0 net/ipv6/ip6_output.c:120
>  ip6_finish_output+0x577/0xc30 net/ipv6/ip6_output.c:154
>  NF_HOOK_COND include/linux/netfilter.h:278 [inline]
>  ip6_output+0x23c/0xa00 net/ipv6/ip6_output.c:171
>  dst_output include/net/dst.h:444 [inline]
>  NF_HOOK include/linux/netfilter.h:289 [inline]
>  NF_HOOK include/linux/netfilter.h:283 [inline]
>  mld_sendpack+0xa44/0xfd0 net/ipv6/mcast.c:1683
>  mld_send_cr net/ipv6/mcast.c:1979 [inline]
>  mld_ifc_timer_expire+0x449/0x8a0 net/ipv6/mcast.c:2478
>  call_timer_fn+0x254/0x900 kernel/time/timer.c:1325
>  expire_timers kernel/time/timer.c:1362 [inline]
>  __run_timers+0x6fc/0xd50 kernel/time/timer.c:1681
>  run_timer_softirq+0x52/0xb0 kernel/time/timer.c:1694
>  __do_softirq+0x30b/0xb11 kernel/softirq.c:292
> 
> The buggy address belongs to the object at ffff88809f1efe00
>  which belongs to the cache kmalloc-192 of size 192
> The buggy address is located 112 bytes inside of
>  192-byte region [ffff88809f1efe00, ffff88809f1efec0)
> The buggy address belongs to the page:
> page:ffffea00027c7bc0 count:1 mapcount:0 mapping:ffff88812c3f0040 index:0x0
> flags: 0x1fffc0000000200(slab)
> raw: 01fffc0000000200 ffffea00027df108 ffffea00027c7c48 ffff88812c3f0040
> raw: 0000000000000000 ffff88809f1ef000 0000000100000010 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff88809f1efd00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff88809f1efd80: 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> ffff88809f1efe00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                                              ^
>  ffff88809f1efe80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>  ffff88809f1eff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ==================================================================
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.

