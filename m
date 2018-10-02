Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21F8C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F0C8205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F0C8205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbeJBSyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:54:46 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:32890 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727584AbeJBSxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:53:05 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w92C4JBM012274;
        Tue, 2 Oct 2018 14:09:45 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2mv4mj179b-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 02 Oct 2018 14:09:45 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4821738;
        Tue,  2 Oct 2018 12:09:44 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E4E7F2A3C;
        Tue,  2 Oct 2018 12:09:43 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 2 Oct 2018
 14:09:43 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 2 Oct 2018
 14:09:43 +0200
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <benjamin.gaignard@linaro.org>, Gerald Baeza <gerald.baeza@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH V4 02/25] mmc: mmci: create generic mmci_dma_setup
Date:   Tue, 2 Oct 2018 14:09:04 +0200
Message-ID: <1538482167-13819-3-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538482167-13819-1-git-send-email-ludovic.Barre@st.com>
References: <1538482167-13819-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-02_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch creates a generic mmci_dma_setup which calls
dma_setup callback of mmci_host_ops and manages common features
like use_dma... If there is a fallbacks to pio mode, dma
functions must check use_dma.

If one of dma channels is not defined (in dma engine config)
release channels.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
change v4:
Adds mmci_dma_release prototype into CONFIG_DMA_ENGINE config,
allows to be call by mmci_dmae_setup for error management.
This prototype will be removed when dma release callback
will be add (defined in .h and removed of "else CONFIG_DMA_ENGINE")

 drivers/mmc/host/mmci.c          | 58 +++++++++++++++++++++++++++++++++-------
 drivers/mmc/host/mmci.h          |  7 ++++-
 drivers/mmc/host/mmci_qcom_dml.c |  9 +++++--
 3 files changed, 61 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index db8c085..2dc37f5 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -57,6 +57,7 @@ static struct variant_data variant_arm = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_ROD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_arm_extended_fifo = {
@@ -68,6 +69,7 @@ static struct variant_data variant_arm_extended_fifo = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_ROD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_arm_extended_fifo_hwfc = {
@@ -80,6 +82,7 @@ static struct variant_data variant_arm_extended_fifo_hwfc = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_ROD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_u300 = {
@@ -98,6 +101,7 @@ static struct variant_data variant_u300 = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_nomadik = {
@@ -117,6 +121,7 @@ static struct variant_data variant_nomadik = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_ux500 = {
@@ -142,6 +147,7 @@ static struct variant_data variant_ux500 = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_ux500v2 = {
@@ -169,6 +175,7 @@ static struct variant_data variant_ux500v2 = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_stm32 = {
@@ -186,6 +193,7 @@ static struct variant_data variant_stm32 = {
 	.f_max			= 48000000,
 	.pwrreg_clkgate		= true,
 	.pwrreg_nopower		= true,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_qcom = {
@@ -356,6 +364,17 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
 	mmci_write_clkreg(host, clk);
 }
 
+void mmci_dma_setup(struct mmci_host *host)
+{
+	if (!host->ops || !host->ops->dma_setup)
+		return;
+
+	if (host->ops->dma_setup(host))
+		return;
+
+	host->use_dma = true;
+}
+
 static void
 mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 {
@@ -414,7 +433,9 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
  * no custom DMA interfaces are supported.
  */
 #ifdef CONFIG_DMA_ENGINE
-static void mmci_dma_setup(struct mmci_host *host)
+static inline void mmci_dma_release(struct mmci_host *host);
+
+int mmci_dmae_setup(struct mmci_host *host)
 {
 	const char *rxname, *txname;
 
@@ -464,8 +485,12 @@ static void mmci_dma_setup(struct mmci_host *host)
 			host->mmc->max_seg_size = max_seg_size;
 	}
 
-	if (host->ops && host->ops->dma_setup)
-		host->ops->dma_setup(host);
+	if (!host->dma_tx_channel || !host->dma_rx_channel) {
+		mmci_dma_release(host);
+		return -EINVAL;
+	}
+
+	return 0;
 }
 
 /*
@@ -496,7 +521,7 @@ static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
 
 static void mmci_dma_data_error(struct mmci_host *host)
 {
-	if (!dma_inprogress(host))
+	if (!host->use_dma || !dma_inprogress(host))
 		return;
 
 	dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
@@ -514,7 +539,7 @@ static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
 	u32 status;
 	int i;
 
-	if (!dma_inprogress(host))
+	if (!host->use_dma || !dma_inprogress(host))
 		return;
 
 	/* Wait up to 1ms for the DMA to complete */
@@ -546,6 +571,7 @@ static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
 	if (status & MCI_RXDATAAVLBLMASK) {
 		dev_err(mmc_dev(host->mmc), "buggy DMA detected. Taking evasive action.\n");
 		mmci_dma_release(host);
+		host->use_dma = false;
 	}
 
 	host->dma_in_progress = false;
@@ -640,6 +666,9 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 	int ret;
 	struct mmc_data *data = host->data;
 
+	if (!host->use_dma)
+		return -EINVAL;
+
 	ret = mmci_dma_prep_data(host, host->data);
 	if (ret)
 		return ret;
@@ -674,6 +703,9 @@ static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
 {
 	struct mmci_host_next *next = &host->next_data;
 
+	if (!host->use_dma)
+		return;
+
 	WARN_ON(data->host_cookie && data->host_cookie != next->cookie);
 	WARN_ON(!data->host_cookie && (next->dma_desc || next->dma_chan));
 
@@ -689,7 +721,7 @@ static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	struct mmc_data *data = mrq->data;
 	struct mmci_host_next *nd = &host->next_data;
 
-	if (!data)
+	if (!host->use_dma || !data)
 		return;
 
 	BUG_ON(data->host_cookie);
@@ -707,7 +739,7 @@ static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
 	struct mmci_host *host = mmc_priv(mmc);
 	struct mmc_data *data = mrq->data;
 
-	if (!data || !data->host_cookie)
+	if (!host->use_dma || !data || !data->host_cookie)
 		return;
 
 	mmci_dma_unmap(host, data);
@@ -735,14 +767,14 @@ static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
 	}
 }
 
+static struct mmci_host_ops mmci_variant_ops = {
+	.dma_setup = mmci_dmae_setup,
+};
 #else
 /* Blank functions if the DMA engine is not available */
 static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
 {
 }
-static inline void mmci_dma_setup(struct mmci_host *host)
-{
-}
 
 static inline void mmci_dma_release(struct mmci_host *host)
 {
@@ -765,8 +797,14 @@ static inline int mmci_dma_start_data(struct mmci_host *host, unsigned int datac
 #define mmci_pre_request NULL
 #define mmci_post_request NULL
 
+static struct mmci_host_ops mmci_variant_ops = {};
 #endif
 
+void mmci_variant_init(struct mmci_host *host)
+{
+	host->ops = &mmci_variant_ops;
+}
+
 static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 {
 	struct variant_data *variant = host->variant;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 01e6c6b..f7fe80f 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -273,7 +273,7 @@ struct variant_data {
 
 /* mmci variant callbacks */
 struct mmci_host_ops {
-	void (*dma_setup)(struct mmci_host *host);
+	int (*dma_setup)(struct mmci_host *host);
 };
 
 struct mmci_host_next {
@@ -323,6 +323,7 @@ struct mmci_host {
 	unsigned int		size;
 	int (*get_rx_fifocnt)(struct mmci_host *h, u32 status, int remain);
 
+	u8			use_dma:1;
 #ifdef CONFIG_DMA_ENGINE
 	/* DMA stuff */
 	struct dma_chan		*dma_current;
@@ -336,3 +337,7 @@ struct mmci_host {
 #endif
 };
 
+void mmci_variant_init(struct mmci_host *host);
+
+int mmci_dmae_setup(struct mmci_host *host);
+
diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
index be3fab5..c8d7592 100644
--- a/drivers/mmc/host/mmci_qcom_dml.c
+++ b/drivers/mmc/host/mmci_qcom_dml.c
@@ -119,19 +119,22 @@ static int of_get_dml_pipe_index(struct device_node *np, const char *name)
 }
 
 /* Initialize the dml hardware connected to SD Card controller */
-static void qcom_dma_setup(struct mmci_host *host)
+static int qcom_dma_setup(struct mmci_host *host)
 {
 	u32 config;
 	void __iomem *base;
 	int consumer_id, producer_id;
 	struct device_node *np = host->mmc->parent->of_node;
 
+	if (mmci_dmae_setup(host))
+		return -EINVAL;
+
 	consumer_id = of_get_dml_pipe_index(np, "tx");
 	producer_id = of_get_dml_pipe_index(np, "rx");
 
 	if (producer_id < 0 || consumer_id < 0) {
 		host->variant->qcom_dml = false;
-		return;
+		return -EINVAL;
 	}
 
 	base = host->base + DML_OFFSET;
@@ -175,6 +178,8 @@ static void qcom_dma_setup(struct mmci_host *host)
 
 	/* Make sure dml initialization is finished */
 	mb();
+
+	return 0;
 }
 
 static struct mmci_host_ops qcom_variant_ops = {
-- 
2.7.4

