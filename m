Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6063EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC9F20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC9F20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389191AbeHALWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:22:45 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:43966 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389066AbeHALWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:22:45 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w719Tav9009421;
        Wed, 1 Aug 2018 11:37:28 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2kjnaddbd4-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 11:37:28 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 410B731;
        Wed,  1 Aug 2018 09:37:28 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1A555288E;
        Wed,  1 Aug 2018 09:37:27 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 1 Aug 2018
 11:37:27 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 1 Aug 2018
 11:37:26 +0200
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH 04/14] mmc: mmci: introduce dma_priv pointer to mmci_host
Date:   Wed, 1 Aug 2018 11:36:51 +0200
Message-ID: <1533116221-380-5-git-send-email-ludovic.Barre@st.com>
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

This patch introduces dma_priv pointer to define specific
needs for each dma engine. This patch is needed to prepare
sdmmc variant with internal dma which not use dmaengine API.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c          | 165 +++++++++++++++++++++++++--------------
 drivers/mmc/host/mmci.h          |  20 +----
 drivers/mmc/host/mmci_qcom_dml.c |   6 +-
 3 files changed, 112 insertions(+), 79 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 8144a87..bdc48c3 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -415,31 +415,57 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
  * no custom DMA interfaces are supported.
  */
 #ifdef CONFIG_DMA_ENGINE
