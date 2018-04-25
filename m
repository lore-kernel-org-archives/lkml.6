Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753290AbeDYMKY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 08:10:24 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:60380 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753089AbeDYMKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 08:10:12 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC: <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Subject: [PATCH v4 05/12] mmc: sdhci: Disable HS200/HS400 mode if controller can't support 1.8v
Date: Wed, 25 Apr 2018 17:39:30 +0530
Message-ID: <20180425120937.29867-6-kishon@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425120937.29867-1-kishon@ti.com>
References: <20180425120937.29867-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Though MMC controller can indicate HS200/HS400 mode capability (by
using "mmc-hs200-1_8v"/"mmc-hs400-1_8v" dt property), if the IO lines
in the board is connected to 3.3v supply, HS200/HS400 mode cannot be
supported. Such boards have "no-1-8-v" property in their dts file.
Disable HS200/HS400 mode for boards which have "no-1-8-v" set.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/sdhci.c | 1 +
 include/linux/mmc/host.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2ededa7f43df..b5f047b5f3ae 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3672,6 +3672,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 	if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V) {
 		host->caps1 &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
 				 SDHCI_SUPPORT_DDR50);
+		mmc->caps2 &= ~MMC_CAP2_HSX00_1_8V;
 	}
 
 	/* Any UHS-I mode in caps implies SDR12 and SDR25 support. */
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 7c6eaf63f5ce..58832451767b 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -345,6 +345,7 @@ struct mmc_host {
 #define MMC_CAP2_HS400_1_2V	(1 << 16)	/* Can support HS400 1.2V */
 #define MMC_CAP2_HS400		(MMC_CAP2_HS400_1_8V | \
 				 MMC_CAP2_HS400_1_2V)
+#define MMC_CAP2_HSX00_1_8V	(MMC_CAP2_HS200_1_8V_SDR | MMC_CAP2_HS400_1_8V)
 #define MMC_CAP2_HSX00_1_2V	(MMC_CAP2_HS200_1_2V_SDR | MMC_CAP2_HS400_1_2V)
 #define MMC_CAP2_SDIO_IRQ_NOTHREAD (1 << 17)
 #define MMC_CAP2_NO_WRITE_PROTECT (1 << 18)	/* No physical write protect pin, assume that card is always read-write */
-- 
2.17.0
