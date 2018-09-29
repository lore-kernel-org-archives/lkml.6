Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1970C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 05:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CCFA2087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 05:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SpcJNTqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CCFA2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeI2MRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 08:17:24 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35856 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbeI2MRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 08:17:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id f18-v6so2382073pgv.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 22:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=iWr4gpxLtZb6+cJ6KwEXZgyRLa7YNF4Gx04rrpmRjF4=;
        b=SpcJNTqTP5x6SwzpklQOKZetxKCuRC+EqICzW67gXkEAbmbGD05qOGayux2q7aWIVG
         nSiIRP/OKZ13BMWQWJQ8ern6FR3J237gXnqlSJB/I0qQvG1KRBoDIywCerw1VPxcEnNQ
         jKe4JtvznBmOThO1WWA5a4VB97YjcED3IJTGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=iWr4gpxLtZb6+cJ6KwEXZgyRLa7YNF4Gx04rrpmRjF4=;
        b=RCxkBbkugPZUQggLOFqo3q/W4zBwJatzGISeGS20dqOZsRv/w8sG7E36SSofWWg7y0
         +zrQVDyIWjSR5bzSh49TABBHxM9MJfVOKX0ludQ/6m/VhBPzU3VIdFO29pdBrqsMwjvA
         YL7Yo9mMu81zMc5vpPDhgTziVtoZ5Wm1nWTwQwWh84FZr54s/icTP8krtpsR0oiVzY68
         5Tnu1Gq8wCu0p6laKv9UAjRfCbIkaS8BcDP44FtCkbRKPXDxbqdJvWH5fyuIlRJgf+zq
         0qXfCWOPcYonHykXvLXWI7eHBpzWrQDC/jDMBCLMGXtVERqE4Cvf/GL4VeNVfebPNOMs
         MYnw==
X-Gm-Message-State: ABuFfojvR9vdtNBXCySHGMjWgcwNsejBW8SWJTGST/1RnTMdfr5z3sDv
        JTeJmgTSKF0VaW7tKyuINruCRw==
X-Google-Smtp-Source: ACcGV61ku+6hvuAIYfJXiislc62+SqZcS/FIndp5L5hNcgSvcp06wWpecuwGkcJ54VnVLqG0rAzfKw==
X-Received: by 2002:a17:902:59dd:: with SMTP id d29-v6mr1746873plj.34.1538200219094;
        Fri, 28 Sep 2018 22:50:19 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i80-v6sm11118049pfi.87.2018.09.28.22.50.15
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Sep 2018 22:50:18 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org,
        eric.long@spreadtrum.com
Cc:     broonie@kernel.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] dmaengine: sprd: Support DMA 2-stage transfer mode
Date:   Sat, 29 Sep 2018 13:49:04 +0800
Message-Id: <f414c95380e71bb37069024cf3d29bf92a8b0746.1538199697.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1538199697.git.baolin.wang@linaro.org>
References: <cover.1538199697.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1538199697.git.baolin.wang@linaro.org>
References: <cover.1538199697.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Long <eric.long@spreadtrum.com>

The Spreadtrum DMA controller supports channel 2-stage tansfer mode,
that means we can request 2 dma channels, one for source channel, and
another one for destination channel. Once the source channel's transaction
is done, it will trigger the destination channel's transaction automatically
by hardware signal.

Signed-off-by: Eric Long <eric.long@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c       |   98 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/dma/sprd-dma.h |   62 ++++++++++++++++++++++++--
 2 files changed, 156 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index cefe42f..50d6569 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -36,6 +36,8 @@
 #define SPRD_DMA_GLB_CHN_EN_STS		0x1c
 #define SPRD_DMA_GLB_DEBUG_STS		0x20
 #define SPRD_DMA_GLB_ARB_SEL_STS	0x24
+#define SPRD_DMA_GLB_2STAGE_GRP1	0x28
+#define SPRD_DMA_GLB_2STAGE_GRP2	0x2c
 #define SPRD_DMA_GLB_REQ_UID(uid)	(0x4 * ((uid) - 1))
 #define SPRD_DMA_GLB_REQ_UID_OFFSET	0x2000
 
@@ -57,6 +59,18 @@
 #define SPRD_DMA_CHN_SRC_BLK_STEP	0x38
 #define SPRD_DMA_CHN_DES_BLK_STEP	0x3c
 
+/* SPRD_DMA_GLB_2STAGE_GRP register definition */
+#define SPRD_DMA_GLB_2STAGE_EN		BIT(24)
+#define SPRD_DMA_GLB_CHN_INT_MASK	GENMASK(23, 20)
+#define SPRD_DMA_GLB_LIST_DONE_TRG	BIT(19)
+#define SPRD_DMA_GLB_TRANS_DONE_TRG	BIT(18)
+#define SPRD_DMA_GLB_BLOCK_DONE_TRG	BIT(17)
+#define SPRD_DMA_GLB_FRAG_DONE_TRG	BIT(16)
+#define SPRD_DMA_GLB_TRG_OFFSET		16
+#define SPRD_DMA_GLB_DEST_CHN_MASK	GENMASK(13, 8)
+#define SPRD_DMA_GLB_DEST_CHN_OFFSET	8
+#define SPRD_DMA_GLB_SRC_CHN_MASK	GENMASK(5, 0)
+
 /* SPRD_DMA_CHN_INTC register definition */
 #define SPRD_DMA_INT_MASK		GENMASK(4, 0)
 #define SPRD_DMA_INT_CLR_OFFSET		24
