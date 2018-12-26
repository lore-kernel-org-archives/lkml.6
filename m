Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8F0C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F9E218E2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545863895;
	bh=QRRLGNJoGKtGSB0xonutg2dNDuGwoLt+gbr6rF3iybs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S9QhD/ezyIgwjg4e372pEELj582NZsIp02I9B2wS0y6g9o7TENYuQzG6vHlVy29FF
	 ia7rWB9MRssgXjvwor9NiBHreUupXmQ5fMS5zdbnNBGdl8kDDbxejCOIqK+3YmnbIU
	 s9EiNQTVPLzK1dVL/pfc+cnYRJ8TA0AhNlZV7/hc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbeLZWiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:38:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:38354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728655AbeLZWiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:38:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5425D21901;
        Wed, 26 Dec 2018 22:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863886;
        bh=QRRLGNJoGKtGSB0xonutg2dNDuGwoLt+gbr6rF3iybs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mYu8ywksjhowSc71FIXjG0P/2ikwwDWDBgf45/0Y2hBKiy2Ksd/b56yvP9PUoXXhf
         t9I1c1opvtLt91eomw3+RQUj7m9JgYKyMFu92PkhlMgKWt5aEbNWscFwuupL4Ejekg
         VNsB9+sjIs1TP8fmDBCWstm1LXH1UA2lPswX6O8c=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Anssi Hannula <anssi.hannula@bitwise.fi>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 75/97] net: macb: add missing barriers when reading descriptors
Date:   Wed, 26 Dec 2018 17:35:35 -0500
Message-Id: <20181226223557.149329-75-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anssi Hannula <anssi.hannula@bitwise.fi>

[ Upstream commit 6e0af298066f3b6d99f58989bb0dca6f764b4c6d ]

When reading buffer descriptors on RX or on TX completion, an
RX_USED/TX_USED bit is checked first to ensure that the descriptors have
been populated, i.e. the ownership has been transferred. However, there
are no memory barriers to ensure that the data protected by the
RX_USED/TX_USED bit is up-to-date with respect to that bit.

Specifically:

- TX timestamp descriptors may be loaded before ctrl is loaded for the
  TX_USED check, which is racy as the descriptors may be updated between
  the loads, causing old timestamp descriptor data to be used.

- RX ctrl may be loaded before addr is loaded for the RX_USED check,
  which is racy as a new frame may be written between the loads, causing
  old ctrl descriptor data to be used.
  This issue exists for both macb_rx() and gem_rx() variants.

Fix the races by adding DMA read memory barriers on those paths and
reordering the reads in macb_rx().

I have not observed any actual problems in practice caused by these
being missing, though.

Tested on a ZynqMP based system.

Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 13 ++++++++++---
 drivers/net/ethernet/cadence/macb_ptp.c  |  2 ++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index b8b37afc5dc3..8f4b2f9a8e07 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1001,11 +1001,15 @@ static int gem_rx(struct macb_queue *queue, int budget)
 
 		rxused = (desc->addr & MACB_BIT(RX_USED)) ? true : false;
 		addr = macb_get_addr(bp, desc);
-		ctrl = desc->ctrl;
 
 		if (!rxused)
 			break;
 
+		/* Ensure ctrl is at least as up-to-date as rxused */
+		dma_rmb();
+
+		ctrl = desc->ctrl;
+
 		queue->rx_tail++;
 		count++;
 
@@ -1180,11 +1184,14 @@ static int macb_rx(struct macb_queue *queue, int budget)
 		/* Make hw descriptor updates visible to CPU */
 		rmb();
 
-		ctrl = desc->ctrl;
-
 		if (!(desc->addr & MACB_BIT(RX_USED)))
 			break;
 
+		/* Ensure ctrl is at least as up-to-date as addr */
+		dma_rmb();
+
+		ctrl = desc->ctrl;
+
 		if (ctrl & MACB_BIT(RX_SOF)) {
 			if (first_frag != -1)
 				discard_partial_frame(queue, first_frag, tail);
diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index cd5296b84229..a6dc47edc4cf 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -319,6 +319,8 @@ int gem_ptp_txstamp(struct macb_queue *queue, struct sk_buff *skb,
 	desc_ptp = macb_ptp_desc(queue->bp, desc);
 	tx_timestamp = &queue->tx_timestamps[head];
 	tx_timestamp->skb = skb;
+	/* ensure ts_1/ts_2 is loaded after ctrl (TX_USED check) */
+	dma_rmb();
 	tx_timestamp->desc_ptp.ts_1 = desc_ptp->ts_1;
 	tx_timestamp->desc_ptp.ts_2 = desc_ptp->ts_2;
 	/* move head */
-- 
2.19.1

