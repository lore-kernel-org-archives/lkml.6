Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753906AbeDMFOo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 01:14:44 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:54464 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751010AbeDMFIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 01:08:15 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w3D56lg3029209
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/30] kconfig: add 'shell' built-in function
Date: Fri, 13 Apr 2018 14:06:18 +0900
Message-Id: <1523595999-27433-10-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This accepts a single command to execute.  It returns the standard
output from it.

[Example code]

  config HELLO
          string
          default "$(shell echo hello world)"

  config Y
          def_bool $(shell echo y)

[Result]

  $ make -s alldefconfig && tail -n 2 .config
  CONFIG_HELLO="hello world"
  CONFIG_Y=y

Caveat:
Like environments, functions are expanded in the lexer.  You cannot
pass symbols to function arguments.  This is a limitation to simplify
the implementation.  I want to avoid the dynamic function evaluation,
which would introduce much more complexity.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2: None

 scripts/kconfig/preprocess.c | 66 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
index e77cf7c..f4c606f 100644
--- a/scripts/kconfig/preprocess.c
+++ b/scripts/kconfig/preprocess.c
@@ -86,7 +86,73 @@ struct function {
 	char *(*func)(int argc, char *argv[]);
 };
 
+/*
+ * Some commands treats commas verbatim.  Concatenate arguments to get
+ * back the original input.  The returned string must be freed when done.
+ */
+static char *join_args(int argc, char *argv[])
+{
+	size_t len = 0;
+	char *out;
+	int i;
+
+	for (i = 0; i < argc; i++)
+		len += strlen(argv[i]) + 1;
+
+	out = xmalloc(len);
+	out[0] = 0;
+	for (i = 0; i < argc; i++) {
+		strcat(out, argv[i]);
+		if (i != argc - 1)
+			strcat(out, ",");
+	}
+
+	return out;
+}
+
+static char *do_shell(int argc, char *argv[])
+{
+	FILE *p;
+	char buf[256];
+	char *cmd;
+	size_t nread;
+	int i;
+
+	cmd = join_args(argc, argv);
+
+	p = popen(cmd, "r");
+	if (!p) {
+		perror(cmd);
+		goto free;
+	}
+
+	nread = fread(buf, 1, sizeof(buf), p);
+	if (nread == sizeof(buf))
+		nread--;
+
+	/* remove trailing new lines */
+	while (buf[nread - 1] == '\n')
+		nread--;
+
+	buf[nread] = 0;
+
+	/* replace a new line with a space */
+	for (i = 0; i < nread; i++) {
+		if (buf[i] == '\n')
+			buf[i] = ' ';
+	}
+
+	if (pclose(p) == -1)
+		perror(cmd);
+
+free:
+	free(cmd);
+
+	return xstrdup(buf);
+}
+
 static const struct function function_table[] = {
+	{ .name = "shell", .func = do_shell },
 };
 
 static char *function_call(const char *name, int argc, char *argv[])
-- 
2.7.4
