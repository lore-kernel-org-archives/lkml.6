Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E40C65C1D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E10A21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="uWYR81tW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E10A21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbeJIND1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 09:03:27 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33850 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeJIND0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 09:03:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id f18-v6so254530plr.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 22:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HUriwkHyLvnR6PfOR/IGT3CTgX/2scA9IP2awmjlhNg=;
        b=uWYR81tWObB0a4RNo9BrUcBqCzZcJgRPoeZCBXo/pWQZrEineujy7zUB3WTRaoN0Pj
         EOrEy1E/xrZvrfSnUtMVONVfcxl4TXW2LD4TWlUlV3aVzx7B0lyzmHBP03SeAo7SIBYb
         KDMqTVMPFocag8zgmVOUKZVQQmWu52QdUxb7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HUriwkHyLvnR6PfOR/IGT3CTgX/2scA9IP2awmjlhNg=;
        b=ZzJo36SeN4M/sZVgs3DpJuxuVX6DSGO8pAplBnSXy4lk/dOi5pIMVsLuMVUJzChuAL
         3Zi5mao8bl8BajSaNyNnFaKy+7q9yJTLP1xZ/JKUmFOTPiGmh7gr1wsROR++lS1gjEer
         kenZDsS1CCA/Pp1Q5c5iYeO9gICuVmEq0efwD5kwrx3sBm15OSkExTJaeGH5wzzkvbat
         D2SxdQT01Ey59LHcq1r2h6QqZV1YarxSnRyxm9CIF8nXZAysJUkuZTd18s4eaKwrTxs0
         YNiBeEtovLuOVmwf8JVf8677o8l4wVLBNAdrso1p0A9oIVouBftJrRWpCGW7ebwpCYjk
         s1zQ==
X-Gm-Message-State: ABuFfojh+iemYU91pkHWn47yFiNRFp4wP+S2GoOx3bc+c0puRJktqaYy
        +azAr6m3n1D85baE5paiAaHyQSJvzK4=
X-Google-Smtp-Source: ACcGV61n0c+VbTj7yWqStK2eKWDmJ1dD6rYcg2o4jH6PZOroiMKqXdoK8Hi7z6fVU+zvRIfy+65I7w==
X-Received: by 2002:a17:902:7109:: with SMTP id a9-v6mr26985609pll.310.1539064093897;
        Mon, 08 Oct 2018 22:48:13 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id a15-v6sm16886234pff.8.2018.10.08.22.48.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 22:48:12 -0700 (PDT)
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
Subject: [PATCH 5/7] dmaengine: stm32-dma: fix DMA IRQ status handling
Date:   Mon,  8 Oct 2018 22:47:50 -0700
Message-Id: <20181009054752.145978-6-joel@joelfernandes.org>
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

Update the way Transfer Complete and Half Transfer Complete status are
acknowledge. Even if HTI is not enabled its status is shown when reading
registers, driver has to clear it gently and not raise an error.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/dma/stm32-dma.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 21ad359a5a59..b40486454a2c 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -34,9 +34,14 @@
 #define STM32_DMA_LIFCR			0x0008 /* DMA Low Int Flag Clear Reg */
 #define STM32_DMA_HIFCR			0x000c /* DMA High Int Flag Clear Reg */
 #define STM32_DMA_TCI			BIT(5) /* Transfer Complete Interrupt */
+#define STM32_DMA_HTI			BIT(4) /* Half Transfer Interrupt */
 #define STM32_DMA_TEI			BIT(3) /* Transfer Error Interrupt */
 #define STM32_DMA_DMEI			BIT(2) /* Direct Mode Error Interrupt */
 #define STM32_DMA_FEI			BIT(0) /* FIFO Error Interrupt */
+#define STM32_DMA_MASKI			(STM32_DMA_TCI \
+					 | STM32_DMA_TEI \
+					 | STM32_DMA_DMEI \
+					 | STM32_DMA_FEI)
 
 /* DMA Stream x Configuration Register */
 #define STM32_DMA_SCR(x)		(0x0010 + 0x18 * (x)) /* x = 0..7 */
@@ -643,13 +648,29 @@ static irqreturn_t stm32_dma_chan_irq(int irq, void *devid)
 	status = stm32_dma_irq_status(chan);
 	scr = stm32_dma_read(dmadev, STM32_DMA_SCR(chan->id));
 
-	if ((status & STM32_DMA_TCI) && (scr & STM32_DMA_SCR_TCIE)) {
+	if (status & STM32_DMA_TCI) {
 		stm32_dma_irq_clear(chan, STM32_DMA_TCI);
-		stm32_dma_handle_chan_done(chan);
-
-	} else {
+		if (scr & STM32_DMA_SCR_TCIE)
+			stm32_dma_handle_chan_done(chan);
+		status &= ~STM32_DMA_TCI;
+	}
+	if (status & STM32_DMA_HTI) {
+		stm32_dma_irq_clear(chan, STM32_DMA_HTI);
+		status &= ~STM32_DMA_HTI;
+	}
+	if (status & STM32_DMA_FEI) {
+		stm32_dma_irq_clear(chan, STM32_DMA_FEI);
+		status &= ~STM32_DMA_FEI;
+		if (!(scr & STM32_DMA_SCR_EN))
+			dev_err(chan2dev(chan), "FIFO Error\n");
+		else
+			dev_dbg(chan2dev(chan), "FIFO over/underrun\n");
+	}
+	if (status) {
 		stm32_dma_irq_clear(chan, status);
 		dev_err(chan2dev(chan), "DMA error: status=0x%08x\n", status);
+		if (!(scr & STM32_DMA_SCR_EN))
+			dev_err(chan2dev(chan), "chan disabled by HW\n");
 	}
 
 	spin_unlock(&chan->vchan.lock);
-- 
2.19.0.605.g01d371f741-goog

