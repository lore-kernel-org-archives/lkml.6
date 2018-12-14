Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D86C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 02:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7612080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 02:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7612080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbeLNCP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 21:15:27 -0500
Received: from mga12.intel.com ([192.55.52.136]:22645 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727901AbeLNCP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 21:15:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2018 18:15:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,351,1539673200"; 
   d="scan'208";a="118451011"
Received: from unknown (HELO dev03.ndswc.sj.intel.com) ([10.233.132.114])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Dec 2018 18:15:26 -0800
From:   Purna Chandra Mandal <purna.chandra.mandal@intel.com>
To:     Fred Bloggs <f.blogs@napier.co.nz>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Purna Chandra Mandal <purna.chandra.mandal@intel.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH] mtd: spi-nor: cadence-quadspi: write upto 8-bytes data in STIG mode
Date:   Thu, 13 Dec 2018 18:15:16 -0800
Message-Id: <20181214021516.43609-1-purna.chandra.mandal@intel.com>
X-Mailer: git-send-email 2.13.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cadence-quadspi controller allows upto eight bytes of data to be transferred
in software Triggered Instruction generator (STIG) mode of operation. Lower
4 bytes are written through writedatalower and upper 4 bytes by
writedataupper register.

This patch allows all the 8 bytes to be written.

Signed-off-by: Purna Chandra Mandal <purna.chandra.mandal@intel.com>
---

 drivers/mtd/spi-nor/cadence-quadspi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index 04cedd3a2bf6..990934387fea 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -420,7 +420,7 @@ static int cqspi_command_write(struct spi_nor *nor, const u8 opcode,
 	unsigned int data;
 	int ret;
 
-	if (n_tx > 4 || (n_tx && !txbuf)) {
+	if (n_tx > CQSPI_STIG_DATA_LEN_MAX || (n_tx && !txbuf)) {
 		dev_err(nor->dev,
 			"Invalid input argument, cmdlen %d txbuf 0x%p\n",
 			n_tx, txbuf);
@@ -435,8 +435,13 @@ static int cqspi_command_write(struct spi_nor *nor, const u8 opcode,
 		data = 0;
 		memcpy(&data, txbuf, n_tx);
 		writel(data, reg_base + CQSPI_REG_CMDWRITEDATALOWER);
-	}
 
+		if (n_tx > 4) {
+			data = 0;
+			memcpy(&data, txbuf + 4, n_tx - 4);
+			writel(data, reg_base + CQSPI_REG_CMDWRITEDATAUPPER);
+		}
+	}
 	ret = cqspi_exec_flash_cmd(cqspi, reg);
 	return ret;
 }
-- 
2.13.0

