Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9301C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC81F2152D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC81F2152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbeHUKfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 06:35:06 -0400
Received: from inva020.nxp.com ([92.121.34.13]:37696 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbeHUKfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 06:35:06 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B42341A003C;
        Tue, 21 Aug 2018 09:16:06 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BE1411A0225;
        Tue, 21 Aug 2018 09:16:03 +0200 (CEST)
Received: from mega.am.freescale.net (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B7FC3402B6;
        Tue, 21 Aug 2018 15:15:59 +0800 (SGT)
From:   Chuanhua Han <chuanhua.han@nxp.com>
To:     boris.brezillon@bootlin.com, broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuanhua Han <chuanhua.han@nxp.com>, stable@vger.kernel.org
Subject: [PATCH v4] mtd: spi-mem: Add the default transfer length adjustments
Date:   Tue, 21 Aug 2018 15:15:50 +0800
Message-Id: <1534835750-2251-1-git-send-email-chuanhua.han@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    We need that to adjust the len of the 2nd transfer (called data in spi-mem)
if it's too long to fit in a SPI message or SPI transfer.

Fixes: c36ff266dc82 ("spi: Extend the core to ease integration of SPI memory controllers")
Cc: <stable@vger.kernel.org>

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
---
Changes in v4:
  -Rename variable name "opcode_addr_dummy_sum" to "len".
  -The comparison of "spi_max_message_size(mem->spi)" and "len" was removed.
  -Adjust their order when comparing the sizes of "spi_max_message_size(mem->spi)" and "len".
  -Changing the "unsigned long" type in the code to "size_t".
Changes in v3:
  -Rename variable name "val" to "opcode_addr_dummy_sum".
  -Place the legitimacy of the transfer size(i.e., "spi_max_message_size(mem->spi)" and
  -"opcode_addr_dummy_sum") into "if (! ctlr - > mem_ops | |! ctlr-> mem_ops->exec_op) {"
structure and add "spi_max_transfer_size(mem->spi) and opcode_addr_dummy_sum".
  -Adjust the formatting alignment of the code.
  -"(unsigned long)op->data.nbytes" was modified to "(unsigned long)(op->data.nbytes)".
Changes in v2:
  -Place the adjusted transfer bytes code in spi_mem_adjust_op_size() and  check 
spi_max_message_size(mem->spi) value before subtracting opcode, addr and dummy bytes.
  -Change the code from fsl-espi controller to generic code(The adjustment of spi transmission
length was originally modified in the "drivers/spi/spi-fsl-espi.c" file, and now the adjustment
of transfer length is made in the "drivers/spi/spi-mem.c" file).

 drivers/spi/spi-mem.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 990770d..5374606 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -328,10 +328,23 @@ EXPORT_SYMBOL_GPL(spi_mem_exec_op);
 int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
 	struct spi_controller *ctlr = mem->spi->controller;
+	size_t len = sizeof(op->cmd.opcode) +
+			    op->addr.nbytes +
+			    op->dummy.nbytes;
 
 	if (ctlr->mem_ops && ctlr->mem_ops->adjust_op_size)
 		return ctlr->mem_ops->adjust_op_size(mem, op);
 
+	if (!ctlr->mem_ops || !ctlr->mem_ops->exec_op) {
+		if (len > spi_max_transfer_size(mem->spi))
+			return -EINVAL;
+
+		op->data.nbytes = min3((size_t)(op->data.nbytes),
+				       spi_max_transfer_size(mem->spi),
+				       spi_max_message_size(mem->spi) -
+				       len);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
-- 
2.7.4

