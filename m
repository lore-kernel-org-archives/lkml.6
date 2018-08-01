Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A943BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482E720862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="sBbVzqBq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482E720862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388869AbeHANaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 09:30:20 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:38620 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387799AbeHANaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 09:30:20 -0400
Received: from trochilidae.toradex.int (unknown [IPv6:2a02:169:34b6::e71])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id AD12B5C03BB;
        Wed,  1 Aug 2018 13:44:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1533123894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=YXf50igpmZ3Und0zC2FUpgOLYWlGtvwnAjZoXcq9WEM=;
        b=sBbVzqBqF1BfoSwS0w+3NB61SaeGxyaHuFgLoO4nl61/gRdX9QqecLaxvOfdLnLZ8ngSv5
        j1+WZ2neFdpC8ElztK4zT1Eh5ymDZRowEQ9Mr0cqQXhXFWUUW8nXi21GPbIF/c1+rtAn/B
        JF3fZECtJrIR26UzwjX6z00Dw/kWQ0o=
From:   Stefan Agner <stefan@agner.ch>
To:     fugang.duan@nxp.com, davem@davemloft.net
Cc:     krzk@kernel.org, robin.murphy@arm.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH] net: fec: check DMA addressing limitations
Date:   Wed,  1 Aug 2018 13:44:49 +0200
Message-Id: <20180801114449.21208-1-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check DMA addressing limitations as suggested by the DMA API
how-to. This does not fix a particular issue seen but is
considered good style.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/net/ethernet/freescale/fec_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c729665107f5..af0fb200e936 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3146,6 +3146,12 @@ static int fec_enet_init(struct net_device *ndev)
 	fep->tx_align = 0x3;
 #endif
 
+	/* Check mask of the streaming and coherent API */
+	if (dma_set_mask_and_coherent(&fep->pdev->dev, DMA_BIT_MASK(32))) {
+		dev_warn(&fep->pdev->dev, "No suitable DMA available\n");
+		return -ENODEV;
+	}
+
 	fec_enet_alloc_queue(ndev);
 
 	bd_size = (fep->total_tx_ring_size + fep->total_rx_ring_size) * dsize;
-- 
2.18.0

