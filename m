Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C1AECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D79F21531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D79F21531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389843AbeIUPfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:35:36 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:37992 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389624AbeIUPff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:35:35 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8L9iYaR008884;
        Fri, 21 Sep 2018 11:46:40 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2mmkmu38kt-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 21 Sep 2018 11:46:40 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EF0C341;
        Fri, 21 Sep 2018 09:46:39 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9D0C82AD2;
        Fri, 21 Sep 2018 09:46:39 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 21 Sep
 2018 11:46:39 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 21 Sep
 2018 11:46:39 +0200
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
Subject: [PATCH V2 09/27] mmc: mmci: modify dma_setup callback
Date:   Fri, 21 Sep 2018 11:46:03 +0200
Message-ID: <1537523181-14578-10-git-send-email-ludovic.Barre@st.com>
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

This patch creates a generic mmci_dma_setup which calls
dma_setup callback and manages common next_cookie.
This patch is needed for sdmmc variant which has a different
dma settings.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

# Conflicts:
#	drivers/mmc/host/mmci.h

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c          | 25 +++++++++++++------------
 drivers/mmc/host/mmci.h          |  1 +
 drivers/mmc/host/mmci_qcom_dml.c |  2 ++
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 55c4222..2a433ed 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -398,6 +398,17 @@ void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
 		host->ops->get_next_data(host, data);
 }
 
+int mmci_dma_setup(struct mmci_host *host)
+{
+	if (!host->ops || !host->ops->dma_setup)
+		return 0;
+
+	/* initialize pre request cookie */
+	host->next_cookie = 1;
+
+	return host->ops->dma_setup(host);
+}
+
 static void
 mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 {
@@ -472,7 +483,7 @@ struct mmci_dmae_priv {
 
 #define mmci_dmae_inprogress(dmae) ((dmae)->in_progress)
 
-static int mmci_dma_setup(struct mmci_host *host)
+int mmci_dmae_setup(struct mmci_host *host)
 {
 	const char *rxname, *txname;
 	struct mmci_dmae_priv *dmae;
@@ -488,9 +499,6 @@ static int mmci_dma_setup(struct mmci_host *host)
 	dmae->tx_channel = dma_request_slave_channel(mmc_dev(host->mmc),
 						     "tx");
 
-	/* initialize pre request cookie */
-	host->next_cookie = 1;
-
 	/*
 	 * If only an RX channel is specified, the driver will
 	 * attempt to use it bidirectionally, however if it is
@@ -531,9 +539,6 @@ static int mmci_dma_setup(struct mmci_host *host)
 			host->mmc->max_seg_size = max_seg_size;
 	}
 
-	if (host->ops && host->ops->dma_setup)
-		return host->ops->dma_setup(host);
-
 	return 0;
 }
 
@@ -793,14 +798,10 @@ static struct mmci_host_ops mmci_variant_ops = {
 	.prep_data = mmci_dmae_prep_data,
 	.unprep_data = mmci_dmae_unprep_data,
 	.get_next_data = mmci_dmae_get_next_data,
+	.dma_setup = mmci_dmae_setup,
 };
 #else
 /* Blank functions if the DMA engine is not available */
-static inline int mmci_dma_setup(struct mmci_host *host)
-{
-	return 0;
-}
-
 static inline void mmci_dma_release(struct mmci_host *host)
 {
 }
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 4f73070..72fe02d 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -334,4 +334,5 @@ int mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
 void mmci_dmae_unprep_data(struct mmci_host *host, struct mmc_data *data,
 			   int err);
 void mmci_dmae_get_next_data(struct mmci_host *host, struct mmc_data *data);
+int mmci_dmae_setup(struct mmci_host *host);
 
diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
index 432a823..003c497 100644
--- a/drivers/mmc/host/mmci_qcom_dml.c
+++ b/drivers/mmc/host/mmci_qcom_dml.c
@@ -126,6 +126,8 @@ static int qcom_dma_setup(struct mmci_host *host)
 	int consumer_id, producer_id;
 	struct device_node *np = host->mmc->parent->of_node;
 
+	mmci_dmae_setup(host);
+
 	consumer_id = of_get_dml_pipe_index(np, "tx");
 	producer_id = of_get_dml_pipe_index(np, "rx");
 
-- 
2.7.4

