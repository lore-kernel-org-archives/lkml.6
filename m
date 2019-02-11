Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B803AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84519222B0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897473;
	bh=IQ/zWVScjqhYrr+OJSup8jh86bkLNU2Fpca9/2P2ghg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SCe4Acswp45hrUBf/EJe1Pq8P3OMR7b+wmkZs4ZjO6c4xGiSMOQSO824bhF5a6IqX
	 UyGI3m5bQ48cGvV0Y+yqRKKuxTyWdlKpOSKdKoDp1tFBWfLK8o7UgDJchFiGrcsgxe
	 hdu/t94Tw9uDI9wG7OhAmlnKhsURLx7BYGWye8hk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390804AbfBKPEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:04:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:53496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729551AbfBKPE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:04:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6516222B0;
        Mon, 11 Feb 2019 15:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897468;
        bh=IQ/zWVScjqhYrr+OJSup8jh86bkLNU2Fpca9/2P2ghg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BK6Wb7gUCMBIR51LQrAAYBcNigaAeXtS7vzaG6iY04N2480SyCHGRyNqw+TZPHukl
         S4/rQ7Tuho/Y0Ne97wUJp7m3JzMciP1sVQ/mkWOo7XWhx6xLZCEvMFLZIBmj8ErQsB
         y0pWMQGXV6ijD/ajTp6409ct30E20fovx2L7MXuA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Leonid Iziumtsev <leonid.iziumtsev@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 4.14 182/205] dmaengine: imx-dma: fix wrong callback invoke
Date:   Mon, 11 Feb 2019 15:19:40 +0100
Message-Id: <20190211141840.289756490@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -623,7 +623,7 @@ static void imxdma_tasklet(unsigned long
 {
 	struct imxdma_channel *imxdmac = (void *)data;
 	struct imxdma_engine *imxdma = imxdmac->imxdma;
-	struct imxdma_desc *desc;
+	struct imxdma_desc *desc, *next_desc;
 	unsigned long flags;
 
 	spin_lock_irqsave(&imxdma->lock, flags);
@@ -653,10 +653,10 @@ static void imxdma_tasklet(unsigned long
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


