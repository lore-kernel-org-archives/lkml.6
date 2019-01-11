Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87748C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A63521848
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217449;
	bh=DYrrKZgAp/wWSE+UYCq+DSeePoRW7HGSmtpwxFWuzAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vow4EKZEJR1TBPozK4szMpm86D2LZnhGQ+OlGZOyetlE8r2iHAOIdftS5lW5bxb0o
	 uYncCKgW7N4hqZh7OJnzjDoJshUVMs99/LmEzQlH7a6+0/uS5qF4h4iovO0VU0efpC
	 h4HQekiPVDa+yjF6hDwCeEDD6USRPliwimeLVyxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390634AbfAKOh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:37:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:57898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390613AbfAKOhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:37:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74C1E2133F;
        Fri, 11 Jan 2019 14:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217442;
        bh=DYrrKZgAp/wWSE+UYCq+DSeePoRW7HGSmtpwxFWuzAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b4HVSJ+C5dbAIIVme3kN0TJ3N5cJuesYBOp131bmhINaKX9aLmsBoXyDJ2XW8Q0R/
         veSmtn6NRJ2JXF4ISf531jECbYcgJgUPjR3NDBv8UKW78vXlSxMFt2Ijf4PxlwXIDW
         vH1B8aFgf7STpOzfUjAJ7/RdCpPIvIzYj1apFG18=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 060/148] net: macb: fix dropped RX frames due to a race
Date:   Fri, 11 Jan 2019 15:13:58 +0100
Message-Id: <20190111131116.663345689@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8159ecab0db9095902d4c73605fb8787f5c7d653 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 2de9197df074..b8b37afc5dc3 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -935,14 +935,19 @@ static void gem_rx_refill(struct macb_queue *queue)
 
 			if (entry == bp->rx_ring_size - 1)
 				paddr |= MACB_BIT(RX_WRAP);
-			macb_set_addr(bp, desc, paddr);
 			desc->ctrl = 0;
+			/* Setting addr clears RX_USED and allows reception,
+			 * make sure ctrl is cleared first to avoid a race.
+			 */
+			dma_wmb();
+			macb_set_addr(bp, desc, paddr);
 
 			/* properly align Ethernet header */
 			skb_reserve(skb, NET_IP_ALIGN);
 		} else {
-			desc->addr &= ~MACB_BIT(RX_USED);
 			desc->ctrl = 0;
+			dma_wmb();
+			desc->addr &= ~MACB_BIT(RX_USED);
 		}
 	}
 
-- 
2.19.1



