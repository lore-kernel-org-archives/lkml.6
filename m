Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F65BECDE4A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4325920685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NywOynHs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4325920685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mailme.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbeJaTzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:55:49 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46392 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728584AbeJaTzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:55:48 -0400
Received: by mail-ed1-f65.google.com with SMTP id f8-v6so857046edt.13;
        Wed, 31 Oct 2018 03:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RuKtI98TNIO9duKNI1SxVQTgP4qi7lBuWijhgG8pd5w=;
        b=NywOynHs+3fC5vZPqTtB9d0CI7nDvsV08OZ3nJWgTI8Vxb13ITaaQFuNm60XijKoWs
         NL04ENNHO8GHybQdJjgsUluVaJwXr+7Fs+ow09moxXk3yCRUAFVi4iml3qNsu2c1L4fW
         STuB029jvynYHEeo4utZ0DQGN99HO2Gm+dv64+Nug9O3zN6uMTB8wsgk5Mrr4pAXIL6O
         4mzyvTIA2XaJsMLibSy9GJg3jDlYN728jSjOsimN1RFgaoMGBF1cjwYHkqUDhaxC6GeR
         YNir9yBTaOh+pq1Fda2CbG2yz9oNchoiDwhObFbmk2PEtgRTQuqC4OQZzJrd11cEMJJf
         35Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=RuKtI98TNIO9duKNI1SxVQTgP4qi7lBuWijhgG8pd5w=;
        b=OyTr59gAaLq/KksR803kYt9bu7y3L0A8QtEvRq62lP7OusiW2ipxF+jOXdz468rJpv
         WhNvqVTImujnLmTIRmVUWHGWesHPqJJkOJcPY+9hLwCi5hwgJGSAoz5U6g6JVNPVAAiC
         le+LH43mAImaWoaeKtrozVTy6GdI437w6aguSAgFIcluXlXmVuGj5aHEJmLG7EMirQz9
         pb4pMaeRL4wrPYddbkDgnkXBKWaD8FSJVVW0Dwu8+rlgXadatXfDPQBGClJ/358CYcJY
         fRN7XbFtmsSoJq3HsJrLQ7OJx0THkOv3NJlwj8dVUCwofO7HehCYAeX2PdYQOyzq5C/8
         APlw==
X-Gm-Message-State: AGRZ1gJOuvXZ2itZLZgVOK83haEXuVU0SV6pcuFxCxNtc3L0DbnWMK/y
        fz6Ye9bvDLtxs1dmerFXpXiYfJwQdrQ=
X-Google-Smtp-Source: AJdET5dUDokvLoQwEsLbrZaa5bkvx3neyw8cTpWXblrxOKEPKZXCfqq7L9cHGRFQT4LC1jXMdOVYpQ==
X-Received: by 2002:a50:f98a:: with SMTP id q10-v6mr1566374edn.138.1540983491149;
        Wed, 31 Oct 2018 03:58:11 -0700 (PDT)
Received: from localhost.localdomain ([5.57.50.195])
        by smtp.gmail.com with ESMTPSA id a40-v6sm9041108edd.61.2018.10.31.03.58.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 03:58:10 -0700 (PDT)
From:   Emil Renner Berthing <esmil@mailme.dk>
To:     linux-spi@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Addy Ke <addy.ke@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 10/14] spi: rockchip: set min/max speed
Date:   Wed, 31 Oct 2018 11:57:07 +0100
Message-Id: <20181031105711.19575-11-esmil@mailme.dk>
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

The driver previously checked each transfer if the
requested speed was higher than possible with the
current spi clock rate and raised the clock rate
accordingly.

However, there is no check to see if the spi clock
was actually set that high and no way to dynamically
lower the spi clock rate again.

So it seems any potiential users of this functionality
are better off just setting the spi clock rate at init
using the assigned-clock-rates devicetree property.

Removing this dynamic spi clock rate raising allows
us let the spi framework handle min/max speeds
for us.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 52 +++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index ba60cbcd45c2..d1b3ba2b1532 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -115,6 +115,10 @@
 /* Bit fields in SER, 2bit */
 #define SER_MASK					0x3
 
+/* Bit fields in BAUDR */
+#define BAUDR_SCKDV_MIN				2
+#define BAUDR_SCKDV_MAX				65534
+
 /* Bit fields in SR, 5bit */
 #define SR_MASK						0x1f
 #define SR_BUSY						(1 << 0)
@@ -147,7 +151,7 @@
 #define TXDMA					(1 << 1)
 
 /* sclk_out: spi master internal logic in rk3x can support 50Mhz */
-#define MAX_SCLK_OUT		50000000
+#define MAX_SCLK_OUT				50000000U
 
 /*
  * SPI_CTRLR1 is 16-bits, so we should support lengths of 0xffff + 1. However,
@@ -171,12 +175,11 @@ struct rockchip_spi {
 
 	/*depth of the FIFO buffer */
 	u32 fifo_len;
