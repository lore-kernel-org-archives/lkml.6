Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0FFC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E553E205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E553E205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeJBSxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:53:05 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:10522 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727586AbeJBSxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:53:04 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w92C4IVf012271;
        Tue, 2 Oct 2018 14:09:48 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2mv4mj179q-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 02 Oct 2018 14:09:48 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 68C4D38;
        Tue,  2 Oct 2018 12:09:47 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 469782A3C;
        Tue,  2 Oct 2018 12:09:47 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 2 Oct 2018
 14:09:47 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 2 Oct 2018
 14:09:46 +0200
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
Subject: [PATCH V4 05/25] mmc: mmci: add prepare/unprepare_data callbacks
Date:   Tue, 2 Oct 2018 14:09:07 +0200
Message-ID: <1538482167-13819-6-git-send-email-ludovic.Barre@st.com>
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
index 392fb59..7f66724 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -378,6 +378,31 @@ void mmci_dma_setup(struct mmci_host *host)
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
@@ -608,7 +633,7 @@ static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
 }
 
 /* prepares DMA channel and DMA descriptor, returns non-zero on failure */
-static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
+static int _mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
 				struct dma_chan **dma_chan,
 				struct dma_async_tx_descriptor **dma_desc)
 {
@@ -671,21 +696,24 @@ static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
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
 
@@ -698,7 +726,7 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 	if (!host->use_dma)
 		return -EINVAL;
 
-	ret = mmci_dma_prep_data(host, host->data, false);
+	ret = mmci_dmae_prep_data(host, host->data, false);
 	if (ret)
 		return ret;
 
@@ -745,32 +773,13 @@ static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
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
@@ -794,11 +803,12 @@ static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
 
 		next->desc = NULL;
 		next->chan = NULL;
-		data->host_cookie = 0;
 	}
 }
 
 static struct mmci_host_ops mmci_variant_ops = {
+	.prep_data = mmci_dmae_prep_data,
+	.unprep_data = mmci_dmae_unprep_data,
 	.dma_setup = mmci_dmae_setup,
 };
 #else
@@ -825,9 +835,6 @@ static inline int mmci_dma_start_data(struct mmci_host *host, unsigned int datac
 	return -ENOSYS;
 }
 
-#define mmci_pre_request NULL
-#define mmci_post_request NULL
-
 static struct mmci_host_ops mmci_variant_ops = {};
 #endif
 
@@ -836,6 +843,34 @@ void mmci_variant_init(struct mmci_host *host)
 	host->ops = &mmci_variant_ops;
 }
 
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
index 2524ed1..e43be60 100644
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
 
@@ -328,5 +332,9 @@ struct mmci_host {
 
 void mmci_variant_init(struct mmci_host *host);
 
+int mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
+			bool next);
+void mmci_dmae_unprep_data(struct mmci_host *host, struct mmc_data *data,
+			   int err);
 int mmci_dmae_setup(struct mmci_host *host);
 
diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
index c8d7592..9f60ac0 100644
--- a/drivers/mmc/host/mmci_qcom_dml.c
+++ b/drivers/mmc/host/mmci_qcom_dml.c
@@ -183,6 +183,8 @@ static int qcom_dma_setup(struct mmci_host *host)
 }
 
 static struct mmci_host_ops qcom_variant_ops = {
+	.prep_data = mmci_dmae_prep_data,
+	.unprep_data = mmci_dmae_unprep_data,
 	.dma_setup = qcom_dma_setup,
 };
 
-- 
2.7.4

