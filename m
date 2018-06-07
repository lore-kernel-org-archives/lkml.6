Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id JzcIG3lDGVviCAAAmS7hNA
	; Thu, 07 Jun 2018 14:38:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5E178608C1; Thu,  7 Jun 2018 14:38:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B26FD608BA;
	Thu,  7 Jun 2018 14:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B26FD608BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934264AbeFGOio (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:38:44 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40483 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934131AbeFGOil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:38:41 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbJ-0005Zq-7y; Thu, 07 Jun 2018 15:09:17 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbF-0003Ih-3S; Thu, 07 Jun 2018 15:09:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "=?UTF-8?q?Linus=20L=C3=BCssing?=" <linus.luessing@c0d3.blue>,
        "Sven Eckelmann" <sven@narfation.org>,
        "Simon Wunderlich" <sw@simonwunderlich.de>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.632111619@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 395/410] batman-adv: fix packet loss for broadcasted
 DHCP packets to a server
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

From: Linus Lüssing <linus.luessing@c0d3.blue>

commit a752c0a4524889cdc0765925258fd1fd72344100 upstream.

DHCP connectivity issues can currently occur if the following conditions
are met:

1) A DHCP packet from a client to a server
2) This packet has a multicast destination
3) This destination has a matching entry in the translation table
   (FF:FF:FF:FF:FF:FF for IPv4, 33:33:00:01:00:02/33:33:00:01:00:03
    for IPv6)
4) The orig-node determined by TT for the multicast destination
   does not match the orig-node determined by best-gateway-selection

In this case the DHCP packet will be dropped.

The "gateway-out-of-range" check is supposed to only be applied to
unicasted DHCP packets to a specific DHCP server.

In that case dropping the the unicasted frame forces the client to
retry via a broadcasted one, but now directed to the new best
gateway.

A DHCP packet with broadcast/multicast destination is already ensured to
always be delivered to the best gateway. Dropping a multicasted
DHCP packet here will only prevent completing DHCP as there is no
other fallback.

So far, it seems the unicast check was implicitly performed by
expecting the batadv_transtable_search() to return NULL for multicast
destinations. However, a multicast address could have always ended up in
the translation table and in fact is now common.

To fix this potential loss of a DHCP client-to-server packet to a
multicast address this patch adds an explicit multicast destination
check to reliably bail out of the gateway-out-of-range check for such
destinations.

The issue and fix were tested in the following three node setup:

- Line topology, A-B-C
- A: gateway client, DHCP client
- B: gateway server, hop-penalty increased: 30->60, DHCP server
- C: gateway server, code modifications to announce FF:FF:FF:FF:FF:FF

Without this patch, A would never transmit its DHCP Discover packet
due to an always "out-of-range" condition. With this patch,
a full DHCP handshake between A and B was possible again.

Fixes: be7af5cf9cae ("batman-adv: refactoring gateway handling code")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
[bwh: Backported to 3.16: Drop redundant change to initialisation]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -804,6 +804,9 @@ bool batadv_gw_out_of_range(struct batad
 
 	vid = batadv_get_vid(skb, 0);
 
+	if (is_multicast_ether_addr(ethhdr->h_dest))
+		goto out;
+
 	orig_dst_node = batadv_transtable_search(bat_priv, ethhdr->h_source,
 						 ethhdr->h_dest, vid);
 	if (!orig_dst_node)
