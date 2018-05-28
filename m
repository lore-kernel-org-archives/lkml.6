Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164124AbeE1KxW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163629AbeE1KxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:53:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefano Brivio <sbrivio@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 266/496] vti6: Fix dev->max_mtu setting
Date: Mon, 28 May 2018 12:00:51 +0200
Message-Id: <20180528100331.071260733@linuxfoundation.org>
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

From: Stefano Brivio <sbrivio@redhat.com>

[ Upstream commit f8a554b4aa9686bb2c12f6bae516e58783289a03 ]

We shouldn't allow a tunnel to have IP_MAX_MTU as MTU, because
another IPv6 header is going on top of our packets. Without this
patch, we might end up building packets bigger than IP_MAX_MTU.

Fixes: b96f9afee4eb ("ipv4/6: use core net MTU range checking")
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
Acked-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_vti.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -852,7 +852,7 @@ static void vti6_dev_setup(struct net_de
 	dev->hard_header_len = LL_MAX_HEADER + sizeof(struct ipv6hdr);
 	dev->mtu = ETH_DATA_LEN;
 	dev->min_mtu = IPV6_MIN_MTU;
-	dev->max_mtu = IP_MAX_MTU;
+	dev->max_mtu = IP_MAX_MTU - sizeof(struct ipv6hdr);
 	dev->flags |= IFF_NOARP;
 	dev->addr_len = sizeof(struct in6_addr);
 	netif_keep_dst(dev);
