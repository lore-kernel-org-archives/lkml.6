Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A51EECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 22:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD8620676
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 22:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CD8620676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbeIXEIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 00:08:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50662 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbeIXEIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 00:08:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CE7204DD49;
        Sun, 23 Sep 2018 22:09:18 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A2E2018EF3;
        Sun, 23 Sep 2018 22:09:18 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 64EEF4BB74;
        Sun, 23 Sep 2018 22:09:18 +0000 (UTC)
Date:   Sun, 23 Sep 2018 18:09:18 -0400 (EDT)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+d3402c47f680ff24b29c@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        sunlianwen <sunlw.fnst@cn.fujitsu.com>
Message-ID: <1040580049.15456466.1537740558279.JavaMail.zimbra@redhat.com>
In-Reply-To: <CACT4Y+Z1G_QMG_PQu_ZwHsyhwyh_DBOG4mX9n=va08w3Z7j02Q@mail.gmail.com>
References: <000000000000565ab805768bf006@google.com> <125732064.15444205.1537718529926.JavaMail.zimbra@redhat.com> <CACT4Y+Z1G_QMG_PQu_ZwHsyhwyh_DBOG4mX9n=va08w3Z7j02Q@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in memcmp (2)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.200.22, 10.4.195.29]
Thread-Topic: KMSAN: uninit-value in memcmp (2)
Thread-Index: tQAyG5rC4ivVSoeQ1Fo/EeLJVURPlQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sun, 23 Sep 2018 22:09:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Dmirty,

Thank you for the reply. Can we please, discuss this further?

> You can see on dashboard that the last crash
> for the second version (2) happened just few days ago. So this is a
> different bug.

