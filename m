Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E4DC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ECC8214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="UEGr97XW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECC8214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbeJINDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 09:03:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34877 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbeJINDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 09:03:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id v133-v6so253378pgb.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 22:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+MWYNVKtdWKD6Kujvr2Aj0Wsqz2uAcNP6f8Ca6gsyhQ=;
        b=UEGr97XWdDuhrAyW352emJpf61BrkxEUIlSDz9vF42Ii3CFMf5SrrrSmUdi5BlcYxz
         4bpFquIee4piojPX22Gzdq61W9axvkWAz3d7U4p7SD2l3qTvyC6TX9/P+gqtNzeeO8io
         vb4JPkTXqL6Z6MO/fpQ25OS4zUU4tEofF2o7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+MWYNVKtdWKD6Kujvr2Aj0Wsqz2uAcNP6f8Ca6gsyhQ=;
        b=pqH+m6w1KfLmaYDBc+1gISz8lPb93UYU9xB5g8yVvXlt0+xlok5A5erGtuMh2hdNuI
         CtZGCCAaxE5NyCmQUbWtpt07dkPPmiZZiaRzcBsW1hYR9SS4sm1Hm6vhVhtex1Vwk3ys
         NSMNZ+PnAdGxMiqCOPGdqmb4vUrqYBlvMOBmYcxHgWFN10k7H8mlch+hzfGteTVqmajA
         0ic347HJZZDOXqMU7/sGqFIDMhFtOHzSrJjeYEWx9kmFTuMEX27JSCnFHjPC1To5DDa0
         mYcqhpmlCkfywXs8H5nPrpi84TNMkkNR4es/PkWV99Ng9VBLAOB7eV1hIFgVc8ESEKE4
         0Kww==
X-Gm-Message-State: ABuFfoiGx7WjMZlUgzzUY1o22KBYCmLPDOhCd6Z8np62JWvSvvYt5CmW
        57oHFi1UCCRW4v2GlGEZQ9j5sw==
X-Google-Smtp-Source: ACcGV62btTrzmG5Nc+IiadGRrGg+nq0I79KJncpZNOsftccNv1XHh1w4r0UpuBz85dlIkAzpLPthrQ==
X-Received: by 2002:a63:9409:: with SMTP id m9-v6mr23420475pge.93.1539064088830;
        Mon, 08 Oct 2018 22:48:08 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id a15-v6sm16886234pff.8.2018.10.08.22.48.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 22:48:07 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     stable@vger.kernel.org
Cc:     Pierre Yves MORDRET <pierre-yves.mordret@st.com>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        Vinod Koul <vinod.koul@intel.com>, gregkh@linuxfoundation.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32
        ARCHITECTURE), linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: [PATCH 2/7] dmaengine: stm32-dma: fix incomplete configuration in cyclic mode
Date:   Mon,  8 Oct 2018 22:47:47 -0700
Message-Id: <20181009054752.145978-3-joel@joelfernandes.org>
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

When in cyclic mode, the configuration is updated after having started the
DMA hardware (STM32_DMA_SCR_EN) leading to incomplete configuration of
SMxAR registers.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/dma/stm32-dma.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 4099948b6914..fae7de54f00a 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -441,6 +441,8 @@ static void stm32_dma_dump_reg(struct stm32_dma_chan *chan)
 	dev_dbg(chan2dev(chan), "SFCR:  0x%08x\n", sfcr);
 }
 
+static void stm32_dma_configure_next_sg(struct stm32_dma_chan *chan);
+
 static void stm32_dma_start_transfer(struct stm32_dma_chan *chan)
 {
 	struct stm32_dma_device *dmadev = stm32_dma_get_dev(chan);
@@ -483,6 +485,9 @@ static void stm32_dma_start_transfer(struct stm32_dma_chan *chan)
 	if (status)
 		stm32_dma_irq_clear(chan, status);
 
+	if (chan->desc->cyclic)
+		stm32_dma_configure_next_sg(chan);
+
 	stm32_dma_dump_reg(chan);
 
 	/* Start DMA */
@@ -576,8 +581,7 @@ static void stm32_dma_issue_pending(struct dma_chan *c)
 	if (vchan_issue_pending(&chan->vchan) && !chan->desc && !chan->busy) {
 		dev_dbg(chan2dev(chan), "vchan %p: issued\n", &chan->vchan);
 		stm32_dma_start_transfer(chan);
-		if (chan->desc->cyclic)
-			stm32_dma_configure_next_sg(chan);
+
 	}
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
 }
-- 
2.19.0.605.g01d371f741-goog

