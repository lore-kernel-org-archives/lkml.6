Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA61C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B28121783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216490;
	bh=4stqkj2j/0Rl9oP6ZCWB6uVhGHEVfsFocRqvqhbK9PA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tiX1v7zpAOzrifMRxBOhbMuWw9IaxBBvEt3l86nMR7jVJHuExLGLcoXs3mSgrklA5
	 BKtMHgWMpDX76RWOO6fQv/7le98Ka9srYTeTnZN5A0kZymDTiCWcKu8fOhZJN9J4lF
	 RF+7q7To7yPq03mph9mu/3sZI3nbtYvMztSoNi4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732293AbfAKOTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:19:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:36386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729359AbfAKOTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:19:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96E1421783;
        Fri, 11 Jan 2019 14:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216365;
        bh=4stqkj2j/0Rl9oP6ZCWB6uVhGHEVfsFocRqvqhbK9PA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I6FqHEyGB7BQJ3Rc79I3iAu8Nm49xMw3RKVTZumjRQATZvayUAbbfcmCtUgc4bHHq
         Xzn0bSZNucls+JCl69xuh/CHA+tm4DgUa9fSFJpNLyIepW3CzOsQY3LGXBy+eJPHZo
         DRWsneS49aOHtn2CxC0LgHeZsh1EHyg/JcypM0P0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        Frank Pavlic <f.pavlic@kunbus.de>,
        Martin Sperl <kernel@martin.sperl.org>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.4 46/88] spi: bcm2835: Fix race on DMA termination
Date:   Fri, 11 Jan 2019 15:08:15 +0100
Message-Id: <20190111131052.955380354@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
References: <20190111131045.137499039@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit e82b0b3828451c1cd331d9f304c6078fcd43b62e upstream.

If a DMA transfer finishes orderly right when spi_transfer_one_message()
determines that it has timed out, the callbacks bcm2835_spi_dma_done()
and bcm2835_spi_handle_err() race to call dmaengine_terminate_all(),
potentially leading to double termination.

Prevent by atomically changing the dma_pending flag before calling
dmaengine_terminate_all().

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Fixes: 3ecd37edaa2a ("spi: bcm2835: enable dma modes for transfers meeting certain conditions")
Cc: stable@vger.kernel.org # v4.2+
Cc: Mathias Duckeck <m.duckeck@kunbus.de>
Cc: Frank Pavlic <f.pavlic@kunbus.de>
Cc: Martin Sperl <kernel@martin.sperl.org>
Cc: Noralf Trønnes <noralf@tronnes.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-bcm2835.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -233,10 +233,9 @@ static void bcm2835_spi_dma_done(void *d
 	 * is called the tx-dma must have finished - can't get to this
 	 * situation otherwise...
 	 */
-	dmaengine_terminate_all(master->dma_tx);
-
-	/* mark as no longer pending */
-	bs->dma_pending = 0;
+	if (cmpxchg(&bs->dma_pending, true, false)) {
+		dmaengine_terminate_all(master->dma_tx);
+	}
 
 	/* and mark as completed */;
 	complete(&master->xfer_completion);
@@ -617,10 +616,9 @@ static void bcm2835_spi_handle_err(struc
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
 
 	/* if an error occurred and we have an active dma, then terminate */
-	if (bs->dma_pending) {
+	if (cmpxchg(&bs->dma_pending, true, false)) {
 		dmaengine_terminate_all(master->dma_tx);
 		dmaengine_terminate_all(master->dma_rx);
-		bs->dma_pending = 0;
 	}
 	/* and reset */
 	bcm2835_spi_reset_hw(master);


