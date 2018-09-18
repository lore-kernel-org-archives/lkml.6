Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2ECDECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566102150C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OTIlO/6z";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FlfYGttM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 566102150C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbeIRXmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 19:42:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:32966 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729689AbeIRXmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 19:42:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BFE736074D; Tue, 18 Sep 2018 18:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537294147;
        bh=rBs8x2AgKumxNX3WAwpfOuOZu/5EEEuMbmOtIRPGMMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OTIlO/6zajud+iidMFSMBxeTKYSesgOIa6LO6GyyxUQu++4uOCTpFTzp+9vj4oe23
         6MxlHKx5/mcqFLrrezU0is3fiVolcxgqIADWs8P8UMplVhhFP7tPQXV1iQd9B7iiYx
         xa9A3OKW/yJq8P3wv9qMkkUV8/q49xTA4e0Sw4Sg=
Received: from dkota-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dkota@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B96D16074D;
        Tue, 18 Sep 2018 18:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537294146;
        bh=rBs8x2AgKumxNX3WAwpfOuOZu/5EEEuMbmOtIRPGMMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FlfYGttM8qja6iW+RB43OjhB2DhxfH1KC49/E0Cf8+XgLwcTJPNvOuJuCtbIAIc1R
         qUx+FYHmigGwYJ2eMDfXyuppo1O7bBjUBnROj7oIKUe+IU+N9/OtGUQDQfxH+1v16e
         j2uafRT1zqEiBrzUSnpaUOOGWxYJBxPewGI5mRbQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B96D16074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=dkota@codeaurora.org
From:   Dilip Kota <dkota@codeaurora.org>
To:     swboyd@chromium.org, dianders@chromium.org, broonie@kernel.org,
        mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Dilip Kota <dkota@codeaurora.org>
Subject: [PATCH V4 4/4] spi: spi-geni-qcom: Plugin API to assert and de-assert Chipselect
Date:   Tue, 18 Sep 2018 23:37:26 +0530
Message-Id: <1537294047-12093-5-git-send-email-dkota@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537294047-12093-1-git-send-email-dkota@codeaurora.org>
References: <1537294047-12093-1-git-send-email-dkota@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Plugin set cs API to the SPI framework so that
framework can do chipselect assert de-assert
during  SPI transfers.

Signed-off-by: Dilip Kota <dkota@codeaurora.org>
---
 drivers/spi/spi-geni-qcom.c | 65 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 949b853..5cfb4f2 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -66,6 +66,13 @@
 
 static irqreturn_t geni_spi_isr(int irq, void *data);
 
+/* SPI M_COMMAND OPCODE */
+enum spi_mcmd_code {
+	CMD_NONE,
+	CMD_XFER,
+	CMD_CS,
+};
+
 struct spi_geni_master {
 	struct geni_se se;
 	struct device *dev;
@@ -81,8 +88,12 @@ struct spi_geni_master {
 	struct completion xfer_done;
 	unsigned int oversampling;
 	spinlock_t lock;
+	unsigned int cur_mcmd;
 };
 
+static void handle_fifo_timeout(struct spi_master *spi,
+				struct spi_message *msg);
+
 static int get_spi_clk_cfg(unsigned int speed_hz,
 			struct spi_geni_master *mas,
 			unsigned int *clk_idx,
@@ -113,6 +124,31 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
 	return ret;
 }
 
+static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
+{
+	struct spi_geni_master *mas = spi_master_get_devdata(slv->master);
+	struct spi_master *spi = dev_get_drvdata(mas->dev);
+	struct geni_se *se = &mas->se;
+	unsigned long timeout;
+
+	reinit_completion(&mas->xfer_done);
+	pm_runtime_get_sync(mas->dev);
+	if (!(slv->mode & SPI_CS_HIGH))
+		set_flag = !set_flag;
+
+	mas->cur_mcmd = CMD_CS;
+	if (set_flag)
+		geni_se_setup_m_cmd(se, SPI_CS_ASSERT, 0);
+	else
+		geni_se_setup_m_cmd(se, SPI_CS_DEASSERT, 0);
+
+	timeout = wait_for_completion_timeout(&mas->xfer_done, HZ);
+	if (!timeout)
+		handle_fifo_timeout(spi, NULL);
+
+	pm_runtime_put(mas->dev);
+}
+
 static void spi_setup_word_len(struct spi_geni_master *mas, u16 mode,
 					unsigned int bits_per_word)
 {
@@ -249,7 +285,7 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 				struct spi_geni_master *mas,
 				u16 mode, struct spi_master *spi)
 {
-	u32 m_cmd = 0, m_param = 0;
+	u32 m_cmd = 0;
 	u32 spi_tx_cfg, trans_len;
 	struct geni_se *se = &mas->se;
 
@@ -305,21 +341,7 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 		trans_len = (xfer->len / bytes_per_word) & TRANS_LEN_MSK;
 	}
 
-	/*
-	 * If CS change flag is set, then toggle the CS line in between
-	 * transfers and keep CS asserted after the last transfer.
-	 * Else if keep CS flag asserted in between transfers and de-assert
-	 * CS after the last message.
-	 */
-	if (xfer->cs_change) {
-		if (list_is_last(&xfer->transfer_list,
-				&spi->cur_msg->transfers))
-			m_param = FRAGMENTATION;
-	} else {
-		if (!list_is_last(&xfer->transfer_list,
-				&spi->cur_msg->transfers))
-			m_param = FRAGMENTATION;
-	}
+
 
 	mas->cur_xfer = xfer;
 	if (m_cmd & SPI_TX_ONLY) {
@@ -332,8 +354,8 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 		mas->rx_rem_bytes = xfer->len;
 	}
 	writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
-	geni_se_setup_m_cmd(se, m_cmd, m_param);
-
+	mas->cur_mcmd = CMD_XFER;
+	geni_se_setup_m_cmd(se, m_cmd, FRAGMENTATION);
 	/*
 	 * TX_WATERMARK_REG should be set after SPI configuration and
 	 * setting up GENI SE engine, as driver starts data transfer
@@ -489,7 +511,11 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 		ret = geni_spi_handle_tx(mas);
 
 	if (m_irq & M_CMD_DONE_EN) {
-		spi_finalize_current_transfer(spi);
+		if (mas->cur_mcmd == CMD_XFER)
+			spi_finalize_current_transfer(spi);
+		else if (mas->cur_mcmd == CMD_CS)
+			complete(&mas->xfer_done);
+		mas->cur_mcmd = CMD_NONE;
 		/*
 		 * If this happens, then a CMD_DONE came before all the Tx
 		 * buffer bytes were sent out. This is unusual, log this
@@ -572,6 +598,7 @@ static int spi_geni_probe(struct platform_device *pdev)
 	spi->transfer_one = spi_geni_transfer_one;
 	spi->auto_runtime_pm = true;
 	spi->handle_err = handle_fifo_timeout;
+	spi->set_cs = spi_geni_set_cs;
 
 	init_completion(&mas->xfer_done);
 	spin_lock_init(&mas->lock);
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

