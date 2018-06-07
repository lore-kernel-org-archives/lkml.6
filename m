Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id fdNiMNRPGVt9AwAAmS7hNA
	; Thu, 07 Jun 2018 15:32:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E34A76074D; Thu,  7 Jun 2018 15:32:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B0723601B4;
	Thu,  7 Jun 2018 15:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B0723601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935234AbeFGOwz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:52:55 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40924 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934776AbeFGOwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:52:51 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbN-0005dI-5X; Thu, 07 Jun 2018 15:09:21 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbD-0003Gn-Gw; Thu, 07 Jun 2018 15:09:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Sven Eckelmann" <sven@narfation.org>,
        "Simon Wunderlich" <sw@simonwunderlich.de>,
        "Matthias Schiffer" <mschiffer@universe-factory.net>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.604239230@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 373/410] batman-adv: Fix skbuff rcsum on packet reroute
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

From: Sven Eckelmann <sven@narfation.org>

commit fc04fdb2c8a894283259f5621d31d75610701091 upstream.

batadv_check_unicast_ttvn may redirect a packet to itself or another
originator. This involves rewriting the ttvn and the destination address in
the batadv unicast header. These field were not yet pulled (with skb rcsum
update) and thus any change to them also requires a change in the receive
checksum.

Reported-by: Matthias Schiffer <mschiffer@universe-factory.net>
Fixes: a73105b8d4c7 ("batman-adv: improved client announcement mechanism")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/batman-adv/routing.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -687,6 +687,7 @@ out:
 /**
  * batadv_reroute_unicast_packet - update the unicast header for re-routing
  * @bat_priv: the bat priv with all the soft interface information
+ * @skb: unicast packet to process
  * @unicast_packet: the unicast header to be updated
  * @dst_addr: the payload destination
  * @vid: VLAN identifier
@@ -698,7 +699,7 @@ out:
  * Returns true if the packet header has been updated, false otherwise
  */
 static bool
-batadv_reroute_unicast_packet(struct batadv_priv *bat_priv,
+batadv_reroute_unicast_packet(struct batadv_priv *bat_priv, struct sk_buff *skb,
 			      struct batadv_unicast_packet *unicast_packet,
 			      uint8_t *dst_addr, unsigned short vid)
 {
@@ -727,8 +728,10 @@ batadv_reroute_unicast_packet(struct bat
 	}
 
 	/* update the packet header */
+	skb_postpull_rcsum(skb, unicast_packet, sizeof(*unicast_packet));
 	ether_addr_copy(unicast_packet->dest, orig_addr);
 	unicast_packet->ttvn = orig_ttvn;
+	skb_postpush_rcsum(skb, unicast_packet, sizeof(*unicast_packet));
 
 	ret = true;
 out:
@@ -768,7 +771,7 @@ static int batadv_check_unicast_ttvn(str
 	 * the packet to
 	 */
 	if (batadv_tt_local_client_is_roaming(bat_priv, ethhdr->h_dest, vid)) {
-		if (batadv_reroute_unicast_packet(bat_priv, unicast_packet,
+		if (batadv_reroute_unicast_packet(bat_priv, skb, unicast_packet,
 						  ethhdr->h_dest, vid))
 			net_ratelimited_function(batadv_dbg, BATADV_DBG_TT,
 						 bat_priv,
@@ -814,7 +817,7 @@ static int batadv_check_unicast_ttvn(str
 	 * destination can possibly be updated and forwarded towards the new
 	 * target host
 	 */
-	if (batadv_reroute_unicast_packet(bat_priv, unicast_packet,
+	if (batadv_reroute_unicast_packet(bat_priv, skb, unicast_packet,
 					  ethhdr->h_dest, vid)) {
 		net_ratelimited_function(batadv_dbg, BATADV_DBG_TT, bat_priv,
 					 "Rerouting unicast packet to %pM (dst=%pM): TTVN mismatch old_ttvn=%u new_ttvn=%u\n",
@@ -837,12 +840,14 @@ static int batadv_check_unicast_ttvn(str
 	if (!primary_if)
 		return 0;
 
+	/* update the packet header */
+	skb_postpull_rcsum(skb, unicast_packet, sizeof(*unicast_packet));
 	ether_addr_copy(unicast_packet->dest, primary_if->net_dev->dev_addr);
+	unicast_packet->ttvn = curr_ttvn;
+	skb_postpush_rcsum(skb, unicast_packet, sizeof(*unicast_packet));
 
 	batadv_hardif_free_ref(primary_if);
 
-	unicast_packet->ttvn = curr_ttvn;
-
 	return 1;
 }
 
