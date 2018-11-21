Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173EDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D424E21104
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ienI2NNA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D424E21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbeKUVFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 16:05:16 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54816 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbeKUVFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 16:05:15 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wALAVLpX053801;
        Wed, 21 Nov 2018 04:31:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542796281;
        bh=TVuGQAJLBCGDQEo4wUpfbiKWsVPiXETwGfkNgAMd4j8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ienI2NNAk46w+o+NI1MWvGEpEfxv26r8zmrVmcIAifdABYB5VVW80ODhM3QTMeVXA
         9eR/KIoGfCkIck/qGTqfHVqoAkfaCin8AhTsnYVi3WJ3bofiKdqXaiVO4iq0NIjxGP
         UkT+qkjhZDk7lVJdbFOl8+mb3mBQDg9pfp1nU0c0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wALAVLXG110062
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Nov 2018 04:31:21 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 21
 Nov 2018 04:31:20 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 21 Nov 2018 04:31:20 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wALAVECe025951;
        Wed, 21 Nov 2018 04:31:19 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <kishon@ti.com>,
        <adrian.hunter@intel.com>, <faiz_abbas@ti.com>
Subject: [PATCH v2 2/3] mmc: sdhci-omap: Add platform specific reset callback
Date:   Wed, 21 Nov 2018 16:03:56 +0530
Message-ID: <20181121103357.3448-3-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121103357.3448-1-faiz_abbas@ti.com>
References: <20181121103357.3448-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TRM (SPRUIC2C - January 2017 - Revised May 2018 [1]) forbids
assertion of data reset while tuning is happening. Implement a
platform specific callback that takes care of this condition.

[1] http://www.ti.com/lit/pdf/spruic2 Section 25.5.1.2.4

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index d264391616f9..4fad47926743 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -115,6 +115,7 @@ struct sdhci_omap_host {
 
 	struct pinctrl		*pinctrl;
 	struct pinctrl_state	**pinctrl_state;
+	bool			is_tuning;
 };
 
 static void sdhci_omap_start_clock(struct sdhci_omap_host *omap_host);
@@ -322,6 +323,8 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		dcrc_was_enabled = true;
 	}
 
+	omap_host->is_tuning = true;
+
 	while (phase_delay <= MAX_PHASE_DELAY) {
 		sdhci_omap_set_dll(omap_host, phase_delay);
 
@@ -359,9 +362,12 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	phase_delay = max_window + 4 * (max_len >> 1);
 	sdhci_omap_set_dll(omap_host, phase_delay);
 
+	omap_host->is_tuning = false;
+
 	goto ret;
 
 tuning_error:
+	omap_host->is_tuning = false;
 	dev_err(dev, "Tuning failed\n");
 	sdhci_omap_disable_tuning(omap_host);
 
@@ -687,6 +693,18 @@ static void sdhci_omap_set_uhs_signaling(struct sdhci_host *host,
 	sdhci_omap_start_clock(omap_host);
 }
 
+void sdhci_omap_reset(struct sdhci_host *host, u8 mask)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
+
+	/* Don't reset data lines during tuning operation */
+	if (omap_host->is_tuning)
+		mask &= ~SDHCI_RESET_DATA;
+
+	sdhci_reset(host, mask);
+}
+
 static struct sdhci_ops sdhci_omap_ops = {
 	.set_clock = sdhci_omap_set_clock,
 	.set_power = sdhci_omap_set_power,
@@ -695,7 +713,7 @@ static struct sdhci_ops sdhci_omap_ops = {
 	.get_min_clock = sdhci_omap_get_min_clock,
 	.set_bus_width = sdhci_omap_set_bus_width,
 	.platform_send_init_74_clocks = sdhci_omap_init_74_clocks,
-	.reset = sdhci_reset,
+	.reset = sdhci_omap_reset,
 	.set_uhs_signaling = sdhci_omap_set_uhs_signaling,
 };
 
-- 
2.19.1

