Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FE0C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3229E20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3229E20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389110AbeHALWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:22:39 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:42355 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389004AbeHALWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:22:37 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w719TSGg009408;
        Wed, 1 Aug 2018 11:37:30 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2kjnaddbd7-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 11:37:30 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 67D3E34;
        Wed,  1 Aug 2018 09:37:30 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0E229288E;
        Wed,  1 Aug 2018 09:37:29 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 1 Aug 2018
 11:37:28 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 1 Aug 2018
 11:37:28 +0200
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH 06/14] mmc: mmci: merge prepare data functions
Date:   Wed, 1 Aug 2018 11:36:53 +0200
Message-ID: <1533116221-380-7-git-send-email-ludovic.Barre@st.com>
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

This patch merges the prepare data functions.
This allows to define a single access to prepare data service.
This prepares integration for mmci host ops.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 5646c2e6..e4d80f1 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -651,11 +651,16 @@ static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
 	return -ENOMEM;
 }
 
-static inline int mmci_dma_prep_data(struct mmci_host *host,
-				     struct mmc_data *data)
+static inline int mmci_dma_prepare_data(struct mmci_host *host,
+					struct mmc_data *data,
+					bool next)
 {
 	struct dmaengine_priv *dmae = host->dma_priv;
+	struct dmaengine_next *nd = &dmae->next_data;
 
+	if (next)
+		return __mmci_dma_prep_data(host, data, &nd->dma_chan,
+					    &nd->dma_desc);
 	/* Check if next job is already prepared. */
 	if (dmae->dma_current && dmae->dma_desc_current)
 		return 0;
@@ -665,22 +670,13 @@ static inline int mmci_dma_prep_data(struct mmci_host *host,
 				    &dmae->dma_desc_current);
 }
 
-static inline int mmci_dma_prep_next(struct mmci_host *host,
-				     struct mmc_data *data)
-{
-	struct dmaengine_priv *dmae = host->dma_priv;
-	struct dmaengine_next *nd = &dmae->next_data;
-
-	return __mmci_dma_prep_data(host, data, &nd->dma_chan, &nd->dma_desc);
-}
-
 static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 {
 	struct dmaengine_priv *dmae = host->dma_priv;
 	struct mmc_data *data = host->data;
 	int ret;
 
-	ret = mmci_dma_prep_data(host, host->data);
+	ret = mmci_dma_prepare_data(host, host->data, false);
 	if (ret)
 		return ret;
 
@@ -737,7 +733,7 @@ static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	if (mmci_validate_data(host, data))
 		return;
 
-	if (!mmci_dma_prep_next(host, data))
+	if (!mmci_dma_prepare_data(host, data, true))
 		data->host_cookie = ++host->next_cookie < 0 ?
 			1 : host->next_cookie;
 }
-- 
2.7.4

