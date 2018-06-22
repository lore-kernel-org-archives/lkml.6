Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBFBC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7D023E00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7D023E00
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751274AbeFVHEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:04:33 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:52286 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbeFVHEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:04:32 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id 1j4S1y00E3XaVaC01j4S3k; Fri, 22 Jun 2018 09:04:31 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fWG7O-0007T8-9o; Fri, 22 Jun 2018 09:04:26 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fWG7O-0006vL-7T; Fri, 22 Jun 2018 09:04:26 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2] mtd: dataflash: Use ULL suffix for 64-bit constants
Date:   Fri, 22 Jun 2018 09:04:25 +0200
Message-Id: <20180622070425.26573-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With gcc 4.1.2 when compiling for 32-bit:

    drivers/mtd/devices/mtd_dataflash.c:736: warning: integer constant is too large for ‘long’ type
    drivers/mtd/devices/mtd_dataflash.c:737: warning: integer constant is too large for ‘long’ type

Add the missing "ULL" suffixes to fix this.

Fixes: 67e4145ebf2c161d ("mtd: dataflash: Add flash_info for AT45DB641E")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
v2:
  - Add Acked-by.
---
 drivers/mtd/devices/mtd_dataflash.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/devices/mtd_dataflash.c b/drivers/mtd/devices/mtd_dataflash.c
index 3a6f450d1093c4c5..53febe8a68c3cdfa 100644
--- a/drivers/mtd/devices/mtd_dataflash.c
+++ b/drivers/mtd/devices/mtd_dataflash.c
@@ -733,8 +733,8 @@ static struct flash_info dataflash_data[] = {
 	{ "AT45DB642x",  0x1f2800, 8192, 1056, 11, SUP_POW2PS},
 	{ "at45db642d",  0x1f2800, 8192, 1024, 10, SUP_POW2PS | IS_POW2PS},
 
-	{ "AT45DB641E",  0x1f28000100, 32768, 264, 9, SUP_EXTID | SUP_POW2PS},
-	{ "at45db641e",  0x1f28000100, 32768, 256, 8, SUP_EXTID | SUP_POW2PS | IS_POW2PS},
+	{ "AT45DB641E",  0x1f28000100ULL, 32768, 264, 9, SUP_EXTID | SUP_POW2PS},
+	{ "at45db641e",  0x1f28000100ULL, 32768, 256, 8, SUP_EXTID | SUP_POW2PS | IS_POW2PS},
 };
 
 static struct flash_info *jedec_lookup(struct spi_device *spi,
-- 
2.17.1

