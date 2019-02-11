Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541C5C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258AB21855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900387;
	bh=oVsxzA2Nv1Tteqi/LWuSaHWh7lcGiUGHNHGInbkNUds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KWBfgvXlBe9vQPk5bIM6WZ/BiW313aoDQDeIMxyKZK4pIOuGQzmb4hM3kevi3+dDg
	 udjz8NMlVSyFcaXIbwbyoESim9sjF4bJaWh4o8iQqY+AnkOh6qbD86p+/ich1ePU7m
	 e2tDenYqJZSY7u/F3piqU7yiPT/lIQOzxgg+FpC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731313AbfBKOgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:36:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:45906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731302AbfBKOgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:36:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF49C20700;
        Mon, 11 Feb 2019 14:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895802;
        bh=oVsxzA2Nv1Tteqi/LWuSaHWh7lcGiUGHNHGInbkNUds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c+PoIS2KrS5BE8He90iJpQMYtXieLOOfjQeDJNol5AHfTGlDndU/j8HViGiKllEOr
         5Huwd7DUOmaql/LfN7WRLKT2sTV4IFqk0Ktc6yvBubT9Ulke5sCqzKKMouHUE8/ySu
         ymQeS8d1ovnTitkJsPWLBakImJVb/fIpv40ZF+rQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Leonid Iziumtsev <leonid.iziumtsev@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 4.20 327/352] dmaengine: imx-dma: fix wrong callback invoke
Date:   Mon, 11 Feb 2019 15:19:14 +0100
Message-Id: <20190211141907.651753990@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
@@ -618,7 +618,7 @@ static void imxdma_tasklet(unsigned long
 {
 	struct imxdma_channel *imxdmac = (void *)data;
 	struct imxdma_engine *imxdma = imxdmac->imxdma;
-	struct imxdma_desc *desc;
+	struct imxdma_desc *desc, *next_desc;
 	unsigned long flags;
 
 	spin_lock_irqsave(&imxdma->lock, flags);
@@ -648,10 +648,10 @@ static void imxdma_tasklet(unsigned long
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


