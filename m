Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932168AbeB0Nzj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 08:55:39 -0500
Received: from relmlor4.renesas.com ([210.160.252.174]:48786 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932129AbeB0Nzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 08:55:37 -0500
X-IronPort-AV: E=Sophos;i="5.47,401,1515423600";
   d="scan'208";a="272286558"
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Michal Simek <michal.simek@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH] mmc: sdhci-of-arasan: Add quirk to avoid erroneous msg
Date: Tue, 27 Feb 2018 13:55:31 +0000
Message-Id: <1519739731-27920-1-git-send-email-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the controller does not support the end-of-busy IRQ, don't use it.
Otherwise, on older SD cards you will get lots of these messages:
"mmc0: Got data interrupt 0x00000002 even though no data operation was in progress"

This has been reported on Xilinx devices that also use the Arasan IP.
See https://patchwork.kernel.org/patch/8062871/

This has been tested on the Renesas RZ/ND-DB board with the RZ/N1 SoC.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index c33a5f7..ab66e32 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -290,7 +290,8 @@ static const struct sdhci_pltfm_data sdhci_arasan_pdata = {
 	.ops = &sdhci_arasan_ops,
 	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
-			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
+			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
+			SDHCI_QUIRK2_STOP_WITH_TC,
 };
 
 static u32 sdhci_arasan_cqhci_irq(struct sdhci_host *host, u32 intmask)
-- 
2.7.4
