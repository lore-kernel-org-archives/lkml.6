Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D29ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBEF20880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBEF20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388574AbeGWN2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:28:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45394 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387970AbeGWN2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:28:12 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3CA70BB3;
        Mon, 23 Jul 2018 12:27:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 44/63] net/ipv6: Do not allow device only routes via the multipath API
Date:   Mon, 23 Jul 2018 14:24:50 +0200
Message-Id: <20180723122448.038607203@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122446.351334162@linuxfoundation.org>
References: <20180723122446.351334162@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Ahern <dsahern@gmail.com>

[ Upstream commit b5d2d75e079a918be686957b1a8d2f6c5cc95a0a ]

Eric reported that reverting the patch that fixed and simplified IPv6
multipath routes means reverting back to invalid userspace notifications.
eg.,
$ ip -6 route add 2001:db8:1::/64 nexthop dev eth0 nexthop dev eth1

only generates a single notification:
2001:db8:1::/64 dev eth0 metric 1024 pref medium

While working on a fix for this problem I found another case that is just
broken completely - a multipath route with a gateway followed by device
followed by gateway:
    $ ip -6 ro add 2001:db8:103::/64
          nexthop via 2001:db8:1::64
          nexthop dev dummy2
          nexthop via 2001:db8:3::64

In this case the device only route is dropped completely - no notification
to userpsace but no addition to the FIB either:

$ ip -6 ro ls
2001:db8:1::/64 dev dummy1 proto kernel metric 256 pref medium
2001:db8:2::/64 dev dummy2 proto kernel metric 256 pref medium
2001:db8:3::/64 dev dummy3 proto kernel metric 256 pref medium
2001:db8:103::/64 metric 1024
	nexthop via 2001:db8:1::64 dev dummy1 weight 1
	nexthop via 2001:db8:3::64 dev dummy3 weight 1 pref medium
fe80::/64 dev dummy1 proto kernel metric 256 pref medium
fe80::/64 dev dummy2 proto kernel metric 256 pref medium
fe80::/64 dev dummy3 proto kernel metric 256 pref medium

Really, IPv6 multipath is just FUBAR'ed beyond repair when it comes to
device only routes, so do not allow it all.

This change will break any scripts relying on the mpath api for insert,
but I don't see any other way to handle the permutations. Besides, since
the routes are added to the FIB as standalone (non-multipath) routes the
kernel is not doing what the user requested, so it might as well tell the
user that.

Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
Signed-off-by: David Ahern <dsahern@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4274,6 +4274,13 @@ static int ip6_route_multipath_add(struc
 			err_nh = nh;
 			goto add_errout;
 		}
+		if (!rt6_qualify_for_ecmp(rt)) {
+			err = -EINVAL;
+			NL_SET_ERR_MSG(extack,
+				       "Device only routes can not be added for IPv6 using the multipath API.");
+			dst_release_immediate(&rt->dst);
+			goto cleanup;
+		}
 
 		/* Because each route is added like a single route we remove
 		 * these flags after the first nexthop: if there is a collision,


