Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id CW3dKE/0G1vAagAAmS7hNA
	; Sat, 09 Jun 2018 15:39:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AAB3C608BF; Sat,  9 Jun 2018 15:39:14 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlWUoy4v"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1CB9B606FA;
	Sat,  9 Jun 2018 15:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1CB9B606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933219AbeFIPjN (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:39:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932696AbeFIPfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:35:52 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41EFF208A3;
        Sat,  9 Jun 2018 15:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558551;
        bh=IknwiBbdL/mAD/Wl5C7dk23x+Xo235NIHWw/OuSxD6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UlWUoy4v3hzQZ0PWPztDMwJJrjBEQAOlTTsiMt8MPvuFjWYfQBvsjhww826MYyR1j
         3/MCtHsBQ/FDRnJf90m9Nwdcq2qV9a+LQ+KPA5HuTmyJPuixYGSBfvgCY774WF4TFe
         Atg5XOxvxE++ka3u5DFU1KBoXdzwZnqsnEzhMzFA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 12/41] ip6_tunnel: remove magic mtu value 0xFFF8
Date: Sat,  9 Jun 2018 17:29:44 +0200
Message-Id: <20180609152927.110772621@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609152926.389750182@linuxfoundation.org>
References: <20180609152926.389750182@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>

[ Upstream commit f7ff1fde9441b4fcc8ffb6e66e6e5a00d008937e ]

I don't know where this value comes from (probably a copy and paste and
paste and paste ...).
Let's use standard values which are a bit greater.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/davem/netdev-vger-cvs.git/commit/?id=e5afd356a411a
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_tunnel.c |   11 ++++++++---
 net/ipv6/sit.c        |    5 +++--
 2 files changed, 11 insertions(+), 5 deletions(-)

--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1693,8 +1693,13 @@ int ip6_tnl_change_mtu(struct net_device
 		if (new_mtu < ETH_MIN_MTU)
 			return -EINVAL;
 	}
-	if (new_mtu > 0xFFF8 - dev->hard_header_len)
-		return -EINVAL;
+	if (tnl->parms.proto == IPPROTO_IPV6 || tnl->parms.proto == 0) {
+		if (new_mtu > IP6_MAX_MTU - dev->hard_header_len)
+			return -EINVAL;
+	} else {
+		if (new_mtu > IP_MAX_MTU - dev->hard_header_len)
+			return -EINVAL;
+	}
 	dev->mtu = new_mtu;
 	return 0;
 }
@@ -1842,7 +1847,7 @@ ip6_tnl_dev_init_gen(struct net_device *
 	if (!(t->parms.flags & IP6_TNL_F_IGN_ENCAP_LIMIT))
 		dev->mtu -= 8;
 	dev->min_mtu = ETH_MIN_MTU;
-	dev->max_mtu = 0xFFF8 - dev->hard_header_len;
+	dev->max_mtu = IP6_MAX_MTU - dev->hard_header_len;
 
 	return 0;
 
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1360,7 +1360,7 @@ static void ipip6_tunnel_setup(struct ne
 	dev->hard_header_len	= LL_MAX_HEADER + t_hlen;
 	dev->mtu		= ETH_DATA_LEN - t_hlen;
 	dev->min_mtu		= IPV6_MIN_MTU;
-	dev->max_mtu		= 0xFFF8 - t_hlen;
+	dev->max_mtu		= IP6_MAX_MTU - t_hlen;
 	dev->flags		= IFF_NOARP;
 	netif_keep_dst(dev);
 	dev->addr_len		= 4;
@@ -1572,7 +1572,8 @@ static int ipip6_newlink(struct net *src
 	if (tb[IFLA_MTU]) {
 		u32 mtu = nla_get_u32(tb[IFLA_MTU]);
 
-		if (mtu >= IPV6_MIN_MTU && mtu <= 0xFFF8 - dev->hard_header_len)
+		if (mtu >= IPV6_MIN_MTU &&
+		    mtu <= IP6_MAX_MTU - dev->hard_header_len)
 			dev->mtu = mtu;
 	}
 
