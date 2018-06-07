Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xLp0NJxTGVszHwAAmS7hNA
	; Thu, 07 Jun 2018 15:48:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0FE946089E; Thu,  7 Jun 2018 15:48:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8D14B60590;
	Thu,  7 Jun 2018 15:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8D14B60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934403AbeFGOkM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:40:12 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40534 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934205AbeFGOkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:40:07 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbN-0005Zw-22; Thu, 07 Jun 2018 15:09:21 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbD-0003Gx-Jw; Thu, 07 Jun 2018 15:09:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Sabrina Dubroca" <sd@queasysnail.net>,
        "Steffen Klassert" <steffen.klassert@secunet.com>,
        "Stefano Brivio" <sbrivio@redhat.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.517083217@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 375/410] ip_tunnel: Clamp MTU to bounds on new link
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Stefano Brivio <sbrivio@redhat.com>

commit 24fc79798b8ddfd46f2dd363a8d29072c083b977 upstream.

Otherwise, it's possible to specify invalid MTU values directly
on creation of a link (via 'ip link add'). This is already
prevented on subsequent MTU changes by commit b96f9afee4eb
("ipv4/6: use core net MTU range checking").

Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
Acked-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
[bwh: Backported to 3.16: Add definition of ETH_MIN_MTU]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv4/ip_tunnel.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -968,8 +968,14 @@ int ip_tunnel_newlink(struct net_device
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
 
--- a/include/uapi/linux/if_ether.h
+++ b/include/uapi/linux/if_ether.h
@@ -36,6 +36,8 @@
 #define ETH_FRAME_LEN	1514		/* Max. octets in frame sans FCS */
 #define ETH_FCS_LEN	4		/* Octets in the FCS		 */
 
+#define ETH_MIN_MTU	68		/* Min IPv4 MTU per RFC791	*/
+
 /*
  *	These are the defined Ethernet Protocol ID's.
  */
