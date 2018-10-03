Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C28C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE65213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PCm8eFu/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PCm8eFu/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE65213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbeJCTMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:12:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54724 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeJCTMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:12:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AC9E460B26; Wed,  3 Oct 2018 12:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538569464;
        bh=/jV6mSQjvnhxUE/dknnGvRHvlUpfpw48/IFY8peH4M0=;
        h=From:To:Cc:Subject:Date:From;
        b=PCm8eFu/CZCfTDZ/01rYTWwSBQTmWbckdis6+mUuYgRxMlooF6us4pl4SDe1k2HG4
         JCDvIwL9j5gUqJiMM3ZiBO2wqUkGC9tm3wOI23tTAM0uym8xBmV55l+d2nQRbQyYa8
         vUzMFidJgO5quwJL4ou+WPsgeLtNJvYV3WjZWL3I=
Received: from alokc-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokc@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1619D60B26;
        Wed,  3 Oct 2018 12:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538569464;
        bh=/jV6mSQjvnhxUE/dknnGvRHvlUpfpw48/IFY8peH4M0=;
        h=From:To:Cc:Subject:Date:From;
        b=PCm8eFu/CZCfTDZ/01rYTWwSBQTmWbckdis6+mUuYgRxMlooF6us4pl4SDe1k2HG4
         JCDvIwL9j5gUqJiMM3ZiBO2wqUkGC9tm3wOI23tTAM0uym8xBmV55l+d2nQRbQyYa8
         vUzMFidJgO5quwJL4ou+WPsgeLtNJvYV3WjZWL3I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1619D60B26
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=alokc@codeaurora.org
From:   Alok Chauhan <alokc@codeaurora.org>
To:     swboyd@chromium.org, dianders@chromium.org, dkota@codeaurora.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alok Chauhan <alokc@codeaurora.org>
Subject: [PATCH] soc: qcom: Add irq clear handling during SE init
Date:   Wed,  3 Oct 2018 17:53:50 +0530
Message-Id: <1538569430-32374-1-git-send-email-alokc@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when the kernel inits a SE, its quite possible we have pending interrupts
from bootloaders which did not handle/clear them. So do this in kernel at
the SE init, to avoid some of it causing bad behavior, while at it also
club all the register writes needed to clear the se irqs into a function
to avoid repeating it over.

Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
---
 drivers/soc/qcom/qcom-geni-se.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index feed3db2..1422fc5 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -215,6 +215,16 @@ static void geni_se_io_init(void __iomem *base)
 	writel_relaxed(FORCE_DEFAULT, base + GENI_FORCE_DEFAULT_REG);
 }
 
+static void geni_se_irq_clear(struct geni_se *se)
+{
+	writel_relaxed(0, se->base + SE_GSI_EVENT_EN);
+	writel_relaxed(0xffffffff, se->base + SE_GENI_M_IRQ_CLEAR);
+	writel_relaxed(0xffffffff, se->base + SE_GENI_S_IRQ_CLEAR);
+	writel_relaxed(0xffffffff, se->base + SE_DMA_TX_IRQ_CLR);
+	writel_relaxed(0xffffffff, se->base + SE_DMA_RX_IRQ_CLR);
+	writel_relaxed(0xffffffff, se->base + SE_IRQ_EN);
+}
+
 /**
  * geni_se_init() - Initialize the GENI serial engine
  * @se:		Pointer to the concerned serial engine.
@@ -228,6 +238,7 @@ void geni_se_init(struct geni_se *se, u32 rx_wm, u32 rx_rfr)
 {
 	u32 val;
 
+	geni_se_irq_clear(se);
 	geni_se_io_init(se->base);
 	geni_se_io_set_mode(se->base);
 
@@ -249,12 +260,7 @@ static void geni_se_select_fifo_mode(struct geni_se *se)
 	u32 proto = geni_se_read_proto(se);
 	u32 val;
 
-	writel_relaxed(0, se->base + SE_GSI_EVENT_EN);
-	writel_relaxed(0xffffffff, se->base + SE_GENI_M_IRQ_CLEAR);
-	writel_relaxed(0xffffffff, se->base + SE_GENI_S_IRQ_CLEAR);
-	writel_relaxed(0xffffffff, se->base + SE_DMA_TX_IRQ_CLR);
-	writel_relaxed(0xffffffff, se->base + SE_DMA_RX_IRQ_CLR);
-	writel_relaxed(0xffffffff, se->base + SE_IRQ_EN);
+	geni_se_irq_clear(se);
 
 	val = readl_relaxed(se->base + SE_GENI_M_IRQ_EN);
 	if (proto != GENI_SE_UART) {
@@ -277,12 +283,7 @@ static void geni_se_select_dma_mode(struct geni_se *se)
 {
 	u32 val;
 
-	writel_relaxed(0, se->base + SE_GSI_EVENT_EN);
-	writel_relaxed(0xffffffff, se->base + SE_GENI_M_IRQ_CLEAR);
-	writel_relaxed(0xffffffff, se->base + SE_GENI_S_IRQ_CLEAR);
-	writel_relaxed(0xffffffff, se->base + SE_DMA_TX_IRQ_CLR);
-	writel_relaxed(0xffffffff, se->base + SE_DMA_RX_IRQ_CLR);
-	writel_relaxed(0xffffffff, se->base + SE_IRQ_EN);
+	geni_se_irq_clear(se);
 
 	val = readl_relaxed(se->base + SE_GENI_DMA_MODE_EN);
 	val |= GENI_DMA_MODE_EN;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

