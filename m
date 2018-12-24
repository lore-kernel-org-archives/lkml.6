Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C05BC64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FC121850
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXj24lQA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbeLXWBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 17:01:18 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33723 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeLXWBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 17:01:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so12557983wrr.0;
        Mon, 24 Dec 2018 14:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lg3SjSsw6XzDVNtRx34Fimx4YGg93H0qpcMPwY3lknE=;
        b=nXj24lQARTnuHQtOomrgtCZNKdrS2uKVHw8iswdOciEkjz2mge6aF7ywLun/VfZGMw
         u0pR/GfxLvxBY5x/vYw/5fWuOxFwjdyBMnzHl9wiPFks5WIZk9CxRR/ShUr64KzTq969
         g5MkSFr0r0qqQlVnfuo4L6NV1/5Plh0oqvXxHvbSgA2qTmmf4uwxd2qCRH8H3dt3Ojc4
         SNMo1jT/h6govxRVcR8LKl0BZJV7PnfqwewfZ3K44OgnHN9WqX8wEohjkq8gGkf1zg7Q
         +C92r1/vTPIE4OA1dfcLqKJkUIDrz2WMQ4L1+XRdQENIDH00qZ1yEgLEFSu3wtZ0l+lX
         bphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Lg3SjSsw6XzDVNtRx34Fimx4YGg93H0qpcMPwY3lknE=;
        b=QrA0fuc2V+cVS2xHcAE2rdksIm8+TTdkiQ44CeO5s790n2JcWZuDtgauP1KCNdQnG4
         0Xs+LR9JwL7oePftcoPMxJeCFIOoIo70G8BtFQchZmhBq13sRt/MVICLpILjqb9xz+dz
         Wjst/+3hdvPvJ392g06tDC8ld9+LqUK62i9TDvxVQMQzeS14zoVW7SznFG5yyYFMpL+5
         nJXEjQuJj5VLb1/YpvVeQX3g5OpCeQdfqXIqWnLx8fYWw2grxQtK6rCJ+uvyJ6UgjZHb
         voTMPPA7iNShzzljky9X5/q90ZZ8skok5UjrTYs6n0/HYAvS8I59QlItVSMclZqj/Wes
         1t5A==
X-Gm-Message-State: AJcUukfukvYnS5ByC5533c7AztCvBEi6W1dDp8NvfP6tMoJl+mqOm87O
        9OPnsR0Fz9A9cStOnkskjVA=
X-Google-Smtp-Source: ALg8bN4hx95NOR2W7oMtWFJ4+pLv6NEMqsw+bBJpCqexQ3aWc0wEbtVu1mx1ctDaCv8Ukd5MhgDxQQ==
X-Received: by 2002:a5d:5208:: with SMTP id j8mr13666167wrv.188.1545688867377;
        Mon, 24 Dec 2018 14:01:07 -0800 (PST)
Received: from gapa-Lenovo-IdeaPad-Y580.home (daw20.neoplus.adsl.tpnet.pl. [83.23.22.20])
        by smtp.gmail.com with ESMTPSA id d4sm23970153wrp.89.2018.12.24.14.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Dec 2018 14:01:06 -0800 (PST)
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
Subject: [PATCH v2 09/14] spi: stm32: split transfer one setup function
Date:   Mon, 24 Dec 2018 23:00:35 +0100
Message-Id: <1545688840-23992-10-git-send-email-cezary.gapinski@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
References: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

Split stm32_spi_transfer_one_setup function into smaller chunks
to be more generic for other stm32 SPI family drivers.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
---
 drivers/spi/spi-stm32.c | 270 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 192 insertions(+), 78 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 9cb7d33..bc8513f 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -101,11 +101,18 @@
 #define STM32H7_SPI_MBR_DIV_MIN		(2 << STM32H7_SPI_CFG1_MBR_MIN)
 #define STM32H7_SPI_MBR_DIV_MAX		(2 << STM32H7_SPI_CFG1_MBR_MAX)
 