@@ -118,6 +132,10 @@
 #define SPRD_DMA_SRC_TRSF_STEP_OFFSET	0
 #define SPRD_DMA_TRSF_STEP_MASK		GENMASK(15, 0)
 
+/* define DMA channel mode & trigger mode mask */
+#define SPRD_DMA_CHN_MODE_MASK		GENMASK(7, 0)
+#define SPRD_DMA_TRG_MODE_MASK		GENMASK(7, 0)
+
 /* define the DMA transfer step type */
 #define SPRD_DMA_NONE_STEP		0
 #define SPRD_DMA_BYTE_STEP		1
@@ -170,6 +188,8 @@ struct sprd_dma_chn {
 	struct dma_slave_config	slave_cfg;
 	u32			chn_num;
 	u32			dev_id;
+	enum sprd_dma_chn_mode	chn_mode;
+	enum sprd_dma_trg_mode	trg_mode;
 	struct sprd_dma_desc	*cur_desc;
 };
 
@@ -206,6 +226,16 @@ static inline struct sprd_dma_desc *to_sprd_dma_desc(struct virt_dma_desc *vd)
 	return container_of(vd, struct sprd_dma_desc, vd);
 }
 
+static void sprd_dma_glb_update(struct sprd_dma_dev *sdev, u32 reg,
+				u32 mask, u32 val)
+{
+	u32 orig = readl(sdev->glb_base + reg);
+	u32 tmp;
+
+	tmp = (orig & ~mask) | val;
+	writel(tmp, sdev->glb_base + reg);
+}
+
 static void sprd_dma_chn_update(struct sprd_dma_chn *schan, u32 reg,
 				u32 mask, u32 val)
 {
@@ -389,6 +419,49 @@ static enum sprd_dma_req_mode sprd_dma_get_req_type(struct sprd_dma_chn *schan)
 	return (frag_reg >> SPRD_DMA_REQ_MODE_OFFSET) & SPRD_DMA_REQ_MODE_MASK;
 }
 
