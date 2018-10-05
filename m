Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CAAC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9A520834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9A520834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbeJEUWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 16:22:34 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:57459 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728473AbeJEUWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 16:22:34 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w95DJGr7001784;
        Fri, 5 Oct 2018 15:23:27 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2mu1bkc6um-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 05 Oct 2018 15:23:27 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 593B731;
        Fri,  5 Oct 2018 13:23:26 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 283502CBE;
        Fri,  5 Oct 2018 13:23:26 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 5 Oct 2018
 15:23:26 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 5 Oct 2018
 15:23:25 +0200
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
Subject: [PATCH V5 03/24] mmc: mmci: introduce dma_priv pointer to mmci_host
Date:   Fri, 5 Oct 2018 15:22:41 +0200
Message-ID: <1538745782-27446-4-git-send-email-ludovic.Barre@st.com>
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

-Introduces dma_priv pointer to define specific
needs for each dma engine. This patch is needed to prepare
sdmmc variant with internal dma which not use dmaengine API.
-Moves next cookie to mmci host structure to share same cookie
management between all variants.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 144 ++++++++++++++++++++++++++++++------------------
 drivers/mmc/host/mmci.h |  19 ++-----
 2 files changed, 94 insertions(+), 69 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 07b799c..792de67 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -382,6 +382,9 @@ void mmci_dma_setup(struct mmci_host *host)
 		return;
 	}
 
+	/* initialize pre request cookie */
+	host->next_cookie = 1;
+
 	host->use_dma = true;
 }
 
@@ -443,31 +446,50 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
  * no custom DMA interfaces are supported.
  */
 #ifdef CONFIG_DMA_ENGINE
