Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C745C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E2720818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sl8WSQA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E2720818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388151AbeKLITx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:19:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:41934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388124AbeKLITw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:52 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BAF6216FD;
        Sun, 11 Nov 2018 22:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975396;
        bh=ofYGln/1qf8LwA/bx66W7ZrhYPJk+Pb6STQOtpCmd6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sl8WSQA6BcJJL27mIOjBsgQUD8XmUpcBvRwTdMx9a/eOBN/lVzy0B6kXew2p3g1fM
         e40VfmE6dmKAaXKHW8Ig8DbZ+nK1FvE/ktjxoPuCdPf+F8JEkVd8ef2m7/AGoR/biq
         ZJze8eux2NzJeq2ffrhwkgtSArGbJta1V6mEc1B4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 085/350] mtd: rawnand: denali: set SPARE_AREA_SKIP_BYTES register to 8 if unset
Date:   Sun, 11 Nov 2018 14:19:09 -0800
Message-Id: <20181111221710.675812634@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/raw/denali.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -28,6 +28,7 @@
 MODULE_LICENSE("GPL");
 
 #define DENALI_NAND_NAME    "denali-nand"
+#define DENALI_DEFAULT_OOB_SKIP_BYTES	8
 
 /* for Indexed Addressing */
 #define DENALI_INDEXED_CTRL	0x00
@@ -1106,12 +1107,17 @@ static void denali_hw_init(struct denali
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


