Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A92FC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6DC2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="aw/RnSCy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6DC2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbeLKLCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:02:25 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:36854 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbeLKLBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:01:48 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wBBB1C62017210;
        Tue, 11 Dec 2018 20:01:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wBBB1C62017210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544526091;
        bh=6Lvtg2dB6yAFCoRPqr59hv7P+Ii7lc6zWyJld8N69xA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aw/RnSCyPCDBoQLgHMgFn4RzvL+v3J93fGMiglKTHAW42E71T8ru8RRRWQHU1x0oE
         yFSBBbLw7TfUM+4rjrb1PXKR8e7LBC3LyeZGxEQNMKxhUiHrjDTSrSW8CnGOjT+BPe
         kYMFohGGSZmXG8gGAAYGm2pBgDhw5pCRmr9BWuoO7VhhyVVRPqSo/SoxnTCy/NpQxV
         RU0wZ1uBEAFUn9BIN0nIWfDjGIPvByFxJVVzhE7xRbDEGDfICqBQ2za0kEOZ1ZqAQn
         INjifWIrVhI02JQpXivFjSSrcEBeA8wVCn1vDv1aRcL94X62Elu57aDSJ00V5O7wdQ
         Mpoe3EpIO+a9w==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 25/27] kconfig: switch to ASSIGN_VAL state in the second lexer
Date:   Tue, 11 Dec 2018 20:01:08 +0900
Message-Id: <1544526070-16690-26-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To simplify the generated lexer, switch to the ASSIGN_VAL state in
the hand-made lexer.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/zconf.l | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index c8823a4..d462507 100644
--- a/scripts/kconfig/zconf.l
+++ b/scripts/kconfig/zconf.l
@@ -25,6 +25,7 @@ static struct {
 	int lineno;
 } current_pos;
 
+static int prev_prev_token = T_EOL;
 static int prev_token = T_EOL;
 static char *text;
 static int text_size, text_asize;
@@ -124,9 +125,9 @@ n	[A-Za-z0-9_-]
 			return T_WORD;
 		free(yylval.string);
 	}
-	"="	{ BEGIN(ASSIGN_VAL); return T_EQUAL; }
-	":="	{ BEGIN(ASSIGN_VAL); return T_COLON_EQUAL; }
-	"+="	{ BEGIN(ASSIGN_VAL); return T_PLUS_EQUAL; }
+	"="	return T_EQUAL;
+	":="	return T_COLON_EQUAL;
+	"+="	return T_PLUS_EQUAL;
 	[[:blank:]]+
 	.	warn_ignored_character(*yytext);
 	\n	{
@@ -294,6 +295,11 @@ repeat:
 	if ((prev_token == T_EOL || prev_token == T_HELPTEXT) && token == T_EOL)
 		goto repeat;
 
+	if (prev_prev_token == T_EOL && prev_token == T_WORD &&
+	    (token == T_EQUAL || token == T_COLON_EQUAL || token == T_PLUS_EQUAL))
+		BEGIN(ASSIGN_VAL);
+
+	prev_prev_token = prev_token;
 	prev_token = token;
 
 	return token;
-- 
2.7.4

