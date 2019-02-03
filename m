Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F934C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575FC2084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbfBCOVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:21:47 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55924 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730620AbfBCOVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:21:44 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIeV-0006TT-Jt; Sun, 03 Feb 2019 14:21:43 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIBi-0007UT-RO; Sun, 03 Feb 2019 14:51:58 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>,
        "Anssi Hannula" <anssi.hannula@bitwise.fi>,
        "Nicolas Ferre" <nicolas.ferre@microchip.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.946866924@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 297/305] net: macb: fix dropped RX frames due to a race
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Anssi Hannula <anssi.hannula@bitwise.fi>

commit 8159ecab0db9095902d4c73605fb8787f5c7d653 upstream.

Bit RX_USED set to 0 in the address field allows the controller to write
data to the receive buffer descriptor.

The driver does not ensure the ctrl field is ready (cleared) when the
controller sees the RX_USED=0 written by the driver. The ctrl field might
only be cleared after the controller has already updated it according to
a newly received frame, causing the frame to be discarded in gem_rx() due
to unexpected ctrl field contents.

A message is logged when the above scenario occurs:

  macb ff0b0000.ethernet eth0: not whole frame pointed by descriptor

Fix the issue by ensuring that when the controller sees RX_USED=0 the
ctrl field is already cleared.

This issue was observed on a ZynqMP based system.

Fixes: 4df95131ea80 ("net/macb: change RX path for GEM")
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Tested-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16:
 - Use bp->rx_ring[entry] instead of *desc
 - Use wmb() instead of dma_wmb()
 - Adjust filename]]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/cadence/macb.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/cadence/macb.c
+++ b/drivers/net/ethernet/cadence/macb.c
@@ -629,14 +629,19 @@ static void gem_rx_refill(struct macb *b
 
 			if (entry == RX_RING_SIZE - 1)
 				paddr |= MACB_BIT(RX_WRAP);
-			bp->rx_ring[entry].addr = paddr;
 			bp->rx_ring[entry].ctrl = 0;
+			/* Setting addr clears RX_USED and allows reception,
+			 * make sure ctrl is cleared first to avoid a race.
+			 */
+			wmb();
+			bp->rx_ring[entry].addr = paddr;
 
 			/* properly align Ethernet header */
 			skb_reserve(skb, NET_IP_ALIGN);
 		} else {
-			bp->rx_ring[entry].addr &= ~MACB_BIT(RX_USED);
 			bp->rx_ring[entry].ctrl = 0;
+			wmb();
+			bp->rx_ring[entry].addr &= ~MACB_BIT(RX_USED);
 		}
 	}
 

