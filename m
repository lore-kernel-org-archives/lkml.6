Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE241C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417C12146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 417C12146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbeKUVFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 16:05:14 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45634 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbeKUVFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 16:05:13 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wALAVJZA113317;
        Wed, 21 Nov 2018 04:31:19 -0600
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wALAVII2070881
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Nov 2018 04:31:19 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 21
 Nov 2018 04:31:18 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 21 Nov 2018 04:31:18 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wALAVECd025951;
        Wed, 21 Nov 2018 04:31:17 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <kishon@ti.com>,
        <adrian.hunter@intel.com>, <faiz_abbas@ti.com>
Subject: [PATCH v2 1/3] mmc: sdhci-omap: Fix DCRC error handling during tuning
Date:   Wed, 21 Nov 2018 16:03:55 +0530
Message-ID: <20181121103357.3448-2-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121103357.3448-1-faiz_abbas@ti.com>
References: <20181121103357.3448-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7d33c3581536 ("mmc: sdhci-omap: Workaround for Errata i802")
disabled DCRC interrupts during tuning. This write to the interrupt
enable register gets overwritten in sdhci_prepare_data() and the
interrupt is not in fact disabled. Fix this by disabling the interrupt
in the host->ier variable.

Fixes: 7d33c3581536 ("mmc: sdhci-omap: Workaround for Errata i802")
Cc: <stable@vger.kernel.org>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 88347ce78f23..d264391616f9 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -288,9 +288,9 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	struct device *dev = omap_host->dev;
 	struct mmc_ios *ios = &mmc->ios;
 	u32 start_window = 0, max_window = 0;
+	bool dcrc_was_enabled = false;
 	u8 cur_match, prev_match = 0;
 	u32 length = 0, max_len = 0;
-	u32 ier = host->ier;
 	u32 phase_delay = 0;
 	int ret = 0;
 	u32 reg;
@@ -317,9 +317,10 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	 * during the tuning procedure. So disable it during the
 	 * tuning procedure.
 	 */
-	ier &= ~SDHCI_INT_DATA_CRC;
-	sdhci_writel(host, ier, SDHCI_INT_ENABLE);
-	sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
+	if (host->ier & SDHCI_INT_DATA_CRC) {
+		host->ier &= ~SDHCI_INT_DATA_CRC;
+		dcrc_was_enabled = true;
+	}
 
 	while (phase_delay <= MAX_PHASE_DELAY) {
 		sdhci_omap_set_dll(omap_host, phase_delay);
@@ -366,6 +367,9 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 ret:
 	sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+	/* Reenable forbidden interrupt */
+	if (dcrc_was_enabled)
+		host->ier |= SDHCI_INT_DATA_CRC;
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 	return ret;
-- 
2.19.1

