Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406C5C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 05:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C74F20870
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 05:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfA1FCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 00:02:33 -0500
Received: from mga03.intel.com ([134.134.136.65]:45144 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbfA1FCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 00:02:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2019 21:02:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,532,1539673200"; 
   d="scan'208";a="141880827"
Received: from unknown (HELO dev03.ndswc.sj.intel.com) ([10.233.132.114])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jan 2019 21:02:32 -0800
From:   Purna Chandra Mandal <purna.chandra.mandal@intel.com>
To:     Fred Bloggs <f.blogs@napier.co.nz>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Cc:     Purna Chandra Mandal <purna.chandra.mandal@intel.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH] mtd: spi-nor: cadence-quadspi: write upto 8-bytes data in STIG mode
Date:   Sun, 27 Jan 2019 21:02:29 -0800
Message-Id: <20190128050229.44965-1-purna.chandra.mandal@intel.com>
X-Mailer: git-send-email 2.13.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cadence-quadspi controller allows upto eight bytes of data to
be written in software Triggered Instruction generator (STIG) mode
of operation. Lower 4 bytes are written through writedatalower and
upper 4 bytes by writedataupper register.

This patch allows all the 8 bytes to be written.

Signed-off-by: Purna Chandra Mandal <purna.chandra.mandal@intel.com>
---

 drivers/mtd/spi-nor/cadence-quadspi.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index 04cedd3a2bf6..7f78f9409ddd 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -418,9 +418,10 @@ static int cqspi_command_write(struct spi_nor *nor, const u8 opcode,
 	void __iomem *reg_base = cqspi->iobase;
 	unsigned int reg;
 	unsigned int data;
+	u32 write_len;
 	int ret;
 
-	if (n_tx > 4 || (n_tx && !txbuf)) {
+	if (n_tx > CQSPI_STIG_DATA_LEN_MAX || (n_tx && !txbuf)) {
 		dev_err(nor->dev,
 			"Invalid input argument, cmdlen %d txbuf 0x%p\n",
 			n_tx, txbuf);
@@ -433,10 +434,18 @@ static int cqspi_command_write(struct spi_nor *nor, const u8 opcode,
 		reg |= ((n_tx - 1) & CQSPI_REG_CMDCTRL_WR_BYTES_MASK)
 			<< CQSPI_REG_CMDCTRL_WR_BYTES_LSB;
 		data = 0;
-		memcpy(&data, txbuf, n_tx);
+		write_len = (n_tx > 4) ? 4 : n_tx;
+		memcpy(&data, txbuf, write_len);
+		txbuf += write_len;
 		writel(data, reg_base + CQSPI_REG_CMDWRITEDATALOWER);
-	}
 
+		if (n_tx > 4) {
+			data = 0;
+			write_len = n_tx - 4;
+			memcpy(&data, txbuf, write_len);
+			writel(data, reg_base + CQSPI_REG_CMDWRITEDATAUPPER);
+		}
+	}
 	ret = cqspi_exec_flash_cmd(cqspi, reg);
 	return ret;
 }
-- 
2.13.0

