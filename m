Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB34C3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F64217AB
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F64217AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933206AbeGGCuR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 22:50:17 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:23874 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S932974AbeGGCtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 22:49:45 -0400
X-UUID: e1f501fcac0e4084be99745e61c6b31b-20180707
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <jun.gao@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1095399838; Sat, 07 Jul 2018 10:49:41 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Sat, 7 Jul 2018 10:49:39 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Sat, 7 Jul 2018 10:49:39 +0800
From:   Jun Gao <jun.gao@mediatek.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Jun Gao <jun.gao@mediatek.com>
Subject: [PATCH 3/3] i2c: mediatek: Use DMA safe buffers for i2c transactions
Date:   Sat, 7 Jul 2018 10:49:13 +0800
Message-ID: <1530931753-8264-4-git-send-email-jun.gao@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1530931753-8264-1-git-send-email-jun.gao@mediatek.com>
References: <1530931753-8264-1-git-send-email-jun.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jun Gao <jun.gao@mediatek.com>

DMA mode will always be used in i2c transactions, try to allocate
a DMA safe buffer if the buf of struct i2c_msg used is not DMA safe.

Signed-off-by: Jun Gao <jun.gao@mediatek.com>
---
 drivers/i2c/busses/i2c-mt65xx.c | 62 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 806e8b90..dd014ee 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -441,6 +441,8 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 	u16 control_reg;
 	u16 restart_flag = 0;
 	u32 reg_4g_mode;
+	u8 *dma_rd_buf;
+	u8 *dma_wr_buf;
 	dma_addr_t rpaddr = 0;
 	dma_addr_t wpaddr = 0;
 	int ret;
@@ -500,10 +502,18 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 	if (i2c->op == I2C_MASTER_RD) {
 		writel(I2C_DMA_INT_FLAG_NONE, i2c->pdmabase + OFFSET_INT_FLAG);
 		writel(I2C_DMA_CON_RX, i2c->pdmabase + OFFSET_CON);
-		rpaddr = dma_map_single(i2c->dev, msgs->buf,
+
+		dma_rd_buf = i2c_get_dma_safe_msg_buf(msgs, 0);
+		if (!dma_rd_buf)
+			return -ENOMEM;
+
+		rpaddr = dma_map_single(i2c->dev, dma_rd_buf,
 					msgs->len, DMA_FROM_DEVICE);
-		if (dma_mapping_error(i2c->dev, rpaddr))
+		if (dma_mapping_error(i2c->dev, rpaddr)) {
+			i2c_free_dma_safe_msg_buf(msgs, dma_rd_buf);
+
 			return -ENOMEM;
+		}
 
 		if (i2c->dev_comp->support_33bits) {
 			reg_4g_mode = mtk_i2c_set_4g_mode(rpaddr);
@@ -515,10 +525,18 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 	} else if (i2c->op == I2C_MASTER_WR) {
 		writel(I2C_DMA_INT_FLAG_NONE, i2c->pdmabase + OFFSET_INT_FLAG);
 		writel(I2C_DMA_CON_TX, i2c->pdmabase + OFFSET_CON);
-		wpaddr = dma_map_single(i2c->dev, msgs->buf,
+
+		dma_wr_buf = i2c_get_dma_safe_msg_buf(msgs, 0);
+		if (!dma_wr_buf)
+			return -ENOMEM;
+
+		wpaddr = dma_map_single(i2c->dev, dma_wr_buf,
 					msgs->len, DMA_TO_DEVICE);
-		if (dma_mapping_error(i2c->dev, wpaddr))
+		if (dma_mapping_error(i2c->dev, wpaddr)) {
+			i2c_free_dma_safe_msg_buf(msgs, dma_wr_buf);
+
 			return -ENOMEM;
+		}
 
 		if (i2c->dev_comp->support_33bits) {
 			reg_4g_mode = mtk_i2c_set_4g_mode(wpaddr);
@@ -530,16 +548,39 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 	} else {
 		writel(I2C_DMA_CLR_FLAG, i2c->pdmabase + OFFSET_INT_FLAG);
 		writel(I2C_DMA_CLR_FLAG, i2c->pdmabase + OFFSET_CON);
-		wpaddr = dma_map_single(i2c->dev, msgs->buf,
+
+		dma_wr_buf = i2c_get_dma_safe_msg_buf(msgs, 0);
+		if (!dma_wr_buf)
+			return -ENOMEM;
+
+		wpaddr = dma_map_single(i2c->dev, dma_wr_buf,
 					msgs->len, DMA_TO_DEVICE);
-		if (dma_mapping_error(i2c->dev, wpaddr))
+		if (dma_mapping_error(i2c->dev, wpaddr)) {
+			i2c_free_dma_safe_msg_buf(msgs, dma_wr_buf);
+
 			return -ENOMEM;
-		rpaddr = dma_map_single(i2c->dev, (msgs + 1)->buf,
+		}
+
+		dma_rd_buf = i2c_get_dma_safe_msg_buf((msgs + 1), 0);
+		if (!dma_rd_buf) {
+			dma_unmap_single(i2c->dev, wpaddr,
+					 msgs->len, DMA_TO_DEVICE);
+
+			i2c_free_dma_safe_msg_buf(msgs, dma_wr_buf);
+
+			return -ENOMEM;
+		}
+
+		rpaddr = dma_map_single(i2c->dev, dma_rd_buf,
 					(msgs + 1)->len,
 					DMA_FROM_DEVICE);
 		if (dma_mapping_error(i2c->dev, rpaddr)) {
 			dma_unmap_single(i2c->dev, wpaddr,
 					 msgs->len, DMA_TO_DEVICE);
+
+			i2c_free_dma_safe_msg_buf(msgs, dma_wr_buf);
+			i2c_free_dma_safe_msg_buf((msgs + 1), dma_rd_buf);
+
 			return -ENOMEM;
 		}
 
@@ -578,14 +619,21 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 	if (i2c->op == I2C_MASTER_WR) {
 		dma_unmap_single(i2c->dev, wpaddr,
 				 msgs->len, DMA_TO_DEVICE);
+
+		i2c_release_dma_safe_msg_buf(msgs, dma_wr_buf);
 	} else if (i2c->op == I2C_MASTER_RD) {
 		dma_unmap_single(i2c->dev, rpaddr,
 				 msgs->len, DMA_FROM_DEVICE);
+
+		i2c_release_dma_safe_msg_buf(msgs, dma_rd_buf);
 	} else {
 		dma_unmap_single(i2c->dev, wpaddr, msgs->len,
 				 DMA_TO_DEVICE);
 		dma_unmap_single(i2c->dev, rpaddr, (msgs + 1)->len,
 				 DMA_FROM_DEVICE);
+
+		i2c_release_dma_safe_msg_buf(msgs, dma_wr_buf);
+		i2c_release_dma_safe_msg_buf((msgs + 1), dma_rd_buf);
 	}
 
 	if (ret == 0) {
-- 
1.8.1.1

