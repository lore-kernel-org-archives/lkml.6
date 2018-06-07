Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 9t9EOeNBGVsfdwAAmS7hNA
	; Thu, 07 Jun 2018 15:33:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A3C176074D; Thu,  7 Jun 2018 15:33:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4C1F6601B4;
	Thu,  7 Jun 2018 15:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C1F6601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935307AbeFGPdF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:33:05 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40904 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934106AbeFGOwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:52:12 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbP-0005hK-Ej; Thu, 07 Jun 2018 15:09:23 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbD-0003GT-BB; Thu, 07 Jun 2018 15:09:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Matthias Schiffer" <mschiffer@universe-factory.net>,
        "Sven Eckelmann" <sven@narfation.org>,
        "Simon Wunderlich" <sw@simonwunderlich.de>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.303642619@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 369/410] batman-adv: update data pointers after skb_cow()
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

commit bc44b78157f621ff2a2618fe287a827bcb094ac4 upstream.

batadv_check_unicast_ttvn() calls skb_cow(), so pointers into the SKB data
must be (re)set after calling it. The ethhdr variable is dropped
altogether.

Fixes: 7cdcf6dddc42 ("batman-adv: add UNICAST_4ADDR packet type")
Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
[bwh: Backported to 3.16:
 - There's no ethhdr variable here
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -886,8 +886,6 @@ int batadv_recv_unicast_packet(struct sk
 	bool is4addr;
 
 	unicast_packet = (struct batadv_unicast_packet *)skb->data;
-	unicast_4addr_packet = (struct batadv_unicast_4addr_packet *)skb->data;
-
 	is4addr = unicast_packet->packet_type == BATADV_UNICAST_4ADDR;
 	/* the caller function should have already pulled 2 bytes */
 	if (is4addr)
@@ -907,9 +905,13 @@ int batadv_recv_unicast_packet(struct sk
 	if (!batadv_check_unicast_ttvn(bat_priv, skb, hdr_size))
 		return NET_RX_DROP;
 
+	unicast_packet = (struct batadv_unicast_packet *)skb->data;
+
 	/* packet for me */
 	if (batadv_is_my_mac(bat_priv, unicast_packet->dest)) {
 		if (is4addr) {
+			unicast_4addr_packet =
+				(struct batadv_unicast_4addr_packet *)skb->data;
 			batadv_dat_inc_counter(bat_priv,
 					       unicast_4addr_packet->subtype);
 			orig_addr = unicast_4addr_packet->src;
