Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48ECEC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0314020645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0314020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbeJNXkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:40:36 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35912 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727464AbeJNXLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:51 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLe-0004cW-Lc; Sun, 14 Oct 2018 16:30:30 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLb-0000mt-KM; Sun, 14 Oct 2018 16:30:27 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Petr Machata" <petrm@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "Ido Schimmel" <idosch@mellanox.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.843242520@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 365/366] ip_tunnel: restore binding to ifaces with a
 large mtu
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>

commit 82612de1c98e610d194e34178bde3cca7dedce41 upstream.

After commit f6cc9c054e77, the following conf is broken (note that the
default loopback mtu is 65536, ie IP_MAX_MTU + 1):

$ ip tunnel add gre1 mode gre local 10.125.0.1 remote 10.125.0.2 dev lo
add tunnel "gre0" failed: Invalid argument
$ ip l a type dummy
$ ip l s dummy1 up
$ ip l s dummy1 mtu 65535
$ ip tunnel add gre1 mode gre local 10.125.0.1 remote 10.125.0.2 dev dummy1
add tunnel "gre0" failed: Invalid argument

dev_set_mtu() doesn't allow to set a mtu which is too large.
First, let's cap the mtu returned by ip_tunnel_bind_dev(). Second, remove
the magic value 0xFFF8 and use IP_MAX_MTU instead.
0xFFF8 seems to be there for ages, I don't know why this value was used.

With a recent kernel, it's also possible to set a mtu > IP_MAX_MTU:
$ ip l s dummy1 mtu 66000
After that patch, it's also possible to bind an ip tunnel on that kind of
interface.

CC: Petr Machata <petrm@mellanox.com>
CC: Ido Schimmel <idosch@mellanox.com>
Link: https://git.kernel.org/pub/scm/linux/kernel/git/davem/netdev-vger-cvs.git/commit/?id=e5afd356a411a
Fixes: f6cc9c054e77 ("ip_tunnel: Emit events for post-register MTU changes")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Reviewed-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16:
 - Drop change in ip_tunnel_create()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -387,7 +387,7 @@ static int ip_tunnel_bind_dev(struct net
 
 	if (tdev) {
 		hlen = tdev->hard_header_len + tdev->needed_headroom;
-		mtu = tdev->mtu;
+		mtu = min(tdev->mtu, IP_MAX_MTU);
 	}
 	dev->iflink = tunnel->parms.link;
 
@@ -851,7 +851,7 @@ int ip_tunnel_change_mtu(struct net_devi
 	int t_hlen = tunnel->hlen + sizeof(struct iphdr);
 
 	if (new_mtu < 68 ||
-	    new_mtu > 0xFFF8 - dev->hard_header_len - t_hlen)
+	    new_mtu > IP_MAX_MTU - dev->hard_header_len - t_hlen)
 		return -EINVAL;
 	dev->mtu = new_mtu;
 	return 0;
@@ -979,7 +979,7 @@ int ip_tunnel_newlink(struct net_device
 
 	mtu = ip_tunnel_bind_dev(dev);
 	if (tb[IFLA_MTU]) {
-		unsigned int max = 0xfff8 - dev->hard_header_len - nt->hlen;
+		unsigned int max = IP_MAX_MTU - dev->hard_header_len - nt->hlen;
 
 		mtu = clamp(dev->mtu, (unsigned int)ETH_MIN_MTU,
 			    (unsigned int)(max - sizeof(struct iphdr)));

