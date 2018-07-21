Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C00ECDFBD
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 14:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68D620863
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 14:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68D620863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbeGUPTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 11:19:47 -0400
Received: from www.osadl.org ([62.245.132.105]:35898 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727745AbeGUPTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 11:19:47 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w6LEMttT015000;
        Sat, 21 Jul 2018 16:23:00 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 2/2] mtd: spi-nor: cadence-quadspi: fix return type to fit wait_for_completion_timeout
Date:   Sat, 21 Jul 2018 16:21:52 +0200
Message-Id: <1532182912-3674-2-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1532182912-3674-1-git-send-email-hofrat@osadl.org>
References: <1532182912-3674-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 wait_for_completion_timeout returns an unsigned long not int. declare a
suitably type timeout and fix up assignment and check.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Found during code review.

Given that CQSPI_READ_TIMEOUT_MS is < INT_MAX the type conversion is safe
here but it is cleaner to use proper types.

Patch was compile tested with: socfpga_defconfig (implies
CONFIG_SPI_CADENCE_QUADSPI=y)

Patch is against 4.18-rc5 (localversion-next is next-20180720)

 drivers/mtd/spi-nor/cadence-quadspi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index d7e10b3..f0c3b0f 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -511,6 +511,7 @@ static int cqspi_indirect_read_execute(struct spi_nor *nor, u8 *rxbuf,
 	unsigned int bytes_to_read = 0;
 	u8 *rxbuf_end = rxbuf + n_rx;
 	int ret = 0;
+	unsigned long timeout;
 
 	writel(from_addr, reg_base + CQSPI_REG_INDIRECTRDSTARTADDR);
 	writel(remaining, reg_base + CQSPI_REG_INDIRECTRDBYTES);
@@ -525,13 +526,13 @@ static int cqspi_indirect_read_execute(struct spi_nor *nor, u8 *rxbuf,
 	       reg_base + CQSPI_REG_INDIRECTRD);
 
 	while (remaining > 0) {
-		ret = wait_for_completion_timeout(&cqspi->transfer_complete,
-						  msecs_to_jiffies
-						  (CQSPI_READ_TIMEOUT_MS));
+		timeout = wait_for_completion_timeout(&cqspi->transfer_complete,
+						      msecs_to_jiffies
+						      (CQSPI_READ_TIMEOUT_MS));
 
 		bytes_to_read = cqspi_get_rd_sram_level(cqspi);
 
-		if (!ret && bytes_to_read == 0) {
+		if (!timeout && bytes_to_read == 0) {
 			dev_err(nor->dev, "Indirect read timeout, no bytes\n");
 			ret = -ETIMEDOUT;
 			goto failrd;
-- 
2.1.4

