Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035A6ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A736C2150E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A736C2150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389366AbeIUMxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 08:53:46 -0400
Received: from inva021.nxp.com ([92.121.34.21]:33100 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbeIUMxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 08:53:46 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 196CB200247;
        Fri, 21 Sep 2018 09:06:13 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0368B200017;
        Fri, 21 Sep 2018 09:06:10 +0200 (CEST)
Received: from mega.ap.freescale.net (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C1847402DD;
        Fri, 21 Sep 2018 15:06:05 +0800 (SGT)
From:   Chuanhua Han <chuanhua.han@nxp.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        eha@deif.com, boris.brezillon@bootlin.com,
        Chuanhua Han <chuanhua.han@nxp.com>
Subject: [PATCH 1/2] spi: spi-mem: Add the spi_set_xfer_bpw function
Date:   Fri, 21 Sep 2018 15:06:26 +0800
Message-Id: <20180921070628.35153-1-chuanhua.han@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before we add this spi_transfer to the spi_message chain table, we need
bits_per_word_mask based on spi_control to set the bits_per_word of
this spi_transfer.

Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
---
 drivers/spi/spi-mem.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index eb72dba71d83..717e711c0952 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -175,6 +175,41 @@ bool spi_mem_supports_op(struct spi_mem *mem, const struct spi_mem_op *op)
 }
 EXPORT_SYMBOL_GPL(spi_mem_supports_op);
 
+/**
+ * spi_set_xfer_bpw() - Set the bits_per_word for each transfer based on
+ *			the bits_per_word_mask of the spi controller
+ * @ctrl: the spi controller
+ * @xfer: the spi transfer
+ *
+ * This function sets the bits_per_word for each transfer based on the spi
+ * controller's bits_per_word_mask to improve the efficiency of spi transport.
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+int spi_set_xfer_bpw(struct spi_controller *ctlr, struct spi_transfer *xfer)
+{
+	if (!ctlr || !xfer) {
+		dev_err(&ctlr->dev,
+			"Fail to set bits_per_word for spi transfer\n");
+		return -EINVAL;
+	}
+
+	if (ctlr->bits_per_word_mask) {
+		if (!(xfer->len % 4)) {
+			if (ctlr->bits_per_word_mask & SPI_BPW_MASK(32))
+				xfer->bits_per_word = 32;
+		} else if (!(xfer->len % 2)) {
+			if (ctlr->bits_per_word_mask & SPI_BPW_MASK(16))
+				xfer->bits_per_word = 16;
+		} else {
+			xfer->bits_per_word = 8;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_set_xfer_bpw);
+
 /**
  * spi_mem_exec_op() - Execute a memory operation
  * @mem: the SPI memory
@@ -252,6 +287,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	xfers[xferpos].tx_buf = tmpbuf;
 	xfers[xferpos].len = sizeof(op->cmd.opcode);
 	xfers[xferpos].tx_nbits = op->cmd.buswidth;
+	spi_set_xfer_bpw(ctlr, &xfers[xferpos]);
 	spi_message_add_tail(&xfers[xferpos], &msg);
 	xferpos++;
 	totalxferlen++;
@@ -266,6 +302,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		xfers[xferpos].tx_buf = tmpbuf + 1;
 		xfers[xferpos].len = op->addr.nbytes;
 		xfers[xferpos].tx_nbits = op->addr.buswidth;
+		spi_set_xfer_bpw(ctlr, &xfers[xferpos]);
 		spi_message_add_tail(&xfers[xferpos], &msg);
 		xferpos++;
 		totalxferlen += op->addr.nbytes;
@@ -276,6 +313,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		xfers[xferpos].tx_buf = tmpbuf + op->addr.nbytes + 1;
 		xfers[xferpos].len = op->dummy.nbytes;
 		xfers[xferpos].tx_nbits = op->dummy.buswidth;
+		spi_set_xfer_bpw(ctlr, &xfers[xferpos]);
 		spi_message_add_tail(&xfers[xferpos], &msg);
 		xferpos++;
 		totalxferlen += op->dummy.nbytes;
@@ -291,6 +329,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		}
 
 		xfers[xferpos].len = op->data.nbytes;
+		spi_set_xfer_bpw(ctlr, &xfers[xferpos]);
 		spi_message_add_tail(&xfers[xferpos], &msg);
 		xferpos++;
 		totalxferlen += op->data.nbytes;
-- 
2.17.1

