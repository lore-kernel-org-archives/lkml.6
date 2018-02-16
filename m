Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x224QDFLkxnJVEChedRWExUvZaeNEUnKu6siPrnXvrxzyy4VFTLS3PbqgnhkR0lFlw3GNEUg/
ARC-Seal: i=1; a=rsa-sha256; t=1518806395; cv=none;
        d=google.com; s=arc-20160816;
        b=bIxbaMz/Ht3qbhzQw8vzT3rSMMamufR3iA+RbDNwPALWF9d3IsVNrtt+LqqYIIkLDi
         9HuR58uvCoAWvJZmRUkZYNqJo1kkLa+XfBo21o4LGa5V7UFCqKNClepiLY5E1HE9+oFf
         dPgBSoWs8VESyAyPWbY4G7rRYkSj1sYud4yBU+5X4WMhsD+wmhWshWQTYoaswukUxy/6
         OHfaoBu3j3RQMbc6+1utHIR8PVXjk/SxK/ZVkNvulJAkzENrW3GKQa0xLUxd6tfqS4Md
         0aSOaYz+/Rv13Tx1n0OpE4GePtAxLLGoEOwt/7I9C8X2aiDkdzw3BWs8wXpY1orgE0i2
         5nUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=6/IoqUTGHai0Czf36phhQJ7Uyzpz6vT0GEH8DaNw/3g=;
        b=HQsSo6FMOImeOK5BtnWyMb2Je4r4Wpx8zHjjce2E8V7iKQQvutdKRCeJZ2SF3mjf83
         zbNOvULIdVicQsX6qmtKLMDv6cdWRrKxkq6Ga7jT546Cjv3+yEg/Lejze7Q9cYn/C1Y8
         6jYI9tLchcMAQj5s66UR1WMP+1cIosI5UzI8KuBgh6c42DN/ooV4830WNVxYeZcBq1vr
         bZg5Qx4ZV1rD9OAlwRQTgRDRUXsIrT3Gv7XtWS+E/4HWqzzq8ZZDVyFLLg1WUnhNS4al
         7IJbUmNxhZh5Gd991ohF9Nu3xK1Jx5u2fcJ0mQSaPnb3DSbfTdS5e9RqCO8t8NgrfaRr
         hGOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=QV6T0K0+;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=QV6T0K0+;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w1GIdBTE013418
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/23] kconfig: add 'shell-stdout' function
Date: Sat, 17 Feb 2018 03:38:39 +0900
Message-Id: <1518806331-7101-12-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583935341216706?=
X-GMAIL-MSGID: =?utf-8?q?1592583935341216706?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the second built-in function, which retrieves the first line
of stdout from the given shell command.

Example code:

  config CC_IS_GCC
          bool
          default $(shell $CC --version | grep -q gcc)

  config GCC_VERSION
          int
          default $(shell-stdout $srctree/scripts/gcc-version.sh $CC | sed 's/^0*//') if CC_IS_GCC
          default 0

Result:

  $ make -s alldefconfig && tail -n 2 .config
  CONFIG_CC_IS_GCC=y
  CONFIG_GCC_VERSION=504

  $ make CC=clang -s alldefconfig && tail -n 2 .config
  # CONFIG_CC_IS_GCC is not set
  CONFIG_GCC_VERSION=0

By the way, function calls can be nested, so the following works.

Example code:

  config FOO
          bool
          default $(shell $(shell-stdout echo $COMMAND_IN_CAPITAL | tr [A-Z] [a-z]))

Result:
  $ make -s COMMAND=TRUE alldefconfig && tail -n 1 .config
  CONFIG_FOO=y
  $ make -s COMMAND=FALSE alldefconfig && tail -n 1 .config
  # CONFIG_FOO is not set

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/function.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/scripts/kconfig/function.c b/scripts/kconfig/function.c
index f7f154d..266f4ec 100644
--- a/scripts/kconfig/function.c
+++ b/scripts/kconfig/function.c
@@ -189,10 +189,56 @@ static char *do_shell(struct function *f, int argc, char *argv[])
 	return xstrdup(ret == 0 ? "y" : "n");
 }
 
+static char *do_shell_stdout(struct function *f, int argc, char *argv[])
+{
+	static const char *pre = "(";
+	static const char *post = ") 2>/dev/null";
+	FILE *p;
+	char buf[256];
+	char *cmd;
+	int ret;
+
+	if (argc != 2)
+		return NULL;
+
+	/*
+	 * Surround the command with ( ) in case it is piped commands.
+	 * Also, redirect stderr to /dev/null.
+	 */
+	cmd = xmalloc(strlen(pre) + strlen(argv[1]) + strlen(post) + 1);
+	strcpy(cmd, pre);
+	strcat(cmd, argv[1]);
+	strcat(cmd, post);
+
+	p = popen(cmd, "r");
+	if (!p) {
+		perror(cmd);
+		goto free;
+	}
+	if (fgets(buf, sizeof(buf), p)) {
+		size_t len = strlen(buf);
+
+		if (buf[len - 1] == '\n')
+			buf[len - 1] = '\0';
+	} else {
+		buf[0] = '\0';
+	}
+
+	ret = pclose(p);
+	if (ret == -1)
+		perror(cmd);
+
+free:
+	free(cmd);
+
+	return xstrdup(buf);
+}
+
 void func_init(void)
 {
 	/* register built-in functions */
 	func_add("shell", do_shell, NULL);
+	func_add("shell-stdout", do_shell_stdout, NULL);
 }
 
 void func_exit(void)
-- 
2.7.4
