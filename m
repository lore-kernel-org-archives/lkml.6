Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15D8C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603E72084D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603E72084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbeJHTWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:22:11 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:36876 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725849AbeJHTWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 15:22:11 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w98C44nB018786;
        Mon, 8 Oct 2018 14:09:34 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2n01heht41-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 08 Oct 2018 14:09:34 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7532138;
        Mon,  8 Oct 2018 12:09:33 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 44DE52D01;
        Mon,  8 Oct 2018 12:09:33 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 8 Oct 2018
 14:09:32 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 8 Oct 2018
 14:09:32 +0200
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
Subject: [PATCH V6 01/23] mmc: mmci: create common mmci_dma_setup/release
Date:   Mon, 8 Oct 2018 14:08:33 +0200
Message-ID: <1539000535-13261-2-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539000535-13261-1-git-send-email-ludovic.Barre@st.com>
References: <1539000535-13261-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-08_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch creates a common mmci_dma_setup/release which calls
dma_setup/release callbacks of mmci_host_ops and manages
common features like use_dma... If there is a fallbacks to
pio mode, dma functions must check use_dma.

error management:
-mmci_dmae_setup fail if Tx and Rx dma channels are not defined
-qcom_dma_setup fail if one of both dma channels is not defined,
 Qcom has no specific resource to release, just mmci dmae resource.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c          | 75 ++++++++++++++++++++++++++++++++--------
 drivers/mmc/host/mmci.h          |  7 +++-
 drivers/mmc/host/mmci_qcom_dml.c | 11 ++++--
 3 files changed, 75 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index db8c085..120382b 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -45,6 +45,12 @@
 
 #define DRIVER_NAME "mmci-pl18x"
 
