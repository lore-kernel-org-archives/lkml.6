Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3057C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A45920854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="y5SmZsIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfAVHos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 02:44:48 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:61632 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfAVHor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 02:44:47 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x0M7h55W025355;
        Tue, 22 Jan 2019 16:43:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x0M7h55W025355
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548142988;
        bh=hSF0u/EvB47CoB40nefIbVyNFXS6grvYzPOkYHR2Q+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y5SmZsISzZLplMiSomjH9Yjc2eOX/fPfxjdr1RHgDWnCSgeR/iGTM0Q5hIWq79/Zr
         yyYY688gcSbKs16em+zc8mMhTSX4U8gY1vgHDqOdGP80S0n5iFNteoOhiMr24ks6Ca
         NXrfVdo5yZM7un63VqukLWhq+GNKUSTXd2k4CFDlaIKoenI6ZG+5hNC9ZiAQNVrtgW
         7v3bvb52wzFWiMOXISOwheYHZo63gOqtYM3Quy2AtBppNyLLeg65mE/qJT6Ul4u6tn
         OjasLIE9PR0+B/WFS33c5DmhqeG+xRnjEJfJLdw2m7DbV0pCd4P6eW8puYJyeAsXMi
         KLIrAa7JN6Y5Q==
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
Subject: [PATCH 2/2] mtd: rawnand: use unnamed union in struct nand_op_parser_pattern_elem
Date:   Tue, 22 Jan 2019 16:42:55 +0900
Message-Id: <1548142975-14219-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548142975-14219-1-git-send-email-yamada.masahiro@socionext.com>
References: <1548142975-14219-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although drivers do not directly get access to the private data of
instruction patterns, let's use unnamed union field to be consistent
with nand_op_instr.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mtd/nand/raw/nand_base.c | 12 ++++++------
 include/linux/mtd/rawnand.h      |  8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 3b620cd..d29de69 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -1995,24 +1995,24 @@ nand_op_parser_must_split_instr(const struct nand_op_parser_pattern_elem *pat,
 {
 	switch (pat->type) {
 	case NAND_OP_ADDR_INSTR:
-		if (!pat->ctx.addr.maxcycles)
+		if (!pat->addr.maxcycles)
 			break;
 
 		if (instr->addr.naddrs - *start_offset >
-		    pat->ctx.addr.maxcycles) {
-			*start_offset += pat->ctx.addr.maxcycles;
+		    pat->addr.maxcycles) {
+			*start_offset += pat->addr.maxcycles;
 			return true;
 		}
 		break;
 
 	case NAND_OP_DATA_IN_INSTR:
 	case NAND_OP_DATA_OUT_INSTR:
-		if (!pat->ctx.data.maxlen)
+		if (!pat->data.maxlen)
 			break;
 
 		if (instr->data.len - *start_offset >
-		    pat->ctx.data.maxlen) {
-			*start_offset += pat->ctx.data.maxlen;
+		    pat->data.maxlen) {
+			*start_offset += pat->data.maxlen;
 			return true;
 		}
 		break;
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index b606ed3..7abb605 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -741,7 +741,7 @@ struct nand_op_parser_pattern_elem {
 	union {
 		struct nand_op_parser_addr_constraints addr;
 		struct nand_op_parser_data_constraints data;
-	} ctx;
+	};
 };
 
 #define NAND_OP_PARSER_PAT_CMD_ELEM(_opt)			\
@@ -754,21 +754,21 @@ struct nand_op_parser_pattern_elem {
 	{							\
 		.type = NAND_OP_ADDR_INSTR,			\
 		.optional = _opt,				\
-		.ctx.addr.maxcycles = _maxcycles,		\
+		.addr.maxcycles = _maxcycles,			\
 	}
 
 #define NAND_OP_PARSER_PAT_DATA_IN_ELEM(_opt, _maxlen)		\
 	{							\
 		.type = NAND_OP_DATA_IN_INSTR,			\
 		.optional = _opt,				\
-		.ctx.data.maxlen = _maxlen,			\
+		.data.maxlen = _maxlen,				\
 	}
 
 #define NAND_OP_PARSER_PAT_DATA_OUT_ELEM(_opt, _maxlen)		\
 	{							\
 		.type = NAND_OP_DATA_OUT_INSTR,			\
 		.optional = _opt,				\
-		.ctx.data.maxlen = _maxlen,			\
+		.data.maxlen = _maxlen,				\
 	}
 
 #define NAND_OP_PARSER_PAT_WAITRDY_ELEM(_opt)			\
-- 
2.7.4

