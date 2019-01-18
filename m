Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69F4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4D62086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="IqUYVyYC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfARFcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 00:32:09 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:51524 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfARFcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 00:32:09 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x0I5Uo9J016515;
        Fri, 18 Jan 2019 14:30:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x0I5Uo9J016515
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547789451;
        bh=g0IEtR2LdGStw2ATPKCXJNsCFAJuQAUZId86SAXzF9Y=;
        h=From:To:Cc:Subject:Date:From;
        b=IqUYVyYCr2u20fWkbOsEFg9rWXO45lPD/7NZ5UyxX3zUB5d6Wr1rX3dhXZm9TsiaO
         8jLl2EttACDLk+qZkF46YSf9gXnrGhgsNovK6ieRKHlNOJajkP8yNKuiKI4rPdcBc5
         G1mLUyJkzyhTn5E+vKr/3+zDm6GRDR0NrN4wfaiAp5lNjIgp+yMl2ZKonhJDDT0Ram
         18s1YQ8TZfLJonk5R1JZEgaZbU+H08gDnbziyr2mISmqQPaguirWfrLIq6RV9XLFqz
         uBTI0uXOrY5eGLUZaOBHvs9r7g+IIMQx2jrm4GNxuS9YQrnVJK6xvLgUYXkJQalSHh
         K2BHRUocjcj9w==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-stable # v4 . 20" <stable@vger.kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: [PATCH] mtd: rawnand: denali: get ->setup_data_interface() working again
Date:   Fri, 18 Jan 2019 14:30:38 +0900
Message-Id: <1547789438-11899-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7a08dbaedd36 ("mtd: rawnand: Move ->setup_data_interface() to
nand_controller_ops") missed to invert the if-conditonal for denali.
Since then, the Denali NAND driver cannnot invoke setup_data_interface.

Fixes: 7a08dbaedd36 ("mtd: rawnand: Move ->setup_data_interface() to nand_controller_ops")
Cc: linux-stable <stable@vger.kernel.org> # v4.20
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mtd/nand/raw/denali.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index eebac35..6e8edc9 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -1322,7 +1322,7 @@ int denali_init(struct denali_nand_info *denali)
 	}
 
 	/* clk rate info is needed for setup_data_interface */
-	if (denali->clk_rate && denali->clk_x_rate)
+	if (!denali->clk_rate || !denali->clk_x_rate)
 		chip->options |= NAND_KEEP_TIMINGS;
 
 	chip->legacy.dummy_controller.ops = &denali_controller_ops;
-- 
2.7.4