-static void mmci_dma_setup(struct mmci_host *host)
+struct dmaengine_next {
+	struct dma_async_tx_descriptor *dma_desc;
+	struct dma_chan	*dma_chan;
+	s32 cookie;
+};
+
+struct dmaengine_priv {
+	struct dma_chan	*dma_current;
+	struct dma_chan	*dma_rx_channel;
+	struct dma_chan	*dma_tx_channel;
+	struct dma_async_tx_descriptor	*dma_desc_current;
+	struct dmaengine_next next_data;
+	bool dma_in_progress;
+};
+
+#define __dmae_inprogress(dmae) ((dmae)->dma_in_progress)
+
+static int mmci_dma_setup(struct mmci_host *host)
 {
 	const char *rxname, *txname;
+	struct dmaengine_priv *dmae;
 
-	host->dma_rx_channel = dma_request_slave_channel(mmc_dev(host->mmc), "rx");
-	host->dma_tx_channel = dma_request_slave_channel(mmc_dev(host->mmc), "tx");
+	dmae = devm_kzalloc(mmc_dev(host->mmc), sizeof(*dmae), GFP_KERNEL);
+	if (!dmae)
+		return -ENOMEM;
+
+	host->dma_priv = dmae;
+
+	dmae->dma_rx_channel = dma_request_slave_channel(mmc_dev(host->mmc),
+							 "rx");
+	dmae->dma_tx_channel = dma_request_slave_channel(mmc_dev(host->mmc),
+							 "tx");
 
 	/* initialize pre request cookie */
-	host->next_data.cookie = 1;
+	dmae->next_data.cookie = 1;
 
 	/*
 	 * If only an RX channel is specified, the driver will
 	 * attempt to use it bidirectionally, however if it is
 	 * is specified but cannot be located, DMA will be disabled.
 	 */
-	if (host->dma_rx_channel && !host->dma_tx_channel)
-		host->dma_tx_channel = host->dma_rx_channel;
+	if (dmae->dma_rx_channel && !dmae->dma_tx_channel)
+		dmae->dma_tx_channel = dmae->dma_rx_channel;
 
-	if (host->dma_rx_channel)
-		rxname = dma_chan_name(host->dma_rx_channel);
+	if (dmae->dma_rx_channel)
+		rxname = dma_chan_name(dmae->dma_rx_channel);
 	else
 		rxname = "none";
 
-	if (host->dma_tx_channel)
-		txname = dma_chan_name(host->dma_tx_channel);
+	if (dmae->dma_tx_channel)
+		txname = dma_chan_name(dmae->dma_tx_channel);
 	else
 		txname = "none";
 
@@ -450,15 +476,15 @@ static void mmci_dma_setup(struct mmci_host *host)
 	 * Limit the maximum segment size in any SG entry according to
 	 * the parameters of the DMA engine device.
 	 */
-	if (host->dma_tx_channel) {
-		struct device *dev = host->dma_tx_channel->device->dev;
+	if (dmae->dma_tx_channel) {
+		struct device *dev = dmae->dma_tx_channel->device->dev;
 		unsigned int max_seg_size = dma_get_max_seg_size(dev);
 
 		if (max_seg_size < host->mmc->max_seg_size)
 			host->mmc->max_seg_size = max_seg_size;
 	}
-	if (host->dma_rx_channel) {
-		struct device *dev = host->dma_rx_channel->device->dev;
+	if (dmae->dma_rx_channel) {
+		struct device *dev = dmae->dma_rx_channel->device->dev;
 		unsigned int max_seg_size = dma_get_max_seg_size(dev);
 
 		if (max_seg_size < host->mmc->max_seg_size)
@@ -466,7 +492,9 @@ static void mmci_dma_setup(struct mmci_host *host)
 	}
 
 	if (host->ops && host->ops->dma_setup)
-		host->ops->dma_setup(host);
+		return host->ops->dma_setup(host);
+
+	return 0;
 }
 
 /*
@@ -475,21 +503,24 @@ static void mmci_dma_setup(struct mmci_host *host)
  */
 static inline void mmci_dma_release(struct mmci_host *host)
 {
-	if (host->dma_rx_channel)
-		dma_release_channel(host->dma_rx_channel);
-	if (host->dma_tx_channel)
-		dma_release_channel(host->dma_tx_channel);
-	host->dma_rx_channel = host->dma_tx_channel = NULL;
+	struct dmaengine_priv *dmae = host->dma_priv;
+
+	if (dmae->dma_rx_channel)
+		dma_release_channel(dmae->dma_rx_channel);
+	if (dmae->dma_tx_channel)
+		dma_release_channel(dmae->dma_tx_channel);
+	dmae->dma_rx_channel = dmae->dma_tx_channel = NULL;
 }
 
-static void __mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
+static void __mmci_dmae_unmap(struct mmci_host *host, struct mmc_data *data)
 {
+	struct dmaengine_priv *dmae = host->dma_priv;
 	struct dma_chan *chan;
 
 	if (data->flags & MMC_DATA_READ)
-		chan = host->dma_rx_channel;
+		chan = dmae->dma_rx_channel;
 	else
-		chan = host->dma_tx_channel;
+		chan = dmae->dma_tx_channel;
 
 	dma_unmap_sg(chan->device->dev, data->sg, data->sg_len,
 		     mmc_get_dma_dir(data));
@@ -497,25 +528,28 @@ static void __mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
 
 static void mmci_dma_data_error(struct mmci_host *host)
 {
-	if (!__dma_inprogress(host))
+	struct dmaengine_priv *dmae = host->dma_priv;
+
+	if (!__dmae_inprogress(dmae))
 		return;
 
 	dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
-	dmaengine_terminate_all(host->dma_current);
-	host->dma_in_progress = false;
-	host->dma_current = NULL;
-	host->dma_desc_current = NULL;
+	dmaengine_terminate_all(dmae->dma_current);
+	dmae->dma_in_progress = false;
+	dmae->dma_current = NULL;
+	dmae->dma_desc_current = NULL;
 	host->data->host_cookie = 0;
 
-	__mmci_dma_unmap(host, host->data);
+	__mmci_dmae_unmap(host, host->data);
 }
 
 static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
 {
+	struct dmaengine_priv *dmae = host->dma_priv;
 	u32 status;
 	int i;
 
-	if (!__dma_inprogress(dmae))
+	if (!__dmae_inprogress(dmae))
 		return;
 
 	/* Wait up to 1ms for the DMA to complete */
@@ -537,7 +571,7 @@ static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
 		if (!data->error)
 			data->error = -EIO;
 	} else if (!data->host_cookie) {
-		__mmci_dma_unmap(host, data);
+		__mmci_dmae_unmap(host, data);
 	}
 
 	/*
@@ -549,9 +583,9 @@ static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
 		mmci_dma_release(host);
 	}
 
-	host->dma_in_progress = false;
-	host->dma_current = NULL;
-	host->dma_desc_current = NULL;
+	dmae->dma_in_progress = false;
+	dmae->dma_current = NULL;
+	dmae->dma_desc_current = NULL;
 }
 
 /* prepares DMA channel and DMA descriptor, returns non-zero on failure */
@@ -559,6 +593,7 @@ static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
 				struct dma_chan **dma_chan,
 				struct dma_async_tx_descriptor **dma_desc)
 {
+	struct dmaengine_priv *dmae = host->dma_priv;
 	struct variant_data *variant = host->variant;
 	struct dma_slave_config conf = {
 		.src_addr = host->phybase + MMCIFIFO,
@@ -577,10 +612,10 @@ static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
 
 	if (data->flags & MMC_DATA_READ) {
 		conf.direction = DMA_DEV_TO_MEM;
-		chan = host->dma_rx_channel;
+		chan = dmae->dma_rx_channel;
 	} else {
 		conf.direction = DMA_MEM_TO_DEV;
-		chan = host->dma_tx_channel;
+		chan = dmae->dma_tx_channel;
 	}
 
 	/* If there's no DMA channel, fall back to PIO */
@@ -620,26 +655,31 @@ static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
 static inline int mmci_dma_prep_data(struct mmci_host *host,
 				     struct mmc_data *data)
 {
+	struct dmaengine_priv *dmae = host->dma_priv;
+
 	/* Check if next job is already prepared. */
-	if (host->dma_current && host->dma_desc_current)
+	if (dmae->dma_current && dmae->dma_desc_current)
 		return 0;
 
 	/* No job were prepared thus do it now. */
-	return __mmci_dma_prep_data(host, data, &host->dma_current,
-				    &host->dma_desc_current);
+	return __mmci_dma_prep_data(host, data, &dmae->dma_current,
+				    &dmae->dma_desc_current);
 }
 
 static inline int mmci_dma_prep_next(struct mmci_host *host,
 				     struct mmc_data *data)
 {
-	struct mmci_host_next *nd = &host->next_data;
+	struct dmaengine_priv *dmae = host->dma_priv;
+	struct dmaengine_next *nd = &dmae->next_data;
+
 	return __mmci_dma_prep_data(host, data, &nd->dma_chan, &nd->dma_desc);
 }
 
 static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 {
-	int ret;
+	struct dmaengine_priv *dmae = host->dma_priv;
 	struct mmc_data *data = host->data;
+	int ret;
 
 	ret = mmci_dma_prep_data(host, host->data);
 	if (ret)
@@ -649,9 +689,9 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 	dev_vdbg(mmc_dev(host->mmc),
 		 "Submit MMCI DMA job, sglen %d blksz %04x blks %04x flags %08x\n",
 		 data->sg_len, data->blksz, data->blocks, data->flags);
-	host->dma_in_progress = true;
-	dmaengine_submit(host->dma_desc_current);
-	dma_async_issue_pending(host->dma_current);
+	dmae->dma_in_progress = true;
+	dmaengine_submit(dmae->dma_desc_current);
+	dma_async_issue_pending(dmae->dma_current);
 
 	if (host->variant->qcom_dml)
 		dml_start_xfer(host, data);
@@ -673,13 +713,14 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 
 static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
 {
-	struct mmci_host_next *next = &host->next_data;
+	struct dmaengine_priv *dmae = host->dma_priv;
+	struct dmaengine_next *next = &dmae->next_data;
 
 	WARN_ON(data->host_cookie && data->host_cookie != next->cookie);
 	WARN_ON(!data->host_cookie && (next->dma_desc || next->dma_chan));
 
-	host->dma_desc_current = next->dma_desc;
-	host->dma_current = next->dma_chan;
+	dmae->dma_desc_current = next->dma_desc;
+	dmae->dma_current = next->dma_chan;
 	next->dma_desc = NULL;
 	next->dma_chan = NULL;
 }
@@ -687,8 +728,9 @@ static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
 static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct mmci_host *host = mmc_priv(mmc);
+	struct dmaengine_priv *dmae = host->dma_priv;
 	struct mmc_data *data = mrq->data;
-	struct mmci_host_next *nd = &host->next_data;
+	struct dmaengine_next *nd = &dmae->next_data;
 
 	if (!data)
 		return;
@@ -706,28 +748,29 @@ static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
 			      int err)
 {
 	struct mmci_host *host = mmc_priv(mmc);
+	struct dmaengine_priv *dmae = host->dma_priv;
 	struct mmc_data *data = mrq->data;
 
 	if (!data || !data->host_cookie)
 		return;
 
-	__mmci_dma_unmap(host, data);
+	__mmci_dmae_unmap(host, data);
 
 	if (err) {
-		struct mmci_host_next *next = &host->next_data;
+		struct dmaengine_next *next = &dmae->next_data;
 		struct dma_chan *chan;
 		if (data->flags & MMC_DATA_READ)
-			chan = host->dma_rx_channel;
+			chan = dmae->dma_rx_channel;
 		else
-			chan = host->dma_tx_channel;
+			chan = dmae->dma_tx_channel;
 		dmaengine_terminate_all(chan);
 
-		if (host->dma_desc_current == next->dma_desc)
-			host->dma_desc_current = NULL;
+		if (dmae->dma_desc_current == next->dma_desc)
+			dmae->dma_desc_current = NULL;
 
-		if (host->dma_current == next->dma_chan) {
-			host->dma_in_progress = false;
-			host->dma_current = NULL;
+		if (dmae->dma_current == next->dma_chan) {
+			dmae->dma_in_progress = false;
+			dmae->dma_current = NULL;
 		}
 
 		next->dma_desc = NULL;
@@ -741,8 +784,10 @@ static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
 static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
 {
 }
-static inline void mmci_dma_setup(struct mmci_host *host)
+
+static inline int mmci_dma_setup(struct mmci_host *host)
 {
+	return 0;
 }
 
 static inline void mmci_dma_release(struct mmci_host *host)
@@ -1796,7 +1841,9 @@ static int mmci_probe(struct amba_device *dev,
 		 amba_rev(dev), (unsigned long long)dev->res.start,
 		 dev->irq[0], dev->irq[1]);
 
-	mmci_dma_setup(host);
+	ret = mmci_dma_setup(host);
+	if (ret)
+		goto clk_disable;
 
 	pm_runtime_set_autosuspend_delay(&dev->dev, 50);
 	pm_runtime_use_autosuspend(&dev->dev);
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index f1ec066..260a1de 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -273,13 +273,7 @@ struct variant_data {
 
 /* mmci variant callbacks */
 struct mmci_host_ops {
-	void (*dma_setup)(struct mmci_host *host);
-};
-
-struct mmci_host_next {
-	struct dma_async_tx_descriptor	*dma_desc;
-	struct dma_chan			*dma_chan;
-	s32				cookie;
+	int (*dma_setup)(struct mmci_host *host);
 };
 
 struct mmci_host {
@@ -323,17 +317,7 @@ struct mmci_host {
 	unsigned int		size;
 	int (*get_rx_fifocnt)(struct mmci_host *h, u32 status, int remain);
 
-#ifdef CONFIG_DMA_ENGINE
-	/* DMA stuff */
-	struct dma_chan		*dma_current;
-	struct dma_chan		*dma_rx_channel;
-	struct dma_chan		*dma_tx_channel;
-	struct dma_async_tx_descriptor	*dma_desc_current;
-	struct mmci_host_next	next_data;
-	bool			dma_in_progress;
-
-#define __dma_inprogress(host)	((host)->dma_in_progress)
-#endif
+	void			*dma_priv;
 };
 
 void qcom_variant_init(struct mmci_host *host);
diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
index be3fab5..1bb59cf 100644
--- a/drivers/mmc/host/mmci_qcom_dml.c
+++ b/drivers/mmc/host/mmci_qcom_dml.c
@@ -119,7 +119,7 @@ static int of_get_dml_pipe_index(struct device_node *np, const char *name)
 }
 
 /* Initialize the dml hardware connected to SD Card controller */
-static void qcom_dma_setup(struct mmci_host *host)
+static int qcom_dma_setup(struct mmci_host *host)
 {
 	u32 config;
 	void __iomem *base;
@@ -131,7 +131,7 @@ static void qcom_dma_setup(struct mmci_host *host)
 
 	if (producer_id < 0 || consumer_id < 0) {
 		host->variant->qcom_dml = false;
-		return;
+		return -EINVAL;
 	}
 
 	base = host->base + DML_OFFSET;
@@ -175,6 +175,8 @@ static void qcom_dma_setup(struct mmci_host *host)
 
 	/* Make sure dml initialization is finished */
 	mb();
+
+	return 0;
 }
 
 static struct mmci_host_ops qcom_variant_ops = {
-- 
2.7.4

