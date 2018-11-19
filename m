Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B549CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0E720823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fRq5yWOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0E720823
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbeKSVhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 16:37:20 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43294 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbeKSVhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 16:37:19 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAJBDwOs073452;
        Mon, 19 Nov 2018 05:13:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542626038;
        bh=cWNNYEoOwBL68ELRI7tx6rZXN0M9WGtvRgFGRIo1fRM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fRq5yWODNPwgmywnBbt9WhmuG+jbNa/oPJYc9s/3aF2E64IkW0Wj7H0XY/hvwDS1c
         FvSFmndyOJOkvg1pLMBWcEfKyAcwVcTYDzGznrNRIKrKWAHlVQDHaBwM1ii4HvU2UQ
         zTPX/2ZPQqrh3xdOlBuLc9a2eODO3DJsUFLI5zX4=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAJBDw7n084450
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Nov 2018 05:13:58 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 19
 Nov 2018 05:13:58 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 19 Nov 2018 05:13:58 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAJBDr11029910;
        Mon, 19 Nov 2018 05:13:56 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <kishon@ti.com>,
        <adrian.hunter@intel.com>, <faiz_abbas@ti.com>
Subject: [PATCH 1/4] mmc: sdhci-omap: Fix DCRC error handling during tuning
Date:   Mon, 19 Nov 2018 16:46:15 +0530
Message-ID: <20181119111618.2745-2-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119111618.2745-1-faiz_abbas@ti.com>
References: <20181119111618.2745-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 88347ce78f23..87138067e334 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -290,7 +290,6 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	u32 start_window = 0, max_window = 0;
 	u8 cur_match, prev_match = 0;
 	u32 length = 0, max_len = 0;
-	u32 ier = host->ier;
 	u32 phase_delay = 0;
 	int ret = 0;
 	u32 reg;
@@ -317,9 +316,7 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	 * during the tuning procedure. So disable it during the
 	 * tuning procedure.
 	 */
-	ier &= ~SDHCI_INT_DATA_CRC;
-	sdhci_writel(host, ier, SDHCI_INT_ENABLE);
-	sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
+	host->ier &= ~SDHCI_INT_DATA_CRC;
 
 	while (phase_delay <= MAX_PHASE_DELAY) {
 		sdhci_omap_set_dll(omap_host, phase_delay);
@@ -366,6 +363,8 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 ret:
 	sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+	/* Reenable forbidden interrupt */
+	host->ier |= SDHCI_INT_DATA_CRC;
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 	return ret;
-- 
2.19.1

