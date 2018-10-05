Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7527BC65BA9
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4389C2087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4389C2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbeJEUWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 16:22:30 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:8271 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727775AbeJEUW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 16:22:29 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w95DJ1LT015078;
        Fri, 5 Oct 2018 15:23:32 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2msxh73acy-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 05 Oct 2018 15:23:32 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4F3A531;
        Fri,  5 Oct 2018 13:23:31 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2E9D02C92;
        Fri,  5 Oct 2018 13:23:31 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 5 Oct 2018
 15:23:31 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 5 Oct 2018
 15:23:30 +0200
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
Subject: [PATCH V5 08/24] mmc: mmci: add dma_finalize callback
Date:   Fri, 5 Oct 2018 15:22:46 +0200
Message-ID: <1538745782-27446-9-git-send-email-ludovic.Barre@st.com>
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

This patch adds dma_finalize callback at mmci_host_ops
to allow to call specific variant.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c          | 19 ++++++++++++-------
 drivers/mmc/host/mmci.h          |  3 ++-
 drivers/mmc/host/mmci_qcom_dml.c |  1 +
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 6a2966a..2d88f8c 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -456,6 +456,15 @@ int mmci_dma_start(struct mmci_host *host, unsigned int datactrl)
 	return 0;
 }
 
+void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
+{
+	if (!host->use_dma)
+		return;
+
+	if (host->ops && host->ops->dma_finalize)
+		host->ops->dma_finalize(host, data);
+}
+
 static void
 mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 {
@@ -635,13 +644,13 @@ static void mmci_dma_data_error(struct mmci_host *host)
 	mmci_dma_unmap(host, host->data);
 }
 
-static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
+void mmci_dmae_finalize(struct mmci_host *host, struct mmc_data *data)
 {
 	struct mmci_dmae_priv *dmae = host->dma_priv;
 	u32 status;
 	int i;
 
-	if (!host->use_dma || !dma_inprogress(host))
+	if (!dma_inprogress(host))
 		return;
 
 	/* Wait up to 1ms for the DMA to complete */
@@ -838,6 +847,7 @@ static struct mmci_host_ops mmci_variant_ops = {
 	.dma_setup = mmci_dmae_setup,
 	.dma_release = mmci_dmae_release,
 	.dma_start = mmci_dmae_start,
+	.dma_finalize = mmci_dmae_finalize,
 };
 
 void mmci_variant_init(struct mmci_host *host)
@@ -846,11 +856,6 @@ void mmci_variant_init(struct mmci_host *host)
 }
 #else
 /* Blank functions if the DMA engine is not available */
-static inline void mmci_dma_finalize(struct mmci_host *host,
-				     struct mmc_data *data)
-{
-}
-
 static inline void mmci_dma_data_error(struct mmci_host *host)
 {
 }
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index bbdfa26..49274cb 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -281,6 +281,7 @@ struct mmci_host_ops {
 	int (*dma_setup)(struct mmci_host *host);
 	void (*dma_release)(struct mmci_host *host);
 	int (*dma_start)(struct mmci_host *host, unsigned int *datactrl);
+	void (*dma_finalize)(struct mmci_host *host, struct mmc_data *data);
 };
 
 struct mmci_host {
@@ -349,4 +350,4 @@ void mmci_dmae_get_next_data(struct mmci_host *host, struct mmc_data *data);
 int mmci_dmae_setup(struct mmci_host *host);
 void mmci_dmae_release(struct mmci_host *host);
 int mmci_dmae_start(struct mmci_host *host, unsigned int *datactrl);
-
+void mmci_dmae_finalize(struct mmci_host *host, struct mmc_data *data);
diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
index ae1c193..9725762 100644
--- a/drivers/mmc/host/mmci_qcom_dml.c
+++ b/drivers/mmc/host/mmci_qcom_dml.c
@@ -189,6 +189,7 @@ static struct mmci_host_ops qcom_variant_ops = {
 	.dma_setup = qcom_dma_setup,
 	.dma_release = mmci_dmae_release,
 	.dma_start = mmci_dmae_start,
+	.dma_finalize = mmci_dmae_finalize,
 };
 
 void qcom_variant_init(struct mmci_host *host)
-- 
2.7.4

