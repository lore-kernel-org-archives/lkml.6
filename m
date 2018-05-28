Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164105AbeE1KxN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:53:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164055AbeE1KxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:53:09 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefano Brivio <sbrivio@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 264/496] ip_tunnel: Clamp MTU to bounds on new link
Date: Mon, 28 May 2018 12:00:49 +0200
Message-Id: <20180528100330.986219941@linuxfoundation.org>
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

[ Upstream commit 24fc79798b8ddfd46f2dd363a8d29072c083b977 ]

Otherwise, it's possible to specify invalid MTU values directly
on creation of a link (via 'ip link add'). This is already
prevented on subsequent MTU changes by commit b96f9afee4eb
("ipv4/6: use core net MTU range checking").

Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
Acked-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_tunnel.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1103,8 +1103,14 @@ int ip_tunnel_newlink(struct net_device
 		eth_hw_addr_random(dev);
 
 	mtu = ip_tunnel_bind_dev(dev);
-	if (!tb[IFLA_MTU])
+	if (tb[IFLA_MTU]) {
+		unsigned int max = 0xfff8 - dev->hard_header_len - nt->hlen;
+
+		dev->mtu = clamp(dev->mtu, (unsigned int)ETH_MIN_MTU,
+				 (unsigned int)(max - sizeof(struct iphdr)));
+	} else {
 		dev->mtu = mtu;
+	}
 
 	ip_tunnel_add(itn, nt);
 out:
