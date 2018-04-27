Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758109AbeD0LsI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 07:48:08 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:46580 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757530AbeD0LsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 07:48:03 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <kishon@ti.com>
Subject: [PATCH v5 09/14] mmc: sdhci-omap: Workaround for Errata i834
Date: Fri, 27 Apr 2018 17:17:18 +0530
Message-ID: <20180427114723.2687-10-kishon@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427114723.2687-1-kishon@ti.com>
References: <20180427114723.2687-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Errata i834 in AM572x Sitara Processors Silicon Revision 2.0, 1.1
(SPRZ429K July 2014–Revised March 2017 [1]) mentions the maximum
obtainable timeout through MMC host controller is 700ms. And for
commands taking longer than 700ms, hardware timeout should be
disabled and software timeout should be used.

The workaround for Errata i834 can be achieved by adding
SDHCI_QUIRK2_DISABLE_HW_TIMEOUT quirk in sdhci-omap.

[1] -> http://www.ti.com/lit/er/sprz429k/sprz429k.pdf

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-omap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index d5c1a9c71f95..2232a9974b21 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -715,7 +715,8 @@ static const struct sdhci_pltfm_data sdhci_omap_pdata = {
 		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC,
 	.quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN |
 		   SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
-		   SDHCI_QUIRK2_RSP_136_HAS_CRC,
+		   SDHCI_QUIRK2_RSP_136_HAS_CRC |
+		   SDHCI_QUIRK2_DISABLE_HW_TIMEOUT,
 	.ops = &sdhci_omap_ops,
 };
 
-- 
2.17.0