-/* SPI Communication mode */
+/* STM32H7 SPI Communication mode */
+#define STM32H7_SPI_FULL_DUPLEX		0
+#define STM32H7_SPI_SIMPLEX_TX		1
+#define STM32H7_SPI_SIMPLEX_RX		2
+#define STM32H7_SPI_HALF_DUPLEX		3
+
+/* SPI Communication type */
 #define SPI_FULL_DUPLEX		0
 #define SPI_SIMPLEX_TX		1
 #define SPI_SIMPLEX_RX		2
-#define SPI_HALF_DUPLEX		3
+#define SPI_3WIRE_TX		3
+#define SPI_3WIRE_RX		4
 
 #define SPI_1HZ_NS		1000000000
 
@@ -232,13 +239,16 @@ static int stm32_spi_get_bpw_mask(struct stm32_spi *spi)
 }
 
 /**
- * stm32_spi_prepare_mbr - Determine SPI_CFG1.MBR value
+ * stm32_spi_prepare_mbr - Determine baud rate divisor value
  * @spi: pointer to the spi controller data structure
  * @speed_hz: requested speed
+ * @min_div: minimum baud rate divisor
+ * @max_div: maximum baud rate divisor
  *
- * Return SPI_CFG1.MBR value in case of success or -EINVAL
+ * Return baud rate divisor value in case of success or -EINVAL
  */
