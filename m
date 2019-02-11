Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9102EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D72222BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897874;
	bh=HGJueeptHIuVp2nd4WHdEK6yC8yGnUuYmKzZabu4gRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0zTExXRXcNzrCkStQSEq/NXWNmhfzTgAXaS2OfgaHmm5TeOHIKvuj7UZ2buPg30M4
	 fxuK3NiEKC9ATn9d9qN0yfROWoEB1k+a3twSSZfNm5XI8HnCVmJD7OZzufgjgKzFWz
	 IeYmV364OK9H1mdO54xWObSmmG6PzaEqf7Jhw4Lk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404056AbfBKPLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:11:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:32968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391355AbfBKPLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:11:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 750F3222B2;
        Mon, 11 Feb 2019 15:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897868;
        bh=HGJueeptHIuVp2nd4WHdEK6yC8yGnUuYmKzZabu4gRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vRynEBOefkDtYZxejb7thTXgOk2B6NHyxyOUaqGideAbtpbmSP/Kwk4dBZR5PxcP2
         Ajed9SnfJieK6hIdDHAG+D9lcZES8kiQUliAjH5cb0VICujBTaN0jTlxvXnsglDgz7
         cj6shtZg6Bte7M9gTW4AjI+J4kDVBQahEKEX0yPk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Frank Pavlic <f.pavlic@kunbus.de>,
        Martin Sperl <kernel@martin.sperl.org>,
        Florian Meier <florian.meier@koalo.de>,
        Clive Messer <clive.m.messer@gmail.com>,
        Matthias Reichl <hias@horus.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Kauer <florian.kauer@koalo.de>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 4.9 119/137] dmaengine: bcm2835: Fix interrupt race on RT
Date:   Mon, 11 Feb 2019 15:20:00 +0100
Message-Id: <20190211141823.208431933@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit f7da7782aba92593f7b82f03d2409a1c5f4db91b upstream.

If IRQ handlers are threaded (either because CONFIG_PREEMPT_RT_BASE is
enabled or "threadirqs" was passed on the command line) and if system
load is sufficiently high that wakeup latency of IRQ threads degrades,
SPI DMA transactions on the BCM2835 occasionally break like this:

ks8851 spi0.0: SPI transfer timed out
bcm2835-dma 3f007000.dma: DMA transfer could not be terminated
ks8851 spi0.0 eth2: ks8851_rdfifo: spi_sync() failed

The root cause is an assumption made by the DMA driver which is
documented in a code comment in bcm2835_dma_terminate_all():

/*
 * Stop DMA activity: we assume the callback will not be called
 * after bcm_dma_abort() returns (even if it does, it will see
 * c->desc is NULL and exit.)
 */

That assumption falls apart if the IRQ handler bcm2835_dma_callback() is
threaded: A client may terminate a descriptor and issue a new one
before the IRQ handler had a chance to run. In fact the IRQ handler may
miss an *arbitrary* number of descriptors. The result is the following
race condition:

1. A descriptor finishes, its interrupt is deferred to the IRQ thread.
2. A client calls dma_terminate_async() which sets channel->desc = NULL.
3. The client issues a new descriptor. Because channel->desc is NULL,
   bcm2835_dma_issue_pending() immediately starts the descriptor.
4. Finally the IRQ thread runs and writes BCM2835_DMA_INT to the CS
   register to acknowledge the interrupt. This clears the ACTIVE flag,
   so the newly issued descriptor is paused in the middle of the
   transaction. Because channel->desc is not NULL, the IRQ thread
   finalizes the descriptor and tries to start the next one.

I see two possible solutions: The first is to call synchronize_irq()
in bcm2835_dma_issue_pending() to wait until the IRQ thread has
finished before issuing a new descriptor. The downside of this approach
is unnecessary latency if clients desire rapidly terminating and
re-issuing descriptors and don't have any use for an IRQ callback.
(The SPI TX DMA channel is a case in point.)

A better alternative is to make the IRQ thread recognize that it has
missed descriptors and avoid finalizing the newly issued descriptor.
So first of all, set the ACTIVE flag when acknowledging the interrupt.
This keeps a newly issued descriptor running.

