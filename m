Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id IAWFFlVFGVvEHgAAmS7hNA
	; Thu, 07 Jun 2018 14:47:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CDE8D6089E; Thu,  7 Jun 2018 14:47:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2F64E6074D;
	Thu,  7 Jun 2018 14:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F64E6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935023AbeFGOrq (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:47:46 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40815 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933094AbeFGOrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:47:43 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbX-0005Zw-Cz; Thu, 07 Jun 2018 15:09:31 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb9-00037i-N4; Thu, 07 Jun 2018 15:09:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Simon Wunderlich" <sw@simonwunderlich.de>,
        "Sven Eckelmann" <sven@narfation.org>,
        "Maximilian Wilhelm" <max@sdn.clinic>,
        "Matthias Schiffer" <mschiffer@universe-factory.net>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.960575087@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 282/410] batman-adv: fix packet checksum in receive path
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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/batman-adv/soft-interface.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -401,13 +401,7 @@ void batadv_interface_rx(struct net_devi
 
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
