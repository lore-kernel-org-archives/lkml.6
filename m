Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7302C46463
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6E8208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6E8208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389123AbeHALWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:22:39 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:40310 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389005AbeHALWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:22:37 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w719TSGi009408;
        Wed, 1 Aug 2018 11:37:33 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2kjnaddbdc-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 11:37:33 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8F49238;
        Wed,  1 Aug 2018 09:37:32 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1DC76289D;
        Wed,  1 Aug 2018 09:37:32 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 1 Aug 2018
 11:37:31 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 1 Aug 2018
 11:37:31 +0200
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH 09/14] mmc: mmci: modify dma_setup callback
Date:   Wed, 1 Aug 2018 11:36:56 +0200
Message-ID: <1533116221-380-10-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533116221-380-1-git-send-email-ludovic.Barre@st.com>
References: <1533116221-380-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch creates a generic mmci_dma_setup which calls
dma_setup callback and manages common next_cookie.
This patch is needed for sdmmc variant which has a different
dma settings.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c          | 25 +++++++++++++------------
 drivers/mmc/host/mmci.h          |  1 +
 drivers/mmc/host/mmci_qcom_dml.c |  2 ++
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 0193da6..ae47d08 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -398,6 +398,17 @@ void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
 		host->ops->get_next_data(host, data);
 }
 
+int mmci_dma_setup(struct mmci_host *host)
+{
+	if (!host->ops || !host->ops->dma_setup)
+		return 0;
+
+	/* initialize pre request cookie */
+	host->next_cookie = 1;
+
+	return host->ops->dma_setup(host);
+}
+
 static void
 mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 {
@@ -472,7 +483,7 @@ struct dmaengine_priv {
 
 #define __dmae_inprogress(dmae) ((dmae)->dma_in_progress)
 
-static int mmci_dma_setup(struct mmci_host *host)
+int mmci_dmae_setup(struct mmci_host *host)
 {
 	const char *rxname, *txname;
 	struct dmaengine_priv *dmae;
@@ -488,9 +499,6 @@ static int mmci_dma_setup(struct mmci_host *host)
 	dmae->dma_tx_channel = dma_request_slave_channel(mmc_dev(host->mmc),
 							 "tx");
 
-	/* initialize pre request cookie */
-	host->next_cookie = 1;
-
 	/*
 	 * If only an RX channel is specified, the driver will
 	 * attempt to use it bidirectionally, however if it is
@@ -531,9 +539,6 @@ static int mmci_dma_setup(struct mmci_host *host)
 			host->mmc->max_seg_size = max_seg_size;
 	}
 
-	if (host->ops && host->ops->dma_setup)
-		return host->ops->dma_setup(host);
-
 	return 0;
 }
 
@@ -793,14 +798,10 @@ static struct mmci_host_ops mmci_variant_ops = {
 	.prepare_data = mmci_dmae_prepare_data,
 	.unprepare_data = mmci_dmae_unprepare_data,
 	.get_next_data = mmci_dmae_get_next_data,
+	.dma_setup = mmci_dmae_setup,
 };
 #else
 /* Blank functions if the DMA engine is not available */
-static inline int mmci_dma_setup(struct mmci_host *host)
-{
-	return 0;
-}
-
 static inline void mmci_dma_release(struct mmci_host *host)
 {
 }
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index bb1e4ba..e1b389c 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -335,3 +335,4 @@ int mmci_dmae_prepare_data(struct mmci_host *host, struct mmc_data *data,
 void mmci_dmae_unprepare_data(struct mmci_host *host,
 			      struct mmc_data *data, int err);
 void mmci_dmae_get_next_data(struct mmci_host *host, struct mmc_data *data);
+int mmci_dmae_setup(struct mmci_host *host);
diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
index e4c505a..47abbdd 100644
--- a/drivers/mmc/host/mmci_qcom_dml.c
+++ b/drivers/mmc/host/mmci_qcom_dml.c
@@ -126,6 +126,8 @@ static int qcom_dma_setup(struct mmci_host *host)
 	int consumer_id, producer_id;
 	struct device_node *np = host->mmc->parent->of_node;
 
+	mmci_dmae_setup(host);
+
 	consumer_id = of_get_dml_pipe_index(np, "tx");
 	producer_id = of_get_dml_pipe_index(np, "rx");
 
-- 
2.7.4

