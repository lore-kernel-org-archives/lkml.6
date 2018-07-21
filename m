Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1170ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 14:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9939920858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 14:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9939920858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbeGUPTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 11:19:47 -0400
Received: from www.osadl.org ([62.245.132.105]:47531 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727598AbeGUPTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 11:19:46 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w6LEMttS015000;
        Sat, 21 Jul 2018 16:22:55 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 1/2] mtd: spi-nor: cadence-quadspi: fix timeout handling in wait_for_completion_timeout
Date:   Sat, 21 Jul 2018 16:21:51 +0200
Message-Id: <1532182912-3674-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wait_for_completion_timeout returns unsigned long not int so a variable of
proper type is introduced. Further the check for <= 0 is ambiguous and should
be == 0 here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: ffa639e069fb ("mtd: spi-nor: cadence-quadspi: Add DMA support for direct mode reads")
---

Patch found by experimental coccinelle API conformance checker

Patch was compile tested with: socfpga_defconfig (implies
CONFIG_SPI_CADENCE_QUADSPI=y)

Patch is against 4.18-rc5 (localversion-next is next-20180720)

 drivers/mtd/spi-nor/cadence-quadspi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index d7e10b3..79f6a54 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -953,6 +953,7 @@ static int cqspi_direct_read_execute(struct spi_nor *nor, u_char *buf,
 	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
 	dma_addr_t dma_src = (dma_addr_t)cqspi->mmap_phys_base + from;
 	int ret = 0;
+	unsigned long timeout;
 	struct dma_async_tx_descriptor *tx;
 	dma_cookie_t cookie;
 	dma_addr_t dma_dst;
@@ -988,9 +989,9 @@ static int cqspi_direct_read_execute(struct spi_nor *nor, u_char *buf,
 	}
 
 	dma_async_issue_pending(cqspi->rx_chan);
-	ret = wait_for_completion_timeout(&cqspi->rx_dma_complete,
-					  msecs_to_jiffies(len));
-	if (ret <= 0) {
+	timeout = wait_for_completion_timeout(&cqspi->rx_dma_complete,
+					      msecs_to_jiffies(len));
+	if (timeout == 0) {
 		dmaengine_terminate_sync(cqspi->rx_chan);
 		dev_err(nor->dev, "DMA wait_for_completion_timeout\n");
 		ret = -ETIMEDOUT;
-- 
2.1.4