+struct mmci_dmae_next {
+	struct dma_async_tx_descriptor *desc;
+	struct dma_chan	*chan;
+};
+
+struct mmci_dmae_priv {
+	struct dma_chan	*cur;
+	struct dma_chan	*rx_channel;
+	struct dma_chan	*tx_channel;
+	struct dma_async_tx_descriptor	*desc_current;
+	struct mmci_dmae_next next_data;
+};
+
 int mmci_dmae_setup(struct mmci_host *host)
 {
 	const char *rxname, *txname;
+	struct mmci_dmae_priv *dmae;
 
-	host->dma_rx_channel = dma_request_slave_channel(mmc_dev(host->mmc), "rx");
-	host->dma_tx_channel = dma_request_slave_channel(mmc_dev(host->mmc), "tx");
+	dmae = devm_kzalloc(mmc_dev(host->mmc), sizeof(*dmae), GFP_KERNEL);
+	if (!dmae)
+		return -ENOMEM;
 
-	/* initialize pre request cookie */
-	host->next_data.cookie = 1;
+	host->dma_priv = dmae;
+
+	dmae->rx_channel = dma_request_slave_channel(mmc_dev(host->mmc),
+						     "rx");
+	dmae->tx_channel = dma_request_slave_channel(mmc_dev(host->mmc),
+						     "tx");
 
 	/*
 	 * If only an RX channel is specified, the driver will
 	 * attempt to use it bidirectionally, however if it is
 	 * is specified but cannot be located, DMA will be disabled.
 	 */
-	if (host->dma_rx_channel && !host->dma_tx_channel)
-		host->dma_tx_channel = host->dma_rx_channel;
+	if (dmae->rx_channel && !dmae->tx_channel)
+		dmae->tx_channel = dmae->rx_channel;
 
-	if (host->dma_rx_channel)
-		rxname = dma_chan_name(host->dma_rx_channel);
+	if (dmae->rx_channel)
+		rxname = dma_chan_name(dmae->rx_channel);
 	else
 		rxname = "none";
 
-	if (host->dma_tx_channel)
-		txname = dma_chan_name(host->dma_tx_channel);
+	if (dmae->tx_channel)
+		txname = dma_chan_name(dmae->tx_channel);
 	else
 		txname = "none";
 
@@ -478,22 +500,22 @@ int mmci_dmae_setup(struct mmci_host *host)
 	 * Limit the maximum segment size in any SG entry according to
 	 * the parameters of the DMA engine device.
 	 */
-	if (host->dma_tx_channel) {
-		struct device *dev = host->dma_tx_channel->device->dev;
+	if (dmae->tx_channel) {
+		struct device *dev = dmae->tx_channel->device->dev;
 		unsigned int max_seg_size = dma_get_max_seg_size(dev);
 
 		if (max_seg_size < host->mmc->max_seg_size)
 			host->mmc->max_seg_size = max_seg_size;
 	}
-	if (host->dma_rx_channel) {
-		struct device *dev = host->dma_rx_channel->device->dev;
+	if (dmae->rx_channel) {
+		struct device *dev = dmae->rx_channel->device->dev;
 		unsigned int max_seg_size = dma_get_max_seg_size(dev);
 
 		if (max_seg_size < host->mmc->max_seg_size)
 			host->mmc->max_seg_size = max_seg_size;
 	}
 
-	if (!host->dma_tx_channel && !host->dma_rx_channel)
+	if (!dmae->tx_channel || !dmae->rx_channel) {
 		return -EINVAL;
 
 	return 0;
@@ -505,21 +527,24 @@ int mmci_dmae_setup(struct mmci_host *host)
  */
 void mmci_dmae_release(struct mmci_host *host)
 {
-	if (host->dma_rx_channel)
-		dma_release_channel(host->dma_rx_channel);
-	if (host->dma_tx_channel)
-		dma_release_channel(host->dma_tx_channel);
-	host->dma_rx_channel = host->dma_tx_channel = NULL;
+	struct mmci_dmae_priv *dmae = host->dma_priv;
+
+	if (dmae->rx_channel)
+		dma_release_channel(dmae->rx_channel);
+	if (dmae->tx_channel)
+		dma_release_channel(dmae->tx_channel);
+	dmae->rx_channel = dmae->tx_channel = NULL;
 }
 
 static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
 {
+	struct mmci_dmae_priv *dmae = host->dma_priv;
 	struct dma_chan *chan;
 
 	if (data->flags & MMC_DATA_READ)
-		chan = host->dma_rx_channel;
+		chan = dmae->rx_channel;
 	else
-		chan = host->dma_tx_channel;
+		chan = dmae->tx_channel;
 
 	dma_unmap_sg(chan->device->dev, data->sg, data->sg_len,
 		     mmc_get_dma_dir(data));
@@ -527,14 +552,16 @@ static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
 
 static void mmci_dma_data_error(struct mmci_host *host)
 {
+	struct mmci_dmae_priv *dmae = host->dma_priv;
+
 	if (!host->use_dma || !dma_inprogress(host))
 		return;
 
 	dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
-	dmaengine_terminate_all(host->dma_current);
+	dmaengine_terminate_all(dmae->cur);
 	host->dma_in_progress = false;
-	host->dma_current = NULL;
-	host->dma_desc_current = NULL;
+	dmae->cur = NULL;
+	dmae->desc_current = NULL;
 	host->data->host_cookie = 0;
 
 	mmci_dma_unmap(host, host->data);
@@ -542,6 +569,7 @@ static void mmci_dma_data_error(struct mmci_host *host)
 
 static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
 {
+	struct mmci_dmae_priv *dmae = host->dma_priv;
 	u32 status;
 	int i;
 
@@ -580,8 +608,8 @@ static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
 	}
 
 	host->dma_in_progress = false;
-	host->dma_current = NULL;
-	host->dma_desc_current = NULL;
+	dmae->cur = NULL;
+	dmae->desc_current = NULL;
 }
 
 /* prepares DMA channel and DMA descriptor, returns non-zero on failure */
@@ -589,6 +617,7 @@ static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
 				struct dma_chan **dma_chan,
 				struct dma_async_tx_descriptor **dma_desc)
 {
+	struct mmci_dmae_priv *dmae = host->dma_priv;
 	struct variant_data *variant = host->variant;
 	struct dma_slave_config conf = {
 		.src_addr = host->phybase + MMCIFIFO,
@@ -607,10 +636,10 @@ static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
 
 	if (data->flags & MMC_DATA_READ) {
 		conf.direction = DMA_DEV_TO_MEM;
-		chan = host->dma_rx_channel;
+		chan = dmae->rx_channel;
 	} else {
 		conf.direction = DMA_MEM_TO_DEV;
-		chan = host->dma_tx_channel;
+		chan = dmae->tx_channel;
 	}
 
 	/* If there's no DMA channel, fall back to PIO */
@@ -650,25 +679,30 @@ static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
 static inline int mmci_dma_prep_data(struct mmci_host *host,
 				     struct mmc_data *data)
 {
+	struct mmci_dmae_priv *dmae = host->dma_priv;
+
 	/* Check if next job is already prepared. */
-	if (host->dma_current && host->dma_desc_current)
+	if (dmae->cur && dmae->desc_current)
 		return 0;
 
 	/* No job were prepared thus do it now. */
-	return __mmci_dma_prep_data(host, data, &host->dma_current,
-				    &host->dma_desc_current);
+	return __mmci_dma_prep_data(host, data, &dmae->cur,
+				    &dmae->desc_current);
 }
 
 static inline int mmci_dma_prep_next(struct mmci_host *host,
 				     struct mmc_data *data)
 {
-	struct mmci_host_next *nd = &host->next_data;
-	return __mmci_dma_prep_data(host, data, &nd->dma_chan, &nd->dma_desc);
+	struct mmci_dmae_priv *dmae = host->dma_priv;
+	struct mmci_dmae_next *nd = &dmae->next_data;
+
+	return __mmci_dma_prep_data(host, data, &nd->chan, &nd->desc);
 }
 
 static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 {
 	int ret;
+	struct mmci_dmae_priv *dmae = host->dma_priv;
 	struct mmc_data *data = host->data;
 
 	if (!host->use_dma)
@@ -683,8 +717,8 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 		 "Submit MMCI DMA job, sglen %d blksz %04x blks %04x flags %08x\n",
 		 data->sg_len, data->blksz, data->blocks, data->flags);
 	host->dma_in_progress = true;
-	dmaengine_submit(host->dma_desc_current);
-	dma_async_issue_pending(host->dma_current);
+	dmaengine_submit(dmae->desc_current);
+	dma_async_issue_pending(dmae->cur);
 
 	if (host->variant->qcom_dml)
 		dml_start_xfer(host, data);
@@ -706,25 +740,25 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 
 static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
 {
-	struct mmci_host_next *next = &host->next_data;
+	struct mmci_dmae_priv *dmae = host->dma_priv;
+	struct mmci_dmae_next *next = &dmae->next_data;
 
 	if (!host->use_dma)
 		return;
 
-	WARN_ON(data->host_cookie && data->host_cookie != next->cookie);
-	WARN_ON(!data->host_cookie && (next->dma_desc || next->dma_chan));
+	WARN_ON(data->host_cookie && data->host_cookie != host->next_cookie);
+	WARN_ON(!data->host_cookie && (next->desc || next->chan));
 
-	host->dma_desc_current = next->dma_desc;
-	host->dma_current = next->dma_chan;
-	next->dma_desc = NULL;
-	next->dma_chan = NULL;
+	dmae->desc_current = next->desc;
+	dmae->cur = next->chan;
+	next->desc = NULL;
+	next->chan = NULL;
 }
 
 static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct mmci_host *host = mmc_priv(mmc);
 	struct mmc_data *data = mrq->data;
-	struct mmci_host_next *nd = &host->next_data;
 
 	if (!host->use_dma || !data)
 		return;
@@ -735,13 +769,15 @@ static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		return;
 
 	if (!mmci_dma_prep_next(host, data))
-		data->host_cookie = ++nd->cookie < 0 ? 1 : nd->cookie;
+		data->host_cookie = ++host->next_cookie < 0 ?
+			1 : host->next_cookie;
 }
 
 static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
 			      int err)
 {
 	struct mmci_host *host = mmc_priv(mmc);
+	struct mmci_dmae_priv *dmae = host->dma_priv;
 	struct mmc_data *data = mrq->data;
 
 	if (!host->use_dma || !data || !data->host_cookie)
@@ -750,24 +786,24 @@ static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
 	mmci_dma_unmap(host, data);
 
 	if (err) {
-		struct mmci_host_next *next = &host->next_data;
+		struct mmci_dmae_next *next = &dmae->next_data;
 		struct dma_chan *chan;
 		if (data->flags & MMC_DATA_READ)
-			chan = host->dma_rx_channel;
+			chan = dmae->rx_channel;
 		else
-			chan = host->dma_tx_channel;
+			chan = dmae->tx_channel;
 		dmaengine_terminate_all(chan);
 
-		if (host->dma_desc_current == next->dma_desc)
-			host->dma_desc_current = NULL;
+		if (dmae->desc_current == next->desc)
+			dmae->desc_current = NULL;
 
-		if (host->dma_current == next->dma_chan) {
+		if (dmae->cur == next->chan) {
 			host->dma_in_progress = false;
-			host->dma_current = NULL;
+			dmae->cur = NULL;
 		}
 
-		next->dma_desc = NULL;
-		next->dma_chan = NULL;
+		next->desc = NULL;
+		next->chan = NULL;
 		data->host_cookie = 0;
 	}
 }
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 9b0a960..e68be1d 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -277,12 +277,6 @@ struct mmci_host_ops {
 	void (*dma_release)(struct mmci_host *host);
 };
 
-struct mmci_host_next {
-	struct dma_async_tx_descriptor	*dma_desc;
-	struct dma_chan			*dma_chan;
-	s32				cookie;
-};
-
 struct mmci_host {
 	phys_addr_t		phybase;
 	void __iomem		*base;
@@ -325,19 +319,14 @@ struct mmci_host {
 	int (*get_rx_fifocnt)(struct mmci_host *h, u32 status, int remain);
 
 	u8			use_dma:1;
-#ifdef CONFIG_DMA_ENGINE
-	/* DMA stuff */
-	struct dma_chan		*dma_current;
-	struct dma_chan		*dma_rx_channel;
-	struct dma_chan		*dma_tx_channel;
-	struct dma_async_tx_descriptor	*dma_desc_current;
-	struct mmci_host_next	next_data;
 	u8			dma_in_progress:1;
+	void			*dma_priv;
 
-#define dma_inprogress(host)	((host)->dma_in_progress)
-#endif
+	s32			next_cookie;
 };
 
+#define dma_inprogress(host)	((host)->dma_in_progress)
+
 #ifdef CONFIG_DMA_ENGINE
 void mmci_variant_init(struct mmci_host *host);
 #else
-- 
2.7.4

