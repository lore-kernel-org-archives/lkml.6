Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C71C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8050120849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MedEQy1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8050120849
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbeLKOUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:20:17 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37578 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbeLKOUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:20:17 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBBEKE36028121;
        Tue, 11 Dec 2018 08:20:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544538014;
        bh=1bMkRlQJkzdHLIreuhrm8yfni2/SM2vZZaNj3wALKRg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MedEQy1H99fstlM82s08GFadm5cSQip0V/jgM7H20POwQElJQ1fvZNk85X5UgNaRl
         hh2LxZpJWUCdr9ZVQAQMxQvc7BICluv1HucLLAYM9ff+9qjjRjsies8QiYlCD6Jk0z
         j9NDJ9FMb+L7S7h/4bFI85NPW5A77NVh5QZHmCLU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBBEKEMI004345
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Dec 2018 08:20:14 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 11
 Dec 2018 08:20:14 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 11 Dec 2018 08:20:14 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBBEK6ef024675;
        Tue, 11 Dec 2018 08:20:12 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <kishon@ti.com>, <faiz_abbas@ti.com>, <j-keerthy@ti.com>
Subject: [PATCH v2 2/2] mmc: sdhci-omap: Workaround errata regarding SDR104/HS200 tuning failures (i929)
Date:   Tue, 11 Dec 2018 19:52:53 +0530
Message-ID: <20181211142253.23747-3-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211142253.23747-1-faiz_abbas@ti.com>
References: <20181211142253.23747-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Errata i929 in certain OMAP5/DRA7XX/AM57XX silicon revisions
(SPRZ426D - November 2014 - Revised February 2018 [1]) mentions
unexpected tuning pattern errors. A small failure band may be present
in the tuning range which may be missed by the current algorithm.
Furthermore, the failure bands vary with temperature leading to
different optimum tuning values for different temperatures.

As suggested in the related Application Report (SPRACA9B - October 2017
- Revised July 2018 [2]), tuning should be done in two stages.
In stage 1, assign the optimum ratio in the maximum pass window for the
current temperature. In stage 2, if the chosen value is close to the
small failure band, move away from it in the appropriate direction.

References:
[1] http://www.ti.com/lit/pdf/sprz426
[2] http://www.ti.com/lit/pdf/SPRACA9

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/Kconfig      |  2 +
 drivers/mmc/host/sdhci-omap.c | 90 ++++++++++++++++++++++++++++++++++-
 2 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 5fa580cec831..d8f984483ab0 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -977,6 +977,8 @@ config MMC_SDHCI_XENON
 config MMC_SDHCI_OMAP
 	tristate "TI SDHCI Controller Support"
 	depends on MMC_SDHCI_PLTFM && OF
+	select THERMAL
+	select TI_SOC_THERMAL
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  support present in TI's DRA7 SOCs. The controller supports
diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index f588ab679cb0..b75c55011fcb 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -27,6 +27,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/sys_soc.h>
+#include <linux/thermal.h>
 
 #include "sdhci-pltfm.h"
 
@@ -286,15 +287,19 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	struct sdhci_host *host = mmc_priv(mmc);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
+	struct thermal_zone_device *thermal_dev;
 	struct device *dev = omap_host->dev;
 	struct mmc_ios *ios = &mmc->ios;
 	u32 start_window = 0, max_window = 0;
+	bool single_point_failure = false;
 	bool dcrc_was_enabled = false;
 	u8 cur_match, prev_match = 0;
 	u32 length = 0, max_len = 0;
 	u32 phase_delay = 0;
+	int temperature;
 	int ret = 0;
 	u32 reg;
+	int i;
 
 	/* clock tuning is not needed for upto 52MHz */
 	if (ios->clock <= 52000000)
@@ -304,6 +309,16 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	if (ios->timing == MMC_TIMING_UHS_SDR50 && !(reg & CAPA2_TSDR50))
 		return 0;
 
