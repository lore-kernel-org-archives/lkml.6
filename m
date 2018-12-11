Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F39CC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3655F2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="vtQymvHw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3655F2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbeLKLBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:01:43 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:36638 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbeLKLBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:01:42 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wBBB1C5g017210;
        Tue, 11 Dec 2018 20:01:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wBBB1C5g017210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544526077;
        bh=BD7gkp9jc0123daEs5SstZ3+OOaAroiN8LQ5Qi2IAvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vtQymvHw5414mFzvRj4NBDaSSaiZJNO7bEecnyK3MbfpDeYHkNJNVE01rTLfLs8q+
         ea0MP3E/3j51FfqurmdvhFbO7kxQy8daYTbOcw0IV2OkbVHLXRJm1n3Gic1LzS0UON
         EJygDGqoNfO8IXY1Xx6w8RJtqIt0iW1WPK4cPZEGiROo2YTKPZev3vK/LrpVa76qfk
         608AqTbSqicDriywfFqdwjvkJvTpJKczGK6gWUyBpvG0KPEOM9JJsL8vSLQZ7oeDLD
         gIEOW1lSfqOqZCc3amFXoFno6Yg/4WGwHnoO+R8JvO/An2LT7e3ktJPTTp7n7BRdXk
         fzcH/5b7X9yRg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 05/27] kconfig: refactor pattern matching in STRING state
Date:   Tue, 11 Dec 2018 20:00:48 +0900
Message-Id: <1544526070-16690-6-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here, similar matching patters are duplicated in order to look ahead
the '\n' character. If the next character is '\n', the lexer returns
T_WORD_QUOTE because it must be prepared to return T_EOL at the next
match.

Use unput('\n') trick to reduce the code duplication.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/zconf.l | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index 709b774..b7bc164 100644
--- a/scripts/kconfig/zconf.l
+++ b/scripts/kconfig/zconf.l
@@ -182,19 +182,9 @@ n	[A-Za-z0-9_-]
 
 <STRING>{
 	"$".*	append_expanded_string(yytext);
-	[^$'"\\\n]+/\n	{
-		append_string(yytext, yyleng);
-		yylval.string = text;
-		return T_WORD_QUOTE;
-	}
 	[^$'"\\\n]+	{
 		append_string(yytext, yyleng);
 	}
-	\\.?/\n	{
-		append_string(yytext + 1, yyleng - 1);
-		yylval.string = text;
-		return T_WORD_QUOTE;
-	}
 	\\.?	{
 		append_string(yytext + 1, yyleng - 1);
 	}
@@ -210,8 +200,10 @@ n	[A-Za-z0-9_-]
 		fprintf(stderr,
 			"%s:%d:warning: multi-line strings not supported\n",
 			zconf_curname(), zconf_lineno());
+		unput('\n');
 		BEGIN(INITIAL);
-		return T_EOL;
+		yylval.string = text;
+		return T_WORD_QUOTE;
 	}
 	<<EOF>>	{
 		BEGIN(INITIAL);
-- 
2.7.4

