Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AB7C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A162085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A162085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeJHTVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:21:37 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:49441 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbeJHTVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 15:21:36 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w98C4RHX024179;
        Mon, 8 Oct 2018 14:09:39 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2mxjgxjvax-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 08 Oct 2018 14:09:39 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 563623A;
        Mon,  8 Oct 2018 12:09:36 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2205E2D01;
        Mon,  8 Oct 2018 12:09:36 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 8 Oct 2018
 14:09:35 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 8 Oct 2018
 14:09:35 +0200
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
Subject: [PATCH V6 04/23] mmc: mmci: add prepare/unprepare_data callbacks
Date:   Mon, 8 Oct 2018 14:08:36 +0200
Message-ID: <1539000535-13261-5-git-send-email-ludovic.Barre@st.com>
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

This patch adds prepare/unprepare callbacks to mmci_host_ops.
Like this mmci_pre/post_request can be generic, mmci_prepare_data
and mmci_unprepare_data provide common next_cookie management.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c          | 101 ++++++++++++++++++++++++++-------------
 drivers/mmc/host/mmci.h          |   8 ++++
 drivers/mmc/host/mmci_qcom_dml.c |   2 +
 3 files changed, 78 insertions(+), 33 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index f862a1b..4db2b3f 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -392,6 +392,31 @@ void mmci_dma_setup(struct mmci_host *host)
 	host->use_dma = true;
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
@@ -619,7 +644,7 @@ static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
 }
 
 /* prepares DMA channel and DMA descriptor, returns non-zero on failure */
-static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
+static int _mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
 				struct dma_chan **dma_chan,
 				struct dma_async_tx_descriptor **dma_desc)
 {
@@ -682,21 +707,24 @@ static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
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
 
+	if (!host->use_dma)
+		return -EINVAL;
+
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
 
@@ -709,7 +737,7 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 	if (!host->use_dma)
 		return -EINVAL;
 
-	ret = mmci_dma_prep_data(host, host->data, false);
+	ret = mmci_dmae_prep_data(host, host->data, false);
 	if (ret)
 		return ret;
 
@@ -756,32 +784,13 @@ static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
 	next->chan = NULL;
 }
 
-static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
-{
-	struct mmci_host *host = mmc_priv(mmc);
-	struct mmc_data *data = mrq->data;
-
-	if (!host->use_dma || !data)
-		return;
-
-	BUG_ON(data->host_cookie);
-
-	if (mmci_validate_data(host, data))
-		return;
-
-	if (!mmci_dma_prep_data(host, data, true))
-		data->host_cookie = ++host->next_cookie < 0 ?
-			1 : host->next_cookie;
-}
+void mmci_dmae_unprep_data(struct mmci_host *host,
+			   struct mmc_data *data, int err)
 
-static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
-			      int err)
 {
-	struct mmci_host *host = mmc_priv(mmc);
 	struct mmci_dmae_priv *dmae = host->dma_priv;
-	struct mmc_data *data = mrq->data;
 
-	if (!host->use_dma || !data || !data->host_cookie)
+	if (!host->use_dma)
 		return;
 
 	mmci_dma_unmap(host, data);
@@ -805,11 +814,12 @@ static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
 
 		next->desc = NULL;
 		next->chan = NULL;
-		data->host_cookie = 0;
 	}
 }
 
 static struct mmci_host_ops mmci_variant_ops = {
+	.prep_data = mmci_dmae_prep_data,
+	.unprep_data = mmci_dmae_unprep_data,
 	.dma_setup = mmci_dmae_setup,
 	.dma_release = mmci_dmae_release,
 };
@@ -838,11 +848,36 @@ static inline int mmci_dma_start_data(struct mmci_host *host, unsigned int datac
 	return -ENOSYS;
 }
 
-#define mmci_pre_request NULL
-#define mmci_post_request NULL
-
 #endif
 
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
index 1d5ba4e..decb1c7 100644
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
 	void (*dma_release)(struct mmci_host *host);
 };
@@ -327,6 +331,10 @@ struct mmci_host {
 
 #define dma_inprogress(host)	((host)->dma_in_progress)
 
+int mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
+			bool next);
+void mmci_dmae_unprep_data(struct mmci_host *host, struct mmc_data *data,
+			   int err);
 int mmci_dmae_setup(struct mmci_host *host);
 void mmci_dmae_release(struct mmci_host *host);
 
diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
index 92b03a3..156e30b 100644
--- a/drivers/mmc/host/mmci_qcom_dml.c
+++ b/drivers/mmc/host/mmci_qcom_dml.c
@@ -184,6 +184,8 @@ static int qcom_dma_setup(struct mmci_host *host)
 }
 
 static struct mmci_host_ops qcom_variant_ops = {
+	.prep_data = mmci_dmae_prep_data,
+	.unprep_data = mmci_dmae_unprep_data,
 	.dma_setup = qcom_dma_setup,
 	.dma_release = mmci_dmae_release,
 };
-- 
2.7.4

