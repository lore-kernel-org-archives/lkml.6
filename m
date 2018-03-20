Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752374AbeCTIhV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 04:37:21 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37598 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752277AbeCTIgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 04:36:50 -0400
X-Google-Smtp-Source: AG47ELsV/dBjjXVq9jsZ/PyLzBfUzhaysEwbVZ7XzscqTV2sA+kLMI15mV6iqjKgVITH2IjSC1oF3A==
From: Chunyan Zhang <zhang.chunyan@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Billows Wu <billows.wu@spreadtrum.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 2/3] mmc: sdhci: made changes for SDMA System Address register
Date: Tue, 20 Mar 2018 16:36:25 +0800
Message-Id: <1521534986-21907-3-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521534986-21907-1-git-send-email-zhang.chunyan@linaro.org>
References: <1521534986-21907-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the SD host controller specification version 4.10, when
Host Version 4 is enabled, SDMA uses ADMA System Address register
(05Fh-058h) instead of using SDMA System Address register to
support both 32-bit and 64-bit addressing.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index da4d91e..748a3a3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -805,6 +805,7 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	u8 ctrl;
+	u32 reg;
 	struct mmc_data *data = cmd->data;
 
 	if (sdhci_data_line_cmd(cmd))
@@ -894,8 +895,10 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 					     SDHCI_ADMA_ADDRESS_HI);
 		} else {
 			WARN_ON(sg_cnt != 1);
+			reg = host->v4_mode ? SDHCI_ADMA_ADDRESS :
+				SDHCI_DMA_ADDRESS;
 			sdhci_writel(host, sdhci_sdma_address(host),
-				     SDHCI_DMA_ADDRESS);
+				     reg);
 		}
 	}
 
@@ -2721,6 +2724,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 		 */
 		if (intmask & SDHCI_INT_DMA_END) {
 			u32 dmastart, dmanow;
+			u32 reg;
 
 			dmastart = sdhci_sdma_address(host);
 			dmanow = dmastart + host->data->bytes_xfered;
@@ -2733,7 +2737,9 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 			host->data->bytes_xfered = dmanow - dmastart;
 			DBG("DMA base 0x%08x, transferred 0x%06x bytes, next 0x%08x\n",
 			    dmastart, host->data->bytes_xfered, dmanow);
-			sdhci_writel(host, dmanow, SDHCI_DMA_ADDRESS);
+			reg = host->v4_mode ? SDHCI_ADMA_ADDRESS :
+				SDHCI_DMA_ADDRESS;
+			sdhci_writel(host, dmanow, reg);
 		}
 
 		if (intmask & SDHCI_INT_DATA_END) {
-- 
2.7.4
