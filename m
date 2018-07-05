Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21506C3279B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D2F24069
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="G4p8DHY/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D2F24069
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753295AbeGECrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 22:47:37 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:54678 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753012AbeGECrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 22:47:36 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w652kGfH001144;
        Thu, 5 Jul 2018 11:46:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w652kGfH001144
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530758777;
        bh=fdnpxHKbOELjeXkWRoa6WFaxD+raM8Vq4RmRYOI3p3I=;
        h=From:To:Cc:Subject:Date:From;
        b=G4p8DHY/3PSxcsY7Xbbh+TFcre8CT9u8g7Qu79Nkn9lDL6Xtzm7r6aDLeAuCyyWKg
         UkAyXqVf/lDFQg4uI1Ifvzak4B33HGr8fuZHr5CmrPgIP7l9LVaeJdQwAD5ffgx/Gf
         EnKZ6V/yLCpuIRmMUePdJUr64NdRMusmG47SYB6ZJ6Ist2fZVANZ0UVIisEtsCaszK
         W/LUvZAi5ZnuLtv4TmlUynBd+r4XXaHIcN+INPQCyl6OPoRsUit20jx+DxFDn9p5Ct
         Qzjo400uRvOInRrlhvjpaaxQLOIU8N+g8I1Nnca3wBtGbaOLtdoYXONO5AnYONVvqf
         LS85s5ZzAPaiQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig: handle format string before calling conf_message_callback()
Date:   Thu,  5 Jul 2018 11:46:12 +0900
Message-Id: <1530758772-31832-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As you see in mconf.c and nconf.c, conf_message_callback() hooks are
likely to end up with the boilerplate of vsnprintf().  Process the
string format before calling conf_message_callback() so that it
receives a simple string.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/confdata.c  | 17 +++++++++++------
 scripts/kconfig/lkc_proto.h |  2 +-
 scripts/kconfig/mconf.c     |  9 +++------
 scripts/kconfig/nconf.c     |  7 ++-----
 4 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 5af25a0..d0988a9 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -105,16 +105,16 @@ static void conf_warning(const char *fmt, ...)
 	conf_warnings++;
 }
 
-static void conf_default_message_callback(const char *fmt, va_list ap)
+static void conf_default_message_callback(const char *s)
 {
 	printf("#\n# ");
-	vprintf(fmt, ap);
+	printf("%s", s);
 	printf("\n#\n");
 }
 
-static void (*conf_message_callback) (const char *fmt, va_list ap) =
+static void (*conf_message_callback)(const char *s) =
 	conf_default_message_callback;
-void conf_set_message_callback(void (*fn) (const char *fmt, va_list ap))
+void conf_set_message_callback(void (*fn)(const char *s))
 {
 	conf_message_callback = fn;
 }
@@ -122,10 +122,15 @@ void conf_set_message_callback(void (*fn) (const char *fmt, va_list ap))
 static void conf_message(const char *fmt, ...)
 {
 	va_list ap;
+	char buf[4096];
+
+	if (!conf_message_callback)
+		return;
 
 	va_start(ap, fmt);
-	if (conf_message_callback)
-		conf_message_callback(fmt, ap);
+
+	vsnprintf(buf, sizeof(buf), fmt, ap);
+	conf_message_callback(buf);
 	va_end(ap);
 }
 
diff --git a/scripts/kconfig/lkc_proto.h b/scripts/kconfig/lkc_proto.h
index b0cd52f..86c2675 100644
--- a/scripts/kconfig/lkc_proto.h
+++ b/scripts/kconfig/lkc_proto.h
@@ -10,7 +10,7 @@ int conf_write(const char *name);
 int conf_write_autoconf(int overwrite);
 bool conf_get_changed(void);
 void conf_set_changed_callback(void (*fn)(void));
-void conf_set_message_callback(void (*fn)(const char *fmt, va_list ap));
+void conf_set_message_callback(void (*fn)(const char *s));
 
 /* menu.c */
 extern struct menu rootmenu;
diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index 82b27a0..83b5836 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -772,16 +772,13 @@ static void show_helptext(const char *title, const char *text)
 	show_textbox(title, text, 0, 0);
 }
 
-static void conf_message_callback(const char *fmt, va_list ap)
+static void conf_message_callback(const char *s)
 {
-	char buf[PATH_MAX+1];
-
-	vsnprintf(buf, sizeof(buf), fmt, ap);
 	if (save_and_exit) {
 		if (!silent)
-			printf("%s", buf);
+			printf("%s", s);
 	} else {
-		show_textbox(NULL, buf, 6, 60);
+		show_textbox(NULL, s, 6, 60);
 	}
 }
 
diff --git a/scripts/kconfig/nconf.c b/scripts/kconfig/nconf.c
index 208f7be..1ef232a 100644
--- a/scripts/kconfig/nconf.c
+++ b/scripts/kconfig/nconf.c
@@ -1211,12 +1211,9 @@ static void conf(struct menu *menu)
 	}
 }
 
-static void conf_message_callback(const char *fmt, va_list ap)
+static void conf_message_callback(const char *s)
 {
-	char buf[1024];
-
-	vsnprintf(buf, sizeof(buf), fmt, ap);
-	btn_dialog(main_window, buf, 1, "<OK>");
+	btn_dialog(main_window, s, 1, "<OK>");
 }
 
 static void show_help(struct menu *menu)
-- 
2.7.4

