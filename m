Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD20CC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24ED2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="JvHjF6IC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24ED2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbeLKLEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:04:12 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:36637 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeLKLBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:01:41 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wBBB1C5i017210;
        Tue, 11 Dec 2018 20:01:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wBBB1C5i017210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544526078;
        bh=p0w0tcziiu1RUOelBJBhML/iGcu+25dug+WgEnUJYVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JvHjF6ICUbcoEz58vc6whQRxo/YWVfZ++9W/VWLCbG8xTWjif0kR/FmA92Did9lm6
         T0rUuAkhn0vKx5/to80deKlE/F1BcjdrkyFzw//oCYSuakgP0ugN0L1KGR5IHaB4mD
         qQTJt8FVh8mccWCWtrV+7prmWMxYp/Yi1i2Xb0k7DPfA1P4fHzFp+7IZnJR1HYVMi0
         5w+zMiYFk39s52qhirfJ1kFv++9zru1Kpo6rYxPgaeEsKeQL6sClyRBXyd2+bI671w
         3XJTOFDk4Na0w9xkQFOxNl0yi6Kc5KOAL1WldORdFJuGdDM889wyXJzgE1c4Axv6b+
         WR49TcAKds4AQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 07/27] kconfig: clean up EOF handling in the lexer
Date:   Tue, 11 Dec 2018 20:00:50 +0900
Message-Id: <1544526070-16690-8-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new file should always start in the INITIAL state.

When the lexer bumps into EOF, the lexer must get back to the INITIAL
state anyway. Remove the redundant <<EOF>> pattern in the PARAM state.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/zconf.l | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index 847ba42..9038e97 100644
--- a/scripts/kconfig/zconf.l
+++ b/scripts/kconfig/zconf.l
@@ -178,9 +178,6 @@ n	[A-Za-z0-9_-]
 	\\\n	;
 	[[:blank:]]+
 	.	warn_ignored_character(*yytext);
-	<<EOF>> {
-		BEGIN(INITIAL);
-	}
 }
 
 <STRING>{
@@ -262,6 +259,8 @@ n	[A-Za-z0-9_-]
 }
 
 <<EOF>>	{
+	BEGIN(INITIAL);
+
 	if (current_file) {
 		zconf_endfile();
 		return T_EOL;
-- 
2.7.4

