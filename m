Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161880AbeE1Oci (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:32:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161600AbeE1Kct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:32:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maximilian Wilhelm <max@sdn.clinic>,
        Matthias Schiffer <mschiffer@universe-factory.net>,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 146/329] batman-adv: fix packet checksum in receive path
Date: Mon, 28 May 2018 12:01:15 +0200
Message-Id: <20180528100254.699220107@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Schiffer <mschiffer@universe-factory.net>

[ Upstream commit abd6360591d3f8259f41c34e31ac4826dfe621b8 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/soft-interface.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -448,13 +448,7 @@ void batadv_interface_rx(struct net_devi
 
 	/* skb->dev & skb->pkt_type are set here */
 	skb->protocol = eth_type_trans(skb, soft_iface);
-
-	/* should not be necessary anymore as we use skb_pull_rcsum()
-	 * TODO: please verify this and remove this TODO
-	 * -- Dec 21st 2009, Simon Wunderlich
-	 */
-
-	/* skb->ip_summed = CHECKSUM_UNNECESSARY; */
+	skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
 
 	batadv_inc_counter(bat_priv, BATADV_CNT_RX);
 	batadv_add_counter(bat_priv, BATADV_CNT_RX_BYTES,
