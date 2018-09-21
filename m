Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CC6C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42BD72154C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42BD72154C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389737AbeIUPe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:34:59 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:6481 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389682AbeIUPe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:34:58 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8L9iYMc008894;
        Fri, 21 Sep 2018 11:46:39 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2mmkmu38kp-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 21 Sep 2018 11:46:39 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3531D34;
        Fri, 21 Sep 2018 09:46:38 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9A1DF2ACC;
        Fri, 21 Sep 2018 09:46:37 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 21 Sep
 2018 11:46:37 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 21 Sep
 2018 11:46:37 +0200
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
Subject: [PATCH V2 07/27] mmc: mmci: add prepare/unprepare_data callbacks
Date:   Fri, 21 Sep 2018 11:46:01 +0200
Message-ID: <1537523181-14578-8-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-21_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds prepare/unprepare callbacks to mmci_host_ops.
Like this mmci_pre/post_request can be generic, mmci_prepare_data
and mmci_unprepare_data provide common next_cookie management.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
change v2:
-rename to mmci_prep/unprep_data
-follow "_" recommendation

 drivers/mmc/host/mmci.c          | 115 +++++++++++++++++++++++++++------------
 drivers/mmc/host/mmci.h          |  10 ++++
 drivers/mmc/host/mmci_qcom_dml.c |   2 +
 3 files changed, 92 insertions(+), 35 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 0cbe71c..5734c05 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -58,6 +58,7 @@ static struct variant_data variant_arm = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_ROD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_arm_extended_fifo = {
@@ -69,6 +70,7 @@ static struct variant_data variant_arm_extended_fifo = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_ROD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_arm_extended_fifo_hwfc = {
@@ -81,6 +83,7 @@ static struct variant_data variant_arm_extended_fifo_hwfc = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_ROD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_u300 = {
@@ -99,6 +102,7 @@ static struct variant_data variant_u300 = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_nomadik = {
@@ -118,6 +122,7 @@ static struct variant_data variant_nomadik = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_ux500 = {
@@ -143,6 +148,7 @@ static struct variant_data variant_ux500 = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_ux500v2 = {
@@ -170,6 +176,7 @@ static struct variant_data variant_ux500v2 = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_stm32 = {
@@ -187,6 +194,7 @@ static struct variant_data variant_stm32 = {
 	.f_max			= 48000000,
 	.pwrreg_clkgate		= true,
 	.pwrreg_nopower		= true,
+	.init			= mmci_variant_init,
 };
 
 static struct variant_data variant_qcom = {
@@ -357,6 +365,31 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
 	mmci_write_clkreg(host, clk);
 }
 
+int mmci_prep_data(struct mmci_host *host, struct mmc_data *data, bool next)
+{
+	int err;
+
+	if (!host->ops || !host->ops->prep_data)
+		return 0;
+
+	err = host->ops->prep_data(host, data, next);
+
+	if (next && !err)
+		data->host_cookie = ++host->next_cookie < 0 ?
+			1 : host->next_cookie;
+
+	return err;
+}
+
+void mmci_unprep_data(struct mmci_host *host, struct mmc_data *data,
+		      int err)
+{
+	if (host->ops && host->ops->unprep_data)
+		host->ops->unprep_data(host, data, err);
+
+	data->host_cookie = 0;
+}
+
 static void
 mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 {
@@ -588,7 +621,7 @@ static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
 }
 
 /* prepares DMA channel and DMA descriptor, returns non-zero on failure */
-static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
+static int _mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
 				struct dma_chan **dma_chan,
 				struct dma_async_tx_descriptor **dma_desc)
 {
@@ -651,21 +684,21 @@ static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
 	return -ENOMEM;
 }
 
-static inline int mmci_dma_prep_data(struct mmci_host *host,
-				     struct mmc_data *data,
-				     bool next)
+int mmci_dmae_prep_data(struct mmci_host *host,
+			struct mmc_data *data,
+			bool next)
 {
 	struct mmci_dmae_priv *dmae = host->dma_priv;
 	struct mmci_dmae_next *nd = &dmae->next_data;
 
 	if (next)
-		return __mmci_dma_prep_data(host, data, &nd->chan, &nd->desc);
+		return _mmci_dmae_prep_data(host, data, &nd->chan, &nd->desc);
 	/* Check if next job is already prepared. */
 	if (dmae->cur && dmae->desc_current)
 		return 0;
 
 	/* No job were prepared thus do it now. */
-	return __mmci_dma_prep_data(host, data, &dmae->cur,
+	return _mmci_dmae_prep_data(host, data, &dmae->cur,
 				    &dmae->desc_current);
 }
 
@@ -675,7 +708,7 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 	struct mmc_data *data = host->data;
 	int ret;
 
-	ret = mmci_dma_prep_data(host, host->data, false);
+	ret = mmci_dmae_prep_data(host, host->data, false);
 	if (ret)
 		return ret;
 
@@ -719,33 +752,11 @@ static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
 	next->chan = NULL;
 }
 
-static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
-{
-	struct mmci_host *host = mmc_priv(mmc);
-	struct mmc_data *data = mrq->data;
-
-	if (!data)
-		return;
-
-	BUG_ON(data->host_cookie);
-
-	if (mmci_validate_data(host, data))
-		return;
+void mmci_dmae_unprep_data(struct mmci_host *host,
+			   struct mmc_data *data, int err)
 
-	if (!mmci_dma_prep_data(host, data, true))
-		data->host_cookie = ++host->next_cookie < 0 ?
-			1 : host->next_cookie;
-}
-
-static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
-			      int err)
 {
-	struct mmci_host *host = mmc_priv(mmc);
 	struct mmci_dmae_priv *dmae = host->dma_priv;
-	struct mmc_data *data = mrq->data;
-
-	if (!data || !data->host_cookie)
-		return;
 
 	mmci_dma_unmap(host, data);
 
@@ -768,10 +779,13 @@ static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
 
 		next->desc = NULL;
 		next->chan = NULL;
-		data->host_cookie = 0;
 	}
 }
 
+static struct mmci_host_ops mmci_variant_ops = {
+	.prep_data = mmci_dmae_prep_data,
+	.unprep_data = mmci_dmae_unprep_data,
+};
 #else
 /* Blank functions if the DMA engine is not available */
 static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
@@ -801,11 +815,42 @@ static inline int mmci_dma_start_data(struct mmci_host *host, unsigned int datac
 	return -ENOSYS;
 }
 
-#define mmci_pre_request NULL
-#define mmci_post_request NULL
-
+static struct mmci_host_ops mmci_variant_ops = {};
 #endif
 
+void mmci_variant_init(struct mmci_host *host)
+{
+	host->ops = &mmci_variant_ops;
+}
+
+static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct mmci_host *host = mmc_priv(mmc);
+	struct mmc_data *data = mrq->data;
+
+	if (!data)
+		return;
+
+	WARN_ON(data->host_cookie);
+
+	if (mmci_validate_data(host, data))
+		return;
+
+	mmci_prep_data(host, data, true);
+}
+
+static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
+			      int err)
+{
+	struct mmci_host *host = mmc_priv(mmc);
+	struct mmc_data *data = mrq->data;
+
+	if (!data || !data->host_cookie)
+		return;
+
+	mmci_unprep_data(host, data, err);
+}
+
 static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 {
 	struct variant_data *variant = host->variant;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 5bb1ce2..0f2f82f 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -273,6 +273,10 @@ struct variant_data {
 
 /* mmci variant callbacks */
 struct mmci_host_ops {
+	int (*prep_data)(struct mmci_host *host, struct mmc_data *data,
+			 bool next);
+	void (*unprep_data)(struct mmci_host *host, struct mmc_data *data,
+			    int err);
 	int (*dma_setup)(struct mmci_host *host);
 };
 
@@ -322,3 +326,9 @@ struct mmci_host {
 	s32			next_cookie;
 };
 
+void mmci_variant_init(struct mmci_host *host);
+
+int mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
+			bool next);
+void mmci_dmae_unprep_data(struct mmci_host *host, struct mmc_data *data,
+			   int err);
diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
index 1bb59cf..e3cbdda 100644
--- a/drivers/mmc/host/mmci_qcom_dml.c
+++ b/drivers/mmc/host/mmci_qcom_dml.c
@@ -180,6 +180,8 @@ static int qcom_dma_setup(struct mmci_host *host)
 }
 
 static struct mmci_host_ops qcom_variant_ops = {
+	.prep_data = mmci_dmae_prep_data,
+	.unprep_data = mmci_dmae_unprep_data,
 	.dma_setup = qcom_dma_setup,
 };
 
-- 
2.7.4

