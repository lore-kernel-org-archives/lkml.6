Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753442AbeE3Ldi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:33:38 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60883 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751742AbeE3LHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:04 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Maximilian Wilhelm" <max@sdn.clinic>,
        "Matthias Schiffer" <mschiffer@universe-factory.net>,
        "Sven Eckelmann" <sven@narfation.org>,
        "Simon Wunderlich" <sw@simonwunderlich.de>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.522774326@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 107/153] batman-adv: fix packet checksum in receive path
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Schiffer <mschiffer@universe-factory.net>

commit abd6360591d3f8259f41c34e31ac4826dfe621b8 upstream.

eth_type_trans() internally calls skb_pull(), which does not adjust the
skb checksum; skb_postpull_rcsum() is necessary to avoid log spam of the
form "bat0: hw csum failure" when packets with CHECKSUM_COMPLETE are
received.

Note that in usual setups, packets don't reach batman-adv with
CHECKSUM_COMPLETE (I assume NICs bail out of checksumming when they see
batadv's ethtype?), which is why the log messages do not occur on every
system using batman-adv. I could reproduce this issue by stacking
batman-adv on top of a VXLAN interface.

Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Tested-by: Maximilian Wilhelm <max@sdn.clinic>
Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -733,12 +733,7 @@ void interface_rx(struct net_device *sof
 
 	/* skb->dev & skb->pkt_type are set here */
 	skb->protocol = eth_type_trans(skb, soft_iface);
-
-	/* should not be necessary anymore as we use skb_pull_rcsum()
-	 * TODO: please verify this and remove this TODO
-	 * -- Dec 21st 2009, Simon Wunderlich */
-
-/*	skb->ip_summed = CHECKSUM_UNNECESSARY;*/
+	skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
 
 	bat_priv->stats.rx_packets++;
 	bat_priv->stats.rx_bytes += skb->len + sizeof(struct ethhdr);
