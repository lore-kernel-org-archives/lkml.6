Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967BEC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 04:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A42221872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 04:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="IOu+DuXZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfAXEVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 23:21:04 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:63162 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbfAXEVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 23:21:02 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x0O4JI05030691;
        Thu, 24 Jan 2019 13:19:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x0O4JI05030691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548303560;
        bh=w3624K2641LQxTT4qz9JU+SrCJSBx2DTYxNESgK5qvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IOu+DuXZ2M2YrlQcxPyvRQYhAn8T4J4dWoP0+4yAu8y8ttp2KoUKXj5lfJp74IWFW
         3yEcP8YQKDdpDyznxIITlXi3uZiHzt/Icz5Iet5AkvXCByywdh1ycKPUFL2P+rKbMV
         UfJy8vPon/fKFKJKMHmHFvuWHV9JrmZISzkFEEXIVjP9gTl8bicPNDtSCkJzVPcJH3
         MZbbgkVGqr/emiRZqxM2YhkZLCtvBtWWRjG/ITRFKJmmZ4t4c23mMVZ6HeydSTjUYW
         /f+NQHW/2IyoPsZquqHrLVjCbhx0F+tMg6CWf5Svga1be/S6Vqw65fC7jqherSa8RE
         cnAOFjvcfUyWQ==
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
Subject: [PATCH 1/2] mtd: rawnand: denali: remove unneeded denali_reset_irq() call
Date:   Thu, 24 Jan 2019 13:19:06 +0900
Message-Id: <1548303547-21156-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548303547-21156-1-git-send-email-yamada.masahiro@socionext.com>
References: <1548303547-21156-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code was added by commit 26d266e10e5e ("mtd: nand: denali: fix
raw and oob accessors for syndrome page layout"), but I do not see
sensible reason.

The IRQ flags are correctly reset by denali_cmd_ctrl(), so this code
is unneeded.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mtd/nand/raw/denali.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 21320b1..6775644 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -751,9 +751,6 @@ static int denali_read_oob(struct nand_chip *chip, int page)
 static int denali_write_oob(struct nand_chip *chip, int page)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
-	struct denali_nand_info *denali = mtd_to_denali(mtd);
-
-	denali_reset_irq(denali);
 
 	denali_oob_xfer(mtd, chip, page, 1);
 
-- 
2.7.4

