Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE55C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1474920664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMq1N/2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1474920664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbeKAIGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:06:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727683AbeKAIGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:06:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E43A72082E;
        Wed, 31 Oct 2018 23:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027166;
        bh=tuEJvDI3bM0wRAyEI8FVDVYwZNrGh0rzXm4cwq5rC7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KMq1N/2qXJm8WpusQ3jRJcW4/LNP2XD0w1WpvresoAkSRZjGVbcnDoVlzuZUMv2U2
         m3DHsHZ+V7J+2nL+PLPx1c52fmp5YPQZXDy8r28UEPTw5HCPXBSnQwZt1L6WH0mAIN
         Ajql6lPjgkbMfKyV6CAkji4xQ/bvStW9T45WW1i8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 026/146] mtd: rawnand: denali: set SPARE_AREA_SKIP_BYTES register to 8 if unset
Date:   Wed, 31 Oct 2018 19:03:41 -0400
Message-Id: <20181031230541.28822-26-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit 0d55c668b218a1db68b5044bce4de74e1bd0f0c8 ]

NAND devices need additional data area (OOB) for error correction,
but it is also used for Bad Block Marker (BBM).  In many cases, the
first byte in OOB is used for BBM, but the location actually depends
on chip vendors.  The NAND controller should preserve the precious
BBM to keep track of bad blocks.

In Denali IP, the SPARE_AREA_SKIP_BYTES register is used to specify
the number of bytes to skip from the start of OOB.  The ECC engine
will automatically skip the specified number of bytes when it gets
access to OOB area.

The same value for SPARE_AREA_SKIP_BYTES should be used between
firmware and the operating system if you intend to use the NAND
device across the control hand-off.

In fact, the current denali.c code expects firmware to have already
set the SPARE_AREA_SKIP_BYTES register, then reads the value out.

If no firmware (or bootloader) has initialized the controller, the
register value is zero, which is the default after power-on-reset.
In other words, the Linux driver cannot initialize the controller
by itself.

Some possible solutions are:

 [1] Add a DT property to specify the skipped bytes in OOB
 [2] Associate the preferred value with compatible
 [3] Hard-code the default value in the driver

My first attempt was [1], but in the review process, [3] was suggested
as a counter-implementation.
(https://lore.kernel.org/patchwork/patch/983055/)

The default value 8 was chosen to match to the boot ROM of the UniPhier
platform.  The preferred value may vary by platform.  If so, please
trade up to a different solution.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/denali.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index b864b93dd289..2242e999a76b 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -28,6 +28,7 @@
 MODULE_LICENSE("GPL");
 
 #define DENALI_NAND_NAME    "denali-nand"
+#define DENALI_DEFAULT_OOB_SKIP_BYTES	8
 
 /* for Indexed Addressing */
 #define DENALI_INDEXED_CTRL	0x00
@@ -1105,12 +1106,17 @@ static void denali_hw_init(struct denali_nand_info *denali)
 		denali->revision = swab16(ioread32(denali->reg + REVISION));
 
 	/*
-	 * tell driver how many bit controller will skip before
-	 * writing ECC code in OOB, this register may be already
-	 * set by firmware. So we read this value out.
-	 * if this value is 0, just let it be.
+	 * Set how many bytes should be skipped before writing data in OOB.
+	 * If a non-zero value has already been set (by firmware or something),
+	 * just use it.  Otherwise, set the driver default.
 	 */
 	denali->oob_skip_bytes = ioread32(denali->reg + SPARE_AREA_SKIP_BYTES);
+	if (!denali->oob_skip_bytes) {
+		denali->oob_skip_bytes = DENALI_DEFAULT_OOB_SKIP_BYTES;
+		iowrite32(denali->oob_skip_bytes,
+			  denali->reg + SPARE_AREA_SKIP_BYTES);
+	}
+
 	denali_detect_max_banks(denali);
 	iowrite32(0x0F, denali->reg + RB_PIN_ENABLED);
 	iowrite32(CHIP_EN_DONT_CARE__FLAG, denali->reg + CHIP_ENABLE_DONT_CARE);
-- 
2.17.1

