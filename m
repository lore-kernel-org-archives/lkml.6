Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD8AC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7553921531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7553921531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390003AbeIUPgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:36:19 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55827 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389632AbeIUPgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:36:19 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8L9iYV0008892;
        Fri, 21 Sep 2018 11:46:46 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2mmkmu38mh-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 21 Sep 2018 11:46:46 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BF50A3A;
        Fri, 21 Sep 2018 09:46:45 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A10CB2AC3;
        Fri, 21 Sep 2018 09:46:45 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 21 Sep
 2018 11:46:45 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 21 Sep
 2018 11:46:45 +0200
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
Subject: [PATCH V2 15/27] mmc: mmci: add set_clk/pwrreg callbacks
Date:   Fri, 21 Sep 2018 11:46:09 +0200
Message-ID: <1537523181-14578-16-git-send-email-ludovic.Barre@st.com>
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

This patch adds set_clkreg and set_pwrreg callbacks
at mmci_host_ops to allow to call specific variant.
extends visibility of mmci_write_clk/pwrreg functions
to be used into specific file variant.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 16 ++++++++++++----
 drivers/mmc/host/mmci.h |  5 +++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 1593942..9d93fe7 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -252,7 +252,7 @@ static void mmci_reg_delay(struct mmci_host *host)
 /*
  * This must be called with host->lock held
  */
-static void mmci_write_clkreg(struct mmci_host *host, u32 clk)
+void mmci_write_clkreg(struct mmci_host *host, u32 clk)
 {
 	if (host->clk_reg != clk) {
 		host->clk_reg = clk;
@@ -263,7 +263,7 @@ static void mmci_write_clkreg(struct mmci_host *host, u32 clk)
 /*
  * This must be called with host->lock held
  */
-static void mmci_write_pwrreg(struct mmci_host *host, u32 pwr)
+void mmci_write_pwrreg(struct mmci_host *host, u32 pwr)
 {
 	if (host->pwr_reg != pwr) {
 		host->pwr_reg = pwr;
@@ -1543,8 +1543,16 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	spin_lock_irqsave(&host->lock, flags);
 
-	mmci_set_clkreg(host, ios->clock);
-	mmci_write_pwrreg(host, pwr);
+	if (host->ops && host->ops->set_clkreg)
+		host->ops->set_clkreg(host, ios->clock);
+	else
+		mmci_set_clkreg(host, ios->clock);
+
+	if (host->ops && host->ops->set_pwrreg)
+		host->ops->set_pwrreg(host, pwr);
+	else
+		mmci_write_pwrreg(host, pwr);
+
 	mmci_reg_delay(host);
 
 	spin_unlock_irqrestore(&host->lock, flags);
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index cf48377..44e06bb 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -284,6 +284,8 @@ struct mmci_host_ops {
 	int (*dma_start)(struct mmci_host *host, unsigned int *datactrl);
 	void (*dma_finalize)(struct mmci_host *host, struct mmc_data *data);
 	void (*dma_error)(struct mmci_host *host);
+	void (*set_clkreg)(struct mmci_host *host, unsigned int desired);
+	void (*set_pwrreg)(struct mmci_host *host, unsigned int pwr);
 };
 
 struct mmci_host {
@@ -332,6 +334,9 @@ struct mmci_host {
 	s32			next_cookie;
 };
 
+void mmci_write_clkreg(struct mmci_host *host, u32 clk);
+void mmci_write_pwrreg(struct mmci_host *host, u32 pwr);
+
 void mmci_variant_init(struct mmci_host *host);
 
 int mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
-- 
2.7.4

