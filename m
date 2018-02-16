Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x224Ozk9G0e5BnPVp0uJ37X0fYOfHGOK/OtSwr/IApYmFNC14Ox5EXjj/vSejg3ixBzMnBdve
ARC-Seal: i=1; a=rsa-sha256; t=1518806834; cv=none;
        d=google.com; s=arc-20160816;
        b=HNba6dN9HVpd7BPnPwgiL3zkMSBLMeEaf9kxUw/n3I44NpLldVXoNb9S+5uC864tGM
         YYYLkz1lJe/0nBC3xyBQfihfSC95+17xfm6rJSKtjBdbCfDD3vE3M/QFxjcloEK5oKe0
         mU53tPWXmGMK8WyBhzh72QlcnfqbZ2MV5KYCO6MwIWN9rN311XUPHpNF+HyvEb7PCjfY
         ThO+wVMC68orz/y2T1hXwiMvQhTGtlD+oWA6G2acNnSYV8a18VdERQK1q2YXrAsFYAeo
         ZAVwptiNffO6DbUk8qJAwDzTf4iEGPzIDF22eNwRiFynHMlC5SEp71nHrs6WWgt5yUXy
         0RGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=g4jr7p8+pSavXrVBxgeLhmsF9gTgnd5dakNfR8FDu8k=;
        b=WmYYF4PuGIN0E4aW9hbwha9lzJb8iO3YyeLrHly0PRdaH4bDZubk9ei0/fmeYvmS5B
         9SiagthFP14mWhgvjH4wyfBSSkOAB+QpUdJgDkw8dOL8K6ltTyAK/RHRw89e8Xsi2gjA
         UODL28tcpvapVZtx7eGNmRzRYfYsUebnsaYFQVuzowa7/khfzWY8UmzkQZiqbak22PnK
         NwBSPbBJW/3ixG9kJjw40ksKlgs985ho8sbqnfD62MN7DyDs2z1c1ExjjkZu4u6hBEfq
         Turr82R51qFRBoYgBdW3WDe4DtrS646bgzieGdVZXMJ8z1FQBddvoeMXaCfPL7oo3fiF
         nhOA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=Zv2WgPoR;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=Zv2WgPoR;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w1GIdBTJ013418
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/23] kbuild: add clang-version.sh
Date: Sat, 17 Feb 2018 03:38:44 +0900
Message-Id: <1518806331-7101-17-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592584394753262475?=
X-GMAIL-MSGID: =?utf-8?q?1592584394753262475?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sami Tolvanen <samitolvanen@google.com>

Based on gcc-version.sh, clang-version.sh prints out the correct
version of clang.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/clang-version.sh | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100755 scripts/clang-version.sh

diff --git a/scripts/clang-version.sh b/scripts/clang-version.sh
new file mode 100755
index 0000000..9780efa
--- /dev/null
+++ b/scripts/clang-version.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# clang-version [-p] clang-command
+#
+# Prints the compiler version of `clang-command' in a canonical 4-digit form
+# such as `0500' for clang-5.0 etc.
+#
+# With the -p option, prints the patchlevel as well, for example `050001' for
+# clang-5.0.1 etc.
+#
+
+if [ "$1" = "-p" ] ; then
+	with_patchlevel=1;
+	shift;
+fi
+
+compiler="$*"
+
+if [ ${#compiler} -eq 0 ]; then
+	echo "Error: No compiler specified."
+	printf "Usage:\n\t$0 <clang-command>\n"
+	exit 1
+fi
+
+MAJOR=$(echo __clang_major__ | $compiler -E -x c - | tail -n 1)
+MINOR=$(echo __clang_minor__ | $compiler -E -x c - | tail -n 1)
+if [ "x$with_patchlevel" != "x" ] ; then
+	PATCHLEVEL=$(echo __clang_patchlevel__ | $compiler -E -x c - | tail -n 1)
+	printf "%02d%02d%02d\\n" $MAJOR $MINOR $PATCHLEVEL
+else
+	printf "%02d%02d\\n" $MAJOR $MINOR
+fi
-- 
2.7.4
