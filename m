Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFA7ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 16:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E16620854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 16:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E16620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeGURGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 13:06:23 -0400
Received: from www.osadl.org ([62.245.132.105]:49595 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727737AbeGURGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 13:06:22 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w6LG9H8Z031732;
        Sat, 21 Jul 2018 18:09:17 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Graham Moore <grmoore@opensource.altera.com>
Cc:     Vignesh R <vigneshr@ti.com>, Marek Vasut <marek.vasut@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] mtd: spi-nor: cadence-quadspi: make return type fit wait_for_completion_timeout
Date:   Sat, 21 Jul 2018 18:08:13 +0200
Message-Id: <1532189293-5975-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wait_for_completion_timeout returns an unsigned long not int. declare a
suitably type timeout and fix up assignment and check.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Reported-by: Vignesh R <vigneshr@ti.com>
Fixes: 140623410536 ("mtd: spi-nor: Add driver for Cadence Quad SPI Flash Controller")
---

Given that CQSPI_TIMEOUT_MS is < INT_MAX the type conversion is actually safe
here but it is cleaner to use proper types.

Patch was compile tested with: socfpga_defconfig (implies
CONFIG_SPI_CADENCE_QUADSPI=y)

Patch is against 4.18-rc5 (localversion-next is next-20180720)

 drivers/mtd/spi-nor/cadence-quadspi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index d7e10b3..ce5f840 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -622,6 +622,7 @@ static int cqspi_indirect_write_execute(struct spi_nor *nor, loff_t to_addr,
 	unsigned int remaining = n_tx;
 	unsigned int write_bytes;
 	int ret;
+	unsigned long timeout;
 
 	writel(to_addr, reg_base + CQSPI_REG_INDIRECTWRSTARTADDR);
 	writel(remaining, reg_base + CQSPI_REG_INDIRECTWRBYTES);
@@ -649,10 +650,10 @@ static int cqspi_indirect_write_execute(struct spi_nor *nor, loff_t to_addr,
 		iowrite32_rep(cqspi->ahb_base, txbuf,
 			      DIV_ROUND_UP(write_bytes, 4));
 
-		ret = wait_for_completion_timeout(&cqspi->transfer_complete,
-						  msecs_to_jiffies
-						  (CQSPI_TIMEOUT_MS));
-		if (!ret) {
+		timeout = wait_for_completion_timeout(&cqspi->transfer_complete,
+						      msecs_to_jiffies
+						      (CQSPI_TIMEOUT_MS));
+		if (!timeout) {
 			dev_err(nor->dev, "Indirect write timeout\n");
 			ret = -ETIMEDOUT;
 			goto failwr;
-- 
2.1.4

