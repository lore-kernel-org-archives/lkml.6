Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2FFC5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BB1214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="cE/IkhWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3BB1214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeJQHxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:53:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44604 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeJQHxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:53:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id r9-v6so12229945pff.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 17:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=u8eFwnEzbMjdPpfi+5GlsSnjxbqm4XcdtlCp30+Z08A=;
        b=cE/IkhWqaohuuGyQiuB4RoivejobsQrDPbY2UUd4Gh/vzn2liZZ2Qc9FbtaWYzu8WO
         piv/Mnt9nnLgLO4ls2tigRQ8yDg3VnZHsl/HqGG2WUfPCRjxsYkL5o3XTn2koQCyy85X
         yLbR5G+p2sfjUu42CxDbVrHJmkZHiDj8pk9eY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=u8eFwnEzbMjdPpfi+5GlsSnjxbqm4XcdtlCp30+Z08A=;
        b=rLGMYZFul4WHU8Z76iqvBQwMDb2FVH9nTfzmUl3hXE+u+ezoueMYfLp4uMdwl0lTsm
         IoPSI+6QWltwgX/Y0ET+O2T4kDKZ3KMx9DRp7/Px4Chs0CC6uAsoZ6YmreFe0XonOEaf
         rDOJjOWebjGfuCXoi8Bc0audTuKKQD8X3L2rrvd7G+fJyYU8znjKTvLlc0t29rgfBJnI
         nj+OjXN2LukEc0oHkXoJVxffDyv0R06zXReW43SRALsAg1ZIxhnDO+u+da47UE4XVvzm
         +Z+saH1FlXAxftjeVkA+/VvzqOzKJIUvnRPFSpMLMgQm0RqH5ZX8wgWaIMkNBq2w8Kvb
         Cc8w==
X-Gm-Message-State: ABuFfogSj5rlBpdNvjZm+Ec7y8M6ROaJay2R+zt+UhgQ+XZRp4rVoHnD
        E/tiCuujjV9S+hDmUVQXTacy4A==
X-Google-Smtp-Source: ACcGV61Hfxv50FJ44RKxFsvSO+4E4i7+YusAc+f53xq2i8edQWUp24y0p4vRXmZ1YXLEzN0NzDpXig==
X-Received: by 2002:a63:f64f:: with SMTP id u15-v6mr22481301pgj.258.1539734415469;
        Tue, 16 Oct 2018 17:00:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id l2-v6sm16200688pgp.20.2018.10.16.17.00.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 17:00:08 -0700 (PDT)
Date:   Tue, 16 Oct 2018 17:00:03 -0700
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     stable@vger.kernel.org
Cc:     Pierre Yves MORDRET <pierre-yves.mordret@st.com>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        Vinod Koul <vinod.koul@intel.com>, gregkh@linuxfoundation.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: [PATCH for-stable] dmaengine: stm32-dma: fix incomplete
 configuration in cyclic mode
Message-ID: <20181017000003.GC140578@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>

commit e57cb3b3f10d005410f09d4598cc6d62b833f2b0 upstream.

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

