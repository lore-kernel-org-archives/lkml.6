Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C19C67838
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2327220661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2327220661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbeLIWGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:06:51 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37130 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726791AbeLIWGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:06:49 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW735-0002ik-C3; Sun, 09 Dec 2018 21:55:39 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72g-0003VV-CU; Sun, 09 Dec 2018 21:55:14 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Mark Brown" <broonie@kernel.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.8330824@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 205/328] spi: rspi: Fix interrupted DMA transfers
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/spi/spi-rspi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -538,11 +538,13 @@ static int rspi_dma_transfer(struct rspi
 
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

