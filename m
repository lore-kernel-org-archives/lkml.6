Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E20ECDFBE
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 21:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5D620850
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 21:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5D620850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387864AbeGVWS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 18:18:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:38804 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387794AbeGVWSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 18:18:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 91399AFD6;
        Sun, 22 Jul 2018 21:20:23 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Ionela Voinescu <ionela.voinescu@imgtec.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH 13/15] spi: img-spfi: RX maximum burst size for DMA is 8
Date:   Sun, 22 Jul 2018 23:20:08 +0200
Message-Id: <20180722212010.3979-14-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180722212010.3979-1-afaerber@suse.de>
References: <20180722212010.3979-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ionela Voinescu <ionela.voinescu@imgtec.com>

The depth of the FIFOs is 16 bytes. The DMA request line is tied
to the half full/empty (depending on the use of the TX or RX FIFO)
threshold. For the TX FIFO, if you set a burst size of 8 (equal to
half the depth) the first burst goes into FIFO without any issues,
but due the latency involved (the time the data leaves  the DMA
engine to the time it arrives at the FIFO), the DMA might trigger
another burst of 8. But given that there is no space for 2 additonal
bursts of 8, this would result in a failure. Therefore, we have to
keep the burst size for TX to 4 to accomodate for an extra burst.

For the read (RX) scenario, the DMA request line goes high when
there is at least 8 entries in the FIFO (half full), and we can
program the burst size to be 8 because the risk of accidental burst
does not exist. The DMA engine will not trigger another read until
the read data for all the burst it has sent out has been received.

While here, move the burst size setting outside of the if/else branches
as they have the same value for both 8 and 32 bit data widths.

Signed-off-by: Ionela Voinescu <ionela.voinescu@imgtec.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/spi/spi-img-spfi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index 231b59c1ab60..8ad6c75d0af5 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -346,12 +346,11 @@ static int img_spfi_start_dma(struct spi_master *master,
 		if (xfer->len % 4 == 0) {
 			rxconf.src_addr = spfi->phys + SPFI_RX_32BIT_VALID_DATA;
 			rxconf.src_addr_width = 4;
-			rxconf.src_maxburst = 4;
 		} else {
 			rxconf.src_addr = spfi->phys + SPFI_RX_8BIT_VALID_DATA;
 			rxconf.src_addr_width = 1;
-			rxconf.src_maxburst = 4;
 		}
+		rxconf.src_maxburst = 8;
 		dmaengine_slave_config(spfi->rx_ch, &rxconf);
 
 		rxdesc = dmaengine_prep_slave_sg(spfi->rx_ch, xfer->rx_sg.sgl,
@@ -370,12 +369,11 @@ static int img_spfi_start_dma(struct spi_master *master,
 		if (xfer->len % 4 == 0) {
 			txconf.dst_addr = spfi->phys + SPFI_TX_32BIT_VALID_DATA;
 			txconf.dst_addr_width = 4;
-			txconf.dst_maxburst = 4;
 		} else {
 			txconf.dst_addr = spfi->phys + SPFI_TX_8BIT_VALID_DATA;
 			txconf.dst_addr_width = 1;
-			txconf.dst_maxburst = 4;
 		}
+		txconf.dst_maxburst = 4;
 		dmaengine_slave_config(spfi->tx_ch, &txconf);
 
 		txdesc = dmaengine_prep_slave_sg(spfi->tx_ch, xfer->tx_sg.sgl,
-- 
2.16.4

