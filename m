Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C505C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32EE72081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="FUBA9gOB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32EE72081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbeLKLC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:02:27 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:36853 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbeLKLBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:01:48 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wBBB1C63017210;
        Tue, 11 Dec 2018 20:01:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wBBB1C63017210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544526092;
        bh=H7uIjhRZd78YuhKatcgyhcv31egGnNdh5y9Y0vrPiac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FUBA9gOBQNlZQC+gbVwyI/JVuq2QwxVbg4+BTaUgI5eWsBKric0VcEtND1MKaxGVw
         p4VUq9iVDrh9e9GUD5YxVvLxjqiU/C8yabrIFv/az7eJ3Q3oGtaBW2C+aoo8BNPZLQ
         afdAVOtDI55NTh4DgADa+xvm/DXTZMepBthKzxhvrG2p1OtIx5bu3ls8MsFLH6Q+kI
         0v9x1LWWZPW27rl6UN2HA+zdPHx06iUVAlJpZghLoM6Gku/RID9Mzc4I/ajSdrp0Bl
         d3V8kmZI5BDHqH6/CWFCUrYJ0bYWQGrooxHgPfntnPSs9IE6PMfx69weLiiyIvkQ2N
         8Zmaa7A+0sVwg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 26/27] kconfig: update current_pos in the second lexer
Date:   Tue, 11 Dec 2018 20:01:09 +0900
Message-Id: <1544526070-16690-27-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To simplify the generated lexer, let the hand-made lexer update the
file name and line number for the parser.

I tested this with DEBUG_PARSE, and confirmed the same file names
and line numbers were dumped.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/zconf.l | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index d462507..f0734abe 100644
--- a/scripts/kconfig/zconf.l
+++ b/scripts/kconfig/zconf.l
@@ -108,8 +108,6 @@ n	[A-Za-z0-9_-]
 <COMMAND>{
 	{n}+	{
 		const struct kconf_id *id = kconf_id_lookup(yytext, yyleng);
-		current_pos.file = current_file;
-		current_pos.lineno = yylineno;
 		if (id && id->flags & TF_COMMAND) {
 			BEGIN(PARAM);
 			return id->token;
@@ -291,9 +289,21 @@ int yylex(void)
 repeat:
 	token = yylex1();
 
-	/* Do not pass unneeded T_EOL to the parser. */
-	if ((prev_token == T_EOL || prev_token == T_HELPTEXT) && token == T_EOL)
-		goto repeat;
+	if (prev_token == T_EOL || prev_token == T_HELPTEXT) {
+		if (token == T_EOL) {
+			/* Do not pass unneeded T_EOL to the parser. */
+			goto repeat;
+		} else {
+			/*
+			 * For the parser, update file/lineno at the first token
+			 * of each statement. Generally, \n is a statement
+			 * terminator in Kconfig, but it is not always true
+			 * because \n could be escaped by a backslash.
+			 */
+			current_pos.file = current_file;
+			current_pos.lineno = yylineno;
+		}
+	}
 
 	if (prev_prev_token == T_EOL && prev_token == T_WORD &&
 	    (token == T_EQUAL || token == T_COLON_EQUAL || token == T_PLUS_EQUAL))
-- 
2.7.4

