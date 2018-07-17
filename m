Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16827ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF74520C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF74520C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731714AbeGQOQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:16:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40841 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731497AbeGQOQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:16:11 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9088A2091A; Tue, 17 Jul 2018 15:43:26 +0200 (CEST)
Received: from mc-bl-xps13.lan (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id 58498206ED;
        Tue, 17 Jul 2018 15:43:16 +0200 (CEST)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com
Subject: [PATCH 0/5] spi: imx: Improve non 8-bit aligned words and dynamic bursts
Date:   Tue, 17 Jul 2018 15:43:06 +0200
Message-Id: <20180717134311.26780-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series aims to improve PIO transfers on the SPI imx driver for several
use-cases, where bits_per_words isn't a multiple of 8, or when using
dynamic_burst mode.

The first patch is just a cosmetic cleanup of extra variable assignments

The second patch enforces the use of the dynamic_burst mode only when we
can pack words into the 32 bits FIFO entries. This avoid having to mask out the
remaining parts of the words, and avoid shifting extra clock ticks.

The 3rd and 4th patches fixes the way we compute the number of bytes per words,
by using 4 bytes to transfer 24 bits words as expected by the core.

Finally, the 4th patch reworks the way dynamic bursts are emitted, by shifting
out the non 4-bytes aligned parts first as expected by the imx SPI controller.

This avoid splitting out transfer when not necessary.

This was tested on imx6s and imx6q, with and without DMA, in single and full
duplex with a wide range of transfer sizes and bit_per_words values.

I however couldn't test the slave mode with these patches, so some review is
very welcomed, especially on the last patch.

Thanks,

Maxime

Maxime Chevallier (5):
  spi: imx: Remove duplicate variable assignments
  spi: imx: Use dynamic bursts only when bits_per_word is 8, 16 or 32
  spi: imx: Use correct number of bytes per words
  spi: imx: remove unnecessary check in spi_imx_can_dma
  spi: imx: Use the longuest possible burst size when in dynamic_burst

 drivers/spi/spi-imx.c | 162 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 101 insertions(+), 61 deletions(-)

-- 
2.11.0

