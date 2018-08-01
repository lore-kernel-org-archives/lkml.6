Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541F8C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BF1208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12BF1208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389082AbeHALWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:22:39 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:38366 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389007AbeHALWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:22:38 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w719SakY016581;
        Wed, 1 Aug 2018 11:37:29 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2kgdxvjuxb-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 11:37:29 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2FCCA31;
        Wed,  1 Aug 2018 09:37:29 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1F7C9289D;
        Wed,  1 Aug 2018 09:37:28 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 1 Aug 2018
 11:37:28 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 1 Aug 2018
 11:37:27 +0200
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH 05/14] mmc: mmci: move mmci next cookie to mci host
Date:   Wed, 1 Aug 2018 11:36:52 +0200
Message-ID: <1533116221-380-6-git-send-email-ludovic.Barre@st.com>
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

This patch moves next cookie to mmci host structure to
share same cookie management between all variants.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 10 ++++------
 drivers/mmc/host/mmci.h |  2 ++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index bdc48c3..5646c2e6 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -418,7 +418,6 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
 struct dmaengine_next {
 	struct dma_async_tx_descriptor *dma_desc;
 	struct dma_chan	*dma_chan;
-	s32 cookie;
 };
 
 struct dmaengine_priv {
@@ -449,7 +448,7 @@ static int mmci_dma_setup(struct mmci_host *host)
 							 "tx");
 
 	/* initialize pre request cookie */
-	dmae->next_data.cookie = 1;
+	host->next_cookie = 1;
 
 	/*
 	 * If only an RX channel is specified, the driver will
@@ -716,7 +715,7 @@ static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
 	struct dmaengine_priv *dmae = host->dma_priv;
 	struct dmaengine_next *next = &dmae->next_data;
 
-	WARN_ON(data->host_cookie && data->host_cookie != next->cookie);
+	WARN_ON(data->host_cookie && data->host_cookie != host->next_cookie);
 	WARN_ON(!data->host_cookie && (next->dma_desc || next->dma_chan));
 
 	dmae->dma_desc_current = next->dma_desc;
@@ -728,9 +727,7 @@ static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
 static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct mmci_host *host = mmc_priv(mmc);
-	struct dmaengine_priv *dmae = host->dma_priv;
 	struct mmc_data *data = mrq->data;
-	struct dmaengine_next *nd = &dmae->next_data;
 
 	if (!data)
 		return;
@@ -741,7 +738,8 @@ static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		return;
 
 	if (!mmci_dma_prep_next(host, data))
-		data->host_cookie = ++nd->cookie < 0 ? 1 : nd->cookie;
+		data->host_cookie = ++host->next_cookie < 0 ?
+			1 : host->next_cookie;
 }
 
 static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 260a1de..d2ec4fd 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -318,6 +318,8 @@ struct mmci_host {
 	int (*get_rx_fifocnt)(struct mmci_host *h, u32 status, int remain);
 
 	void			*dma_priv;
+
+	s32			next_cookie;
 };
 
 void qcom_variant_init(struct mmci_host *host);
-- 
2.7.4

