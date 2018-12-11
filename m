Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A854CC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC082082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="FGgwOUfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC082082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbeLKLBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:01:51 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:36706 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbeLKLBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:01:44 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wBBB1C5u017210;
        Tue, 11 Dec 2018 20:01:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wBBB1C5u017210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544526086;
        bh=uqOZ9vU8oru+M9Os9BjewQ7I6t7aJJ1laipYhaaZlRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FGgwOUfpfex79hXVFIznqJ03YWykn1b5Ie9Yi7W13S0/MfuZ1/YHOzE/Wbxe+HDzM
         9Ep+/KcvTASYBlSVrBC8ckfZ4v+uMExEEDPvsbXMPJ53WTzdz0YRTanuw/G5uSnW7z
         sqIwAPsAtm/FM6cfiVDhTiqG7i4wLujFQqWP52UTw5+tXT3jjxqDlZ3eW+DEkfv3iN
         8gDRC/GMz2uOf/epdif4n72wXaub6rL5YnXHuuDPWhYWxuoFTzORk+6ZpFv+UNu9jv
         eqcbEtq9LdTVUI6ak537rINB8ySXaI7QGjQW2U4tfPyU0wcrlKu0LR1pUsNHWeSXck
         r7fYiUownkBAA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 19/27] kconfig: use T_WORD instead of T_VARIABLE for variables
Date:   Tue, 11 Dec 2018 20:01:02 +0900
Message-Id: <1544526070-16690-20-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no grammatical ambiguity by using T_WORD for variables.
The parser can distinguish variables from symbols from the context.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/zconf.l | 4 ++--
 scripts/kconfig/zconf.y | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index 981b5f8..defb722 100644
--- a/scripts/kconfig/zconf.l
+++ b/scripts/kconfig/zconf.l
@@ -116,13 +116,13 @@ n	[A-Za-z0-9_-]
 		}
 		alloc_string(yytext, yyleng);
 		yylval.string = text;
-		return T_VARIABLE;
+		return T_WORD;
 	}
 	({n}|$)+	{
 		/* this token includes at least one '$' */
 		yylval.string = expand_token(yytext, yyleng);
 		if (strlen(yylval.string))
-			return T_VARIABLE;
+			return T_WORD;
 		free(yylval.string);
 	}
 	"="	{ BEGIN(ASSIGN_VAL); return T_EQUAL; }
diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index 97f86e2..3c44d67 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -84,7 +84,6 @@ static struct menu *current_menu, *current_entry;
 %token T_STRING
 %token T_TRISTATE
 %token T_EOL
-%token <string> T_VARIABLE
 %token <string> T_ASSIGN_VAL
 
 %left T_OR
@@ -480,7 +479,7 @@ word_opt: /* empty */			{ $$ = NULL; }
 
 /* assignment statement */
 
-assignment_stmt:  T_VARIABLE assign_op assign_val T_EOL	{ variable_add($1, $3, $2); free($1); free($3); }
+assignment_stmt:  T_WORD assign_op assign_val T_EOL	{ variable_add($1, $3, $2); free($1); free($3); }
 
 assign_op:
 	  T_EQUAL	{ $$ = VAR_RECURSIVE; }
-- 
2.7.4

