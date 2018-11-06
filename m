Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B97C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B19D2083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sbs/+DtC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B19D2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbeKFOZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 09:25:41 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44149 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbeKFOZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 09:25:40 -0500
Received: by mail-pg1-f195.google.com with SMTP id w3-v6so5252734pgs.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 21:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=iWr4gpxLtZb6+cJ6KwEXZgyRLa7YNF4Gx04rrpmRjF4=;
        b=Sbs/+DtCkaM2ZZHSu+MPuZuWAQm+/63ec/1c6BXpQRI4G9NqgHNgqt1Fbp25lg1thF
         JytDD4IoZc0xAKJqZP3fJnFHBHJsZzXvvd6GiYw54Wy1cJuwTKkjUmv+0PbZ8uSX3ob6
         Fss1IFaAFELSnsh/U5WivAnSu2LdIhSPl7JIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=iWr4gpxLtZb6+cJ6KwEXZgyRLa7YNF4Gx04rrpmRjF4=;
        b=eajAQhCAEPk1LfAW2xlPbqBIETnG81g+2HO1Wg5hm3vu2GrWfJoBzCwnwbV0PsEnsn
         if4nqvmd0Seti6+vlpCQpk+leVfjlXT1AGf4mLCovDVSYuANkgBkuAHqCDJXggK+2Eu/
         /G3UtiG4tjFjozja1G0d/fxQwTExlKVO2rOC9uuGxmZKJA1DLZbB6fT3wRNEJcxCwdh6
         bXCcKfH/TxvOq352GR4W5+8T/b8B9LMM57wIzDVRY0SOl2nTtk1MTf36OFwqyGKe2Z0N
         k4f0061V+BmVuhvrREFzTx4brlVBYpJ17R87T9Q/a8iFrIGLYSzAu1B7+wzchMoq+LBL
         f6gg==
X-Gm-Message-State: AGRZ1gIprpbggo2t9CH0QNPgNdAYKKCLHapRn0bJD7PB4BDUTO/uMr0B
        hGmdAaeD0E6+sarTI4DqR/xOSQ==
X-Google-Smtp-Source: AJdET5dpAT2GofcGLSnyAzIzoNhQB0nIJ1iH0ZED6UT0tm9E9B1NwEFdVHPI2JDQNrTSiDgKmvjyzQ==
X-Received: by 2002:a62:34c5:: with SMTP id b188-v6mr25689007pfa.65.1541480537831;
        Mon, 05 Nov 2018 21:02:17 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id o7-v6sm55735416pfb.23.2018.11.05.21.02.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 21:02:17 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org, eric.long@unisoc.com
Cc:     broonie@kernel.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 6/7] dmaengine: sprd: Support DMA 2-stage transfer mode
Date:   Tue,  6 Nov 2018 13:01:36 +0800
Message-Id: <2cddbfd67b58c3f153ef0950eb4d1b88765afc16.1541480353.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1541480353.git.baolin.wang@linaro.org>
References: <cover.1541480353.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1541480353.git.baolin.wang@linaro.org>
References: <cover.1541480353.git.baolin.wang@linaro.org>
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

