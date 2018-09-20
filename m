Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F34ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5202021525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k21blh7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5202021525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387858AbeITXsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:48:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35373 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732340AbeITXsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:48:09 -0400
Received: by mail-pl1-f195.google.com with SMTP id g2-v6so4710929plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 11:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nMypszJCM6rR4MByZFa6dYUd8t3+l7c4ueckXilTbvg=;
        b=k21blh7hy8Ce5BlXDiDzSdusVN1AiqzVrcdC1jGG4IAAFjnt8lYAXtmWIkh0B8qhyu
         VdrAt61irlrJmYsmopGLHIPj93jwwd+bkica3d8V4dl+Mg9qISOQShW/izUZyjkahU46
         1ZH0dFP4a28/hoiTGhDlCw/jjDdQbWQ8kZjBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nMypszJCM6rR4MByZFa6dYUd8t3+l7c4ueckXilTbvg=;
        b=hVuJQ0FiSzjhtaQ+kg0CwxtkOYCl7xlbosZLz+r/3QlLdZbhoaPRGFIHaYZGYopTpb
         CPkmf3DO6eQxMuLhy/J48X1DaHFpQqGVzGgUqBpa5acbzheFyYTnH6Y4PudMjbpELdBU
         M3mGMaHHpvxj71Z+j2I4/jZ1YUHssJEcP0RRDgZhLg3be7bkVFNXbNZ2iKuc9Plh39bu
         /xq6aiDsx2CwronRhpP5HS6v1TFqEtEqAKRVm/3xI70WfSrTenpA16El0Qm6jO/nrN17
         jmKxlTMAJmX3CkiMg2HE8bHNOKmJmTEI6CKjv6WyZVIDdXgULfA9vfB9U1+IwdMlBhp5
         I+Fw==
X-Gm-Message-State: APzg51BnBMbJU0BD9rH5MVj5EtZihQG29yNh3s3dWJU3lVQ6Ni41ZAV8
        J0/mRGlm8ENdxkVUicqkV67VBeb2PYU=
X-Google-Smtp-Source: ANB0VdY59cZA5M0ZMrtIih4RSdE1OjiZe51IkOKItIyYNNGWKgnIhAbEHqoZavaz5c/6kEKvFSGhmg==
X-Received: by 2002:a17:902:3fa5:: with SMTP id a34-v6mr40709689pld.244.1537466608974;
        Thu, 20 Sep 2018 11:03:28 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id h124-v6sm2941874pfg.112.2018.09.20.11.03.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 11:03:28 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>
Subject: [PATCH v2 2/2] i2c: i2c-qcom-geni: Simplify tx/rx functions
Date:   Thu, 20 Sep 2018 11:03:23 -0700
Message-Id: <20180920180323.217377-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
In-Reply-To: <20180920180323.217377-1-swboyd@chromium.org>
References: <20180920180323.217377-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We never really look at the 'ret' local variable in these functions, so
let's remove it to make way for shorter and simpler code. Furthermore,
we can shorten some lines by adding two local variables for the SE and
the message length so that everything fits in 80 columns. And kernel
style is to leave the return statement by itself, detached from the rest
of the function.

Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Cc: Sagar Dharia <sdharia@codeaurora.org>
Cc: Girish Mahadevan <girishm@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 54 ++++++++++++++----------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 9f2eb02481d3..1215bb21c9f1 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -368,6 +368,8 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 	enum geni_se_xfer_mode mode;
 	unsigned long time_left = XFER_TIMEOUT;
 	void *dma_buf;
+	struct geni_se *se = &gi2c->se;
+	size_t len = msg->len;
 
 	gi2c->cur = msg;
 	mode = GENI_SE_FIFO;
@@ -375,19 +377,14 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 	if (dma_buf)
 		mode = GENI_SE_DMA;
 
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
+	geni_se_select_mode(se, mode);
+	writel_relaxed(len, se->base + SE_I2C_RX_TRANS_LEN);
+	geni_se_setup_m_cmd(se, I2C_READ, m_param);
+
+	if (dma_buf && geni_se_rx_dma_prep(se, dma_buf, len, &rx_dma)) {
+		mode = GENI_SE_FIFO;
+		geni_se_select_mode(se, mode);
+		i2c_put_dma_safe_msg_buf(dma_buf, msg, false);
 	}
 
 	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
@@ -398,9 +395,10 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 	if (mode == GENI_SE_DMA) {
 		if (gi2c->err)
 			geni_i2c_rx_fsm_rst(gi2c);
-		geni_se_rx_dma_unprep(&gi2c->se, rx_dma, msg->len);
+		geni_se_rx_dma_unprep(se, rx_dma, len);
 		i2c_put_dma_safe_msg_buf(dma_buf, msg, !gi2c->err);
 	}
+
 	return gi2c->err;
 }
 
@@ -411,6 +409,8 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 	enum geni_se_xfer_mode mode;
 	unsigned long time_left;
 	void *dma_buf;
+	struct geni_se *se = &gi2c->se;
+	size_t len = msg->len;
 
 	gi2c->cur = msg;
 	mode = GENI_SE_FIFO;
@@ -418,23 +418,18 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 	if (dma_buf)
 		mode = GENI_SE_DMA;
 
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
+	geni_se_select_mode(se, mode);
+	writel_relaxed(len, se->base + SE_I2C_TX_TRANS_LEN);
+	geni_se_setup_m_cmd(se, I2C_WRITE, m_param);
+
+	if (dma_buf && geni_se_tx_dma_prep(se, dma_buf, len, &tx_dma)) {
+		mode = GENI_SE_FIFO;
+		geni_se_select_mode(se, mode);
+		i2c_put_dma_safe_msg_buf(dma_buf, msg, false);
 	}
 
 	if (mode == GENI_SE_FIFO) /* Get FIFO IRQ */
-		writel_relaxed(1, gi2c->se.base + SE_GENI_TX_WATERMARK_REG);
+		writel_relaxed(1, se->base + SE_GENI_TX_WATERMARK_REG);
 
 	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
 	if (!time_left)
@@ -444,9 +439,10 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 	if (mode == GENI_SE_DMA) {
 		if (gi2c->err)
 			geni_i2c_tx_fsm_rst(gi2c);
-		geni_se_tx_dma_unprep(&gi2c->se, tx_dma, msg->len);
+		geni_se_tx_dma_unprep(se, tx_dma, len);
 		i2c_put_dma_safe_msg_buf(dma_buf, msg, !gi2c->err);
 	}
+
 	return gi2c->err;
 }
 
-- 
Sent by a computer through tubes

