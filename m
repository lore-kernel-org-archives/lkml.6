Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031535AbeEZJcF (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 05:32:05 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:41930 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031362AbeEZJcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 05:32:04 -0400
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sat, 26 May 2018 11:32:00 +0200
X-ME-IP: 90.55.202.35
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Paul Parsons <lost.distance@yahoo.com>
Cc: linux-kernel@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH] mfd: asic3: Fix the broken MMC card detection
Date: Sat, 26 May 2018 11:31:50 +0200
Message-Id: <20180526093150.20989-1-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MMC framework requires the ocr_mask to be provided. Without it, the
SD card is not detected, especially on the hx4700 platform.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/mfd/asic3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/asic3.c b/drivers/mfd/asic3.c
index cf2e25ab2940..1531302a50ec 100644
--- a/drivers/mfd/asic3.c
+++ b/drivers/mfd/asic3.c
@@ -31,6 +31,8 @@
 #include <linux/mfd/ds1wm.h>
 #include <linux/mfd/tmio.h>
 
+#include <linux/mmc/host.h>
+
 enum {
 	ASIC3_CLOCK_SPI,
 	ASIC3_CLOCK_OWM,
@@ -719,6 +721,7 @@ static void asic3_mmc_clk_div(struct platform_device *pdev, int state)
 
 static struct tmio_mmc_data asic3_mmc_data = {
 	.hclk           = 24576000,
+	.ocr_mask	= MMC_VDD_32_33 | MMC_VDD_33_34,
 	.set_pwr        = asic3_mmc_pwr,
 	.set_clk_div    = asic3_mmc_clk_div,
 };
-- 
2.11.0
