Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752423AbeEQG2V (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:28:21 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:24196 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbeEQGSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:18:51 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w4H6HbU6002841
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v4 08/31] kconfig: add 'shell' built-in function
Date: Thu, 17 May 2018 15:16:47 +0900
Message-Id: <1526537830-22606-9-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
References: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This accepts a single command to execute.  It returns the standard
output from it.

[Example code]

  config HELLO
          string
          default "$(shell,echo hello world)"

  config Y
          def_bool $(shell,echo y)

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

Changes in v4:
  - Accept only one argument to simplify the implementation

Changes in v3: None
Changes in v2: None

 scripts/kconfig/preprocess.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
index 5be28ec..d8c5f60 100644
--- a/scripts/kconfig/preprocess.c
+++ b/scripts/kconfig/preprocess.c
@@ -104,8 +104,49 @@ struct function {
 	char *(*func)(int argc, char *argv[], int old_argc, char *old_argv[]);
 };
 
+static char *do_shell(int argc, char *argv[], int old_argc, char *old_argv[])
+{
+	FILE *p;
+	char buf[256];
+	char *cmd;
+	size_t nread;
+	int i;
+
+	cmd = argv[0];
+
+	p = popen(cmd, "r");
+	if (!p) {
+		perror(cmd);
+		exit(1);
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
+	if (pclose(p) == -1) {
+		perror(cmd);
+		exit(1);
+	}
+
+	return xstrdup(buf);
+}
+
 static const struct function function_table[] = {
 	/* Name		MIN	MAX	EXP?	Function */
+	{ "shell",	1,	1,	true,	do_shell },
 };
 
 #define FUNCTION_MAX_ARGS		16
-- 
2.7.4
