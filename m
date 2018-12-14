Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF1EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA826206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MG18kJed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbeLNSWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:22:00 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13353 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728388AbeLNSWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:22:00 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c13f4c10000>; Fri, 14 Dec 2018 10:21:53 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 14 Dec 2018 10:21:59 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 14 Dec 2018 10:21:59 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 14 Dec
 2018 18:21:59 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Dec 2018 18:21:59 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c13f4c70000>; Fri, 14 Dec 2018 10:21:59 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <linux-mmc@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V1] mmc: cqhci: DMA Configuration prior to CQE
Date:   Fri, 14 Dec 2018 10:21:55 -0800
Message-ID: <1544811715-23792-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1544811714; bh=uUDoqdpD/nSQgikmY2SmsCqVimcjpnTvl6Fix1QU1BA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=MG18kJedSS9jPa1QSL5DxJN5qH9X8n36qNaf0T42BPortaHQ4sDAI/B620nwoE7b9
         F2oHhKnRzGYB6NrJy9IYNDbDNxl/lIlLg2zbSNJFj6B+5NlyLNERJqbXkQGjjFIW17
         5utMO9Ldr1VVLvpUdNX0Mec/meT8eu2F7TGFxYfm8KdqNd1dftSp50MDbb94KpK9VZ
         G60OnqdMGCEN6G5xY29/rNDMgEXy/EdqMdhuPOXYr8OwkbAidC/EhdMX0dmvh//rvC
         qMiyRy5BB5wJGDen4jCKS+8VsH00XyYhs8F4HMLHOcv8GWhn8XLzkvkbFCemz6CasJ
         JV02g7eb4EpJA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

eMMC-5.1 JESD85-B51 Spec (Section 6.6.39), mentions DMA selection
and DMA Block size configuration on SDHCI Host need to be done
prior to enabling Command Queue Engine.

This patch fixes the sequence to follow the spec.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/cqhci.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index 159270e947cf..f701342e7212 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -248,6 +248,9 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
 		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
 	}
 
+	if (cq_host->ops->enable)
+		cq_host->ops->enable(mmc);
+
 	cqcfg &= ~(CQHCI_DCMD | CQHCI_TASK_DESC_SZ);
 
 	if (mmc->caps2 & MMC_CAP2_CQE_DCMD)
@@ -273,9 +276,6 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
 
 	mmc->cqe_on = true;
 
-	if (cq_host->ops->enable)
-		cq_host->ops->enable(mmc);
-
 	/* Ensure all writes are done before interrupts are enabled */
 	wmb();
 
@@ -561,6 +561,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	int tag = cqhci_tag(mrq);
 	struct cqhci_host *cq_host = mmc->cqe_private;
 	unsigned long flags;
+	u32 cqcfg = 0;
 
 	if (!cq_host->enabled) {
 		pr_err("%s: cqhci: not enabled\n", mmc_hostname(mmc));
@@ -579,8 +580,19 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 			pr_err("%s: cqhci: CQE failed to exit halt state\n",
 			       mmc_hostname(mmc));
 		}
+		/* Configuration must not be changed while enabled */
+		cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
+		if (cqcfg & CQHCI_ENABLE) {
+			cqcfg &= ~CQHCI_ENABLE;
+			cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
+		}
+
 		if (cq_host->ops->enable)
 			cq_host->ops->enable(mmc);
+
+		cqcfg |= CQHCI_ENABLE;
+		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
+
 	}
 
 	if (mrq->data) {
-- 
2.7.4