Well... yes and no. When I was looking at this bug (bug?id=088efeac32fd) I was looking
at the report at "2018/05/09 18:55" (https://syzkaller.appspot.com/text?tag=CrashReport&x=141b707b800000),
since it was the only report with a reproducer. This was my error.

The error and the call trace in this report are:

>>>
BUG: KMSAN: uninit-value in memcmp+0x119/0x180 lib/string.c:861
CPU: 0 PID: 38 Comm: kworker/0:1 Not tainted 4.17.0-rc3+ #88
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:113
 kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
 __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:683
 memcmp+0x119/0x180 lib/string.c:861
 __hw_addr_add_ex net/core/dev_addr_lists.c:61 [inline]
 __dev_mc_add+0x1fc/0x900 net/core/dev_addr_lists.c:670
 dev_mc_add+0x6d/0x80 net/core/dev_addr_lists.c:687
 igmp6_group_added+0x2db/0xa00 net/ipv6/mcast.c:662
 ipv6_dev_mc_inc+0xe9e/0x1130 net/ipv6/mcast.c:914
 addrconf_join_solict net/ipv6/addrconf.c:2103 [inline]
 addrconf_dad_begin net/ipv6/addrconf.c:3853 [inline]
 addrconf_dad_work+0x462/0x2a20 net/ipv6/addrconf.c:3979
 process_one_work+0x12c6/0x1f60 kernel/workqueue.c:2145
 worker_thread+0x113c/0x24f0 kernel/workqueue.c:2279
 kthread+0x539/0x720 kernel/kthread.c:239
 ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:412

Local variable description: ----buf@igmp6_group_added
Variable was created at:
 igmp6_group_added+0x4a/0xa00 net/ipv6/mcast.c:650
 ipv6_dev_mc_inc+0xe9e/0x1130 net/ipv6/mcast.c:914
<<<

It is the same like in bug?id=3887c0d99aecb27d085180c5222d245d08a30806
which, after some more test, made me believe these bugs are duplicate
and are fixed by the same commit.

But let's look at another report at "2018/09/12 21:00"
(https://syzkaller.appspot.com/text?tag=CrashReport&x=14f99b71400000)
at the bug (bug?id=088efeac32fd), the one you've mentioned as
"the last crash for the second version (2) happened just few days ago".

Its error and the call trace are completely different:

>>>
BUG: KMSAN: uninit-value in memcmp+0x11d/0x180 lib/string.c:863
CPU: 0 PID: 6107 Comm: syz-executor4 Not tainted 4.19.0-rc3+ #45
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x14b/0x190 lib/dump_stack.c:113
 kmsan_report+0x183/0x2b0 mm/kmsan/kmsan.c:956
 __msan_warning+0x70/0xc0 mm/kmsan/kmsan_instr.c:645
 memcmp+0x11d/0x180 lib/string.c:863
 dev_uc_add_excl+0x165/0x7b0 net/core/dev_addr_lists.c:464
 ndo_dflt_fdb_add net/core/rtnetlink.c:3463 [inline]
 rtnl_fdb_add+0x1081/0x1270 net/core/rtnetlink.c:3558
 rtnetlink_rcv_msg+0xa0b/0x1530 net/core/rtnetlink.c:4715
 netlink_rcv_skb+0x36e/0x5f0 net/netlink/af_netlink.c:2454
 rtnetlink_rcv+0x50/0x60 net/core/rtnetlink.c:4733
 netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
 netlink_unicast+0x1638/0x1720 net/netlink/af_netlink.c:1343
 netlink_sendmsg+0x1205/0x1290 net/netlink/af_netlink.c:1908
 sock_sendmsg_nosec net/socket.c:621 [inline]
 sock_sendmsg net/socket.c:631 [inline]
...
Uninit was created at:
...
 slab_post_alloc_hook mm/slab.h:446 [inline]
 slab_alloc_node mm/slub.c:2718 [inline]
 __kmalloc_node_track_caller+0x9e7/0x1160 mm/slub.c:4351
 __kmalloc_reserve net/core/skbuff.c:138 [inline]
 __alloc_skb+0x2f5/0x9e0 net/core/skbuff.c:206
 alloc_skb include/linux/skbuff.h:996 [inline]
 netlink_alloc_large_skb net/netlink/af_netlink.c:1189 [inline]
 netlink_sendmsg+0xb49/0x1290 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:621 [inline]
 sock_sendmsg net/socket.c:631 [inline]
 ___sys_sendmsg+0xe70/0x1290 net/socket.c:2114
<<<

This is a different bug. How come these 2 different reports for 2 different
bugs have ended in the same syzkaller report (bug?id=088efeac32fd) ?

One bug is fixed by the "net: fix uninit-value in __hw_addr_add_ex()" commit,
the second one is not, but they are still in the same syzkaller report.

This was the reason of my confusion. I'm not sure how to fix this. If it is possible,
probably we need to cancel/revoke "#syz fix: net: fix uninit-value in __hw_addr_add_ex()"
for this syzkaller report (bug?id=088efeac32fd). And then "split" it into 2 or
more different reports, but I'm not sure if this is possible.

Probably, syzkaller needs to look deeper into the KMSAN reports to differentiate
KMSAN errors happening because of different reasons.

Best regards,
Vladis Dronov | Red Hat, Inc. | Product Security Engineer

----- Original Message -----
> From: "Dmitry Vyukov" <dvyukov@google.com>
> To: "Vladis Dronov" <vdronov@redhat.com>
> Cc: "syzbot" <syzbot+d3402c47f680ff24b29c@syzkaller.appspotmail.com>, "syzkaller-bugs"
> <syzkaller-bugs@googlegroups.com>, "David Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
> "LKML" <linux-kernel@vger.kernel.org>, "netdev" <netdev@vger.kernel.org>, "sunlianwen" <sunlw.fnst@cn.fujitsu.com>
> Sent: Sunday, September 23, 2018 6:22:36 PM
> Subject: Re: KMSAN: uninit-value in memcmp (2)
> 
> On Sun, Sep 23, 2018 at 6:02 PM, Vladis Dronov <vdronov@redhat.com> wrote:
> > #syz fix: net: fix uninit-value in __hw_addr_add_ex()
> 
> Hi Vladis,
> 
> This can be fixed with "net: fix uninit-value in __hw_addr_add_ex()".
> That commit landed in April, syzbot waited till the commit reached all
> tested trees, and then closed the bug.
> But the similar bug continued to happen, so syzbot created second
> version of this bug (2). You can see on dashboard that the last crash
> for the second version (2) happened just few days ago. So this is a
> different bug.
>
