Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CC3ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5480F20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5480F20C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbeIRQbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 12:31:10 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55570 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729632AbeIRQ26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 12:28:58 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8IAsMjZ004541;
        Tue, 18 Sep 2018 12:56:13 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2mgryf0w56-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 18 Sep 2018 12:56:13 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BC22531;
        Tue, 18 Sep 2018 10:56:12 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6E7392A9D;
        Tue, 18 Sep 2018 10:56:12 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 18 Sep
 2018 12:56:12 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 18 Sep
 2018 12:56:12 +0200
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
Subject: [PATCH V2 03/27] mmc: mmci: convert dma_setup callback to return an int
Date:   Tue, 18 Sep 2018 12:55:20 +0200
Message-ID: <1537268144-21152-4-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537268144-21152-1-git-send-email-ludovic.Barre@st.com>
References: <1537268144-21152-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-18_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch converts dma_setup callback to return an integer
This patch is needed to prepare sdmmc variant with internal dma

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c          | 16 +++++++++++-----
 drivers/mmc/host/mmci.h          |  2 +-
 drivers/mmc/host/mmci_qcom_dml.c |  6 ++++--
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 7d22cb9..077d4a7 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -415,7 +415,7 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
  * no custom DMA interfaces are supported.
  */
 #ifdef CONFIG_DMA_ENGINE
-static void mmci_dma_setup(struct mmci_host *host)
+static int mmci_dma_setup(struct mmci_host *host)
 {
 	const char *rxname, *txname;
 
@@ -466,7 +466,9 @@ static void mmci_dma_setup(struct mmci_host *host)
 	}
 
 	if (host->ops && host->ops->dma_setup)
-		host->ops->dma_setup(host);
+		return host->ops->dma_setup(host);
+
+	return 0;
 }
 
 /*
@@ -515,7 +517,7 @@ static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
 	u32 status;
 	int i;
 
-	if (!__dma_inprogress(dmae))
+	if (!__dma_inprogress(host))
 		return;
 
 	/* Wait up to 1ms for the DMA to complete */
@@ -741,8 +743,10 @@ static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
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
@@ -1796,7 +1800,9 @@ static int mmci_probe(struct amba_device *dev,
 		 amba_rev(dev), (unsigned long long)dev->res.start,
 		 dev->irq[0], dev->irq[1]);
 
-	mmci_dma_setup(host);
+	ret = mmci_dma_setup(host);
+	if (ret)
+		goto clk_disable;
 
 	pm_runtime_set_autosuspend_delay(&dev->dev, 50);
 	pm_runtime_use_autosuspend(&dev->dev);
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index f1ec066..312ad5c 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -273,7 +273,7 @@ struct variant_data {
 
 /* mmci variant callbacks */
 struct mmci_host_ops {
-	void (*dma_setup)(struct mmci_host *host);
+	int (*dma_setup)(struct mmci_host *host);
 };
 
 struct mmci_host_next {
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