-static int stm32_spi_prepare_mbr(struct stm32_spi *spi, u32 speed_hz)
+static int stm32_spi_prepare_mbr(struct stm32_spi *spi, u32 speed_hz,
+				 u32 min_div, u32 max_div)
 {
 	u32 div, mbrdiv;
 
@@ -251,8 +261,7 @@ static int stm32_spi_prepare_mbr(struct stm32_spi *spi, u32 speed_hz)
 	 * no need to check it there.
 	 * However, we need to ensure the following calculations.
 	 */
-	if (div < STM32H7_SPI_MBR_DIV_MIN ||
-	    div > STM32H7_SPI_MBR_DIV_MAX)
+	if ((div < min_div) || (div > max_div))
 		return -EINVAL;
 
 	/* Determine the first power of 2 greater than or equal to div */
@@ -802,7 +811,8 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 	}
 
 	if (tx_dma_desc) {
-		if (spi->cur_comm == SPI_SIMPLEX_TX) {
+		if (spi->cur_comm == SPI_SIMPLEX_TX ||
+		    spi->cur_comm == SPI_3WIRE_TX) {
 			tx_dma_desc->callback = stm32_spi_dma_cb;
 			tx_dma_desc->callback_param = spi;
 		}
@@ -848,92 +858,130 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 }
 
 /**
- * stm32_spi_transfer_one_setup - common setup to transfer a single
- *				  spi_transfer either using DMA or
- *				  interrupts.
+ * stm32_spi_set_bpw - configure bits per word
+ * @spi: pointer to the spi controller data structure
  */
-static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
-					struct spi_device *spi_dev,
-					struct spi_transfer *transfer)
+static void stm32_spi_set_bpw(struct stm32_spi *spi)
 {
-	unsigned long flags;
-	u32 cfg1_clrb = 0, cfg1_setb = 0, cfg2_clrb = 0, cfg2_setb = 0;
-	u32 mode, nb_words;
-	int ret = 0;
+	u32 bpw, fthlv;
+	u32 cfg1_clrb = 0, cfg1_setb = 0;
 
-	spin_lock_irqsave(&spi->lock, flags);
+	bpw = spi->cur_bpw - 1;
 
-	if (spi->cur_bpw != transfer->bits_per_word) {
-		u32 bpw, fthlv;
-
-		spi->cur_bpw = transfer->bits_per_word;
-		bpw = spi->cur_bpw - 1;
+	cfg1_clrb |= STM32H7_SPI_CFG1_DSIZE;
+	cfg1_setb |= (bpw << STM32H7_SPI_CFG1_DSIZE_SHIFT) &
+		     STM32H7_SPI_CFG1_DSIZE;
 
-		cfg1_clrb |= STM32H7_SPI_CFG1_DSIZE;
-		cfg1_setb |= (bpw << STM32H7_SPI_CFG1_DSIZE_SHIFT) &
-			     STM32H7_SPI_CFG1_DSIZE;
+	spi->cur_fthlv = stm32_spi_prepare_fthlv(spi);
+	fthlv = spi->cur_fthlv - 1;
 
-		spi->cur_fthlv = stm32_spi_prepare_fthlv(spi);
-		fthlv = spi->cur_fthlv - 1;
+	cfg1_clrb |= STM32H7_SPI_CFG1_FTHLV;
+	cfg1_setb |= (fthlv << STM32H7_SPI_CFG1_FTHLV_SHIFT) &
+		     STM32H7_SPI_CFG1_FTHLV;
 
-		cfg1_clrb |= STM32H7_SPI_CFG1_FTHLV;
-		cfg1_setb |= (fthlv << STM32H7_SPI_CFG1_FTHLV_SHIFT) &
-			     STM32H7_SPI_CFG1_FTHLV;
-	}
-
-	if (spi->cur_speed != transfer->speed_hz) {
-		int mbr;
+	writel_relaxed(
+		(readl_relaxed(spi->base + STM32H7_SPI_CFG1) &
+		 ~cfg1_clrb) | cfg1_setb,
+		spi->base + STM32H7_SPI_CFG1);
+}
 
-		/* Update spi->cur_speed with real clock speed */
-		mbr = stm32_spi_prepare_mbr(spi, transfer->speed_hz);
-		if (mbr < 0) {
-			ret = mbr;
-			goto out;
-		}
+/**
+ * stm32_spi_set_mbr - Configure baud rate divisor in master mode
+ * @spi: pointer to the spi controller data structure
+ * @mbrdiv: baud rate divisor value
+ */
+static void stm32_spi_set_mbr(struct stm32_spi *spi, u32 mbrdiv)
+{
+	u32 cfg1_clrb = 0, cfg1_setb = 0;
 
-		transfer->speed_hz = spi->cur_speed;
+	cfg1_clrb |= STM32H7_SPI_CFG1_MBR;
+	cfg1_setb |= ((u32)mbrdiv << STM32H7_SPI_CFG1_MBR_SHIFT) &
+		STM32H7_SPI_CFG1_MBR;
 
-		cfg1_clrb |= STM32H7_SPI_CFG1_MBR;
-		cfg1_setb |= ((u32)mbr << STM32H7_SPI_CFG1_MBR_SHIFT) &
-			     STM32H7_SPI_CFG1_MBR;
-	}
+	writel_relaxed((readl_relaxed(spi->base + STM32H7_SPI_CFG1) &
+			~cfg1_clrb) | cfg1_setb,
+		       spi->base + STM32H7_SPI_CFG1);
+}
 
