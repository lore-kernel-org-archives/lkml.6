Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A46DC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B98021721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="BoFeItFZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfBGJ7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:59:13 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:33772 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfBGJ7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:59:12 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x179vwEV007618;
        Thu, 7 Feb 2019 18:57:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x179vwEV007618
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549533479;
        bh=iw6uQDkF1w+n1nuxwJnEKZ11rxlAfTizSmtetXPuvzE=;
        h=From:To:Cc:Subject:Date:From;
        b=BoFeItFZaWOYa+ARb66rUQVHzlgBVIkJe69Q1SVtImEfpDPJKKDp2BNu0jEo3Gpq/
         qwch6dfKYrzbw2ZTWMPeQQAFdNpFot13waP4cMHsFz/pueGID3mok/VTMEVGnLgLIb
         IvqF9dYqylY0V4tWjEb6xwzWQFYOl+GxH5kc2FjUHGBfrnJDnTIkxYWrA4TTALbOt3
         FOhPLiY2cOs7L4xK3t7d6xh7e2eUVjCRqEWxLWi7H/XtYWbMXHS4N/1ODxdNAXR47M
         MqlnAc2rwWJo9tsG0M3kai+8Dhv+iXlGalKcHiXG9PiS1IADQs7T+gYrrrkt5ZvtGQ
         z1r2zVPOVCvxw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: [PATCH] mtd: rawnand: call onfi_fill_data_interface() once again after nand_detect
Date:   Thu,  7 Feb 2019 18:57:56 +0900
Message-Id: <1549533476-3742-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nand_scan_ident() calls onfi_fill_data_interface() at its entry
to set up the initial timing parameters.

The timing parameters are needed not only for ->setup_data_interface(),
but also for giving the correct delay to NAND_OP_WAIT_RDY, for example.

If the driver sets the NAND_KEEP_TIMINGS flag, or does not support
->setup_data_interface() hook, those parameters will never updated.

Before nand_detect(), we never know whether the chip is ONFi or not.
So, onfi_fill_data_interface() has to assume the worst case, i.e.
non-ONFi.

After nand_detect(), if the chip turns out to be ONFi-compliant,
we can optimize tPROG_max, tBERS_max, etc.

Call onfi_fill_data_interface() once again.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mtd/nand/raw/nand_base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 9b3d7ff..35e543c 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5040,6 +5040,9 @@ static int nand_scan_ident(struct nand_chip *chip, unsigned int maxchips,
 
 	nand_deselect_target(chip);
 
+	/* If the chip turns out ONFi, we can optimize timing parameters. */
+	onfi_fill_data_interface(chip, NAND_SDR_IFACE, 0);
+
 	/* Check for a chip array */
 	for (i = 1; i < maxchips; i++) {
 		u8 id[2];
-- 
2.7.4

