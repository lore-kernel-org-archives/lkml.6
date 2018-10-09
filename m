Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85C2C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A077E21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="LS3IMq7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A077E21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbeJIND3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 09:03:29 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33853 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbeJIND2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 09:03:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id f18-v6so254566plr.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 22:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X9Pi7kVseJCqn/XAAguX5FsfI2og3DoGIlIZ/tzzQ3U=;
        b=LS3IMq7Js5UbwUJ/6XVmpfNBh8RhR80Di9PEgmDQg/k0wz9eZhmCky8McL5u5N9+IX
         9PzaaFLsu40ymIvYu2pdjowlF4DgQi3lr1rddt6JZ+WH3rtkSLZ+RdyyJBJQiTnTRNv7
         MIhzWjTQ6pwa9suwuF2+Bg0xPFuQecllgZjF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X9Pi7kVseJCqn/XAAguX5FsfI2og3DoGIlIZ/tzzQ3U=;
        b=GWPdl42sQJODJQ8bCcFjSC/TayF/3PAWFGYDGXg+ld0d1t/9auucnUme0r4PpW0NA1
         kQsHvv1Euu87L8uURriEpedV7ftJVK5X8MJB0DBnVyd3H8v/CMTzXFk5parFZ3I+P/sc
         NA/UA7JR85PP+LhNRHgwYG+TIWcIZ0uLMfhrIsx/jKwEJ723Fv4kpgYgdO2wKbor+AK5
         F/kzyzgRMd/q8ictL1nWtXqnBzbudTD5tH2El/gdFlAmv93Zo0D+VKjDiH6P3F6PeGsh
         D45wOWrWtwHNPneRMgIWuu+KJwsQPlAMPsIb+65mcaUdaKEhR+PifT8JbIUSFw7FC/1l
         AaJg==
X-Gm-Message-State: ABuFfoh+9t3h+WCW4hWVyRnDj5clxAAWkCxXuxWUuXksWz28Uf3+C2HV
        BoH7+d8SV8VQELpUGbKUrSXe8A==
X-Google-Smtp-Source: ACcGV60cXp1emE3xFoWYJ8jVXiCRV+8TyYtWQzEho2WnBUiE8RJPqtQsGUFrfg+bytt4NkKjcHXKbA==
X-Received: by 2002:a17:902:2f41:: with SMTP id s59-v6mr26811116plb.240.1539064095841;
        Mon, 08 Oct 2018 22:48:15 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id a15-v6sm16886234pff.8.2018.10.08.22.48.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 22:48:14 -0700 (PDT)
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
Subject: [PATCH 6/7] dmaengine: stm32-dma: fix max items per transfer
Date:   Mon,  8 Oct 2018 22:47:51 -0700
Message-Id: <20181009054752.145978-7-joel@joelfernandes.org>
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

Having 0 in item counter register is valid and stands for a "No or Ended
transfer". Therefore valid transfer starts from @+0 to @+0xFFFE leading to
unaligned scatter gather at boundary. Thus it's safer to round down this
value on its FIFO size (16 Bytes).

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/dma/stm32-dma.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index b40486454a2c..05a2974cd2c0 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -38,10 +38,6 @@
 #define STM32_DMA_TEI			BIT(3) /* Transfer Error Interrupt */
 #define STM32_DMA_DMEI			BIT(2) /* Direct Mode Error Interrupt */
 #define STM32_DMA_FEI			BIT(0) /* FIFO Error Interrupt */
-#define STM32_DMA_MASKI			(STM32_DMA_TCI \
-					 | STM32_DMA_TEI \
-					 | STM32_DMA_DMEI \
-					 | STM32_DMA_FEI)
 
 /* DMA Stream x Configuration Register */
 #define STM32_DMA_SCR(x)		(0x0010 + 0x18 * (x)) /* x = 0..7 */
@@ -118,6 +114,13 @@
 #define STM32_DMA_FIFO_THRESHOLD_FULL			0x03
 
 #define STM32_DMA_MAX_DATA_ITEMS	0xffff
+/*
+ * Valid transfer starts from @0 to @0xFFFE leading to unaligned scatter
+ * gather at boundary. Thus it's safer to round down this value on FIFO
+ * size (16 Bytes)
+ */
+#define STM32_DMA_ALIGNED_MAX_DATA_ITEMS	\
+	ALIGN_DOWN(STM32_DMA_MAX_DATA_ITEMS, 16)
 #define STM32_DMA_MAX_CHANNELS		0x08
 #define STM32_DMA_MAX_REQUEST_ID	0x08
 #define STM32_DMA_MAX_DATA_PARAM	0x03
@@ -869,7 +872,7 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_slave_sg(
 		desc->sg_req[i].len = sg_dma_len(sg);
 
 		nb_data_items = desc->sg_req[i].len / buswidth;
-		if (nb_data_items > STM32_DMA_MAX_DATA_ITEMS) {
+		if (nb_data_items > STM32_DMA_ALIGNED_MAX_DATA_ITEMS) {
 			dev_err(chan2dev(chan), "nb items not supported\n");
 			goto err;
 		}
@@ -935,7 +938,7 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_cyclic(
 		return NULL;
 
 	nb_data_items = period_len / buswidth;
-	if (nb_data_items > STM32_DMA_MAX_DATA_ITEMS) {
+	if (nb_data_items > STM32_DMA_ALIGNED_MAX_DATA_ITEMS) {
 		dev_err(chan2dev(chan), "number of items not supported\n");
 		return NULL;
 	}
@@ -985,7 +988,7 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_memcpy(
 	u32 num_sgs, best_burst, dma_burst, threshold;
 	int i;
 
-	num_sgs = DIV_ROUND_UP(len, STM32_DMA_MAX_DATA_ITEMS);
+	num_sgs = DIV_ROUND_UP(len, STM32_DMA_ALIGNED_MAX_DATA_ITEMS);
 	desc = stm32_dma_alloc_desc(num_sgs);
 	if (!desc)
 		return NULL;
@@ -994,7 +997,7 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_memcpy(
 
 	for (offset = 0, i = 0; offset < len; offset += xfer_count, i++) {
 		xfer_count = min_t(size_t, len - offset,
-				   STM32_DMA_MAX_DATA_ITEMS);
+				   STM32_DMA_ALIGNED_MAX_DATA_ITEMS);
 
 		/* Compute best burst size */
 		max_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
-- 
2.19.0.605.g01d371f741-goog

