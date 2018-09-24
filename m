Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE8AC43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6DC20874
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DlzRZgjq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6DC20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbeIYF5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 01:57:25 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46873 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbeIYF5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 01:57:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id b129-v6so10059356pga.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 16:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+uyMWo2cY9l4Ar92yvj0UCofpuhs+WjwXrGz/0hgOvE=;
        b=DlzRZgjqvhkiyeDAGcTl0W1nVkTR+j0agSSRSUTI4Txj1ks1RC3nLiN2wUFfOUjSWx
         VLXE4L3DjmOVlrDZ5HBr3gv5gw3WRZ/UsjsE98o2pcgmSn7AGfK2RNfRcqJxkj0zeq70
         Vh5mId5TArQLSsq/ZVJFg0Awvg2cXD3Vw1TZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+uyMWo2cY9l4Ar92yvj0UCofpuhs+WjwXrGz/0hgOvE=;
        b=jL5/mxCnG6MRNdqLrBwbgHsXRkTOLdOkCbTzL6UGhlS5zROluFzpuPMbGSPXxbbWQG
         AnuoWVi3MNvmgU3Gupn+sLw7XjOsfpIjkrerVvpVRTe0AUlg0T6jw3DSPCH+r9Hwgpaq
         m8w8W7ljp9lmV/SC8p3i2T+wp+iQNevZJELmGcVSu/++tAx4rSpymT/WIyGOWbo088Jj
         TwhUCv+VL3LLjsppPqkFHcpaFAHnpXrGdlU6Ul++BkjJrJ4zBRnz/oWO4y8iGSiw4GZa
         9G8k5y+H3n7rWsWvZwowY8gTvLQ6bRj+ybmh3M8pJAxKEfIGKeccAPafTjUkyIhtWvEW
         g++Q==
X-Gm-Message-State: ABuFfohcyyvB03bltkQP5XjwNjzJCRf0NTjQqJyR1zLQ65aTtSd+m0Jq
        kDT6z4qAeHM58ho+i3LVMvOOhQ==
X-Google-Smtp-Source: ACcGV63m+fEnQTr+9XtGFZzzQw87YVVH9mH2aWw62JCeKXp0lBrTMcYAHyNNXT7I10tiLe5Lr7hOcA==
X-Received: by 2002:a17:902:14e:: with SMTP id 72-v6mr856142plb.299.1537833158783;
        Mon, 24 Sep 2018 16:52:38 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id d81-v6sm518993pfj.122.2018.09.24.16.52.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 16:52:38 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH v3 3/3] i2c: i2c-qcom-geni: Simplify irq handler
