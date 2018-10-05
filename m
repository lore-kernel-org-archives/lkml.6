Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAB9C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6402120834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6402120834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbeJEUXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 16:23:05 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:34902 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728814AbeJEUXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 16:23:05 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w95DIwan012080;
        Fri, 5 Oct 2018 15:23:32 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2mv4mjkj18-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 05 Oct 2018 15:23:32 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4B6F338;
        Fri,  5 Oct 2018 13:23:30 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 28CEE2C92;
        Fri,  5 Oct 2018 13:23:30 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 5 Oct 2018
 15:23:30 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 5 Oct 2018
 15:23:29 +0200
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH V5 07/24] mmc: mmci: add dma_start callback
Date:   Fri, 5 Oct 2018 15:22:45 +0200
Message-ID: <1538745782-27446-8-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538745782-27446-1-git-send-email-ludovic.Barre@st.com>
References: <1538745782-27446-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-05_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds dma_start callback to mmci_host_ops.
Create a generic mmci_dma_start function which regroup
common action between variant.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c          | 69 +++++++++++++++++++++++-----------------
 drivers/mmc/host/mmci.h          |  2 ++
 drivers/mmc/host/mmci_qcom_dml.c |  1 +
 3 files changed, 42 insertions(+), 30 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 074350e1..6a2966a 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -421,6 +421,41 @@ void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
 		host->ops->get_next_data(host, data);
 }
 
+int mmci_dma_start(struct mmci_host *host, unsigned int datactrl)
+{
+	struct mmc_data *data = host->data;
+	int ret;
+
+	if (!host->use_dma)
+		return -EINVAL;
+
+	ret = mmci_prep_data(host, data, false);
+	if (ret)
+		return ret;
+
+	if (!host->ops || !host->ops->dma_start)
+		return -EINVAL;
+
+	/* Okay, go for it. */
+	dev_vdbg(mmc_dev(host->mmc),
+		 "Submit MMCI DMA job, sglen %d blksz %04x blks %04x flags %08x\n",
+		 data->sg_len, data->blksz, data->blocks, data->flags);
+
+	host->ops->dma_start(host, &datactrl);
+
+	/* Trigger the DMA transfer */
+	mmci_write_datactrlreg(host, datactrl);
+
+	/*
+	 * Let the MMCI say when the data is ended and it's time
+	 * to fire next DMA request. When that happens, MMCI will
+	 * call mmci_data_end()
+	 */
+	writel(readl(host->base + MMCIMASK0) | MCI_DATAENDMASK,
+	       host->base + MMCIMASK0);
+	return 0;
+}
+
 static void
 mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 {
@@ -730,23 +765,11 @@ int mmci_dmae_prep_data(struct mmci_host *host,
 				    &dmae->desc_current);
 }
 
-static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
+int mmci_dmae_start(struct mmci_host *host, unsigned int *datactrl)
 {
-	int ret;
 	struct mmci_dmae_priv *dmae = host->dma_priv;
 	struct mmc_data *data = host->data;
 
-	if (!host->use_dma)
-		return -EINVAL;
-
-	ret = mmci_dmae_prep_data(host, host->data, false);
-	if (ret)
-		return ret;
-
-	/* Okay, go for it. */
-	dev_vdbg(mmc_dev(host->mmc),
-		 "Submit MMCI DMA job, sglen %d blksz %04x blks %04x flags %08x\n",
-		 data->sg_len, data->blksz, data->blocks, data->flags);
 	host->dma_in_progress = true;
 	dmaengine_submit(dmae->desc_current);
 	dma_async_issue_pending(dmae->cur);
@@ -754,18 +777,8 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 	if (host->variant->qcom_dml)
 		dml_start_xfer(host, data);
 
-	datactrl |= MCI_DPSM_DMAENABLE;
+	*datactrl |= MCI_DPSM_DMAENABLE;
 
-	/* Trigger the DMA transfer */
-	mmci_write_datactrlreg(host, datactrl);
-
-	/*
-	 * Let the MMCI say when the data is ended and it's time
-	 * to fire next DMA request. When that happens, MMCI will
-	 * call mmci_data_end()
-	 */
-	writel(readl(host->base + MMCIMASK0) | MCI_DATAENDMASK,
-	       host->base + MMCIMASK0);
 	return 0;
 }
 
@@ -824,6 +837,7 @@ static struct mmci_host_ops mmci_variant_ops = {
 	.get_next_data = mmci_dmae_get_next_data,
 	.dma_setup = mmci_dmae_setup,
 	.dma_release = mmci_dmae_release,
+	.dma_start = mmci_dmae_start,
 };
 
 void mmci_variant_init(struct mmci_host *host)
@@ -841,11 +855,6 @@ static inline void mmci_dma_data_error(struct mmci_host *host)
 {
 }
 
-static inline int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
-{
-	return -ENOSYS;
-}
-
 #endif
 
 static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
@@ -942,7 +951,7 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	 * Attempt to use DMA operation mode, if this
 	 * should fail, fall back to PIO mode
 	 */
-	if (!mmci_dma_start_data(host, datactrl))
+	if (!mmci_dma_start(host, datactrl))
 		return;
 
 	/* IRQ mode, map the SG list for CPU reading/writing */
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index acaf343..bbdfa26 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -280,6 +280,7 @@ struct mmci_host_ops {
 	void (*get_next_data)(struct mmci_host *host, struct mmc_data *data);
 	int (*dma_setup)(struct mmci_host *host);
 	void (*dma_release)(struct mmci_host *host);
+	int (*dma_start)(struct mmci_host *host, unsigned int *datactrl);
 };
 
 struct mmci_host {
@@ -347,4 +348,5 @@ void mmci_dmae_unprep_data(struct mmci_host *host, struct mmc_data *data,
 void mmci_dmae_get_next_data(struct mmci_host *host, struct mmc_data *data);
 int mmci_dmae_setup(struct mmci_host *host);
 void mmci_dmae_release(struct mmci_host *host);
+int mmci_dmae_start(struct mmci_host *host, unsigned int *datactrl);
 
diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
index 5334427..ae1c193 100644
--- a/drivers/mmc/host/mmci_qcom_dml.c
+++ b/drivers/mmc/host/mmci_qcom_dml.c
@@ -188,6 +188,7 @@ static struct mmci_host_ops qcom_variant_ops = {
 	.get_next_data = mmci_dmae_get_next_data,
 	.dma_setup = qcom_dma_setup,
 	.dma_release = mmci_dmae_release,
+	.dma_start = mmci_dmae_start,
 };
 
 void qcom_variant_init(struct mmci_host *host)
-- 
2.7.4

