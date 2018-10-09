Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B637C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E468521479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="J1OJ/NVr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E468521479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbeJINDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 09:03:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40905 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeJINDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 09:03:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id s5-v6so253405pfj.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 22:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eW4Ce55VjYsIH9MyeML3hQXQKFMbk+C12X1qFn1Si2o=;
        b=J1OJ/NVro04YDIAp7uO6GxnlBPMf1qK+Ic3H2mdbGT/Kv7P8/1DO7uFd/YM3Xr+TH+
         U3UoZYhjaONyVNE0CehGK5Cab0SyxQdG6Ncr1jt5ebuxk+t3nydeOnqrYnQIntIKf8P8
         EvqWWmTLjxjo6Zeb070B2LlGwhrrmu5njWm4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eW4Ce55VjYsIH9MyeML3hQXQKFMbk+C12X1qFn1Si2o=;
        b=lXXfYYHz9ahp+y9G11z1zSCk5aKsEZZx2FR9jOaO43M8yyN9qG7US9MhOpoP6TwR85
         yNvtxU8FjxDBguEX9I2LiPfJAB1Y9xVY+vfMBUUGN/YNblFCeXMERrFjIMhBZ4SNZ14N
         fP0TcXJ5cPBKEAEe01raMX0W6t9q4eCXkXkJhyuUHLQFyY3m24wNz9JKn3ZMNfkijdt2
         ETDzqNTy7SC6vgGJXFcPp2FKsLLSE7AH+8i/7blIcIMM7+XKuL5sxHaBGjm+81vrV3/I
         n2OTJD2m+UMj3jO754hWagnpawOJt1Y3ZxFlGpdawtF0U43478SyCSUd+27kGrlosGDH
         D8jQ==
X-Gm-Message-State: ABuFfohJj4ol9bJp4dWsdpotafCKZgP422eDjgY2oBmVGj6YPNMpyaNW
        wLzxXwLJfm32S/+bxTKnrbIB7Q==
X-Google-Smtp-Source: ACcGV63EUVAsXYPZ5xjm8SPgh4vzszjNQFzT/4eUBdu1yH33jc3pRXBDGQ88mZGVAc8WaDgUkHJwlQ==
X-Received: by 2002:a63:c5a:: with SMTP id 26-v6mr24278770pgm.372.1539064086528;
        Mon, 08 Oct 2018 22:48:06 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id a15-v6sm16886234pff.8.2018.10.08.22.48.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 22:48:05 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     stable@vger.kernel.org
Cc:     Pierre Yves MORDRET <pierre-yves.mordret@st.com>,
        Vinod Koul <vinod.koul@intel.com>, gregkh@linuxfoundation.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32
        ARCHITECTURE), linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: [PATCH 1/7] dmaengine: stm32-dma: threshold manages with bitfield feature
Date:   Mon,  8 Oct 2018 22:47:46 -0700
Message-Id: <20181009054752.145978-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181009054752.145978-1-joel@joelfernandes.org>
References: <20181009054752.145978-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>

>From now on, DMA bitfield is to manage DMA FIFO Threshold.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/dma/stm32-dma.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 786fc8fcc38e..4099948b6914 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -116,6 +116,10 @@
 #define STM32_DMA_MAX_DATA_PARAM	0x03
 #define STM32_DMA_MAX_BURST		16
 
+/* DMA Features */
+#define STM32_DMA_THRESHOLD_FTR_MASK	GENMASK(1, 0)
+#define STM32_DMA_THRESHOLD_FTR_GET(n)	((n) & STM32_DMA_THRESHOLD_FTR_MASK)
+
 enum stm32_dma_width {
 	STM32_DMA_BYTE,
 	STM32_DMA_HALF_WORD,
@@ -129,11 +133,18 @@ enum stm32_dma_burst_size {
 	STM32_DMA_BURST_INCR16,
 };
 
+/**
+ * struct stm32_dma_cfg - STM32 DMA custom configuration
+ * @channel_id: channel ID
+ * @request_line: DMA request
+ * @stream_config: 32bit mask specifying the DMA channel configuration
+ * @features: 32bit mask specifying the DMA Feature list
+ */
 struct stm32_dma_cfg {
 	u32 channel_id;
 	u32 request_line;
 	u32 stream_config;
-	u32 threshold;
+	u32 features;
 };
 
 struct stm32_dma_chan_reg {
@@ -171,6 +182,7 @@ struct stm32_dma_chan {
 	u32 next_sg;
 	struct dma_slave_config	dma_sconfig;
 	struct stm32_dma_chan_reg chan_reg;
+	u32 threshold;
 };
 
 struct stm32_dma_device {
@@ -976,7 +988,8 @@ static void stm32_dma_set_config(struct stm32_dma_chan *chan,
 	/* Enable Interrupts  */
 	chan->chan_reg.dma_scr |= STM32_DMA_SCR_TEIE | STM32_DMA_SCR_TCIE;
 
-	chan->chan_reg.dma_sfcr = cfg->threshold & STM32_DMA_SFCR_FTH_MASK;
+	chan->threshold = STM32_DMA_THRESHOLD_FTR_GET(cfg->features);
+	chan->chan_reg.dma_sfcr = STM32_DMA_SFCR_FTH(chan->threshold);
 }
 
 static struct dma_chan *stm32_dma_of_xlate(struct of_phandle_args *dma_spec,
@@ -996,7 +1009,7 @@ static struct dma_chan *stm32_dma_of_xlate(struct of_phandle_args *dma_spec,
 	cfg.channel_id = dma_spec->args[0];
 	cfg.request_line = dma_spec->args[1];
 	cfg.stream_config = dma_spec->args[2];
-	cfg.threshold = dma_spec->args[3];
+	cfg.features = dma_spec->args[3];
 
 	if ((cfg.channel_id >= STM32_DMA_MAX_CHANNELS) ||
 	    (cfg.request_line >= STM32_DMA_MAX_REQUEST_ID)) {
-- 
2.19.0.605.g01d371f741-goog

