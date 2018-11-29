Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAD3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4AED2146F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSdqYtIX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4AED2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbeK2RGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:06:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:43448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728676AbeK2RGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:06:47 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 087842146D;
        Thu, 29 Nov 2018 06:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471355;
        bh=DNTpOWcAzpZp6ip2GksZjwoRrXZbwD+fBa7w1pq8f5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pSdqYtIXT47qt/VGkgi3nPylILqAgtSIse3opST469JcPjVeh3n5TvmT+0E9tNC80
         GpnsBgYZZhoKiK7aiMZSzzJDSGHs9WeKIvIvAFLxDoq+NAreDFViToSYr8AtXRIpcT
         OPgsH/fXlIjSUNUm+tVVjo40G3eHiucKabD/QGjk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thor Thayer <thor.thayer@linux.intel.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-mtd@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 22/35] mtd: spi-nor: Fix Cadence QSPI page fault kernel panic
Date:   Thu, 29 Nov 2018 01:00:56 -0500
Message-Id: <20181129060110.159878-22-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129060110.159878-1-sashal@kernel.org>
References: <20181129060110.159878-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

[ Upstream commit a6a66f80c85e8e20573ca03fabf32445954a88d5 ]

The current Cadence QSPI driver caused a kernel panic sporadically
when writing to QSPI. The problem was caused by writing more bytes
than needed because the QSPI operated on 4 bytes at a time.
<snip>
[   11.202044] Unable to handle kernel paging request at virtual address bffd3000
[   11.209254] pgd = e463054d
[   11.211948] [bffd3000] *pgd=2fffb811, *pte=00000000, *ppte=00000000
[   11.218202] Internal error: Oops: 7 [#1] SMP ARM
[   11.222797] Modules linked in:
[   11.225844] CPU: 1 PID: 1317 Comm: systemd-hwdb Not tainted 4.17.7-d0c45cd44a8f
[   11.235796] Hardware name: Altera SOCFPGA Arria10
[   11.240487] PC is at __raw_writesl+0x70/0xd4
[   11.244741] LR is at cqspi_write+0x1a0/0x2cc
</snip>
On a page boundary limit the number of bytes copied from the tx buffer
to remain within the page.

This patch uses a temporary buffer to hold the 4 bytes to write and then
copies only the bytes required from the tx buffer.

Reported-by: Adrian Amborzewicz <adrian.ambrozewicz@intel.com>
Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/spi-nor/cadence-quadspi.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index 8d89204b90d2..f22dd34f4f83 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -625,9 +625,23 @@ static int cqspi_indirect_write_execute(struct spi_nor *nor,
 	       reg_base + CQSPI_REG_INDIRECTWR);
 
 	while (remaining > 0) {
+		size_t write_words, mod_bytes;
+
 		write_bytes = remaining > page_size ? page_size : remaining;
-		iowrite32_rep(cqspi->ahb_base, txbuf,
-			      DIV_ROUND_UP(write_bytes, 4));
+		write_words = write_bytes / 4;
+		mod_bytes = write_bytes % 4;
+		/* Write 4 bytes at a time then single bytes. */
+		if (write_words) {
+			iowrite32_rep(cqspi->ahb_base, txbuf, write_words);
+			txbuf += (write_words * 4);
+		}
+		if (mod_bytes) {
+			unsigned int temp = 0xFFFFFFFF;
+
+			memcpy(&temp, txbuf, mod_bytes);
+			iowrite32(temp, cqspi->ahb_base);
+			txbuf += mod_bytes;
+		}
 
 		ret = wait_for_completion_timeout(&cqspi->transfer_complete,
 						  msecs_to_jiffies
@@ -638,7 +652,6 @@ static int cqspi_indirect_write_execute(struct spi_nor *nor,
 			goto failwr;
 		}
 
-		txbuf += write_bytes;
 		remaining -= write_bytes;
 
 		if (remaining > 0)
-- 
2.17.1