Date:   Mon, 24 Sep 2018 16:52:35 -0700
Message-Id: <20180924235235.182649-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20180924235235.182649-1-swboyd@chromium.org>
References: <20180924235235.182649-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to use goto here, we can just collapse the if statement
and goto chain into multiple branches and then combine some duplicate
completion calls into one big if statement. Let's do it to clean up code
some more.

Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Cc: Sagar Dharia <sdharia@codeaurora.org>
Cc: Girish Mahadevan <girishm@codeaurora.org>
Cc: Doug Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 70 +++++++++++++-----------------
 1 file changed, 29 insertions(+), 41 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 0b466835cf40..527f55c8c4c7 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -201,21 +201,23 @@ static void geni_i2c_err(struct geni_i2c_dev *gi2c, int err)
 static irqreturn_t geni_i2c_irq(int irq, void *dev)
 {
 	struct geni_i2c_dev *gi2c = dev;
-	int j;
+	void __iomem *base = gi2c->se.base;
+	int j, p;
 	u32 m_stat;
 	u32 rx_st;
 	u32 dm_tx_st;
 	u32 dm_rx_st;
 	u32 dma;
+	u32 val;
 	struct i2c_msg *cur;
 	unsigned long flags;
 
 	spin_lock_irqsave(&gi2c->lock, flags);
-	m_stat = readl_relaxed(gi2c->se.base + SE_GENI_M_IRQ_STATUS);
-	rx_st = readl_relaxed(gi2c->se.base + SE_GENI_RX_FIFO_STATUS);
-	dm_tx_st = readl_relaxed(gi2c->se.base + SE_DMA_TX_IRQ_STAT);
-	dm_rx_st = readl_relaxed(gi2c->se.base + SE_DMA_RX_IRQ_STAT);
-	dma = readl_relaxed(gi2c->se.base + SE_GENI_DMA_MODE_EN);
+	m_stat = readl_relaxed(base + SE_GENI_M_IRQ_STATUS);
+	rx_st = readl_relaxed(base + SE_GENI_RX_FIFO_STATUS);
+	dm_tx_st = readl_relaxed(base + SE_DMA_TX_IRQ_STAT);
+	dm_rx_st = readl_relaxed(base + SE_DMA_RX_IRQ_STAT);
+	dma = readl_relaxed(base + SE_GENI_DMA_MODE_EN);
 	cur = gi2c->cur;
 
 	if (!cur ||
@@ -238,26 +240,17 @@ static irqreturn_t geni_i2c_irq(int irq, void *dev)
 
 		/* Disable the TX Watermark interrupt to stop TX */
 		if (!dma)
-			writel_relaxed(0, gi2c->se.base +
-					   SE_GENI_TX_WATERMARK_REG);
-		goto irqret;
-	}
-
-	if (dma) {
+			writel_relaxed(0, base + SE_GENI_TX_WATERMARK_REG);
+	} else if (dma) {
 		dev_dbg(gi2c->se.dev, "i2c dma tx:0x%x, dma rx:0x%x\n",
 			dm_tx_st, dm_rx_st);
-		goto irqret;
-	}
-
-	if (cur->flags & I2C_M_RD &&
-	    m_stat & (M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN)) {
+	} else if (cur->flags & I2C_M_RD &&
+		   m_stat & (M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN)) {
 		u32 rxcnt = rx_st & RX_FIFO_WC_MSK;
 
 		for (j = 0; j < rxcnt; j++) {
-			u32 val;
-			int p = 0;
-
-			val = readl_relaxed(gi2c->se.base + SE_GENI_RX_FIFOn);
+			p = 0;
+			val = readl_relaxed(base + SE_GENI_RX_FIFOn);
 			while (gi2c->cur_rd < cur->len && p < sizeof(val)) {
 				cur->buf[gi2c->cur_rd++] = val & 0xff;
 				val >>= 8;
@@ -270,44 +263,39 @@ static irqreturn_t geni_i2c_irq(int irq, void *dev)
 		   m_stat & M_TX_FIFO_WATERMARK_EN) {
 		for (j = 0; j < gi2c->tx_wm; j++) {
 			u32 temp;
-			u32 val = 0;
-			int p = 0;
 
+			val = 0;
+			p = 0;
 			while (gi2c->cur_wr < cur->len && p < sizeof(val)) {
 				temp = cur->buf[gi2c->cur_wr++];
 				val |= temp << (p * 8);
 				p++;
 			}
-			writel_relaxed(val, gi2c->se.base + SE_GENI_TX_FIFOn);
+			writel_relaxed(val, base + SE_GENI_TX_FIFOn);
 			/* TX Complete, Disable the TX Watermark interrupt */
 			if (gi2c->cur_wr == cur->len) {
-				writel_relaxed(0, gi2c->se.base +
-						SE_GENI_TX_WATERMARK_REG);
+				writel_relaxed(0, base + SE_GENI_TX_WATERMARK_REG);
 				break;
 			}
 		}
 	}
-irqret:
+
 	if (m_stat)
-		writel_relaxed(m_stat, gi2c->se.base + SE_GENI_M_IRQ_CLEAR);
+		writel_relaxed(m_stat, base + SE_GENI_M_IRQ_CLEAR);
+
+	if (dma && dm_tx_st)
+		writel_relaxed(dm_tx_st, base + SE_DMA_TX_IRQ_CLR);
+	if (dma && dm_rx_st)
+		writel_relaxed(dm_rx_st, base + SE_DMA_RX_IRQ_CLR);
 
-	if (dma) {
-		if (dm_tx_st)
-			writel_relaxed(dm_tx_st, gi2c->se.base +
-						SE_DMA_TX_IRQ_CLR);
-		if (dm_rx_st)
-			writel_relaxed(dm_rx_st, gi2c->se.base +
-						SE_DMA_RX_IRQ_CLR);
-	}
 	/* if this is err with done-bit not set, handle that through timeout. */
-	if (m_stat & M_CMD_DONE_EN || m_stat & M_CMD_ABORT_EN)
-		complete(&gi2c->done);
-	else if (dm_tx_st & TX_DMA_DONE || dm_tx_st & TX_RESET_DONE)
-		complete(&gi2c->done);
-	else if (dm_rx_st & RX_DMA_DONE || dm_rx_st & RX_RESET_DONE)
+	if (m_stat & M_CMD_DONE_EN || m_stat & M_CMD_ABORT_EN ||
+	    dm_tx_st & TX_DMA_DONE || dm_tx_st & TX_RESET_DONE ||
+	    dm_rx_st & RX_DMA_DONE || dm_rx_st & RX_RESET_DONE)
 		complete(&gi2c->done);
 
 	spin_unlock_irqrestore(&gi2c->lock, flags);
+
 	return IRQ_HANDLED;
 }
 
-- 
Sent by a computer through tubes

