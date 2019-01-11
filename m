Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB91C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45C82063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217110;
	bh=ceV8O2wzbxPTWswEN+LHc5y4Jpo+cFjqIpdRf738eH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wt+Zy8M6nRZEJVDC6oYyvhNCQhz7hc0iWDVmw/BeT/WvOj01RRLql6vFcHCd4p/hz
	 I5eRf93ovLbR9wNq93kxnnJLy2RbVzw5A5f5B+9EVI5Nulg5nbtRSFjC8JvDdjx6WC
	 XF57sJHFU9SjvGSzowdnytyLsLevTnkQ5SO88m74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389262AbfAKObu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:31:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:51592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389245AbfAKObr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:31:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FF3721848;
        Fri, 11 Jan 2019 14:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217106;
        bh=ceV8O2wzbxPTWswEN+LHc5y4Jpo+cFjqIpdRf738eH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gq7LKpBfJ01HCdYmEjTghEKGZozki3EBJ2PbQW8oByHlwAa8Q6NLJGSELRDBiTtij
         Oj/QTbm9DloGuWxBv/AajpQr1bcbWe29+ou7qQzxJ6CV446yO0u4+dj+hgcPOCDxqt
         WLN1vDl9mqXojd9GuQwV2zE9868tfVYHNmg/WhpY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 044/105] net: macb: fix dropped RX frames due to a race
Date:   Fri, 11 Jan 2019 15:14:15 +0100
Message-Id: <20190111131106.809889494@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index 3aabc36eec0b..9046993947cc 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -923,14 +923,19 @@ static void gem_rx_refill(struct macb *bp)
 
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



