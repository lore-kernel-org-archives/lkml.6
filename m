Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0052C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9375C2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0lPI4l5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9375C2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbeK3UZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:25:59 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:53048 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeK3UZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:25:53 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wAU9GEac028692;
        Fri, 30 Nov 2018 18:16:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wAU9GEac028692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543569376;
        bh=HiMqj/ME+AaGau+DxV454Be5fNhnAhoE/t6iCz3z6jg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0lPI4l5QGeZ4FmFhB/3a9h8BVW7oBdM/qSU9p6YwNGzHP9nRB0gfgHj4pYmH1yGWG
         LYkh7Cdo4wdnem8m11bWar/IW3pOibroI/ohq/5zaDRUdMNA1Yno7CTlHfcgpIJ8O6
         KpBuc3YgtCTBHzujQm5/l2RK67n2I7l/afD+pig7sHvZ6iOYZ1f3rTNJfQb5qUfD2o
         HaivYoNgvbqvyMDdLJlyMizYgephTbiAdrP8Cia/Z9H2CZm9EhVcjoONNpyn0MCrjl
         D65NB86DUMrUMmuk8psBlyhvHN7XST8u+mdfsArGImSb1Fl3IrtjexDxmqeJHnPm+s
         OppF+2kH0PB7g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] kconfig: split out code touching a file to conf_touch_dep()
Date:   Fri, 30 Nov 2018 18:15:50 +0900
Message-Id: <1543569352-4899-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543569352-4899-1-git-send-email-yamada.masahiro@socionext.com>
References: <1543569352-4899-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

conf_touch_deps() iterates over symbols, touching corresponding
include/config/*.h files as needed.

Split the part that touches a single file into a new helper so it can
be reused.

The new helper, conf_touch_dep(), takes a symbol name as a parameter,
and touches the corresponding include/config/*.h file.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/confdata.c | 92 ++++++++++++++++++++++++----------------------
 1 file changed, 49 insertions(+), 43 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 4c76d56..7263b83 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -74,6 +74,47 @@ static int make_parent_dir(const char *path)
 	return 0;
 }
 
+static char depfile_path[PATH_MAX];
+static size_t depfile_prefix_len;
+
+/* touch depfile for symbol 'name' */
+static int conf_touch_dep(const char *name)
+{
+	int fd, ret;
+	const char *s;
+	char *d, c;
+
+	/* check overflow: prefix + name + ".h" + '\0' must fix in buffer. */
+	if (depfile_prefix_len + strlen(name) + 3 > sizeof(depfile_path))
+		return -1;
+
+	d = depfile_path + depfile_prefix_len;
+	s = name;
+
+	while ((c = *s++))
+		*d++ = (c == '_') ? '/' : tolower(c);
+	strcpy(d, ".h");
+
+	/* Assume directory path already exists. */
+	fd = open(depfile_path, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+	if (fd == -1) {
+		if (errno != ENOENT)
+			return -1;
+
+		ret = make_parent_dir(depfile_path);
+		if (ret)
+			return ret;
+
+		/* Try it again. */
+		fd = open(depfile_path, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+		if (fd == -1)
+			return -1;
+	}
+	close(fd);
+
+	return 0;
+}
+
 struct conf_printer {
 	void (*print_symbol)(FILE *, struct symbol *, const char *, void *);
 	void (*print_comment)(FILE *, const char *, void *);
@@ -909,21 +950,16 @@ static int conf_write_dep(const char *name)
 static int conf_touch_deps(void)
 {
 	const char *name;
-	char path[PATH_MAX+1];
-	char *s, *d, c;
 	struct symbol *sym;
-	int res, i, fd;
+	int res, i;
+
+	strcpy(depfile_path, "include/config/");
+	depfile_prefix_len = strlen(depfile_path);
 
 	name = conf_get_autoconfig_name();
 	conf_read_simple(name, S_DEF_AUTO);
 	sym_calc_value(modules_sym);
 
-	if (make_parent_dir("include/config/foo.h"))
-		return 1;
-	if (chdir("include/config"))
-		return 1;
-
-	res = 0;
 	for_all_symbols(i, sym) {
 		sym_calc_value(sym);
 		if ((sym->flags & SYMBOL_NO_WRITE) || !sym->name)
@@ -975,42 +1011,12 @@ static int conf_touch_deps(void)
 		 *	different from 'no').
 		 */
 
-		/* Replace all '_' and append ".h" */
-		s = sym->name;
-		d = path;
-		while ((c = *s++)) {
-			c = tolower(c);
-			*d++ = (c == '_') ? '/' : c;
-		}
-		strcpy(d, ".h");
-
-		/* Assume directory path already exists. */
-		fd = open(path, O_WRONLY | O_CREAT | O_TRUNC, 0644);
-		if (fd == -1) {
-			if (errno != ENOENT) {
-				res = 1;
-				break;
-			}
-
-			if (make_parent_dir(path)) {
-				res = 1;
-				goto out;
-			}
-
-			/* Try it again. */
-			fd = open(path, O_WRONLY | O_CREAT | O_TRUNC, 0644);
-			if (fd == -1) {
-				res = 1;
-				break;
-			}
-		}
-		close(fd);
+		res = conf_touch_dep(sym->name);
+		if (res)
+			return res;
 	}
-out:
-	if (chdir("../.."))
-		return 1;
 
-	return res;
+	return 0;
 }
 
 int conf_write_autoconf(int overwrite)
-- 
2.7.4