-	/* max bus freq supported */
-	u32 max_freq;
+	/* frequency of spiclk */
+	u32 freq;
 
 	u8 n_bytes;
 	u32 rsd_nsecs;
-	u32 speed;
 
 	const void *tx;
 	const void *tx_end;
@@ -191,11 +194,6 @@ static inline void spi_enable_chip(struct rockchip_spi *rs, bool enable)
 	writel_relaxed((enable ? 1U : 0U), rs->regs + ROCKCHIP_SPI_SSIENR);
 }
 
-static inline void spi_set_clk(struct rockchip_spi *rs, u16 div)
-{
-	writel_relaxed(div, rs->regs + ROCKCHIP_SPI_BAUDR);
-}
-
 static inline void wait_for_idle(struct rockchip_spi *rs)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(5);
@@ -451,7 +449,6 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 		struct spi_device *spi, struct spi_transfer *xfer,
 		bool use_dma)
 {
-	u32 div = 0;
 	u32 dmacr = 0;
 	int rsd = 0;
 
@@ -477,30 +474,17 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 			dmacr |= RF_DMA_EN;
 	}
 
-	if (WARN_ON(rs->speed > MAX_SCLK_OUT))
-		rs->speed = MAX_SCLK_OUT;
-
-	/* the minimum divisor is 2 */
-	if (rs->max_freq < 2 * rs->speed) {
-		clk_set_rate(rs->spiclk, 2 * rs->speed);
-		rs->max_freq = clk_get_rate(rs->spiclk);
-	}
-
-	/* div doesn't support odd number */
-	div = DIV_ROUND_UP(rs->max_freq, rs->speed);
-	div = (div + 1) & 0xfffe;
-
 	/* Rx sample delay is expressed in parent clock cycles (max 3) */
-	rsd = DIV_ROUND_CLOSEST(rs->rsd_nsecs * (rs->max_freq >> 8),
+	rsd = DIV_ROUND_CLOSEST(rs->rsd_nsecs * (rs->freq >> 8),
 				1000000000 >> 8);
 	if (!rsd && rs->rsd_nsecs) {
 		pr_warn_once("rockchip-spi: %u Hz are too slow to express %u ns delay\n",
-			     rs->max_freq, rs->rsd_nsecs);
+			     rs->freq, rs->rsd_nsecs);
 	} else if (rsd > 3) {
 		rsd = 3;
 		pr_warn_once("rockchip-spi: %u Hz are too fast to express %u ns delay, clamping at %u ns\n",
-			     rs->max_freq, rs->rsd_nsecs,
-			     rsd * 1000000000U / rs->max_freq);
+			     rs->freq, rs->rsd_nsecs,
+			     rsd * 1000000000U / rs->freq);
 	}
 	cr0 |= rsd << CR0_RSD_OFFSET;
 
@@ -520,9 +504,12 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 	writel_relaxed(0, rs->regs + ROCKCHIP_SPI_DMARDLR);
 	writel_relaxed(dmacr, rs->regs + ROCKCHIP_SPI_DMACR);
 
-	spi_set_clk(rs, div);
-
-	dev_dbg(rs->dev, "cr0 0x%x, div %d\n", cr0, div);
+	/* the hardware only supports an even clock divisor, so
+	 * round divisor = spiclk / speed up to nearest even number
+	 * so that the resulting speed is <= the requested speed
+	 */
+	writel_relaxed(2 * DIV_ROUND_UP(rs->freq, 2 * xfer->speed_hz),
+			rs->regs + ROCKCHIP_SPI_BAUDR);
 }
 
 static size_t rockchip_spi_max_transfer_size(struct spi_device *spi)
@@ -551,7 +538,6 @@ static int rockchip_spi_transfer_one(
 		return -EINVAL;
 	}
 
-	rs->speed = xfer->speed_hz;
 	rs->n_bytes = xfer->bits_per_word >> 3;
 
 	rs->tx = xfer->tx_buf;
@@ -631,7 +617,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	spi_enable_chip(rs, false);
 
 	rs->dev = &pdev->dev;
-	rs->max_freq = clk_get_rate(rs->spiclk);
+	rs->freq = clk_get_rate(rs->spiclk);
 
 	if (!of_property_read_u32(pdev->dev.of_node, "rx-sample-delay-ns",
 				  &rsd_nsecs))
@@ -653,6 +639,8 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	master->num_chipselect = ROCKCHIP_SPI_MAX_CS_NUM;
 	master->dev.of_node = pdev->dev.of_node;
 	master->bits_per_word_mask = SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
+	master->min_speed_hz = rs->freq / BAUDR_SCKDV_MAX;
+	master->max_speed_hz = min(rs->freq / BAUDR_SCKDV_MIN, MAX_SCLK_OUT);
 
 	master->set_cs = rockchip_spi_set_cs;
 	master->transfer_one = rockchip_spi_transfer_one;
-- 
2.19.1

