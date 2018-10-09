Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBDBC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411B021479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OAnb0LOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411B021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeJINDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 09:03:23 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38536 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbeJINDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 09:03:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id b5-v6so247032plr.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 22:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3RJ/t1zGSm3UfjNE8WI2rEcf5JWxo9DPt72JtaWe1nc=;
        b=OAnb0LOLsek/oBjbd/RvEDOLwPnxFi8khlKDc7dtNbTDodJRo3hJcQ3+RGL0hlVXUS
         MeT3As4Err6QRj2bqtj2/AxIeyoiykDcUoyFJnxD0IPlsY0Zn3JArlnbHZKIUqgkjwcO
         DRNZhYjaAiDXac4oXb/whaGEkY6Vlt1BFkxbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3RJ/t1zGSm3UfjNE8WI2rEcf5JWxo9DPt72JtaWe1nc=;
        b=b2KvUeY3VGkeVSHNkLiQ8er5ItMUHVTckZZZNTjBatE/xDP/8PyVTJREoFpYnnfnlb
         XhLmdc/NOPzsLc0wwik8tsreBT6n4ebejxpLRLEut7iUuR2tXwPS+uxIBe9N8w3GwjCM
         CSGcEyMPoMJTifgVdUbBavRyx7wocuGAZb26je26dQMOnYS/ciisAYI7nAeS0sxRPVx0
         Cq68GAIjtW3fc8pIgWoX1SqDWY4iI+30iuqR3XT52oBgf9n1gwQ3HvO6KsNs4KPaH6hN
         kBDOulhoQLBnB7vRBpV1EYXPxe/FbGZ1PSdbY8Gn3TqsnKGMfnF57vOoG4lQhb4iSERW
         VIAg==
X-Gm-Message-State: ABuFfoihsBmYCODbP0H6qRWDqVA1S96CJhoc9+k7SXvS+64vOKyJhZz2
        rfB7Va9L1R4tns+ejs4xIWpI7Q==
X-Google-Smtp-Source: ACcGV61hNIYMAw/1MXI+AVlnFVRjyLQUhIq8EqHXyT+gawh5a79FLEuK6O6RcAeZ/xrFtwE5xRCgKw==
X-Received: by 2002:a17:902:d715:: with SMTP id w21-v6mr26370555ply.143.1539064090437;
        Mon, 08 Oct 2018 22:48:10 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id a15-v6sm16886234pff.8.2018.10.08.22.48.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 22:48:09 -0700 (PDT)
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
Subject: [PATCH 3/7] dmaengine: stm32-dma: fix typo and reported checkpatch warnings
Date:   Mon,  8 Oct 2018 22:47:48 -0700
Message-Id: <20181009054752.145978-4-joel@joelfernandes.org>
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

Fix typo in a comment and solved reported checkpatch warnings.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/dma/stm32-dma.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index fae7de54f00a..b64e14a83dec 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -60,7 +60,8 @@
 #define STM32_DMA_SCR_PINC		BIT(9) /* Peripheral increment mode */
 #define STM32_DMA_SCR_CIRC		BIT(8) /* Circular mode */
 #define STM32_DMA_SCR_PFCTRL		BIT(5) /* Peripheral Flow Controller */
-#define STM32_DMA_SCR_TCIE		BIT(4) /* Transfer Cplete Int Enable*/
+#define STM32_DMA_SCR_TCIE		BIT(4) /* Transfer Complete Int Enable
+						*/
 #define STM32_DMA_SCR_TEIE		BIT(2) /* Transfer Error Int Enable */
 #define STM32_DMA_SCR_DMEIE		BIT(1) /* Direct Mode Err Int Enable */
 #define STM32_DMA_SCR_EN		BIT(0) /* Stream Enable */
@@ -918,7 +919,7 @@ static enum dma_status stm32_dma_tx_status(struct dma_chan *c,
 	u32 residue = 0;
 
 	status = dma_cookie_status(c, cookie, state);
-	if ((status == DMA_COMPLETE) || (!state))
+	if (status == DMA_COMPLETE || !state)
 		return status;
 
 	spin_lock_irqsave(&chan->vchan.lock, flags);
@@ -982,7 +983,7 @@ static void stm32_dma_desc_free(struct virt_dma_desc *vdesc)
 }
 
 static void stm32_dma_set_config(struct stm32_dma_chan *chan,
-			  struct stm32_dma_cfg *cfg)
+				 struct stm32_dma_cfg *cfg)
 {
 	stm32_dma_clear_reg(&chan->chan_reg);
 
@@ -1015,8 +1016,8 @@ static struct dma_chan *stm32_dma_of_xlate(struct of_phandle_args *dma_spec,
 	cfg.stream_config = dma_spec->args[2];
 	cfg.features = dma_spec->args[3];
 
-	if ((cfg.channel_id >= STM32_DMA_MAX_CHANNELS) ||
-	    (cfg.request_line >= STM32_DMA_MAX_REQUEST_ID)) {
+	if (cfg.channel_id >= STM32_DMA_MAX_CHANNELS ||
+	    cfg.request_line >= STM32_DMA_MAX_REQUEST_ID) {
 		dev_err(dev, "Bad channel and/or request id\n");
 		return NULL;
 	}
-- 
2.19.0.605.g01d371f741-goog

