Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754268AbeE1J3U (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:29:20 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:21621 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754326AbeE1JYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:24:16 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w4S9MInQ027506
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v5 09/31] kconfig: add 'shell' built-in function
Date: Mon, 28 May 2018 18:21:46 +0900
Message-Id: <1527499328-13213-10-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
References: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
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

Changes in v5: None
Changes in v4:
  - Accept only one argument to simplify the implementation

Changes in v3: None
Changes in v2: None

 scripts/kconfig/preprocess.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
index f32a496..528be59 100644
--- a/scripts/kconfig/preprocess.c
+++ b/scripts/kconfig/preprocess.c
@@ -106,8 +106,49 @@ struct function {
 	char *(*func)(int argc, char *argv[]);
 };
 
+static char *do_shell(int argc, char *argv[])
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
 	/* Name		MIN	MAX	Function */
+	{ "shell",	1,	1,	do_shell },
 };
 
 #define FUNCTION_MAX_ARGS		16
-- 
2.7.4
