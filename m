Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42AEC3279B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C37E24069
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="HYlFQkks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C37E24069
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753211AbeGEClb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 22:41:31 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:43647 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753154AbeGECl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 22:41:29 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w652duZY028145;
        Thu, 5 Jul 2018 11:39:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w652duZY028145
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530758399;
        bh=H9Y4ynGPta8AfBiCIIAsKjioyPf3qY185lk6pn4qKOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HYlFQkksOnYzNWDvz2mlO1g4n2mwDVaiPqjVs4Wiwsmr418N6yXZam1B7pmAfYEiV
         6KLjZnp4fQXvvq2HoVT8WKtTSuqnCCgyshpEtKlidQtUZHul/cpOiiD93fXDftPLnt
         fJhzOW/FsFxGGhEj66n7hmLBJVWuHC6PIHexpTeyX2ukfcct8uGma0YCxweDTd4mCq
         l28bPAXUgkSYR4+4vYEfcGoNIDg1iSamlcXxktOrBuBsd9hO91dY8/dxyKDD8NjnSY
         X7ueo4YBhHvV3z5Ow5x3BfaEA2uNh8gEal0SPWFPPrzZ2HQQI/hqxfhHeWlRY6wtw1
         Pnz1rNIQdhMuw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/12] kconfig: split out helpers to check file/directory, create directory
Date:   Thu,  5 Jul 2018 11:39:39 +0900
Message-Id: <1530758389-30862-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530758389-30862-1-git-send-email-yamada.masahiro@socionext.com>
References: <1530758389-30862-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split out helpers:
 is_file() - check if the given path exists and it is a regular file
 is_dir() - check if the given path exists and it is a directory
 mkdir_p() - create the parent directories of the given path

These helpers will be reused in later commits.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/confdata.c | 85 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 68 insertions(+), 17 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 4771820..881993e 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -16,6 +16,68 @@
 
 #include "lkc.h"
 
+/* return true if 'path' exists and it is a regular file, false otherwise */
+static bool is_file(const char *path)
+{
+	struct stat st;
+
+	if (stat(path, &st))
+		return 0;
+
+	return S_ISREG(st.st_mode);
+}
+
+/* return true if 'path' exists and it is a directory, false otherwise */
+static bool is_dir(const char *path)
+{
+	struct stat st;
+
+	if (stat(path, &st))
+		return 0;
+
+	return S_ISDIR(st.st_mode);
+}
+
+/*
+ * Create the parent directory of the given path.
+ *
+ * For example, if 'include/config/auto.conf' is given, create 'include/config'.
+ * If the path ends with '/' like 'include/config/', create 'include/config'.
+ */
+static int mkdir_p(const char *path)
+{
+	char tmp[PATH_MAX + 1];
+	char *p;
+
+	strncpy(tmp, path, sizeof(tmp));
+	tmp[sizeof(tmp) - 1] = 0;
+
+	/* Remove the base name. Just return if nothing is left */
+	p = strrchr(tmp, '/');
+	if (!p)
+		return 0;
+	*(p + 1) = 0;
+
+	/* Just in case it is an absolute path */
+	p = tmp;
+	while (*p == '/')
+		p++;
+
+	while ((p = strchr(p, '/'))) {
+		*p = 0;
+
+		/* skip if the directory exists */
+		if (!is_dir(tmp) && mkdir(tmp, 0755))
+			return -1;
+
+		*p = '/';
+		while (*p == '/')
+			p++;
+	}
+
+	return 0;
+}
+
 struct conf_printer {
 	void (*print_symbol)(FILE *, struct symbol *, const char *, void *);
 	void (*print_comment)(FILE *, const char *, void *);
@@ -83,7 +145,6 @@ const char *conf_get_autoconfig_name(void)
 
 char *conf_get_default_confname(void)
 {
-	struct stat buf;
 	static char fullname[PATH_MAX+1];
 	char *env, *name;
 
@@ -91,7 +152,7 @@ char *conf_get_default_confname(void)
 	env = getenv(SRCTREE);
 	if (env) {
 		sprintf(fullname, "%s/%s", env, name);
-		if (!stat(fullname, &buf))
+		if (is_file(fullname))
 			return fullname;
 	}
 	return name;
@@ -725,10 +786,9 @@ int conf_write(const char *name)
 
 	dirname[0] = 0;
 	if (name && name[0]) {
-		struct stat st;
 		char *slash;
 
-		if (!stat(name, &st) && S_ISDIR(st.st_mode)) {
+		if (is_dir(name)) {
 			strcpy(dirname, name);
 			strcat(dirname, "/");
 			basename = conf_get_configname();
@@ -848,7 +908,6 @@ static int conf_split_config(void)
 	char path[PATH_MAX+1];
 	char *s, *d, c;
 	struct symbol *sym;
-	struct stat sb;
 	int res, i, fd;
 
 	name = conf_get_autoconfig_name();
@@ -926,18 +985,10 @@ static int conf_split_config(void)
 				res = 1;
 				break;
 			}
-			/*
-			 * Create directory components,
-			 * unless they exist already.
-			 */
-			d = path;
-			while ((d = strchr(d, '/'))) {
-				*d = 0;
-				if (stat(path, &sb) && mkdir(path, 0755)) {
-					res = 1;
-					goto out;
-				}
-				*d++ = '/';
+
+			if (mkdir_p(path)) {
+				res = 1;
+				goto out;
 			}
 			/* Try it again. */
 			fd = open(path, O_WRONLY | O_CREAT | O_TRUNC, 0644);
-- 
2.7.4

