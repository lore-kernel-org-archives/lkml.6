Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB93C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE112063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218287;
	bh=ncRsdOQTkxQgOOEAsFjvTYJMKYv/NAlrz6kaeimq8vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j+BB7U7USUcaYacZZgt0hJKoNNrfRdSsfQnI0G71iv1ew7+BuhlnvbnUy+0MejnQw
	 OM6dP/GV4tAWzred+/sPFv4GWV4kh0Drb/6NswFZwMmby1PArfDOzlkmx/GA216ACp
	 uYk+ujl3YWRV7lWAn2cWIB2cyTYGcagI37h74UEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403811AbfAKOje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:39:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:60340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391072AbfAKOjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:39:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8615E21841;
        Fri, 11 Jan 2019 14:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217571;
        bh=ncRsdOQTkxQgOOEAsFjvTYJMKYv/NAlrz6kaeimq8vw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jXFvHpv8u2xT+eAEkikSF7Ss6emdMe42IyFGD/PVTwbTbwYzKzcH5v0N88Fse/EZn
         bY5XammObZXXC4bOr8zeJJ8h9KZe95Njiai47Ov4GqhrgVx8jXKyL79JPeviStX+50
         exbvqUAj8rOzG/t2y6d8nffhZR+ovB2YMQNqzPIE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 061/148] net: macb: add missing barriers when reading descriptors
Date:   Fri, 11 Jan 2019 15:13:59 +0100
Message-Id: <20190111131116.699033078@linuxfoundation.org>
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



