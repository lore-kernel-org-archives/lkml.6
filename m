Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC36C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A7321925
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M06tQnzm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391957AbfBOJCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:02:13 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35745 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732672AbfBOJCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:02:11 -0500
Received: by mail-pf1-f196.google.com with SMTP id j5so35213pfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 01:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TKEr6BQfPYwpZOOmXDLLiGCXvoI2GmC6CPcG6Delj7k=;
        b=M06tQnzmpEvPURrsn18wmE1G0bf8j/j3E4/gaRn5UHdWAIszU5S/8BRF4bn0GNtXSe
         r7t1bSEpPbePPUAaBWw95Kui9EIi7UJTA81Di6i6f5bxLCXBdflLoBmKbdqrWgc+DwRL
         gE2EemCnKz5LtwY05osXbp7gG2eB8OesL0+Ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TKEr6BQfPYwpZOOmXDLLiGCXvoI2GmC6CPcG6Delj7k=;
        b=OOQNKskcudAgHTyjKBeatO3L+E0YBF3qqnBnYWQpXD/31LaHvo9PTVV2PmjQbeht4J
         cg3209J1ODZi+dhaowxQU5p/D6TfNAOUvYw2slhWWEQTLw9EGMms7/KHxrTJj2v8WgRz
         uPefFvZ6ge/D7O3dLHHiN2Ybwxn0nPlPayEP+/Zf+MX/r3YzXp1dnkDToa5HP1PxHhF4
         RuDsBYoraThdz0+htCysxmG1fRfAmRZk2ZkMSr0NNjoF+KiqkFRco9cE1XCoIiEz8ToA
         h5v3wNvJJ58QRplyRI1QXLTPmsw0tv6HBZeO1KYvshRDAoeb4ezOTQv1EBeOwjtuO8XI
         gfiQ==
X-Gm-Message-State: AHQUAuZ6tlpAFTMB2of0eQ9aTjtubpxqRKz3XrQj0gR6skuOEJp2YDaL
        wbW4n6yxcKN6fKSO0gq6rEDskA==
X-Google-Smtp-Source: AHgI3IZ+IPALVVKhe1XQ2ry7m3Jzss69II/WcqBU5mzDNdUy2gIbEPcfg4GYGt2NpDsJktpgvm9zaw==
X-Received: by 2002:a65:6219:: with SMTP id d25mr4392407pgv.18.1550221330954;
        Fri, 15 Feb 2019 01:02:10 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id z67sm9012653pfd.188.2019.02.15.01.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Feb 2019 01:02:10 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Jun Gao <jun.gao@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Ryder Lee <ryder.lee@mediatek.com>, linux-i2c@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: mediatek: modify threshold passed to i2c_get_dma_safe_msg_buf()
Date:   Fri, 15 Feb 2019 17:02:02 +0800
Message-Id: <20190215090202.157100-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i2c_get_dma_safe_msg_buf() allocates space based on msg->len. If threshold is
0 and msg->len is also 0, function makes zero-length allocation, which returns
a special ZERO_SIZE_PTR instead of a NULL pointer, and this will cause later
code to fail. Modify the threshold to > 0 so the function returns NULL pointer.

Fixes: fc66b39fe36a ("i2c: mediatek: Use DMA safe buffers for i2c transactions")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/i2c/busses/i2c-mt65xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index a74ef76705e0..2bb4d20ead32 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -503,7 +503,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 		writel(I2C_DMA_INT_FLAG_NONE, i2c->pdmabase + OFFSET_INT_FLAG);
 		writel(I2C_DMA_CON_RX, i2c->pdmabase + OFFSET_CON);
 
-		dma_rd_buf = i2c_get_dma_safe_msg_buf(msgs, 0);
+		dma_rd_buf = i2c_get_dma_safe_msg_buf(msgs, 1);
 		if (!dma_rd_buf)
 			return -ENOMEM;
 
@@ -526,7 +526,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 		writel(I2C_DMA_INT_FLAG_NONE, i2c->pdmabase + OFFSET_INT_FLAG);
 		writel(I2C_DMA_CON_TX, i2c->pdmabase + OFFSET_CON);
 
-		dma_wr_buf = i2c_get_dma_safe_msg_buf(msgs, 0);
+		dma_wr_buf = i2c_get_dma_safe_msg_buf(msgs, 1);
 		if (!dma_wr_buf)
 			return -ENOMEM;
 
@@ -549,7 +549,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 		writel(I2C_DMA_CLR_FLAG, i2c->pdmabase + OFFSET_INT_FLAG);
 		writel(I2C_DMA_CLR_FLAG, i2c->pdmabase + OFFSET_CON);
 
-		dma_wr_buf = i2c_get_dma_safe_msg_buf(msgs, 0);
+		dma_wr_buf = i2c_get_dma_safe_msg_buf(msgs, 1);
 		if (!dma_wr_buf)
 			return -ENOMEM;
 
@@ -561,7 +561,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 			return -ENOMEM;
 		}
 
-		dma_rd_buf = i2c_get_dma_safe_msg_buf((msgs + 1), 0);
+		dma_rd_buf = i2c_get_dma_safe_msg_buf((msgs + 1), 1);
 		if (!dma_rd_buf) {
 			dma_unmap_single(i2c->dev, wpaddr,
 					 msgs->len, DMA_TO_DEVICE);
-- 
2.18.1

