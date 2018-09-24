Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AD1C004D2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A4920874
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VTJ/5rP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A4920874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeIYF5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 01:57:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46870 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbeIYF5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 01:57:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id b129-v6so10059335pga.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 16:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GQx4+8piOC119OmgabNJqagqCh2OX3UghjZ88RjYxf4=;
        b=VTJ/5rP2sonjKvLxhEbufoWk6XWXXRnDr7j4Jt6Kti7JswJkDogvFL3FbQ2qqdbXSW
         BZaU58e0ZCWPxjdC3nEzcth7yrW5IycXOEt4QqWILNIpmsFSKNRQvTHl5uryhkokNZIZ
         GccXdd2I7Bfu23EGAeoljXTpMrImlAN4f1ZiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GQx4+8piOC119OmgabNJqagqCh2OX3UghjZ88RjYxf4=;
        b=lcp+aWZkBVVAYe5+8qkLXjHNNNC2V0U5RGUuaLp6wVz1Co445xzlRC4N9oucCgdDX/
         SB88XHnCMhCFP74qxMaW9O8eWvoK2M+ByGKXMr3/ZNstg14VYIIeFcjm0AylNwGceuaW
         D/3YJuzR6yesi7TBNUuB1PMWJYqf4NBmEtNvTnoQKvxMluycxVJN5ZiezCKUGpp3rGRL
         LimOL86LsLUnHvyH+aniv1bTDx5sA8WMva9jqvjDLwpgX0MP17FuRXb7mDTB4uKcZMh/
         iDn/gWozVyLQC0d52EaB7fl57D9CAny+7FzQsTL3XgVib4DII097QgMWWKAhbd/yh/Mb
         o48Q==
X-Gm-Message-State: ABuFfojfGoup88jOKdxeh671RMqapL44F4eraHJyvENrNDWgHqccXZpJ
        GUvOWpRxlK/+U117afWS2uko1A==
X-Google-Smtp-Source: ACcGV635s/VArenaFnlKcHRSBXuEnWtmaBXylOtbkUX4cNjMgbAF/Oyg88kgjR39y5RRE+xzggBMAA==
X-Received: by 2002:a62:b604:: with SMTP id j4-v6mr893492pff.199.1537833158075;
        Mon, 24 Sep 2018 16:52:38 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id d81-v6sm518993pfj.122.2018.09.24.16.52.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 16:52:37 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH v3 2/3] i2c: i2c-qcom-geni: Simplify tx/rx functions
