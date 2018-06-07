Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 7ydAL609GVurRAAAmS7hNA
	; Thu, 07 Jun 2018 14:14:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 90BD7608C8; Thu,  7 Jun 2018 14:14:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 779FA602FC;
	Thu,  7 Jun 2018 14:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 779FA602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933389AbeFGOOB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:14:01 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39516 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933156AbeFGOJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:38 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbJ-0005Zw-7K; Thu, 07 Jun 2018 15:09:17 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbF-0003Ic-1j; Thu, 07 Jun 2018 15:09:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Simon Wunderlich" <sw@simonwunderlich.de>,
        "Sven Eckelmann" <sven@narfation.org>,
        "=?UTF-8?q?Linus=20L=C3=BCssing?=" <linus.luessing@c0d3.blue>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.228512641@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 394/410] batman-adv: fix multicast-via-unicast
 transmission with AP isolation
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

commit f8fb3419ead44f9a3136995acd24e35da4525177 upstream.

For multicast frames AP isolation is only supposed to be checked on
the receiving nodes and never on the originating one.

Furthermore, the isolation or wifi flag bits should only be intepreted
as such for unicast and never multicast TT entries.

By injecting flags to the multicast TT entry claimed by a single
target node it was verified in tests that this multicast address
becomes unreachable, leading to packet loss.

Omitting the "src" parameter to the batadv_transtable_search() call
successfully skipped the AP isolation check and made the target
reachable again.

Fixes: 1d8ab8d3c176 ("batman-adv: Modified forwarding behaviour for multicast packets")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/batman-adv/multicast.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -398,8 +398,8 @@ static struct batadv_orig_node *
 batadv_mcast_forw_tt_node_get(struct batadv_priv *bat_priv,
 			      struct ethhdr *ethhdr)
 {
-	return batadv_transtable_search(bat_priv, ethhdr->h_source,
-					ethhdr->h_dest, BATADV_NO_FLAGS);
+	return batadv_transtable_search(bat_priv, NULL, ethhdr->h_dest,
+					BATADV_NO_FLAGS);
 }
 
 /**
