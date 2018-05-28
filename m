Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163398AbeE1Ksi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:48:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163354AbeE1Ks2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:48:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Garver <e@erig.me>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 163/496] ip_gre: fix IFLA_MTU ignored on NEWLINK
Date: Mon, 28 May 2018 11:59:08 +0200
Message-Id: <20180528100326.737036984@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit ffc2b6ee417435605ee8bb1eb4c8f02e9ff4b4a5 ]

It's safe to remove the setting of dev's needed_headroom and mtu in
__gre_tunnel_init, as discussed in [1], ip_tunnel_newlink can do it
properly.

Now Eric noticed that it could cover the mtu value set in do_setlink
when creating a ip_gre dev. It makes IFLA_MTU param not take effect.

So this patch is to remove them to make IFLA_MTU work, as in other
ipv4 tunnels.

  [1]: https://patchwork.ozlabs.org/patch/823504/

Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
Reported-by: Eric Garver <e@erig.me>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_gre.c |    5 -----
 1 file changed, 5 deletions(-)

--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -951,9 +951,6 @@ static void __gre_tunnel_init(struct net
 
 	t_hlen = tunnel->hlen + sizeof(struct iphdr);
 
-	dev->needed_headroom	= LL_MAX_HEADER + t_hlen + 4;
-	dev->mtu		= ETH_DATA_LEN - t_hlen - 4;
-
 	dev->features		|= GRE_FEATURES;
 	dev->hw_features	|= GRE_FEATURES;
 
@@ -1253,8 +1250,6 @@ static int erspan_tunnel_init(struct net
 		       sizeof(struct erspanhdr);
 	t_hlen = tunnel->hlen + sizeof(struct iphdr);
 
-	dev->needed_headroom = LL_MAX_HEADER + t_hlen + 4;
-	dev->mtu = ETH_DATA_LEN - t_hlen - 4;
 	dev->features		|= GRE_FEATURES;
 	dev->hw_features	|= GRE_FEATURES;
 	dev->priv_flags		|= IFF_LIVE_ADDR_CHANGE;
