Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A42CC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193E720833
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zOIIqK/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193E720833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbeKCDor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:44:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728336AbeKCDoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:44:46 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F244A20833;
        Fri,  2 Nov 2018 18:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541183796;
        bh=inLnG844OBRxKvcOyhnqXdQSzhb3kaI2QDHAeDXe7dI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zOIIqK/WWVDVNLTN3l2dyQHpEAefKhKShMgapbPrJkFD9fXyLIxKPTw6mEQzbaWOk
         jMfDqbujs58pzHMwaiDsiHLXauUARLjuIZJIjNkMJJuy4dyHEn/OSQ0qDtyZJgGPM+
         9mI8SL7teO8UUkX0rB7zi39YDmwgLkCrU+QskjXk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 12/24] net/ipv6: Allow onlink routes to have a device mismatch if it is the default route
Date:   Fri,  2 Nov 2018 19:34:45 +0100
Message-Id: <20181102182841.658276687@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182839.725385066@linuxfoundation.org>
References: <20181102182839.725385066@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Ahern <dsahern@gmail.com>

[ Upstream commit 4ed591c8ab44e711e56b8e021ffaf4f407c045f5 ]

The intent of ip6_route_check_nh_onlink is to make sure the gateway
given for an onlink route is not actually on a connected route for
a different interface (e.g., 2001:db8:1::/64 is on dev eth1 and then
an onlink route has a via 2001:db8:1::1 dev eth2). If the gateway
lookup hits the default route then it most likely will be a different
interface than the onlink route which is ok.

Update ip6_route_check_nh_onlink to disregard the device mismatch
if the gateway lookup hits the default route. Turns out the existing
onlink tests are passing because there is no default route or it is
an unreachable default, so update the onlink tests to have a default
route other than unreachable.

Fixes: fc1e64e1092f6 ("net/ipv6: Add support for onlink flag")
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c                                |    2 ++
 tools/testing/selftests/net/fib-onlink-tests.sh |   14 +++++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2799,6 +2799,8 @@ static int ip6_route_check_nh_onlink(str
 	grt = ip6_nh_lookup_table(net, cfg, gw_addr, tbid, 0);
 	if (grt) {
 		if (!grt->dst.error &&
+		    /* ignore match if it is the default route */
+		    grt->from && !ipv6_addr_any(&grt->from->fib6_dst.addr) &&
 		    (grt->rt6i_flags & flags || dev != grt->dst.dev)) {
 			NL_SET_ERR_MSG(extack,
 				       "Nexthop has invalid gateway or device mismatch");
--- a/tools/testing/selftests/net/fib-onlink-tests.sh
+++ b/tools/testing/selftests/net/fib-onlink-tests.sh
@@ -167,8 +167,8 @@ setup()
 	# add vrf table
 	ip li add ${VRF} type vrf table ${VRF_TABLE}
 	ip li set ${VRF} up
-	ip ro add table ${VRF_TABLE} unreachable default
-	ip -6 ro add table ${VRF_TABLE} unreachable default
+	ip ro add table ${VRF_TABLE} unreachable default metric 8192
+	ip -6 ro add table ${VRF_TABLE} unreachable default metric 8192
 
 	# create test interfaces
 	ip li add ${NETIFS[p1]} type veth peer name ${NETIFS[p2]}
@@ -185,20 +185,20 @@ setup()
 	for n in 1 3 5 7; do
 		ip li set ${NETIFS[p${n}]} up
 		ip addr add ${V4ADDRS[p${n}]}/24 dev ${NETIFS[p${n}]}
-		ip addr add ${V6ADDRS[p${n}]}/64 dev ${NETIFS[p${n}]}
+		ip addr add ${V6ADDRS[p${n}]}/64 dev ${NETIFS[p${n}]} nodad
 	done
 
 	# move peer interfaces to namespace and add addresses
 	for n in 2 4 6 8; do
 		ip li set ${NETIFS[p${n}]} netns ${PEER_NS} up
 		ip -netns ${PEER_NS} addr add ${V4ADDRS[p${n}]}/24 dev ${NETIFS[p${n}]}
-		ip -netns ${PEER_NS} addr add ${V6ADDRS[p${n}]}/64 dev ${NETIFS[p${n}]}
+		ip -netns ${PEER_NS} addr add ${V6ADDRS[p${n}]}/64 dev ${NETIFS[p${n}]} nodad
 	done
 
-	set +e
+	ip -6 ro add default via ${V6ADDRS[p3]/::[0-9]/::64}
+	ip -6 ro add table ${VRF_TABLE} default via ${V6ADDRS[p7]/::[0-9]/::64}
 
-	# let DAD complete - assume default of 1 probe
-	sleep 1
+	set +e
 }
 
 cleanup()


