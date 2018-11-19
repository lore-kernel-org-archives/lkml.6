Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F2CC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69FAC20823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Hfh/+nPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69FAC20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbeKSVhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 16:37:21 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51254 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728557AbeKSVhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 16:37:20 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAJBE0FF012075;
        Mon, 19 Nov 2018 05:14:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542626040;
        bh=hGlv/j2mgo0IqfMNeBzcf1ERreS0YZu4S7pBXKqnd8U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Hfh/+nPqKYLjgSOaYKp1i6NENFKwfBccCPHDyr5KvbQu3biE0ubDUSWrcdNJkmz+f
         6a6iY6x1OlkFJpEn21N2NREM/4yoGRGp/bVAUmfH7iKV8lraboPzUuOXGFICo9adeK
         jfVKcnoPXnEyyQuNpLWqKBMtko7TVG/Sc4Nv2Yy0=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAJBE0Pf084479
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Nov 2018 05:14:00 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 19
 Nov 2018 05:14:00 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 19 Nov 2018 05:14:00 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAJBDr12029910;
        Mon, 19 Nov 2018 05:13:58 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <kishon@ti.com>,
        <adrian.hunter@intel.com>, <faiz_abbas@ti.com>
Subject: [PATCH 2/4] mmc: sdhci-omap: Add variable to indicate host is tuning
Date:   Mon, 19 Nov 2018 16:46:16 +0530
Message-ID: <20181119111618.2745-3-faiz_abbas@ti.com>
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

Add a variable in sdhc_omap_host to indicate whether a tuning
operation is ongoing.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 87138067e334..cfffcf58be3f 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -115,6 +115,7 @@ struct sdhci_omap_host {
 
 	struct pinctrl		*pinctrl;
 	struct pinctrl_state	**pinctrl_state;
+	bool			is_tuning;
 };
 
 static void sdhci_omap_start_clock(struct sdhci_omap_host *omap_host);
@@ -318,6 +319,8 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	 */
 	host->ier &= ~SDHCI_INT_DATA_CRC;
 
+	omap_host->is_tuning = true;
+
 	while (phase_delay <= MAX_PHASE_DELAY) {
 		sdhci_omap_set_dll(omap_host, phase_delay);
 
@@ -355,9 +358,12 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	phase_delay = max_window + 4 * (max_len >> 1);
 	sdhci_omap_set_dll(omap_host, phase_delay);
 
+	omap_host->is_tuning = false;
+
 	goto ret;
 
 tuning_error:
+	omap_host->is_tuning = false;
 	dev_err(dev, "Tuning failed\n");
 	sdhci_omap_disable_tuning(omap_host);
 
-- 
2.19.1