+static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
+{
+	struct sprd_dma_dev *sdev = to_sprd_dma_dev(&schan->vc.chan);
+	u32 val, chn = schan->chn_num + 1;
+
+	switch (schan->chn_mode) {
+	case SPRD_DMA_SRC_CHN0:
+		val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
+		val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
+		val |= SPRD_DMA_GLB_2STAGE_EN;
+		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1, val, val);
+		break;
+
+	case SPRD_DMA_SRC_CHN1:
+		val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
+		val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
+		val |= SPRD_DMA_GLB_2STAGE_EN;
+		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2, val, val);
+		break;
+
+	case SPRD_DMA_DST_CHN0:
+		val = (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
+			SPRD_DMA_GLB_DEST_CHN_MASK;
+		val |= SPRD_DMA_GLB_2STAGE_EN;
+		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1, val, val);
+		break;
+
+	case SPRD_DMA_DST_CHN1:
+		val = (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
+			SPRD_DMA_GLB_DEST_CHN_MASK;
+		val |= SPRD_DMA_GLB_2STAGE_EN;
+		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2, val, val);
+		break;
+
+	default:
+		dev_err(sdev->dma_dev.dev, "invalid channel mode setting %d\n",
+			schan->chn_mode);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void sprd_dma_set_chn_config(struct sprd_dma_chn *schan,
 				    struct sprd_dma_desc *sdesc)
 {
@@ -423,6 +496,13 @@ static void sprd_dma_start(struct sprd_dma_chn *schan)
 	schan->cur_desc = to_sprd_dma_desc(vd);
 
 	/*
+	 * Set 2-stage configuration if the channel starts one 2-stage
+	 * transfer.
+	 */
+	if (schan->chn_mode && sprd_dma_set_2stage_config(schan))
+		return;
+
+	/*
 	 * Copy the DMA configuration from DMA descriptor to this hardware
 	 * channel.
 	 */
@@ -617,6 +697,7 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
 {
 	struct sprd_dma_dev *sdev = to_sprd_dma_dev(chan);
 	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
+	enum sprd_dma_chn_mode chn_mode = schan->chn_mode;
 	u32 req_mode = (flags >> SPRD_DMA_REQ_SHIFT) & SPRD_DMA_REQ_MODE_MASK;
 	u32 int_mode = flags & SPRD_DMA_INT_MASK;
 	int src_datawidth, dst_datawidth, src_step, dst_step;
@@ -628,7 +709,16 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
 			dev_err(sdev->dma_dev.dev, "invalid source step\n");
 			return src_step;
 		}
-		dst_step = SPRD_DMA_NONE_STEP;
+
+		/*
+		 * For 2-stage transfer, destination channel step can not be 0,
+		 * since destination device is AON IRAM.
+		 */
+		if (chn_mode == SPRD_DMA_DST_CHN0 ||
+		    chn_mode == SPRD_DMA_DST_CHN1)
+			dst_step = src_step;
+		else
+			dst_step = SPRD_DMA_NONE_STEP;
 	} else {
 		dst_step = sprd_dma_get_step(slave_cfg->dst_addr_width);
 		if (dst_step < 0) {
@@ -855,6 +945,12 @@ static int sprd_dma_fill_linklist_desc(struct dma_chan *chan,
 		}
 	}
 
+	/* Set channel mode and trigger mode for 2-stage transfer */
+	schan->chn_mode =
+		(flags >> SPRD_DMA_CHN_MODE_SHIFT) & SPRD_DMA_CHN_MODE_MASK;
+	schan->trg_mode =
+		(flags >> SPRD_DMA_TRG_MODE_SHIFT) & SPRD_DMA_TRG_MODE_MASK;
+
 	ret = sprd_dma_fill_desc(chan, &sdesc->chn_hw, 0, 0, src, dst, len,
 				 dir, flags, slave_cfg);
 	if (ret) {
diff --git a/include/linux/dma/sprd-dma.h b/include/linux/dma/sprd-dma.h
index b42b80e5..ab82df6 100644
--- a/include/linux/dma/sprd-dma.h
+++ b/include/linux/dma/sprd-dma.h
@@ -3,9 +3,65 @@
 #ifndef _SPRD_DMA_H_
 #define _SPRD_DMA_H_
 
-#define SPRD_DMA_REQ_SHIFT 16
-#define SPRD_DMA_FLAGS(req_mode, int_type) \
-	((req_mode) << SPRD_DMA_REQ_SHIFT | (int_type))
+#define SPRD_DMA_REQ_SHIFT	8
+#define SPRD_DMA_TRG_MODE_SHIFT	16
+#define SPRD_DMA_CHN_MODE_SHIFT	24
+#define SPRD_DMA_FLAGS(chn_mode, trg_mode, req_mode, int_type) \
+	((chn_mode) << SPRD_DMA_CHN_MODE_SHIFT | \
+	(trg_mode) << SPRD_DMA_TRG_MODE_SHIFT | \
+	(req_mode) << SPRD_DMA_REQ_SHIFT | (int_type))
+
+/*
+ * The Spreadtrum DMA controller supports channel 2-stage tansfer, that means
+ * we can request 2 dma channels, one for source channel, and another one for
+ * destination channel. Each channel is independent, and has its own
+ * configurations. Once the source channel's transaction is done, it will
+ * trigger the destination channel's transaction automatically by hardware
+ * signal.
+ *
+ * To support 2-stage tansfer, we must configure the channel mode and trigger
+ * mode as below definition.
+ */
+
+/*
+ * enum sprd_dma_chn_mode: define the DMA channel mode for 2-stage transfer
+ * @SPRD_DMA_CHN_MODE_NONE: No channel mode setting which means channel doesn't
+ * support the 2-stage transfer.
+ * @SPRD_DMA_SRC_CHN0: Channel used as source channel 0.
+ * @SPRD_DMA_SRC_CHN1: Channel used as source channel 1.
+ * @SPRD_DMA_DST_CHN0: Channel used as destination channel 0.
+ * @SPRD_DMA_DST_CHN1: Channel used as destination channel 1.
+ *
+ * Now the DMA controller can supports 2 groups 2-stage transfer.
+ */
+enum sprd_dma_chn_mode {
+	SPRD_DMA_CHN_MODE_NONE,
+	SPRD_DMA_SRC_CHN0,
+	SPRD_DMA_SRC_CHN1,
+	SPRD_DMA_DST_CHN0,
+	SPRD_DMA_DST_CHN1,
+};
+
+/*
+ * enum sprd_dma_trg_mode: define the DMA channel trigger mode for 2-stage
+ * transfer
+ * @SPRD_DMA_NO_TRG: No trigger setting.
+ * @SPRD_DMA_FRAG_DONE_TRG: Trigger the transaction of destination channel
+ * automatically once the source channel's fragment request is done.
+ * @SPRD_DMA_BLOCK_DONE_TRG: Trigger the transaction of destination channel
+ * automatically once the source channel's block request is done.
+ * @SPRD_DMA_TRANS_DONE_TRG: Trigger the transaction of destination channel
+ * automatically once the source channel's transfer request is done.
+ * @SPRD_DMA_LIST_DONE_TRG: Trigger the transaction of destination channel
+ * automatically once the source channel's link-list request is done.
+ */
+enum sprd_dma_trg_mode {
+	SPRD_DMA_NO_TRG,
+	SPRD_DMA_FRAG_DONE_TRG,
+	SPRD_DMA_BLOCK_DONE_TRG,
+	SPRD_DMA_TRANS_DONE_TRG,
+	SPRD_DMA_LIST_DONE_TRG,
+};
 
 /*
  * enum sprd_dma_req_mode: define the DMA request mode
-- 
1.7.9.5

