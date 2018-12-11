Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EC9C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECD12081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ZF/3yxsw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ECD12081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbeLKLCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:02:07 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:36861 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbeLKLBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:01:50 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wBBB1C5x017210;
        Tue, 11 Dec 2018 20:01:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wBBB1C5x017210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544526089;
        bh=XFpsRQgZt6zvb7DKTN9C3r7E7nhS5P7194SgXasbn1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZF/3yxswEeQ9IdyVhvua72SdlmD73OUFIQJj9jYCgIcEAbe+4w8E2zIU1PYYFZgwt
         mkQTUuCvmoTsaZ4Hf3csIV6UroMQx9+j7Wt6DgBhb0TffRSYaYCKVIuCZeOq3S1mwF
         DIJdeyb6/jcr0Y3ptp/N1/sQIS5vV3HuaCsD34WGjptaShH68O8P0K66DJ71r1m2c4
         pLWAzK5lCAEWCUrF9l/Q+mjzXSvEKuCBu2gt4gxVWyAbgdP6hVYbEInQcViVj6HRfV
         khe1rDJOChbZQt/R0fzlJbyYGQ5rvOJuF6W8V/b1NW9hp8xdPZ1QLwPx6ZvRna1OLy
         jkCQIaJd/e46w==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 22/27] kconfig: ban the use of '.' and '/' in unquoted words
Date:   Tue, 11 Dec 2018 20:01:05 +0900
Message-Id: <1544526070-16690-23-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In my understanding, special characters such as '.' and '/' are
supported in unquoted words to use bare file paths in the source
statement.

With all included file paths quoted in the previous commit, we can
drop this.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/preprocess.c | 3 +--
 scripts/kconfig/zconf.l      | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
index 5ca2df7..b028a48 100644
--- a/scripts/kconfig/preprocess.c
+++ b/scripts/kconfig/preprocess.c
@@ -555,8 +555,7 @@ char *expand_string(const char *in)
 
 static bool is_end_of_token(char c)
 {
-	/* Why are '.' and '/' valid characters for symbols? */
-	return !(isalnum(c) || c == '_' || c == '-' || c == '.' || c == '/');
+	return !(isalnum(c) || c == '_' || c == '-');
 }
 
 /*
diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index defb722..b715af9 100644
--- a/scripts/kconfig/zconf.l
+++ b/scripts/kconfig/zconf.l
@@ -167,7 +167,7 @@ n	[A-Za-z0-9_-]
 		BEGIN(STRING);
 	}
 	\n	BEGIN(INITIAL); return T_EOL;
-	({n}|[/.])+	{
+	{n}+	{
 		const struct kconf_id *id = kconf_id_lookup(yytext, yyleng);
 		if (id && id->flags & TF_PARAM) {
 			yylval.id = id;
@@ -177,7 +177,7 @@ n	[A-Za-z0-9_-]
 		yylval.string = text;
 		return T_WORD;
 	}
-	({n}|[/.$])+	{
+	({n}|$)+	{
 		/* this token includes at least one '$' */
 		yylval.string = expand_token(yytext, yyleng);
 		if (strlen(yylval.string))
-- 
2.7.4

