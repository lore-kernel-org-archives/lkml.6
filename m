Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12502C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A5C208E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJZslMiX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A5C208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeHOV6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 17:58:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39436 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeHOV6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 17:58:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id h10-v6so1982129wre.6;
        Wed, 15 Aug 2018 12:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oEX5gOHx1pvpWmHV8PDVMKcDGJJZXRTMhlxb0kQd9KY=;
        b=lJZslMiXAGLU/gYCC6waevoG4BqD8Px0MJaPg+Zu2eoVNSjoUruAzckH36NJqvp5Rk
         RXqILH37jPUGk0zy8HcAtCNA8CLG7rVz5FqB84ZK91xlw7/V7V6AuGmHYdAQ2GO97bGY
         Kvvyx9WZX2hBTf5l7iwA9ObbT4tOfx+5OdgYGOaQPHCEKbQbN9dyisYXEFMpbioQ03+M
         jCFSn+qyaAAWzaGgRgy+Ak1FLXeCMcuUFS4fSjux6LL4k0xyx3jrMmt4D9lsaSvy9JMA
         +/MeSeErsO0YgjeRSW7c8gC9QOlgxl/FjPc7FpaioQ7TxaMQYjAqCeM/aYXmUq1smI8i
         o8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oEX5gOHx1pvpWmHV8PDVMKcDGJJZXRTMhlxb0kQd9KY=;
        b=MW2vkgzT4z7dIO1+G45qc2N3K385F4gKojFDihiM3+Fm+T87xaWzWkocFLMFfcqS0Y
         +cRVS8uIfhuYeSZ9apgt3gOVUcrn6y6965JpWOqVqjJXZqNRB2Pnsl6XI9pVk+4HJDfy
         7RQYl0OrPL6FIV0bnEskZnRWzv4BUdqAS4eCz88E8QyqC1LhHJKGO+B6YYiNMy4pfKHb
         /tduTsS8gtazJt1n8UbVOero0VXJ9gAVL6TbLm7rXNAfTiuATMAa5DAiGZjGHN2zoqvs
         /9zE98s8cAfjgrHOtlC4dhJRUMb410TA8x7WHRMrwHCC7yJ+mBkFmB3tik4TU5penXrL
         vNFQ==
X-Gm-Message-State: AOUpUlHx0k2fdQp1B3S+Sllx/l3YSugBhViwlRPUZsvxYR+LNSSQ/F6B
        N/1ZO0t87c83De4KQGUVGsSJsh0m
X-Google-Smtp-Source: AA+uWPz1avyre1AVmE/An5Vy0raEHZSFhWyJn9NhEPKVq4gFvjLrcsu7q4jP9DIn8eDjn8LCW1hSRQ==
X-Received: by 2002:adf:8276:: with SMTP id 109-v6mr17622835wrb.127.1534359902085;
        Wed, 15 Aug 2018 12:05:02 -0700 (PDT)
Received: from kostamach.yok.int.mrv.com (194-90-138-234.bb.netvision.net.il. [194.90.138.234])
        by smtp.gmail.com with ESMTPSA id v5-v6sm31079610wrp.87.2018.08.15.12.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 12:05:00 -0700 (PDT)
From:   Kosta Zertsekel <zertsekel@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kosta Zertsekel <zertsekel@gmail.com>,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
        Stefan Roese <sr@denx.de>, Ken Wilson <ken.wilson@opengear.com>
Subject: [PATCH v4] spi: orion: cosmetics - alias long direct_access variables
Date:   Wed, 15 Aug 2018 22:04:49 +0300
Message-Id: <20180815190449.23738-1-zertsekel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change increases the source code readability.
Instead of using `spi->child[cs].direct_access.XXX` use `dir_acc->XXX`.
Instead of using `orion_spi->child[cs].direct_access.vaddr` use `vaddr`.

Signed-off-by: Kosta Zertsekel <zertsekel@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Stefan Roese <sr@denx.de>
---
 drivers/spi/spi-orion.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index d01a6adc726e..184ba91abeee 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -430,6 +430,7 @@ orion_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
 	int word_len;
 	struct orion_spi *orion_spi;
 	int cs = spi->chip_select;
+	void __iomem *vaddr;
 
 	word_len = spi->bits_per_word;
 	count = xfer->len;
@@ -440,8 +441,9 @@ orion_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
 	 * Use SPI direct write mode if base address is available. Otherwise
 	 * fall back to PIO mode for this transfer.
 	 */
-	if ((orion_spi->child[cs].direct_access.vaddr) && (xfer->tx_buf) &&
-	    (word_len == 8)) {
+	vaddr = orion_spi->child[cs].direct_access.vaddr;
+
+	if (vaddr && xfer->tx_buf && word_len == 8) {
 		unsigned int cnt = count / 4;
 		unsigned int rem = count % 4;
 
@@ -449,13 +451,11 @@ orion_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
 		 * Send the TX-data to the SPI device via the direct
 		 * mapped address window
 		 */
-		iowrite32_rep(orion_spi->child[cs].direct_access.vaddr,
-			      xfer->tx_buf, cnt);
+		iowrite32_rep(vaddr, xfer->tx_buf, cnt);
 		if (rem) {
 			u32 *buf = (u32 *)xfer->tx_buf;
 
-			iowrite8_rep(orion_spi->child[cs].direct_access.vaddr,
-				     &buf[cnt], rem);
+			iowrite8_rep(vaddr, &buf[cnt], rem);
 		}
 
 		return count;
@@ -683,6 +683,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 
 	/* Scan all SPI devices of this controller for direct mapped devices */
 	for_each_available_child_of_node(pdev->dev.of_node, np) {
+		struct orion_direct_acc *dir_acc;
 		u32 cs;
 
 		/* Get chip-select number from the "reg" property */
@@ -711,14 +712,13 @@ static int orion_spi_probe(struct platform_device *pdev)
 		 * This needs to get extended for the direct SPI-NOR / SPI-NAND
 		 * support, once this gets implemented.
 		 */
-		spi->child[cs].direct_access.vaddr = devm_ioremap(&pdev->dev,
-							    r->start,
-							    PAGE_SIZE);
-		if (!spi->child[cs].direct_access.vaddr) {
+		dir_acc = &spi->child[cs].direct_access;
+		dir_acc->vaddr = devm_ioremap(&pdev->dev, r->start, PAGE_SIZE);
+		if (!dir_acc->vaddr) {
 			status = -ENOMEM;
 			goto out_rel_axi_clk;
 		}
-		spi->child[cs].direct_access.size = PAGE_SIZE;
+		dir_acc->size = PAGE_SIZE;
 
 		dev_info(&pdev->dev, "CS%d configured for direct access\n", cs);
 	}
-- 
2.17.1

