Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4630C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 15:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5A62086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 15:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfALP3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 10:29:18 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34296 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfALP3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 10:29:09 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x0CFSs2Q026603;
        Sat, 12 Jan 2019 16:28:54 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Silvio Cesare <silvio.cesare@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>
Subject: [PATCH 8/8] spi: dw: change snprintf to scnprintf for possible overflow
Date:   Sat, 12 Jan 2019 16:28:44 +0100
Message-Id: <20190112152844.26550-8-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20190112152844.26550-1-w@1wt.eu>
References: <20190112152844.26550-1-w@1wt.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Silvio Cesare <silvio.cesare@gmail.com>

Change snprintf to scnprintf. There are generally two cases where using
snprintf causes problems.

1) Uses of size += snprintf(buf, SIZE - size, fmt, ...)
In this case, if snprintf would have written more characters than what the
buffer size (SIZE) is, then size will end up larger than SIZE. In later
uses of snprintf, SIZE - size will result in a negative number, leading
to problems. Note that size might already be too large by using
size = snprintf before the code reaches a case of size += snprintf.

2) If size is ultimately used as a length parameter for a copy back to user
space, then it will potentially allow for a buffer overflow and information
disclosure when size is greater than SIZE. When the size is used to index
the buffer directly, we can have memory corruption. This also means when
size = snprintf... is used, it may also cause problems since size may become
large.  Copying to userspace is mitigated by the HARDENED_USERCOPY kernel
configuration.

The solution to these issues is to use scnprintf which returns the number of
characters actually written to the buffer, so the size variable will never
exceed SIZE.

Signed-off-by: Silvio Cesare <silvio.cesare@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>

---
 drivers/spi/spi-dw.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index b705f2bdb8b9..008d52d37439 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -54,41 +54,41 @@ static ssize_t dw_spi_show_regs(struct file *file, char __user *user_buf,
 	if (!buf)
 		return 0;
 
-	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
 			"%s registers:\n", dev_name(&dws->master->dev));
-	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
 			"=================================\n");
-	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
 			"CTRL0: \t\t0x%08x\n", dw_readl(dws, DW_SPI_CTRL0));
-	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
 			"CTRL1: \t\t0x%08x\n", dw_readl(dws, DW_SPI_CTRL1));
-	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
 			"SSIENR: \t0x%08x\n", dw_readl(dws, DW_SPI_SSIENR));
-	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
 			"SER: \t\t0x%08x\n", dw_readl(dws, DW_SPI_SER));
-	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
 			"BAUDR: \t\t0x%08x\n", dw_readl(dws, DW_SPI_BAUDR));
-	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
 			"TXFTLR: \t0x%08x\n", dw_readl(dws, DW_SPI_TXFLTR));
-	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
 			"RXFTLR: \t0x%08x\n", dw_readl(dws, DW_SPI_RXFLTR));
-	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
 			"TXFLR: \t\t0x%08x\n", dw_readl(dws, DW_SPI_TXFLR));
-	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
 			"RXFLR: \t\t0x%08x\n", dw_readl(dws, DW_SPI_RXFLR));
-	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
 			"SR: \t\t0x%08x\n", dw_readl(dws, DW_SPI_SR));
-	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
 			"IMR: \t\t0x%08x\n", dw_readl(dws, DW_SPI_IMR));
-	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
 			"ISR: \t\t0x%08x\n", dw_readl(dws, DW_SPI_ISR));
-	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
 			"DMACR: \t\t0x%08x\n", dw_readl(dws, DW_SPI_DMACR));
-	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
 			"DMATDLR: \t0x%08x\n", dw_readl(dws, DW_SPI_DMATDLR));
-	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
 			"DMARDLR: \t0x%08x\n", dw_readl(dws, DW_SPI_DMARDLR));
-	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
 			"=================================\n");
 
 	ret = simple_read_from_buffer(user_buf, count, ppos, buf, len);
-- 
2.19.2

