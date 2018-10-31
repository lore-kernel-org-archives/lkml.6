Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C63ECDE47
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F059C20840
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvYC/+AC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F059C20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mailme.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbeJaTzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:55:39 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45630 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbeJaTzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:55:38 -0400
Received: by mail-ed1-f68.google.com with SMTP id t10-v6so13195006eds.12;
        Wed, 31 Oct 2018 03:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WYfde6DTmy6vKGV+9gDH9plmleyfINd+8JWW56qt+kk=;
        b=FvYC/+AC5eYuBgNb2nlAiPB3vz1mElDsfRt1OAHoYeEvGj/UCl9XZHXo/EUvRErm/b
         ntWYBBn4EbOK5SaJhCIPFEGPa+sqL4gCpmIITH55qcRNJvTjz6Mhbtyu3vK0Vi4NIwGJ
         mauAqUiMZ3Y/lASVl15NKh7npR3HPOC4ZnOIELKJwD1C+ICvGHr4gB8Zu4Vou/Ruh6Ft
         +i3OxcOKSP5H65KXW5hTMADJCZQtfGihNr3+IVpoiKojvXGg5lgjyJnU+giwES3dQ/TC
         eMdtaeI8GjTgtPYzLOAoM/ZsubZmVYDXj18149os4E9Pe3TeovqFvc3p2kmZ1ubFFdum
         rt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=WYfde6DTmy6vKGV+9gDH9plmleyfINd+8JWW56qt+kk=;
        b=Wis3/euJ2BlTFBZfpeHA3CkNvDJzC1ACvMfjdBPFkoHfaoH6s9ewmXcdzLZqV2ijb9
         Z6BbzhdcMpbFN/8c8I+CB6A6wwICs4yht7eCZNBN/Yh0aLdV1s1kWydOyB/73Ln/F8wx
         057UlGsa4CqXW3zoq+5xBzUhX+rxSMB7vR+NWvBgReexU/4oFdVtY/mtCoc/dX/2weql
         OgFon/5DEUpQOptojHScWR9s6rotg5oVoFw6KhHD9hXPtqbABo+VePOd3GAspja1zYu6
         ZOWR+S9AWiSTarZea6WrKwhp+F8UN3zEP45g1sevI70BILKKzDrTG22W4b47c36PhouR
         zyAw==
X-Gm-Message-State: AGRZ1gJYxml9Rs1AKaaJDoHq+WN+6FkDh0hzAPHN05/OS7j3XO+Tb8nn
        h7iY+ElK2tr//Q0tkOoVrnMfRxf9i+s=
X-Google-Smtp-Source: AJdET5f9NHRG2n+sUIBfqLTHXySKCvK74rFxnIFr4yjw7JiAPzJfTUx79/DjK7MgXtl34huxli5MzQ==
X-Received: by 2002:a50:b36e:: with SMTP id r43-v6mr1660672edd.284.1540983480917;
        Wed, 31 Oct 2018 03:58:00 -0700 (PDT)
Received: from localhost.localdomain ([5.57.50.195])
        by smtp.gmail.com with ESMTPSA id a40-v6sm9041108edd.61.2018.10.31.03.57.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 03:57:59 -0700 (PDT)
From:   Emil Renner Berthing <esmil@mailme.dk>
To:     linux-spi@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Addy Ke <addy.ke@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 02/14] spi: rockchip: use designated init for dma config
Date:   Wed, 31 Oct 2018 11:56:59 +0100
Message-Id: <20181031105711.19575-3-esmil@mailme.dk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181031105711.19575-1-esmil@mailme.dk>
References: <20181031105711.19575-1-esmil@mailme.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

Use C99 designated initializers for dma slave config
structures. This also makes sure uninitialized fields
are zeroed so we don't need an explicit memset.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 7e54e1a69cc8..87d1b9837d94 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -442,12 +442,8 @@ static void rockchip_spi_dma_txcb(void *data)
 static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 {
 	unsigned long flags;
-	struct dma_slave_config rxconf, txconf;
 	struct dma_async_tx_descriptor *rxdesc, *txdesc;
 
-	memset(&rxconf, 0, sizeof(rxconf));
-	memset(&txconf, 0, sizeof(txconf));
-
 	spin_lock_irqsave(&rs->lock, flags);
 	rs->state &= ~RXBUSY;
 	rs->state &= ~TXBUSY;
@@ -455,10 +451,13 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 
 	rxdesc = NULL;
 	if (rs->rx) {
-		rxconf.direction = DMA_DEV_TO_MEM;
-		rxconf.src_addr = rs->dma_rx.addr;
-		rxconf.src_addr_width = rs->n_bytes;
-		rxconf.src_maxburst = 1;
+		struct dma_slave_config rxconf = {
+			.direction = DMA_DEV_TO_MEM,
+			.src_addr = rs->dma_rx.addr,
+			.src_addr_width = rs->n_bytes,
+			.src_maxburst = 1,
+		};
+
 		dmaengine_slave_config(rs->dma_rx.ch, &rxconf);
 
 		rxdesc = dmaengine_prep_slave_sg(
@@ -474,10 +473,13 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 
 	txdesc = NULL;
 	if (rs->tx) {
-		txconf.direction = DMA_MEM_TO_DEV;
-		txconf.dst_addr = rs->dma_tx.addr;
-		txconf.dst_addr_width = rs->n_bytes;
-		txconf.dst_maxburst = rs->fifo_len / 2;
+		struct dma_slave_config txconf = {
+			.direction = DMA_MEM_TO_DEV,
+			.dst_addr = rs->dma_tx.addr,
+			.dst_addr_width = rs->n_bytes,
+			.dst_maxburst = rs->fifo_len / 2,
+		};
+
 		dmaengine_slave_config(rs->dma_tx.ch, &txconf);
 
 		txdesc = dmaengine_prep_slave_sg(
-- 
2.19.1

