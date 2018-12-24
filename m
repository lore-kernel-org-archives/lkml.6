Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FFEC64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9439021850
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4Aactj3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbeLXWBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 17:01:52 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35984 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbeLXWBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 17:01:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id u4so12529933wrp.3;
        Mon, 24 Dec 2018 14:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z25qU1Gd2RNparvr3msaNkK+mb9KyV51aUQZgpnOltw=;
        b=s4Aactj3pMwWVGPktsMfEhcBhBwyuKkrVkCv7wW3ZebzpNntT23v2JvQV2US8TgAlX
         +2X47nr6Ajs+VtKMRKRGQkF8BI6Fwzy+8L+veQvBoFeRmNNT1JBFoVKIHXe+N5Xe7AfS
         OQqmw5pU/wV2SPRRloQ7E/tme/ahkC9Jg/8GBnWKqF6W4GtsRVF5HMGtumZkdzQeDf4/
         RIqo6CVJkKKdWktuyZ77j/Dfo5eCAHypOJu78d927JHyk1gfRXfm8hEulQNwCudgtaXo
         6u2g2iMFZw4SvyKAMkszBWLKwxBO7Sk/Ela9L6yi6/E2qpeB6KFk3UKw8eQOup21Smhk
         Znnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z25qU1Gd2RNparvr3msaNkK+mb9KyV51aUQZgpnOltw=;
        b=IbyXWC7OPt46zBhDPVmHoHzARhFUni6TSTEDu/5dA35fo+Dt50QCmsZSaItD5WkmMF
         Iprg9s6P17J2Tftv86/D/vTaOHmU+gR8rkgpi4Oo9HFRl+iOw+JqtwPJejkCyxeiZ4f5
         D1T5AMIYK+Z7pLLt/XNxd2rA8p3vi4UASSAt1XX6wU5oIa6eCD7F7z304MIOBVhOGRFA
         giJJ/rPA1/T8ixv/Q9fHvDbOu1HBkPp6OiSfA/5CL3LqWconBJYqbGo314N2Us/t7w90
         uP5QHHFYcBH3383oVwZOpRP1ddVwfkpm+1o8WbCRq4hv3nlGqj/5/46kBtmoIX+nOvxG
         w7vA==
X-Gm-Message-State: AJcUukemaNn9fjlVv1sFNVWT92X25kQcoc2n/+ElFApF4rVvuIzB41+X
        FmZeVZqva3i0fyUv2J7tHE64eJqQ85I=
X-Google-Smtp-Source: ALg8bN5sUn6t/qQVtpNnEhk7IBxihKXCFbWe6/aOi3aISToUdQPZvgpZcIx2N+DMLp4St6rVeZH17A==
X-Received: by 2002:adf:f9cb:: with SMTP id w11mr12812261wrr.201.1545688869106;
        Mon, 24 Dec 2018 14:01:09 -0800 (PST)
Received: from gapa-Lenovo-IdeaPad-Y580.home (daw20.neoplus.adsl.tpnet.pl. [83.23.22.20])
        by smtp.gmail.com with ESMTPSA id d4sm23970153wrp.89.2018.12.24.14.01.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Dec 2018 14:01:08 -0800 (PST)
From:   cezary.gapinski@gmail.com
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Cezary Gapinski <cezary.gapinski@gmail.com>
Subject: [PATCH v2 10/14] spi: stm32: add start dma transfer function
Date:   Mon, 24 Dec 2018 23:00:36 +0100
Message-Id: <1545688840-23992-11-git-send-email-cezary.gapinski@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
References: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

Add transfer_one_dma_start function to be more generic for other
stm32 SPI family drivers.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
---
 drivers/spi/spi-stm32.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index bc8513f..b19d02b 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -748,6 +748,23 @@ static int stm32_spi_transfer_one_irq(struct stm32_spi *spi)
 }
 
 /**
+ * stm32_spi_transfer_one_dma_start - Set SPI driver registers to start transfer
+ *				      using DMA
+ */
+static void stm32_spi_transfer_one_dma_start(struct stm32_spi *spi)
+{
+	/* Enable the interrupts relative to the end of transfer */
+	stm32_spi_set_bits(spi, STM32H7_SPI_IER, STM32H7_SPI_IER_EOTIE |
+						 STM32H7_SPI_IER_TXTFIE |
+						 STM32H7_SPI_IER_OVRIE |
+						 STM32H7_SPI_IER_MODFIE);
+
+	stm32_spi_enable(spi);
+
+	stm32_spi_set_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_CSTART);
+}
+
+/**
  * stm32_spi_transfer_one_dma - transfer a single spi_transfer using DMA
  *
  * It must returns 0 if the transfer is finished or 1 if the transfer is still
@@ -759,7 +776,6 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 	struct dma_slave_config tx_dma_conf, rx_dma_conf;
 	struct dma_async_tx_descriptor *tx_dma_desc, *rx_dma_desc;
 	unsigned long flags;
-	u32 ier = 0;
 
 	spin_lock_irqsave(&spi->lock, flags);
 
@@ -829,14 +845,7 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 				   STM32H7_SPI_CFG1_TXDMAEN);
 	}
 
-	/* Enable the interrupts relative to the end of transfer */
-	ier |= STM32H7_SPI_IER_EOTIE | STM32H7_SPI_IER_TXTFIE |
-	       STM32H7_SPI_IER_OVRIE | STM32H7_SPI_IER_MODFIE;
-	writel_relaxed(ier, spi->base + STM32H7_SPI_IER);
-
-	stm32_spi_enable(spi);
-
-	stm32_spi_set_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_CSTART);
+	stm32_spi_transfer_one_dma_start(spi);
 
 	spin_unlock_irqrestore(&spi->lock, flags);
 
-- 
2.7.4

