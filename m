Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758093AbeD0LsC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 07:48:02 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:46572 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758058AbeD0Lr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 07:47:57 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <kishon@ti.com>
Subject: [PATCH v5 07/14] mmc: sdhci: Factor out target_timeout calculation
Date: Fri, 27 Apr 2018 17:17:16 +0530
Message-ID: <20180427114723.2687-8-kishon@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427114723.2687-1-kishon@ti.com>
References: <20180427114723.2687-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Factor out the target_timeout calculation so it can be re-used.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/sdhci.c | 48 +++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 8da118d0d2c4..b229354e5b88 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -709,6 +709,35 @@ static u32 sdhci_sdma_address(struct sdhci_host *host)
 		return sg_dma_address(host->data->sg);
 }
 
+static unsigned int sdhci_target_timeout(struct sdhci_host *host,
+					 struct mmc_command *cmd,
+					 struct mmc_data *data)
+{
+	unsigned int target_timeout;
+
+	/* timeout in us */
+	if (!data) {
+		target_timeout = cmd->busy_timeout * 1000;
+	} else {
+		target_timeout = DIV_ROUND_UP(data->timeout_ns, 1000);
+		if (host->clock && data->timeout_clks) {
+			unsigned long long val;
+
+			/*
+			 * data->timeout_clks is in units of clock cycles.
+			 * host->clock is in Hz.  target_timeout is in us.
+			 * Hence, us = 1000000 * cycles / Hz.  Round up.
+			 */
+			val = 1000000ULL * data->timeout_clks;
+			if (do_div(val, host->clock))
+				target_timeout++;
+			target_timeout += val;
+		}
+	}
+
+	return target_timeout;
+}
+
 static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
 			     bool *too_big)
 {
@@ -732,24 +761,7 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
 		return 0xE;
 
 	/* timeout in us */
-	if (!data)
-		target_timeout = cmd->busy_timeout * 1000;
-	else {
-		target_timeout = DIV_ROUND_UP(data->timeout_ns, 1000);
-		if (host->clock && data->timeout_clks) {
-			unsigned long long val;
-
-			/*
-			 * data->timeout_clks is in units of clock cycles.
-			 * host->clock is in Hz.  target_timeout is in us.
-			 * Hence, us = 1000000 * cycles / Hz.  Round up.
-			 */
-			val = 1000000ULL * data->timeout_clks;
-			if (do_div(val, host->clock))
-				target_timeout++;
-			target_timeout += val;
-		}
-	}
+	target_timeout = sdhci_target_timeout(host, cmd, data);
 
 	/*
 	 * Figure out needed cycles.
-- 
2.17.0
