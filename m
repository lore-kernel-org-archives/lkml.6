Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D7EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D6F20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Sx8OsZDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D6F20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405163AbeKWSlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 13:41:00 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:55965 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390244AbeKWSk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 13:40:58 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wAN7vWj4021058;
        Fri, 23 Nov 2018 16:57:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wAN7vWj4021058
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542959854;
        bh=lOj4lXrPAtpsd7/ex0Gl8dUQwYFD9eQxYWKByw5NgPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sx8OsZDzhuTgWgFLlXbvFLWcV3pSYAVDEBgxFxVMS2LgCevnloYb2U7QEJwWz9MXv
         L/Upzk2qrX7mgA2zuPgd8nYtNohp9dKye07v8UCbsotgn8nsF4rhzWBACJ3t7qYFu0
         JKNmHslMm6z6BLDHmESXA39h8ghc0ScPdvAs5Fy08/Nm3Yhj21Z3ZTlSSszjCnilq9
         wIOHs8v/BhOxymxjyJ1vgrNHbD7Bsn6E88yv2xvTHGocNDub9TdVI/iRkOeWVcuJ41
         edPVUxRB1yy0LfRixOgxh5H5yxoHqkrPKwhdNJWnWUUtR41vUVUpuoMn/AnPdOZQY0
         1Z17/ydXedUSQ==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Leonardo Bras <leobras.c@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] modpost: move unresolved symbol checks to check_exports()
Date:   Fri, 23 Nov 2018 16:57:23 +0900
Message-Id: <1542959843-16145-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542959843-16145-1-git-send-email-yamada.masahiro@socionext.com>
References: <1542959843-16145-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will fit better in check_exports() than add_versions().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/mod/modpost.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 05e41eb..32e5026 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2085,15 +2085,27 @@ static void check_for_unused(enum export exp, const char *m, const char *s)
 	}
 }
 
-static void check_exports(struct module *mod)
+static int check_exports(struct module *mod)
 {
 	struct symbol *s, *exp;
+	int err = 0;
 
 	for (s = mod->unres; s; s = s->next) {
 		const char *basename;
 		exp = find_symbol(s->name);
-		if (!exp || exp->module == mod)
+		if (!exp || exp->module == mod) {
+			if (have_vmlinux && !s->weak) {
+				if (warn_unresolved) {
+					warn("\"%s\" [%s.ko] undefined!\n",
+					     s->name, mod->name);
+				} else {
+					merror("\"%s\" [%s.ko] undefined!\n",
+					       s->name, mod->name);
+					err = 1;
+				}
+			}
 			continue;
+		}
 		basename = strrchr(mod->name, '/');
 		if (basename)
 			basename++;
@@ -2103,6 +2115,8 @@ static void check_exports(struct module *mod)
 			check_for_gpl_usage(exp->export, basename, exp->name);
 		check_for_unused(exp->export, basename, exp->name);
 	}
+
+	return err;
 }
 
 static int check_modname_len(struct module *mod)
@@ -2180,19 +2194,8 @@ static int add_versions(struct buffer *b, struct module *mod)
 
 	for (s = mod->unres; s; s = s->next) {
 		exp = find_symbol(s->name);
-		if (!exp || exp->module == mod) {
-			if (have_vmlinux && !s->weak) {
-				if (warn_unresolved) {
-					warn("\"%s\" [%s.ko] undefined!\n",
-					     s->name, mod->name);
-				} else {
-					merror("\"%s\" [%s.ko] undefined!\n",
-					       s->name, mod->name);
-					err = 1;
-				}
-			}
+		if (!exp || exp->module == mod)
 			continue;
-		}
 		s->module = exp->module;
 		s->crc_valid = exp->crc_valid;
 		s->crc = exp->crc;
@@ -2495,7 +2498,7 @@ int main(int argc, char **argv)
 		buf.pos = 0;
 
 		err |= check_modname_len(mod);
-		check_exports(mod);
+		err |= check_exports(mod);
 		add_header(&buf, mod);
 		add_intree_flag(&buf, !external_module);
 		add_retpoline(&buf);
-- 
2.7.4

