Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753944AbeDMFMp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 01:12:45 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:54506 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbeDMFIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 01:08:16 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w3D56lgA029209
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/30] kconfig: add 'info' and 'warning' built-in functions
Date: Fri, 13 Apr 2018 14:06:25 +0900
Message-Id: <1523595999-27433-17-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'info' and 'warning' functions as in Make.

They print messages during parsing Kconfig files, which is useful
when debugging Kconfig at least.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2: None

 scripts/kconfig/preprocess.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
index 85972fb..f8d06d9 100644
--- a/scripts/kconfig/preprocess.c
+++ b/scripts/kconfig/preprocess.c
@@ -203,6 +203,19 @@ static char *join_args(int argc, char *argv[])
 	return out;
 }
 
+static char *do_info(int argc, char *argv[])
+{
+	char *msg;
+
+	msg = join_args(argc, argv);
+
+	printf("%s\n", msg);
+
+	free(msg);
+
+	return xstrdup("");
+}
+
 static char *do_shell(int argc, char *argv[])
 {
 	FILE *p;
@@ -244,8 +257,23 @@ static char *do_shell(int argc, char *argv[])
 	return xstrdup(buf);
 }
 
+static char *do_warning(int argc, char *argv[])
+{
+	char *msg;
+
+	msg = join_args(argc, argv);
+
+	fprintf(stderr, "%s:%d: %s\n", current_file->name, yylineno, msg);
+
+	free(msg);
+
+	return xstrdup("");
+}
+
 static const struct function function_table[] = {
+	{ .name = "info", .func = do_info },
 	{ .name = "shell", .func = do_shell },
+	{ .name = "warning", .func = do_warning },
 };
 
 static char *function_call(const char *name, int argc, char *argv[])
-- 
2.7.4