+#ifdef CONFIG_DMA_ENGINE
+void mmci_variant_init(struct mmci_host *host);
+#else
+static inline void mmci_variant_init(struct mmci_host *host) {}
+#endif
+
 static unsigned int fmax = 515633;
 
 static struct variant_data variant_arm = {
@@ -57,6 +63,7 @@ static struct variant_data variant_arm = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_ROD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_arm_extended_fifo = {
@@ -68,6 +75,7 @@ static struct variant_data variant_arm_extended_fifo = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_ROD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_arm_extended_fifo_hwfc = {
@@ -80,6 +88,7 @@ static struct variant_data variant_arm_extended_fifo_hwfc = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_ROD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_u300 = {
@@ -98,6 +107,7 @@ static struct variant_data variant_u300 = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_nomadik = {
@@ -117,6 +127,7 @@ static struct variant_data variant_nomadik = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_ux500 = {
@@ -142,6 +153,7 @@ static struct variant_data variant_ux500 = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_ux500v2 = {
@@ -169,6 +181,7 @@ static struct variant_data variant_ux500v2 = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_stm32 = {
@@ -186,6 +199,7 @@ static struct variant_data variant_stm32 = {
 	.f_max			= 48000000,
 	.pwrreg_clkgate		= true,
 	.pwrreg_nopower		= true,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_qcom = {
@@ -356,6 +370,25 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
 	mmci_write_clkreg(host, clk);
 }
 
+void mmci_dma_release(struct mmci_host *host)
+{
+	if (host->ops && host->ops->dma_release)
+		host->ops->dma_release(host);
+
+	host->use_dma = false;
+}
+
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
@@ -414,7 +447,7 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
  * no custom DMA interfaces are supported.
  */
 #ifdef CONFIG_DMA_ENGINE
-static void mmci_dma_setup(struct mmci_host *host)
+int mmci_dmae_setup(struct mmci_host *host)
 {
 	const char *rxname, *txname;
 
@@ -464,15 +497,19 @@ static void mmci_dma_setup(struct mmci_host *host)
 			host->mmc->max_seg_size = max_seg_size;
 	}
 
-	if (host->ops && host->ops->dma_setup)
-		host->ops->dma_setup(host);
+	if (!host->dma_tx_channel && !host->dma_rx_channel) {
+		mmci_dmae_release(host);
+		return -EINVAL;
+	}
+
+	return 0;
 }
 
 /*
  * This is used in or so inline it
  * so it can be discarded.
  */
-static inline void mmci_dma_release(struct mmci_host *host)
+void mmci_dmae_release(struct mmci_host *host)
 {
 	if (host->dma_rx_channel)
 		dma_release_channel(host->dma_rx_channel);
@@ -496,7 +533,7 @@ static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
 
 static void mmci_dma_data_error(struct mmci_host *host)
 {
-	if (!dma_inprogress(host))
+	if (!host->use_dma || !dma_inprogress(host))
 		return;
 
 	dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
@@ -514,7 +551,7 @@ static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
 	u32 status;
 	int i;
 
-	if (!dma_inprogress(host))
+	if (!host->use_dma || !dma_inprogress(host))
 		return;
 
 	/* Wait up to 1ms for the DMA to complete */
@@ -640,6 +677,9 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 	int ret;
 	struct mmc_data *data = host->data;
 
+	if (!host->use_dma)
+		return -EINVAL;
+
 	ret = mmci_dma_prep_data(host, host->data);
 	if (ret)
 		return ret;
@@ -674,6 +714,9 @@ static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
 {
 	struct mmci_host_next *next = &host->next_data;
 
+	if (!host->use_dma)
+		return;
+
 	WARN_ON(data->host_cookie && data->host_cookie != next->cookie);
 	WARN_ON(!data->host_cookie && (next->dma_desc || next->dma_chan));
 
@@ -689,7 +732,7 @@ static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	struct mmc_data *data = mrq->data;
 	struct mmci_host_next *nd = &host->next_data;
 
-	if (!data)
+	if (!host->use_dma || !data)
 		return;
 
 	BUG_ON(data->host_cookie);
@@ -707,7 +750,7 @@ static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
 	struct mmci_host *host = mmc_priv(mmc);
 	struct mmc_data *data = mrq->data;
 
-	if (!data || !data->host_cookie)
+	if (!host->use_dma || !data || !data->host_cookie)
 		return;
 
 	mmci_dma_unmap(host, data);
@@ -735,18 +778,20 @@ static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
 	}
 }
 
+static struct mmci_host_ops mmci_variant_ops = {
+	.dma_setup = mmci_dmae_setup,
+	.dma_release = mmci_dmae_release,
+};
+
+void mmci_variant_init(struct mmci_host *host)
+{
+	host->ops = &mmci_variant_ops;
+}
 #else
 /* Blank functions if the DMA engine is not available */
 static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
 {
 }
-static inline void mmci_dma_setup(struct mmci_host *host)
-{
-}
-
-static inline void mmci_dma_release(struct mmci_host *host)
-{
-}
 
 static inline void mmci_dma_finalize(struct mmci_host *host,
 				     struct mmc_data *data)
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 01e6c6b..34bb5e6 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -273,7 +273,8 @@ struct variant_data {
 
 /* mmci variant callbacks */
 struct mmci_host_ops {
-	void (*dma_setup)(struct mmci_host *host);
+	int (*dma_setup)(struct mmci_host *host);
+	void (*dma_release)(struct mmci_host *host);
 };
 
 struct mmci_host_next {
@@ -323,6 +324,7 @@ struct mmci_host {
 	unsigned int		size;
 	int (*get_rx_fifocnt)(struct mmci_host *h, u32 status, int remain);
 
+	u8			use_dma:1;
 #ifdef CONFIG_DMA_ENGINE
 	/* DMA stuff */
 	struct dma_chan		*dma_current;
@@ -336,3 +338,6 @@ struct mmci_host {
 #endif
 };
 
+int mmci_dmae_setup(struct mmci_host *host);
+void mmci_dmae_release(struct mmci_host *host);
+
diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
index be3fab5..92b03a3 100644
--- a/drivers/mmc/host/mmci_qcom_dml.c
+++ b/drivers/mmc/host/mmci_qcom_dml.c
@@ -119,19 +119,23 @@ static int of_get_dml_pipe_index(struct device_node *np, const char *name)
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
+		mmci_dmae_release(host);
+		return -EINVAL;
 	}
 
 	base = host->base + DML_OFFSET;
@@ -175,10 +179,13 @@ static void qcom_dma_setup(struct mmci_host *host)
 
 	/* Make sure dml initialization is finished */
 	mb();
+
+	return 0;
 }
 
 static struct mmci_host_ops qcom_variant_ops = {
 	.dma_setup = qcom_dma_setup,
+	.dma_release = mmci_dmae_release,
 };
 
 void qcom_variant_init(struct mmci_host *host)
-- 
2.7.4

