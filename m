Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF26ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851F12064D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851F12064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731995AbeGQO4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:56:49 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42143 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731733AbeGQO4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:56:24 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 68A61208FB; Tue, 17 Jul 2018 16:23:29 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3C135206ED;
        Tue, 17 Jul 2018 16:23:19 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/5] spi: dw: allow providing own set_cs callback
Date:   Tue, 17 Jul 2018 16:23:11 +0200
Message-Id: <20180717142314.32337-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180717142314.32337-1-alexandre.belloni@bootlin.com>
References: <20180717142314.32337-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow platform specific drivers to provide their own set_cs callback when
the IP integration requires it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/spi/spi-dw.c | 3 +++
 drivers/spi/spi-dw.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index a087464efdd7..f76e31faf694 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -507,6 +507,9 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	master->dev.of_node = dev->of_node;
 	master->flags = SPI_MASTER_GPIO_SS;
 
+	if (dws->set_cs)
+		master->set_cs = dws->set_cs;
+
 	/* Basic HW init */
 	spi_hw_init(dev, dws);
 
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 2cde2473b3e9..446013022849 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -112,6 +112,7 @@ struct dw_spi {
 	u32			reg_io_width;	/* DR I/O width in bytes */
 	u16			bus_num;
 	u16			num_cs;		/* supported slave numbers */
+	void (*set_cs)(struct spi_device *spi, bool enable);
 
 	/* Current message transfer state info */
 	size_t			len;
-- 
2.18.0

