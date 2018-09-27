Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F93AC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03BF20836
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03BF20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbeI0P3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:29:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55378 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbeI0P3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:29:49 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4A1601117;
        Thu, 27 Sep 2018 09:12:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.18 40/88] mtd: devices: m25p80: Make sure the buffer passed in op is DMA-able
Date:   Thu, 27 Sep 2018 11:03:21 +0200
Message-Id: <20180927090305.611960984@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
References: <20180927090300.631426620@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Brezillon <boris.brezillon@bootlin.com>

commit 4a3e85f2674cbfb81052059107d0165269778e2f upstream.

As documented in spi-mem.h, spi_mem_op->data.buf.{in,out} must be
DMA-able, and commit 4120f8d158ef ("mtd: spi-nor: Use the spi_mem_xx()
API") failed to follow this rule as buffers passed to
->{read,write}_reg() are usually placed on the stack.

Fix that by allocating a scratch buffer and copying the data around.

Fixes: 4120f8d158ef ("mtd: spi-nor: Use the spi_mem_xx() API")
Reported-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/devices/m25p80.c |   26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -41,13 +41,23 @@ static int m25p80_read_reg(struct spi_no
 	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(code, 1),
 					  SPI_MEM_OP_NO_ADDR,
 					  SPI_MEM_OP_NO_DUMMY,
-					  SPI_MEM_OP_DATA_IN(len, val, 1));
+					  SPI_MEM_OP_DATA_IN(len, NULL, 1));
+	void *scratchbuf;
 	int ret;
 
+	scratchbuf = kmalloc(len, GFP_KERNEL);
+	if (!scratchbuf)
+		return -ENOMEM;
+
+	op.data.buf.in = scratchbuf;
 	ret = spi_mem_exec_op(flash->spimem, &op);
 	if (ret < 0)
 		dev_err(&flash->spimem->spi->dev, "error %d reading %x\n", ret,
 			code);
+	else
+		memcpy(val, scratchbuf, len);
+
+	kfree(scratchbuf);
 
 	return ret;
 }
@@ -58,9 +68,19 @@ static int m25p80_write_reg(struct spi_n
 	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(opcode, 1),
 					  SPI_MEM_OP_NO_ADDR,
 					  SPI_MEM_OP_NO_DUMMY,
-					  SPI_MEM_OP_DATA_OUT(len, buf, 1));
+					  SPI_MEM_OP_DATA_OUT(len, NULL, 1));
+	void *scratchbuf;
+	int ret;
+
+	scratchbuf = kmemdup(buf, len, GFP_KERNEL);
+	if (!scratchbuf)
+		return -ENOMEM;
 
-	return spi_mem_exec_op(flash->spimem, &op);
+	op.data.buf.out = scratchbuf;
+	ret = spi_mem_exec_op(flash->spimem, &op);
+	kfree(scratchbuf);
+
+	return ret;
 }
 
 static ssize_t m25p80_write(struct spi_nor *nor, loff_t to, size_t len,


