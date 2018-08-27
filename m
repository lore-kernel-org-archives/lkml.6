Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E76EC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47F321722
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="f0LbQX0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47F321722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbeH0KtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 06:49:03 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:39533 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbeH0KtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 06:49:02 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w7R71vKg007630;
        Mon, 27 Aug 2018 16:01:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w7R71vKg007630
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535353318;
        bh=CsXgelmvnyMTmumHsOs/Hy678CwuZXeCIRKotVgV6pA=;
        h=From:To:Cc:Subject:Date:From;
        b=f0LbQX0biuVPrKHauIbQYVZ8jCvwiAQxReotI1JNN+2QpY5H1soU0p0mF77THJDu1
         mj2/idwqluwZJ4HXp7UadlJTFez8HCuWV1aY9qNEXMTXdcGKb9GIoszQyjOzEIESvm
         bc1DYeFRVjl9NrRbLMov525lq3olGDlBOpKINHtroPq7JRM18vJe/jLWBsM5jgf8xZ
         +3aVeyCIDLmGeb2paUUs+GnQ+zPB5jOeCLiXyUE4uzD2KaAp1T0h0GQw6Y6Sfi2BQP
         X2EPK/s8meDZ0zGVeLpa0/fMXe34oFyeReflMpT4dgqm2bi0G4H2bZZ1ndfLzwE+45
         lwDVOEedpUznQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v2] mtd: rawnand: denali: do not pass zero maxchips to nand_scan()
Date:   Mon, 27 Aug 2018 16:01:41 +0900
Message-Id: <1535353301-1727-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 49aa76b16676 ("mtd: rawnand: do not execute nand_scan_ident()
if maxchips is zero") gave a new meaning for calling nand_scan_ident()
with maxchips=0.

It is a special usage for some drivers such as docg4, but actually
the Denali driver may pass maxchips=0 to nand_scan() when the driver
is enabled but no NAND chip is found on the board for some reasons.

If nand_scan_with_ids() is called with maxchips=0, nand_scan_ident()
is skipped, then nand_set_defaults() is skipped as well.  Thus, the
driver must set chip->controller beforehand.  Otherwise, nand_attach()
causes NULL pointer dereference.

In fact, the Denali controller knows the number of connected chips
before calling nand_scan_ident(); if DEVICE_RESET fails, there is no
chip in that chip select.  Then, denali_reset_banks() sets the maxchips
to the number of detected chips.  If no chip is found, maxchips is zero.

In this case, there is no point for calling nand_scan() because we know
it will fail for sure.  Let's make the probe function fail immediately.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Return -ENODEV immediately if no chip was found on the board
    for some reasons.
    This is the smallest, and safest change for the fixes branch.
    (I will investigate later if further cleanups are possible or not.)

 drivers/mtd/nand/raw/denali.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index ca18612..67b2065 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -1338,6 +1338,11 @@ int denali_init(struct denali_nand_info *denali)
 
 	denali_enable_irq(denali);
 	denali_reset_banks(denali);
+	if (!denali->max_banks) {
+		/* Error out earlier if no chip is found for some reasons. */
+		ret = -ENODEV;
+		goto disable_irq;
+	}
 
 	denali->active_bank = DENALI_INVALID_BANK;
 
-- 
2.7.4

