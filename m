Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A24C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158BC21534
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 158BC21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbeHTM6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:58:40 -0400
Received: from inva020.nxp.com ([92.121.34.13]:53602 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbeHTM6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:58:40 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AB06A1A0086;
        Mon, 20 Aug 2018 11:43:44 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id ED3781A008D;
        Mon, 20 Aug 2018 11:43:40 +0200 (CEST)
Received: from mega.am.freescale.net (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E9B50402A3;
        Mon, 20 Aug 2018 17:43:35 +0800 (SGT)
From:   Chuanhua Han <chuanhua.han@nxp.com>
To:     broonie@kernel.org, boris.brezillon@bootlin.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, jiafei.pan@nxp.com, zhiqiang.hou@nxp.com,
        Chuanhua Han <chuanhua.han@nxp.com>
Subject: [PATCH] mtd: m25p80: consider max message size when use the spi_mem_xx() API
Date:   Mon, 20 Aug 2018 17:43:26 +0800
Message-Id: <1534758206-24555-1-git-send-email-chuanhua.han@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
---
Changes in v2:
	- Place the adjusted transfer bytes code in spi_mem_adjust_op_size()
	and  check spi_max_message_size(mem->spi) value before subtracting 
	opcode, addr and dummy bytes.
*fixes:
	spi: Extend the core to ease integration of SPI memory controllers
---
 drivers/spi/spi-mem.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 990770d..f5e75d1 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -328,10 +328,21 @@ EXPORT_SYMBOL_GPL(spi_mem_exec_op);
 int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
 	struct spi_controller *ctlr = mem->spi->controller;
+	unsigned long val =	sizeof(op->cmd.opcode) +
+							  op->addr.nbytes +
+							  op->dummy.nbytes;
 
 	if (ctlr->mem_ops && ctlr->mem_ops->adjust_op_size)
 		return ctlr->mem_ops->adjust_op_size(mem, op);
 
+	if (spi_max_message_size(mem->spi) < val)
+		return -EINVAL;
+
+	if (!ctlr->mem_ops || !ctlr->mem_ops->exec_op)
+		op->data.nbytes = min3((unsigned long)op->data.nbytes,
+				spi_max_transfer_size(mem->spi),
+				spi_max_message_size(mem->spi) - val);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
-- 
2.7.4

