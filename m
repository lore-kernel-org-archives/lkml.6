Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11176C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C632147A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="NAHnxrp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C632147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbeHBKdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:33:03 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:47684 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeHBKdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:33:02 -0400
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 4DA075C0A80;
        Thu,  2 Aug 2018 10:42:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1533199373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=Jex5bShoBENvnN9HpXMYmB/UJrRCVrkYWRT6EiLnQvA=;
        b=NAHnxrp0Heu4IEVk8znkiM6jz6INVctQTs5XrudSWcFVkBroVNzVMvapBF2Q5ZcPbQUjL0
        10I2jM7wvdmpiAetYEMyawMj+lUptR4EhBQmza04hrXu+AQDbCM99pXMopb1j++AW1C4cV
        0VWd6LkYjXoqFpUTAN/HbNh8aY4UAMo=
From:   Stefan Agner <stefan@agner.ch>
To:     fugang.duan@nxp.com, davem@davemloft.net
Cc:     krzk@kernel.org, robin.murphy@arm.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2] net: fec: check DMA addressing limitations
Date:   Thu,  2 Aug 2018 10:42:50 +0200
Message-Id: <20180802084250.26489-1-stefan@agner.ch>
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
 drivers/net/ethernet/freescale/fec_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c729665107f5..cdf2f5447910 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3136,6 +3136,7 @@ static int fec_enet_init(struct net_device *ndev)
 	unsigned dsize = fep->bufdesc_ex ? sizeof(struct bufdesc_ex) :
 			sizeof(struct bufdesc);
 	unsigned dsize_log2 = __fls(dsize);
+	int ret;
 
 	WARN_ON(dsize != (1 << dsize_log2));
 #if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
@@ -3146,6 +3147,13 @@ static int fec_enet_init(struct net_device *ndev)
 	fep->tx_align = 0x3;
 #endif
 
+	/* Check mask of the streaming and coherent API */
+	ret = dma_set_mask_and_coherent(&fep->pdev->dev, DMA_BIT_MASK(32));
+	if (ret < 0) {
+		dev_warn(&fep->pdev->dev, "No suitable DMA available\n");
+		return ret;
+	}
+
 	fec_enet_alloc_queue(ndev);
 
 	bd_size = (fep->total_tx_ring_size + fep->total_rx_ring_size) * dsize;
-- 
2.18.0

