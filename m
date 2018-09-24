Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E036ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C3E21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C3E21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733002AbeIXS1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:27:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57010 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730683AbeIXS1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:27:37 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 63AF0108B;
        Mon, 24 Sep 2018 12:25:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Zubin Mithra <zsm@chromium.org>
Subject: [PATCH 4.14 166/173] net/ipv6: prevent use after free in ip6_route_mpath_notify
Date:   Mon, 24 Sep 2018 13:53:20 +0200
Message-Id: <20180924113127.224183751@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Ahern <dsahern@gmail.com>

commit f7225172f25aaf0dfd9ad65f05be8da5d6108b12 upstream.

syzbot reported a use-after-free:

BUG: KASAN: use-after-free in ip6_route_mpath_notify+0xe9/0x100 net/ipv6/route.c:4180
Read of size 4 at addr ffff8801bf789cf0 by task syz-executor756/4555

CPU: 1 PID: 4555 Comm: syz-executor756 Not tainted 4.17.0-rc7+ #78
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1b9/0x294 lib/dump_stack.c:113
 print_address_description+0x6c/0x20b mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:354 [inline]
 kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
 __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
 ip6_route_mpath_notify+0xe9/0x100 net/ipv6/route.c:4180
 ip6_route_multipath_add+0x615/0x1910 net/ipv6/route.c:4303
 inet6_rtm_newroute+0xe3/0x160 net/ipv6/route.c:4391
 ...

Allocated by task 4555:
 save_stack+0x43/0xd0 mm/kasan/kasan.c:448
 set_track mm/kasan/kasan.c:460 [inline]
 kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
 kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
 kmem_cache_alloc+0x12e/0x760 mm/slab.c:3554
 dst_alloc+0xbb/0x1d0 net/core/dst.c:104
 __ip6_dst_alloc+0x35/0xa0 net/ipv6/route.c:361
 ip6_dst_alloc+0x29/0xb0 net/ipv6/route.c:376
 ip6_route_info_create+0x4d4/0x3a30 net/ipv6/route.c:2834
 ip6_route_multipath_add+0xc7e/0x1910 net/ipv6/route.c:4240
 inet6_rtm_newroute+0xe3/0x160 net/ipv6/route.c:4391
 ...

Freed by task 4555:
 save_stack+0x43/0xd0 mm/kasan/kasan.c:448
 set_track mm/kasan/kasan.c:460 [inline]
 __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
 kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
 __cache_free mm/slab.c:3498 [inline]
 kmem_cache_free+0x86/0x2d0 mm/slab.c:3756
 dst_destroy+0x267/0x3c0 net/core/dst.c:140
 dst_release_immediate+0x71/0x9e net/core/dst.c:205
 fib6_add+0xa40/0x1650 net/ipv6/ip6_fib.c:1305
 __ip6_ins_rt+0x6c/0x90 net/ipv6/route.c:1011
 ip6_route_multipath_add+0x513/0x1910 net/ipv6/route.c:4267
 inet6_rtm_newroute+0xe3/0x160 net/ipv6/route.c:4391
 ...

The problem is that rt_last can point to a deleted route if the insert
fails.

One reproducer is to insert a route and then add a multipath route that
has a duplicate nexthop.e.g,:
    $ ip -6 ro add vrf red 2001:db8:101::/64 nexthop via 2001:db8:1::2
    $ ip -6 ro append vrf red 2001:db8:101::/64 nexthop via 2001:db8:1::4 nexthop via 2001:db8:1::2

Fix by not setting rt_last until the it is verified the insert succeeded.

Backport Note:
- Upstream has replaced rt6_info usage with fib6_info in 8d1c802b281
("net/ipv6: Flip FIB entries to fib6_info")
- fib6_info_release was introduced upstream in 93531c674315
("net/ipv6: separate handling of FIB entries from dst based routes"),
but is not present in stable kernels; 4.14.y relies on dst_release/
ip6_rt_put/dst_release_immediate.

Fixes: 3b1137fe7482 ("net: ipv6: Change notifications for multipath add to RTA_MULTIPATH")
Cc: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David Ahern <dsahern@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Zubin Mithra <zsm@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3239,11 +3239,16 @@ static int ip6_route_multipath_add(struc
 
 	err_nh = NULL;
 	list_for_each_entry(nh, &rt6_nh_list, next) {
-		rt_last = nh->rt6_info;
 		err = __ip6_ins_rt(nh->rt6_info, info, &nh->mxc, extack);
-		/* save reference to first route for notification */
-		if (!rt_notif && !err)
-			rt_notif = nh->rt6_info;
+
+		if (!err) {
+			/* save reference to last route successfully inserted */
+			rt_last = nh->rt6_info;
+
+			/* save reference to first route for notification */
+			if (!rt_notif)
+				rt_notif = nh->rt6_info;
+		}
 
 		/* nh->rt6_info is used or freed at this point, reset to NULL*/
 		nh->rt6_info = NULL;


