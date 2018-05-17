Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752244AbeEQGTX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:19:23 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:24996 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751379AbeEQGTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:19:16 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w4H6HbUE002841
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v4 16/31] kconfig: add 'if' built-in function
Date: Thu, 17 May 2018 15:16:55 +0900
Message-Id: <1526537830-22606-17-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
References: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'if' function is invoked in the form:

  $(if,condition,then-part,else-part)

The behavior is slightly different from that of Make.

In Make, the condition is true if the expansion contains any characters
(even space).  That is why we sometimes need $(strip ...) in the
condition part.

I thought it was a nasty part in Make, so I changed it for Kconfig;
the condition is true if the expansion contains any characters except
whitespaces.

Unlike the other functions, the parameters passed to 'if' are lazily
expanded.  The then-part is expanded only when the condition true,
and the else-part when false.  If the parameters were evaluated
before passed to the 'if' function, $(if,$(cond),$(error,...))
would terminate the parsing regardless of $(cond).

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v4:
 - Newly added

Changes in v3: None
Changes in v2: None

 scripts/kconfig/preprocess.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
index 591bcf7..88844a7 100644
--- a/scripts/kconfig/preprocess.c
+++ b/scripts/kconfig/preprocess.c
@@ -111,6 +111,32 @@ static char *do_error(int argc, char *argv[], int old_argc, char *old_argv[])
 	return NULL;
 }
 
+static char *do_if(int argc, char *argv[], int old_argc, char *old_argv[])
+{
+	char *cond, *p, *res;
+	const char *sel;
+
+	cond = expand_string_with_args(argv[0], old_argc, old_argv);
+	p = cond;
+
+	/* condition is true if any character except whitespaces is contained */
+	while (*p == ' ' || *p == '\t')
+		p++;
+
+	if (*p)
+		sel = argv[1];
+	else if (argc >= 3)
+		sel = argv[2];
+	else
+		sel = "";
+
+	res = expand_string_with_args(sel, old_argc, old_argv);
+
+	free(cond);
+
+	return res;
+}
+
 static char *do_info(int argc, char *argv[], int old_argc, char *old_argv[])
 {
 	printf("%s\n", argv[0]);
@@ -168,6 +194,7 @@ static char *do_warning(int argc, char *argv[], int old_argc, char *old_argv[])
 static const struct function function_table[] = {
 	/* Name		MIN	MAX	EXP?	Function */
 	{ "error",	1,	1,	true,	do_error },
+	{ "if",		2,	3,	false,	do_if },
 	{ "info",	1,	1,	true,	do_info },
 	{ "shell",	1,	1,	true,	do_shell },
 	{ "warning",	1,	1,	true,	do_warning },
-- 
2.7.4
