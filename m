Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1D3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFC22177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499388;
	bh=l46B26V6RjiGa3su7wC1tZ6wtYZqo2bQHXkpgulhYp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oCoR3tT4KFfp9b4dkKYdxccwb+/+VNvFBjcjcHMqfdE24rwn4f4r2Qy1mZvzN36ut
	 WLNi/hRgPkViCnz6DOG7kY8nAJpg6cXGGZHJtrAwmmUEEoaH84GSQj4UJu3X7L+j2b
	 dLmLm2j7Luq4HCIHQL7Xc1/i3UC3S6UbFWXTY+Wc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfBROQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:16:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:55048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391644AbfBROLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:11:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DDEA217D7;
        Mon, 18 Feb 2019 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550499065;
        bh=l46B26V6RjiGa3su7wC1tZ6wtYZqo2bQHXkpgulhYp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G30q2cDKp15h8i450uiqjhJtsbYI9/tNDapNhptKLZ+IhyNyQaNfgncYPRl6mXI1w
         0h6ymu7YX72Ewyh28+e6hcKT8o5vK5d+0WlyHYUczQJpF8BK1jTGzxGrVJbDK46TeW
         K7iAaRhvZa93gsAv6jm8sOztX9NdLZW6YF+VzBUo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Leonid Iziumtsev <leonid.iziumtsev@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 3.18 066/108] dmaengine: imx-dma: fix wrong callback invoke
Date:   Mon, 18 Feb 2019 14:44:02 +0100
Message-Id: <20190218133522.585595630@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leonid Iziumtsev <leonid.iziumtsev@gmail.com>

commit 341198eda723c8c1cddbb006a89ad9e362502ea2 upstream.

Once the "ld_queue" list is not empty, next descriptor will migrate
into "ld_active" list. The "desc" variable will be overwritten
during that transition. And later the dmaengine_desc_get_callback_invoke()
will use it as an argument. As result we invoke wrong callback.

That behaviour was in place since:
commit fcaaba6c7136 ("dmaengine: imx-dma: fix callback path in tasklet").
But after commit 4cd13c21b207 ("softirq: Let ksoftirqd do its job")
things got worse, since possible delay between tasklet_schedule()
from DMA irq handler and actual tasklet function execution got bigger.
And that gave more time for new DMA request to be submitted and
to be put into "ld_queue" list.

It has been noticed that DMA issue is causing problems for "mxc-mmc"
driver. While stressing the system with heavy network traffic and
writing/reading to/from sd card simultaneously the timeout may happen:

10013000.sdhci: mxcmci_watchdog: read time out (status = 0x30004900)

That often lead to file system corruption.

Signed-off-by: Leonid Iziumtsev <leonid.iziumtsev@gmail.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/imx-dma.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -624,7 +624,7 @@ static void imxdma_tasklet(unsigned long
 {
 	struct imxdma_channel *imxdmac = (void *)data;
 	struct imxdma_engine *imxdma = imxdmac->imxdma;
-	struct imxdma_desc *desc;
+	struct imxdma_desc *desc, *next_desc;
 	unsigned long flags;
 
 	spin_lock_irqsave(&imxdma->lock, flags);
@@ -654,10 +654,10 @@ static void imxdma_tasklet(unsigned long
 	list_move_tail(imxdmac->ld_active.next, &imxdmac->ld_free);
 
 	if (!list_empty(&imxdmac->ld_queue)) {
-		desc = list_first_entry(&imxdmac->ld_queue, struct imxdma_desc,
-					node);
+		next_desc = list_first_entry(&imxdmac->ld_queue,
+					     struct imxdma_desc, node);
 		list_move_tail(imxdmac->ld_queue.next, &imxdmac->ld_active);
-		if (imxdma_xfer_desc(desc) < 0)
+		if (imxdma_xfer_desc(next_desc) < 0)
 			dev_warn(imxdma->dev, "%s: channel: %d couldn't xfer desc\n",
 				 __func__, imxdmac->channel);
 	}


