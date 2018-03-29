Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753533AbeC2SZM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 14:25:12 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:36877 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752825AbeC2SYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 14:24:55 -0400
X-Google-Smtp-Source: AIpwx4/X8Vz8Hs468yBVpLteCMzMm9ufARxv62h7/4Gcb5rG6btFqQZfMzFEGVV3QoRWF/xCB6NCKw==
From: oscardagrach <ryan@edited.us>
Cc: oscardagrach <ryan@edited.us>, Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: dw_mmc-k3: Fix DDR52 mode by setting required clock divisor
Date: Thu, 29 Mar 2018 13:24:22 -0500
Message-Id: <20180329182423.21201-1-ryan@edited.us>
X-Mailer: git-send-email 2.11.0
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: oscardagrach <ryan@edited.us>
---
 drivers/mmc/host/dw_mmc-k3.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index 89cdb3d533bb..efc546cb4db8 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -194,8 +194,14 @@ static void dw_mci_hi6220_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 	int ret;
 	unsigned int clock;
 
-	clock = (ios->clock <= 25000000) ? 25000000 : ios->clock;
-
+	/* CLKDIV must be 1 for DDR52/8-bit mode */
+	if (ios->bus_width == MMC_BUS_WIDTH_8 &&
+		ios->timing == MMC_TIMING_MMC_DDR52) {
+		mci_writel(host, CLKDIV, 0x1);
+		clock = ios->clock;
+	} else {
+		clock = (ios->clock <= 25000000) ? 25000000 : ios->clock;
+	}
 	ret = clk_set_rate(host->biu_clk, clock);
 	if (ret)
 		dev_warn(host->dev, "failed to set rate %uHz\n", clock);
-- 
2.11.0