-	if (cfg1_clrb || cfg1_setb)
-		writel_relaxed((readl_relaxed(spi->base + STM32H7_SPI_CFG1) &
-				~cfg1_clrb) | cfg1_setb,
-			       spi->base + STM32H7_SPI_CFG1);
+/**
+ * stm32_spi_communication_type - return transfer communication type
+ * @spi_dev: pointer to the spi device
+ * transfer: pointer to spi transfer
+ */
+static unsigned int stm32_spi_communication_type(struct spi_device *spi_dev,
+						 struct spi_transfer *transfer)
+{
+	unsigned int type = SPI_FULL_DUPLEX;
 
-	mode = SPI_FULL_DUPLEX;
 	if (spi_dev->mode & SPI_3WIRE) { /* MISO/MOSI signals shared */
 		/*
 		 * SPI_3WIRE and xfer->tx_buf != NULL and xfer->rx_buf != NULL
-		 * is forbidden und unvalidated by SPI subsystem so depending
+		 * is forbidden and unvalidated by SPI subsystem so depending
 		 * on the valid buffer, we can determine the direction of the
 		 * transfer.
 		 */
-		mode = SPI_HALF_DUPLEX;
 		if (!transfer->tx_buf)
-			stm32_spi_clr_bits(spi, STM32H7_SPI_CR1,
-					   STM32H7_SPI_CR1_HDDIR);
-		else if (!transfer->rx_buf)
-			stm32_spi_set_bits(spi, STM32H7_SPI_CR1,
-					   STM32H7_SPI_CR1_HDDIR);
+			type = SPI_3WIRE_RX;
+		else
+			type = SPI_3WIRE_TX;
 	} else {
 		if (!transfer->tx_buf)
-			mode = SPI_SIMPLEX_RX;
+			type = SPI_SIMPLEX_RX;
 		else if (!transfer->rx_buf)
-			mode = SPI_SIMPLEX_TX;
+			type = SPI_SIMPLEX_TX;
 	}
-	if (spi->cur_comm != mode) {
-		spi->cur_comm = mode;
 
-		cfg2_clrb |= STM32H7_SPI_CFG2_COMM;
-		cfg2_setb |= (mode << STM32H7_SPI_CFG2_COMM_SHIFT) &
-			     STM32H7_SPI_CFG2_COMM;
+	return type;
+}
+
+/**
+ * stm32_spi_set_mode - configure communication mode
+ * @spi: pointer to the spi controller data structure
+ * @comm_type: type of communication to configure
+ */
+static int stm32_spi_set_mode(struct stm32_spi *spi, unsigned int comm_type)
+{
+	u32 mode;
+	u32 cfg2_clrb = 0, cfg2_setb = 0;
+
+	if (comm_type == SPI_3WIRE_RX) {
+		mode = STM32H7_SPI_HALF_DUPLEX;
+		stm32_spi_clr_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_HDDIR);
+	} else if (comm_type == SPI_3WIRE_TX) {
+		mode = STM32H7_SPI_HALF_DUPLEX;
+		stm32_spi_set_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_HDDIR);
+	} else if (comm_type == SPI_SIMPLEX_RX) {
+		mode = STM32H7_SPI_SIMPLEX_RX;
+	} else if (comm_type == SPI_SIMPLEX_TX) {
+		mode = STM32H7_SPI_SIMPLEX_TX;
+	} else {
+		mode = STM32H7_SPI_FULL_DUPLEX;
 	}
 