Date:   Mon, 24 Sep 2018 16:52:34 -0700
Message-Id: <20180924235235.182649-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20180924235235.182649-1-swboyd@chromium.org>
References: <20180924235235.182649-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We never really look at the 'ret' local variable in these functions, so
let's remove it to make way for shorter and simpler code. Furthermore,
we can shorten some lines by adding two local variables for the SE and
the message length so that everything fits in 80 columns and testing the
'dma_buf' local variable in lieu of the 'mode' local variable.  And
kernel style is to leave the return statement by itself, detached from
the rest of the function.

Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Cc: Sagar Dharia <sdharia@codeaurora.org>
Cc: Girish Mahadevan <girishm@codeaurora.org>
Cc: Doug Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 79 ++++++++++++++----------------
 1 file changed, 36 insertions(+), 43 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 9f2eb02481d3..0b466835cf40 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -365,29 +365,24 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 				u32 m_param)
 {
 	dma_addr_t rx_dma;
-	enum geni_se_xfer_mode mode;
-	unsigned long time_left = XFER_TIMEOUT;
+	unsigned long time_left;
 	void *dma_buf;
+	struct geni_se *se = &gi2c->se;
+	size_t len = msg->len;
 
-	gi2c->cur = msg;
-	mode = GENI_SE_FIFO;
 	dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
 	if (dma_buf)
-		mode = GENI_SE_DMA;
-
-	geni_se_select_mode(&gi2c->se, mode);
-	writel_relaxed(msg->len, gi2c->se.base + SE_I2C_RX_TRANS_LEN);
-	geni_se_setup_m_cmd(&gi2c->se, I2C_READ, m_param);
-	if (mode == GENI_SE_DMA) {
-		int ret;
-
-		ret = geni_se_rx_dma_prep(&gi2c->se, dma_buf, msg->len,
-								&rx_dma);
-		if (ret) {
-			mode = GENI_SE_FIFO;
-			geni_se_select_mode(&gi2c->se, mode);
-			i2c_put_dma_safe_msg_buf(dma_buf, msg, false);
-		}
+		geni_se_select_mode(se, GENI_SE_DMA);
+	else
+		geni_se_select_mode(se, GENI_SE_FIFO);
+
+	writel_relaxed(len, se->base + SE_I2C_RX_TRANS_LEN);
+	geni_se_setup_m_cmd(se, I2C_READ, m_param);
+
+	if (dma_buf && geni_se_rx_dma_prep(se, dma_buf, len, &rx_dma)) {
+		geni_se_select_mode(se, GENI_SE_FIFO);
+		i2c_put_dma_safe_msg_buf(dma_buf, msg, false);
+		dma_buf = NULL;
 	}
 
 	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
@@ -395,12 +390,13 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 		geni_i2c_abort_xfer(gi2c);
 
 	gi2c->cur_rd = 0;
-	if (mode == GENI_SE_DMA) {
+	if (dma_buf) {
 		if (gi2c->err)
 			geni_i2c_rx_fsm_rst(gi2c);
-		geni_se_rx_dma_unprep(&gi2c->se, rx_dma, msg->len);
+		geni_se_rx_dma_unprep(se, rx_dma, len);
 		i2c_put_dma_safe_msg_buf(dma_buf, msg, !gi2c->err);
 	}
+
 	return gi2c->err;
 }
 
@@ -408,45 +404,41 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 				u32 m_param)
 {
 	dma_addr_t tx_dma;
-	enum geni_se_xfer_mode mode;
 	unsigned long time_left;
 	void *dma_buf;
+	struct geni_se *se = &gi2c->se;
+	size_t len = msg->len;
 
-	gi2c->cur = msg;
-	mode = GENI_SE_FIFO;
 	dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
 	if (dma_buf)
-		mode = GENI_SE_DMA;
-
-	geni_se_select_mode(&gi2c->se, mode);
-	writel_relaxed(msg->len, gi2c->se.base + SE_I2C_TX_TRANS_LEN);
-	geni_se_setup_m_cmd(&gi2c->se, I2C_WRITE, m_param);
-	if (mode == GENI_SE_DMA) {
-		int ret;
-
-		ret = geni_se_tx_dma_prep(&gi2c->se, dma_buf, msg->len,
-								&tx_dma);
-		if (ret) {
-			mode = GENI_SE_FIFO;
-			geni_se_select_mode(&gi2c->se, mode);
-			i2c_put_dma_safe_msg_buf(dma_buf, msg, false);
-		}
+		geni_se_select_mode(se, GENI_SE_DMA);
+	else
+		geni_se_select_mode(se, GENI_SE_FIFO);
+
+	writel_relaxed(len, se->base + SE_I2C_TX_TRANS_LEN);
+	geni_se_setup_m_cmd(se, I2C_WRITE, m_param);
+
+	if (dma_buf && geni_se_tx_dma_prep(se, dma_buf, len, &tx_dma)) {
+		geni_se_select_mode(se, GENI_SE_FIFO);
+		i2c_put_dma_safe_msg_buf(dma_buf, msg, false);
+		dma_buf = NULL;
 	}
 
-	if (mode == GENI_SE_FIFO) /* Get FIFO IRQ */
-		writel_relaxed(1, gi2c->se.base + SE_GENI_TX_WATERMARK_REG);
+	if (!dma_buf) /* Get FIFO IRQ */
+		writel_relaxed(1, se->base + SE_GENI_TX_WATERMARK_REG);
 
 	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
 	if (!time_left)
 		geni_i2c_abort_xfer(gi2c);
 
 	gi2c->cur_wr = 0;
-	if (mode == GENI_SE_DMA) {
+	if (dma_buf) {
 		if (gi2c->err)
 			geni_i2c_tx_fsm_rst(gi2c);
-		geni_se_tx_dma_unprep(&gi2c->se, tx_dma, msg->len);
+		geni_se_tx_dma_unprep(se, tx_dma, len);
 		i2c_put_dma_safe_msg_buf(dma_buf, msg, !gi2c->err);
 	}
+
 	return gi2c->err;
 }
 
@@ -474,6 +466,7 @@ static int geni_i2c_xfer(struct i2c_adapter *adap,
 
 		m_param |= ((msgs[i].addr << SLV_ADDR_SHFT) & SLV_ADDR_MSK);
 
+		gi2c->cur = &msgs[i];
 		if (msgs[i].flags & I2C_M_RD)
 			ret = geni_i2c_rx_one_msg(gi2c, &msgs[i], m_param);
 		else
-- 
Sent by a computer through tubes

