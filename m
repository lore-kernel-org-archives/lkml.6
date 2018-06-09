Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Q7qRN0fzG1uAZAAAmS7hNA
	; Sat, 09 Jun 2018 15:34:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 95F52608C1; Sat,  9 Jun 2018 15:34:24 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGf2gVHa"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E5C87606FA;
	Sat,  9 Jun 2018 15:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E5C87606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753749AbeFIPeU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:34:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753354AbeFIPeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:34:16 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB8D5204EC;
        Sat,  9 Jun 2018 15:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558455;
        bh=be7QfjDrWIOwyPU34BmtioK41zVOBoIWqbzbduvXGC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lGf2gVHaokY7yevCRkjzFX4nuGbP3eB/F8pGpsWOsFffQMEEnTUql3lz2+Y/Z2Ej1
         vEMw5LpQfefZhkbrP19F4NG1Y/3v0eQDcwaIkAIYwHY+pVIPIv7+Bbf/6azFhUi129
         uj0MdgUDOBu/Te54WHdnLfArT2oI9wuKitACqBOo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Machata <petrm@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 45/48] ip_tunnel: restore binding to ifaces with a large mtu
Date: Sat,  9 Jun 2018 17:29:57 +0200
Message-Id: <20180609145950.849739672@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609145947.679103414@linuxfoundation.org>
References: <20180609145947.679103414@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>

[ Upstream commit 82612de1c98e610d194e34178bde3cca7dedce41 ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_tunnel.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -344,7 +344,7 @@ static int ip_tunnel_bind_dev(struct net
 
 	if (tdev) {
 		hlen = tdev->hard_header_len + tdev->needed_headroom;
-		mtu = tdev->mtu;
+		mtu = min(tdev->mtu, IP_MAX_MTU);
 	}
 
 	dev->needed_headroom = t_hlen + hlen;
@@ -379,7 +379,7 @@ static struct ip_tunnel *ip_tunnel_creat
 	nt = netdev_priv(dev);
 	t_hlen = nt->hlen + sizeof(struct iphdr);
 	dev->min_mtu = ETH_MIN_MTU;
-	dev->max_mtu = 0xFFF8 - dev->hard_header_len - t_hlen;
+	dev->max_mtu = IP_MAX_MTU - dev->hard_header_len - t_hlen;
 	ip_tunnel_add(itn, nt);
 	return nt;
 
@@ -948,7 +948,7 @@ int __ip_tunnel_change_mtu(struct net_de
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 	int t_hlen = tunnel->hlen + sizeof(struct iphdr);
-	int max_mtu = 0xFFF8 - dev->hard_header_len - t_hlen;
+	int max_mtu = IP_MAX_MTU - dev->hard_header_len - t_hlen;
 
 	if (new_mtu < ETH_MIN_MTU)
 		return -EINVAL;
@@ -1119,7 +1119,7 @@ int ip_tunnel_newlink(struct net_device
 
 	mtu = ip_tunnel_bind_dev(dev);
 	if (tb[IFLA_MTU]) {
-		unsigned int max = 0xfff8 - dev->hard_header_len - nt->hlen;
+		unsigned int max = IP_MAX_MTU - dev->hard_header_len - nt->hlen;
 
 		mtu = clamp(dev->mtu, (unsigned int)ETH_MIN_MTU,
 			    (unsigned int)(max - sizeof(struct iphdr)));
