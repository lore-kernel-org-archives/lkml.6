Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F230ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 20:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA49E2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 20:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA49E2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbeIOBVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 21:21:44 -0400
Received: from mail.ispras.ru ([83.149.199.45]:36322 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbeIOBVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 21:21:44 -0400
Received: from localhost.localdomain (unknown [85.140.178.24])
        by mail.ispras.ru (Postfix) with ESMTPSA id 6EAD9540093;
        Fri, 14 Sep 2018 23:05:42 +0300 (MSK)
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
To:     Mark Brown <broonie@kernel.org>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] spi: pic32-sqi: remove unnecessary of_node_get()
Date:   Fri, 14 Sep 2018 23:05:34 +0300
Message-Id: <1536955534-22978-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Almost all spi drivers assign spi master->dev.of_node from
its parent platform device without additional refcounting.
It seems of_node_get() in pic32_sqi_probe() is unnecessary
and there is no corresponding of_node_put().

Found by Linux Driver Verification project (linuxtesting.org)

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/spi/spi-pic32-sqi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pic32-sqi.c b/drivers/spi/spi-pic32-sqi.c
index bd1c6b53283f..62e6bf1f50b1 100644
--- a/drivers/spi/spi-pic32-sqi.c
+++ b/drivers/spi/spi-pic32-sqi.c
@@ -656,7 +656,7 @@ static int pic32_sqi_probe(struct platform_device *pdev)
 	master->max_speed_hz	= clk_get_rate(sqi->base_clk);
 	master->dma_alignment	= 32;
 	master->max_dma_len	= PESQI_BD_BUF_LEN_MAX;
-	master->dev.of_node	= of_node_get(pdev->dev.of_node);
+	master->dev.of_node	= pdev->dev.of_node;
 	master->mode_bits	= SPI_MODE_3 | SPI_MODE_0 | SPI_TX_DUAL |
 				  SPI_RX_DUAL | SPI_TX_QUAD | SPI_RX_QUAD;
 	master->flags		= SPI_MASTER_HALF_DUPLEX;
-- 
2.7.4

