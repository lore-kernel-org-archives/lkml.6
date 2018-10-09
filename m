Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB3AC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035B621479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="PbZ1lIJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035B621479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeJINDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 09:03:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40022 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbeJINDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 09:03:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id 1-v6so243304plv.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 22:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z23Tjh1yqMbwhE8WbL7Mv5Y/M073KHw3jtyb5qocoBQ=;
        b=PbZ1lIJyVyyh3yI53kRy/FLEntyL9v3ClQWBuhzRBKXg78LnoAVfyWFgPJzoIA6L/w
         w3MOu5KXNdANYv8/7appfJ6EQUa/pkPyPQM50A8cZ1HiwJB6zKHRuhdXLtIkkQmOqYDh
         LLrEUvZiKGrnGhEON+CkLddhpseaIKTjZOK9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z23Tjh1yqMbwhE8WbL7Mv5Y/M073KHw3jtyb5qocoBQ=;
        b=GLAoQHr3iwProQLw1YAtmKCE4mgfkBAOnCO/3zKiiBEzVcBDdihgHwrHWKND+FPUL5
         vK8UmGYLNTlUrSRKHEDtT4fZ0jDkl3ocvcOY11kZsRccQWbfAK/x8nG+FUnlaj/NmR+U
         TU8C5VxocY9Apzq8gO19cTO/VTHebFt0AfRqdInp2vVBJWGfBf7fBpx3baIpqxtKW12+
         8OIEroBMp5BHEzvpQ7SVS4RnCYQYL+35S70Q3sL1BeTXSM2qjKRsrZUKItNZKStLiuIf
         5lXMwK9ddhk1DtuNxNor6CM4cdm2vEpk89JW/O23g6qwFskMBbnSdTJq91jALxWcLVq+
         hnEg==
X-Gm-Message-State: ABuFfohfkHoQdcGgTy6TdYZiCO8lvISgT8Co82vVyGGNCY+BSHfw5aii
        EhfGNYTSW0w2go5eilCRZnld2Q==
X-Google-Smtp-Source: ACcGV615++WW5p6TKsjmAHxp8EVY43qGKMs9RmF8EHqlvjVJXxxB2ee08QLTfYReCUz3k/aBRJ0SOw==
X-Received: by 2002:a17:902:50e3:: with SMTP id c32-v6mr26734108plj.194.1539064097457;
        Mon, 08 Oct 2018 22:48:17 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id a15-v6sm16886234pff.8.2018.10.08.22.48.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 22:48:16 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     stable@vger.kernel.org
Cc:     Pierre Yves MORDRET <pierre-yves.mordret@st.com>,
        Antonio Borneo <borneo.antonio@gmail.com>,
        Vinod Koul <vinod.koul@intel.com>, gregkh@linuxfoundation.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32
        ARCHITECTURE), linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: [PATCH 7/7] dmaengine: stm32-dma: properly mask irq bits
Date:   Mon,  8 Oct 2018 22:47:52 -0700
Message-Id: <20181009054752.145978-8-joel@joelfernandes.org>
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

A single register of the controller holds the information for four dma
channels.
The functions stm32_dma_irq_status() don't mask the relevant bits after
the shift, thus adjacent channel's status is also reported in the returned
value.
Fixed by masking the value before returning it.

Similarly, the function stm32_dma_irq_clear() don't mask the input value
before shifting it, thus an incorrect input value could disable the
interrupts of adjacent channels.
Fixed by masking the input value before using it.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/dma/stm32-dma.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 05a2974cd2c0..8c5807362a25 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -38,6 +38,10 @@
 #define STM32_DMA_TEI			BIT(3) /* Transfer Error Interrupt */
 #define STM32_DMA_DMEI			BIT(2) /* Direct Mode Error Interrupt */
 #define STM32_DMA_FEI			BIT(0) /* FIFO Error Interrupt */
+#define STM32_DMA_MASKI			(STM32_DMA_TCI \
+					 | STM32_DMA_TEI \
+					 | STM32_DMA_DMEI \
+					 | STM32_DMA_FEI)
 
 /* DMA Stream x Configuration Register */
 #define STM32_DMA_SCR(x)		(0x0010 + 0x18 * (x)) /* x = 0..7 */
@@ -405,7 +409,7 @@ static u32 stm32_dma_irq_status(struct stm32_dma_chan *chan)
 
 	flags = dma_isr >> (((chan->id & 2) << 3) | ((chan->id & 1) * 6));
 
-	return flags;
+	return flags & STM32_DMA_MASKI;
 }
 
 static void stm32_dma_irq_clear(struct stm32_dma_chan *chan, u32 flags)
@@ -420,6 +424,7 @@ static void stm32_dma_irq_clear(struct stm32_dma_chan *chan, u32 flags)
 	 * If (ch % 4) is 2 or 3, left shift the mask by 16 bits.
 	 * If (ch % 4) is 1 or 3, additionally left shift the mask by 6 bits.
 	 */
+	flags &= STM32_DMA_MASKI;
 	dma_ifcr = flags << (((chan->id & 2) << 3) | ((chan->id & 1) * 6));
 
 	if (chan->id & 4)
-- 
2.19.0.605.g01d371f741-goog

