Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E15C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 14:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68E32087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 14:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68E32087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389800AbeKQAf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 19:35:58 -0500
Received: from mga04.intel.com ([192.55.52.120]:4865 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727999AbeKQAf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 19:35:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2018 06:23:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,240,1539673200"; 
   d="scan'208";a="280539912"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by fmsmga005.fm.intel.com with ESMTP; 16 Nov 2018 06:23:22 -0800
From:   thor.thayer@linux.intel.com
To:     marek.vasut@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        richard@nod.at
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCHv2] mtd: spi-nor: Fix Cadence QSPI page fault kernel panic
Date:   Fri, 16 Nov 2018 08:25:49 -0600
Message-Id: <1542378349-29929-1-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

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
---
v2 Remove min() function as suggested by community
---
 drivers/mtd/spi-nor/cadence-quadspi.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index d846428ef038..04cedd3a2bf6 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -644,9 +644,23 @@ static int cqspi_indirect_write_execute(struct spi_nor *nor, loff_t to_addr,
 		ndelay(cqspi->wr_delay);
 
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
 
 		if (!wait_for_completion_timeout(&cqspi->transfer_complete,
 					msecs_to_jiffies(CQSPI_TIMEOUT_MS))) {
@@ -655,7 +669,6 @@ static int cqspi_indirect_write_execute(struct spi_nor *nor, loff_t to_addr,
 			goto failwr;
 		}
 
-		txbuf += write_bytes;
 		remaining -= write_bytes;
 
 		if (remaining > 0)
-- 
2.7.4

