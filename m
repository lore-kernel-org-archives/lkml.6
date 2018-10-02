Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92FAC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777982083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 777982083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732125AbeJBURY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:17:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35136 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732083AbeJBURW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:17:22 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 91307B2F;
        Tue,  2 Oct 2018 13:33:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 092/137] spi: rspi: Fix interrupted DMA transfers
Date:   Tue,  2 Oct 2018 06:24:53 -0700
Message-Id: <20181002132504.948696351@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
References: <20181002132458.446916963@linuxfoundation.org>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 8dbbaa47b96f6ea5f09f922b4effff3c505cd8cf upstream.

When interrupted, wait_event_interruptible_timeout() returns
-ERESTARTSYS, and the SPI transfer in progress will fail, as expected:

    m25p80 spi0.0: SPI transfer failed: -512
    spi_master spi0: failed to transfer one message from queue

However, as the underlying DMA transfers may not have completed, all
subsequent SPI transfers may start to fail:

    spi_master spi0: receive timeout
    qspi_transfer_out_in() returned -110
    m25p80 spi0.0: SPI transfer failed: -110
    spi_master spi0: failed to transfer one message from queue

Fix this by calling dmaengine_terminate_all() not only for timeouts, but
also for errors.

This can be reproduced on r8a7991/koelsch, using "hd /dev/mtd0" followed
by CTRL-C.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-rspi.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -598,11 +598,13 @@ static int rspi_dma_transfer(struct rspi
 
 	ret = wait_event_interruptible_timeout(rspi->wait,
 					       rspi->dma_callbacked, HZ);
-	if (ret > 0 && rspi->dma_callbacked)
+	if (ret > 0 && rspi->dma_callbacked) {
 		ret = 0;
-	else if (!ret) {
-		dev_err(&rspi->master->dev, "DMA timeout\n");
-		ret = -ETIMEDOUT;
+	} else {
+		if (!ret) {
+			dev_err(&rspi->master->dev, "DMA timeout\n");
+			ret = -ETIMEDOUT;
+		}
 		if (tx)
 			dmaengine_terminate_all(rspi->master->dma_tx);
 		if (rx)