+	thermal_dev = thermal_zone_get_zone_by_name("cpu_thermal");
+	if (IS_ERR(thermal_dev)) {
+		dev_err(dev, "Unable to get thermal zone for tuning\n");
+		return PTR_ERR(thermal_dev);
+	}
+
+	ret = thermal_zone_get_temp(thermal_dev, &temperature);
+	if (ret)
+		return ret;
+
 	reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_DLL);
 	reg |= DLL_SWT;
 	sdhci_omap_writel(omap_host, SDHCI_OMAP_DLL, reg);
@@ -321,6 +336,11 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 	omap_host->is_tuning = true;
 
+	/*
+	 * Stage 1: Search for a maximum pass window ignoring any
+	 * any single point failures. If the tuning value ends up
+	 * near it, move away from it in stage 2 below
+	 */
 	while (phase_delay <= MAX_PHASE_DELAY) {
 		sdhci_omap_set_dll(omap_host, phase_delay);
 
@@ -328,10 +348,15 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		if (cur_match) {
 			if (prev_match) {
 				length++;
+			} else if (single_point_failure) {
+				/* ignore single point failure */
+				length++;
 			} else {
 				start_window = phase_delay;
 				length = 1;
 			}
+		} else {
+			single_point_failure = prev_match;
 		}
 
 		if (length > max_len) {
@@ -349,13 +374,76 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		goto tuning_error;
 	}
 
+	/*
+	 * Assign tuning value as a ratio of maximum pass window based
+	 * on temperature
+	 */
+	if (temperature < -20000)
+		phase_delay = min(max_window + 4 * max_len - 24,
+				  max_window +
+				  DIV_ROUND_UP(13 * max_len, 16) * 4);
+	else if (temperature < 20000)
+		phase_delay = max_window + DIV_ROUND_UP(9 * max_len, 16) * 4;
+	else if (temperature < 40000)
+		phase_delay = max_window + DIV_ROUND_UP(8 * max_len, 16) * 4;
+	else if (temperature < 70000)
+		phase_delay = max_window + DIV_ROUND_UP(7 * max_len, 16) * 4;
+	else if (temperature < 90000)
+		phase_delay = max_window + DIV_ROUND_UP(5 * max_len, 16) * 4;
+	else if (temperature < 120000)
+		phase_delay = max_window + DIV_ROUND_UP(4 * max_len, 16) * 4;
+	else
+		phase_delay = max_window + DIV_ROUND_UP(3 * max_len, 16) * 4;
+
+	/*
+	 * Stage 2: Search for a single point failure near the chosen tuning
+	 * value in two steps. First in the +3 to +10 range and then in the
+	 * +2 to -10 range. If found, move away from it in the appropriate
+	 * direction by the appropriate amount depending on the temperature.
+	 */
+	for (i = 3; i <= 10; i++) {
+		sdhci_omap_set_dll(omap_host, phase_delay + i);
+
+		if (mmc_send_tuning(mmc, opcode, NULL)) {
+			if (temperature < 10000)
+				phase_delay += i + 6;
+			else if (temperature < 20000)
+				phase_delay += i - 12;
+			else if (temperature < 70000)
+				phase_delay += i - 8;
+			else
+				phase_delay += i - 6;
+
+			goto single_failure_found;
+		}
+	}
+
+	for (i = 2; i >= -10; i--) {
+		sdhci_omap_set_dll(omap_host, phase_delay + i);
+
+		if (mmc_send_tuning(mmc, opcode, NULL)) {
+			if (temperature < 10000)
+				phase_delay += i + 12;
+			else if (temperature < 20000)
+				phase_delay += i + 8;
+			else if (temperature < 70000)
+				phase_delay += i + 8;
+			else if (temperature < 90000)
+				phase_delay += i + 10;
+			else
+				phase_delay += i + 12;
+
+			goto single_failure_found;
+		}
+	}
+
+single_failure_found:
 	reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_AC12);
 	if (!(reg & AC12_SCLK_SEL)) {
 		ret = -EIO;
 		goto tuning_error;
 	}
 
-	phase_delay = max_window + 4 * (max_len >> 1);
 	sdhci_omap_set_dll(omap_host, phase_delay);
 
 	omap_host->is_tuning = false;
-- 
2.19.2