If the descriptor was finished, the channel remains idle despite the
ACTIVE flag being set. However the ACTIVE flag can then no longer be
used to check whether the channel is idle, so instead check whether
the register containing the current control block address is zero
and finalize the current descriptor only if so.

That way, there is no impact on latency and throughput if the client
doesn't care for the interrupt: Only minimal additional overhead is
introduced for non-cyclic descriptors as one further MMIO read is
necessary per interrupt to check for idleness of the channel. Cyclic
descriptors are sped up slightly by removing one MMIO write per
interrupt.

Fixes: 96286b576690 ("dmaengine: Add support for BCM2835")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v3.14+
Cc: Frank Pavlic <f.pavlic@kunbus.de>
Cc: Martin Sperl <kernel@martin.sperl.org>
Cc: Florian Meier <florian.meier@koalo.de>
Cc: Clive Messer <clive.m.messer@gmail.com>
Cc: Matthias Reichl <hias@horus.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Florian Kauer <florian.kauer@koalo.de>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/bcm2835-dma.c |   33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -421,7 +421,12 @@ static int bcm2835_dma_abort(void __iome
 	long int timeout = 10000;
 
 	cs = readl(chan_base + BCM2835_DMA_CS);
-	if (!(cs & BCM2835_DMA_ACTIVE))
+
+	/*
+	 * A zero control block address means the channel is idle.
+	 * (The ACTIVE flag in the CS register is not a reliable indicator.)
+	 */
+	if (!readl(chan_base + BCM2835_DMA_ADDR))
 		return 0;
 
 	/* Write 0 to the active bit - Pause the DMA */
@@ -485,8 +490,15 @@ static irqreturn_t bcm2835_dma_callback(
 
 	spin_lock_irqsave(&c->vc.lock, flags);
 
-	/* Acknowledge interrupt */
-	writel(BCM2835_DMA_INT, c->chan_base + BCM2835_DMA_CS);
+	/*
+	 * Clear the INT flag to receive further interrupts. Keep the channel
+	 * active in case the descriptor is cyclic or in case the client has
+	 * already terminated the descriptor and issued a new one. (May happen
+	 * if this IRQ handler is threaded.) If the channel is finished, it
+	 * will remain idle despite the ACTIVE flag being set.
+	 */
+	writel(BCM2835_DMA_INT | BCM2835_DMA_ACTIVE,
+	       c->chan_base + BCM2835_DMA_CS);
 
 	d = c->desc;
 
@@ -494,11 +506,7 @@ static irqreturn_t bcm2835_dma_callback(
 		if (d->cyclic) {
 			/* call the cyclic callback */
 			vchan_cyclic_callback(&d->vd);
-
-			/* Keep the DMA engine running */
-			writel(BCM2835_DMA_ACTIVE,
-			       c->chan_base + BCM2835_DMA_CS);
-		} else {
+		} else if (!readl(c->chan_base + BCM2835_DMA_ADDR)) {
 			vchan_cookie_complete(&c->desc->vd);
 			bcm2835_dma_start_desc(c);
 		}
@@ -806,11 +814,7 @@ static int bcm2835_dma_terminate_all(str
 	list_del_init(&c->node);
 	spin_unlock(&d->lock);
 
-	/*
-	 * Stop DMA activity: we assume the callback will not be called
-	 * after bcm_dma_abort() returns (even if it does, it will see
-	 * c->desc is NULL and exit.)
-	 */
+	/* stop DMA activity */
 	if (c->desc) {
 		bcm2835_dma_desc_free(&c->desc->vd);
 		c->desc = NULL;
@@ -818,8 +822,7 @@ static int bcm2835_dma_terminate_all(str
 
 		/* Wait for stopping */
 		while (--timeout) {
-			if (!(readl(c->chan_base + BCM2835_DMA_CS) &
-						BCM2835_DMA_ACTIVE))
+			if (!readl(c->chan_base + BCM2835_DMA_ADDR))
 				break;
 
 			cpu_relax();


