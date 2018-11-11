Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B398C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB2221780
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gm9hsxHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB2221780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403854AbeKLIWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:22:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:51248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403775AbeKLIWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:40 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9D91223D8;
        Sun, 11 Nov 2018 22:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975563;
        bh=iruh8JKe+2QWe2ox8e371IVGqv5Bx/Zm9Njie6QZhrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gm9hsxHQKGBAqwRmXamaIm3DlzUOvtkTj8tAPIAyPBsLxPjngqxzAWBSu3+rTfYBy
         iSKLPpcmOSG6nVT76NJjgfIJo+K3tlpVpHzGAFseSEUZ7wW+nTUT5o8WZWbOmSz1LG
         RT+JV2fF85TmMuymv926M1Bqy/xXcoCZwFvS1xUE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        Vinod Koul <vinod.koul@intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH 4.14 130/222] dmaengine: stm32-dma: fix incomplete configuration in cyclic mode
Date:   Sun, 11 Nov 2018 14:23:47 -0800
Message-Id: <20181111221659.229602970@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>

commit e57cb3b3f10d005410f09d4598cc6d62b833f2b0 upstream.

When in cyclic mode, the configuration is updated after having started the
DMA hardware (STM32_DMA_SCR_EN) leading to incomplete configuration of
SMxAR registers.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/stm32-dma.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -429,6 +429,8 @@ static void stm32_dma_dump_reg(struct st
 	dev_dbg(chan2dev(chan), "SFCR:  0x%08x\n", sfcr);
 }
 
+static void stm32_dma_configure_next_sg(struct stm32_dma_chan *chan);
+
 static void stm32_dma_start_transfer(struct stm32_dma_chan *chan)
 {
 	struct stm32_dma_device *dmadev = stm32_dma_get_dev(chan);
@@ -471,6 +473,9 @@ static void stm32_dma_start_transfer(str
 	if (status)
 		stm32_dma_irq_clear(chan, status);
 
+	if (chan->desc->cyclic)
+		stm32_dma_configure_next_sg(chan);
+
 	stm32_dma_dump_reg(chan);
 
 	/* Start DMA */
@@ -564,8 +569,7 @@ static void stm32_dma_issue_pending(stru
 	if (vchan_issue_pending(&chan->vchan) && !chan->desc && !chan->busy) {
 		dev_dbg(chan2dev(chan), "vchan %p: issued\n", &chan->vchan);
 		stm32_dma_start_transfer(chan);
-		if (chan->desc->cyclic)
-			stm32_dma_configure_next_sg(chan);
+
 	}
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
 }