+	cfg2_clrb |= STM32H7_SPI_CFG2_COMM;
+	cfg2_setb |= (mode << STM32H7_SPI_CFG2_COMM_SHIFT) &
+		     STM32H7_SPI_CFG2_COMM;
+
+	writel_relaxed(
+		(readl_relaxed(spi->base + STM32H7_SPI_CFG2) &
+		 ~cfg2_clrb) | cfg2_setb,
+		spi->base + STM32H7_SPI_CFG2);
+
+	return 0;
+}
+
+/**
+ * stm32_spi_data_idleness - configure minimum time delay inserted between two
+ *			     consecutive data frames in master mode
+ * @spi: pointer to the spi controller data structure
+ * @len: transfer len
+ */
+static void stm32_spi_data_idleness(struct stm32_spi *spi, u32 len)
+{
+	u32 cfg2_clrb = 0, cfg2_setb = 0;
+
 	cfg2_clrb |= STM32H7_SPI_CFG2_MIDI;
-	if ((transfer->len > 1) && (spi->cur_midi > 0)) {
+	if ((len > 1) && (spi->cur_midi > 0)) {
 		u32 sck_period_ns = DIV_ROUND_UP(SPI_1HZ_NS, spi->cur_speed);
 		u32 midi = min((u32)DIV_ROUND_UP(spi->cur_midi, sck_period_ns),
 			       (u32)STM32H7_SPI_CFG2_MIDI >>
@@ -941,15 +989,85 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
 
 		dev_dbg(spi->dev, "period=%dns, midi=%d(=%dns)\n",
 			sck_period_ns, midi, midi * sck_period_ns);
-
 		cfg2_setb |= (midi << STM32H7_SPI_CFG2_MIDI_SHIFT) &
 			     STM32H7_SPI_CFG2_MIDI;
 	}
 
-	if (cfg2_clrb || cfg2_setb)
-		writel_relaxed((readl_relaxed(spi->base + STM32H7_SPI_CFG2) &
-				~cfg2_clrb) | cfg2_setb,
-			       spi->base + STM32H7_SPI_CFG2);
+	writel_relaxed((readl_relaxed(spi->base + STM32H7_SPI_CFG2) &
+			~cfg2_clrb) | cfg2_setb,
+		       spi->base + STM32H7_SPI_CFG2);
+}
+
+/**
+ * stm32_spi_number_of_data - configure number of data at current transfer
+ * @spi: pointer to the spi controller data structure
+ * @len: transfer length
+ */
+static int stm32_spi_number_of_data(struct stm32_spi *spi, u32 nb_words)
+{
+	u32 cr2_clrb = 0, cr2_setb = 0;
+
+	if (nb_words <= (STM32H7_SPI_CR2_TSIZE >>
+			 STM32H7_SPI_CR2_TSIZE_SHIFT)) {
+		cr2_clrb |= STM32H7_SPI_CR2_TSIZE;
+		cr2_setb = nb_words << STM32H7_SPI_CR2_TSIZE_SHIFT;
+		writel_relaxed((readl_relaxed(spi->base + STM32H7_SPI_CR2) &
+				~cr2_clrb) | cr2_setb,
+			       spi->base + STM32H7_SPI_CR2);
+	} else {
+		return -EMSGSIZE;
+	}
+
+	return 0;
+}
+
+/**
+ * stm32_spi_transfer_one_setup - common setup to transfer a single
+ *				  spi_transfer either using DMA or
+ *				  interrupts.
+ */
+static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
+					struct spi_device *spi_dev,
+					struct spi_transfer *transfer)
+{
+	unsigned long flags;
+	unsigned int comm_type;
+	int nb_words, ret = 0;
+
+	spin_lock_irqsave(&spi->lock, flags);
+
+	if (spi->cur_bpw != transfer->bits_per_word) {
+		spi->cur_bpw = transfer->bits_per_word;
+		stm32_spi_set_bpw(spi);
+	}
+
+	if (spi->cur_speed != transfer->speed_hz) {
+		int mbr;
+
+		/* Update spi->cur_speed with real clock speed */
+		mbr = stm32_spi_prepare_mbr(spi, transfer->speed_hz,
+					    STM32H7_SPI_MBR_DIV_MIN,
+					    STM32H7_SPI_MBR_DIV_MAX);
+		if (mbr < 0) {
+			ret = mbr;
+			goto out;
+		}
+
+		transfer->speed_hz = spi->cur_speed;
+		stm32_spi_set_mbr(spi, mbr);
+	}
+
+	comm_type = stm32_spi_communication_type(spi_dev, transfer);
+	if (spi->cur_comm != comm_type) {
+		stm32_spi_set_mode(spi, comm_type);
+
+		if (ret < 0)
+			goto out;
+
+		spi->cur_comm = comm_type;
+	}
+
+	stm32_spi_data_idleness(spi, transfer->len);
 
 	if (spi->cur_bpw <= 8)
 		nb_words = transfer->len;
@@ -957,14 +1075,10 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
 		nb_words = DIV_ROUND_UP(transfer->len * 8, 16);
 	else
 		nb_words = DIV_ROUND_UP(transfer->len * 8, 32);
-	nb_words <<= STM32H7_SPI_CR2_TSIZE_SHIFT;
 
-	if (nb_words <= STM32H7_SPI_CR2_TSIZE) {
-		writel_relaxed(nb_words, spi->base + STM32H7_SPI_CR2);
-	} else {
-		ret = -EMSGSIZE;
+	ret = stm32_spi_number_of_data(spi, nb_words);
+	if (ret < 0)
 		goto out;
-	}
 
 	spi->cur_xferlen = transfer->len;
 
-- 
2.7.4

