Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AG47ELspAvN0bqRFmoMsdxIvUvzQ4RA1V1D65UZugHPr3J5BXyTUe7Tt1tMEy2Wn2WyuaSwPi0ar
ARC-Seal: i=1; a=rsa-sha256; t=1522128625; cv=none;
        d=google.com; s=arc-20160816;
        b=hVlgiQzEbrG4MQKuA1FDlvL05SKzi/1i6VF2LhgxURaE2qkwr58zqX28oZY3E9yvK4
         LKaUPGHamGlMA11MhDeMDpZR7FUPovCjCjkbhPE55dCTlvK0tEl2ppOhyByV4+2UyAoJ
         VUbIkPk2bA0O22dXtinimOd3rWc9u6+wxS8qVA4g3UNSSugE52fVfYcUm3HFCQntNg9N
         A/YShlw1biSdC9mkCzQoNY5vLS46O42NbYkqO63nj9rv1mdpkK2NOTSCCsJSY56G7+3+
         D+cG0vWNc5awdqTFLuvQGyhHPJiMEigBeajacZ4tmR74CXDYuUeRGE78uro4Qz9cVFU1
         E53A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=RYqC1QRkceoAm9+CHevbEu7OH/qqF2FDZaEeQkX7ooA=;
        b=TB0CmpF9UmMXeiBV6xfpwpyLjKW1C1sbABtveqPeTtBFX6iekugOVq3KR6nYPsBqqh
         q9dVJ8BEYgWaWWKja0gkzjFG93aCOD6v7wOezbby1db5Y1zMIT5LTHhtQB+KZuOdyGll
         OEL8TdiHZAesxDelTekalQByxl27z+auaXuYyfOCA5hwGdsw3IWol2ZHsSlBpcvI0dDj
         CiHe1QjRt06oRF1nZkJzsgKFOCVFpBEl3gOqvDwK7VLjt2Rk1ghmy+IgnfEwPKH5r2kv
         NeR3BQEJQ/nZ22CqXrkvXoxuOdxiOYv9Lihoq9uyV8L9Rjd+tNkSpt5nFwTsdVBAWeVI
         cI6A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=qfBbq9xZ;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=qfBbq9xZ;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w2R5TaLx011947
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ulf Magnusson <ulfalizer@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Nicolas Pitre <nico@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/21] kconfig: add CC_IS_CLANG and CLANG_VERSION
Date: Tue, 27 Mar 2018 14:29:28 +0900
Message-Id: <1522128575-5326-15-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067545333051904?=
X-GMAIL-MSGID: =?utf-8?q?1596067545333051904?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This will be useful to describe the clang version dependency.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 init/Kconfig             |  7 +++++++
 scripts/clang-version.sh | 24 +++++++++++-------------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 923cab5..5998034 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -22,6 +22,13 @@ config GCC_VERSION
 	default $(shell $srctree/scripts/gcc-version.sh -p $CC | sed 's/^0*//') if CC_IS_GCC
 	default 0
 
+config CC_IS_CLANG
+	def_bool $(success $CC --version | grep -q clang)
+
+config CLANG_VERSION
+	int
+	default $(shell $srctree/scripts/clang-version.sh $CC)
+
 config CONSTRUCTORS
 	bool
 	depends on !UML
diff --git a/scripts/clang-version.sh b/scripts/clang-version.sh
index 9780efa..d8002d2 100755
--- a/scripts/clang-version.sh
+++ b/scripts/clang-version.sh
@@ -10,24 +10,22 @@
 # clang-5.0.1 etc.
 #
 
-if [ "$1" = "-p" ] ; then
-	with_patchlevel=1;
-	shift;
-fi
-
 compiler="$*"
 
 if [ ${#compiler} -eq 0 ]; then
-	echo "Error: No compiler specified."
-	printf "Usage:\n\t$0 <clang-command>\n"
+	echo "Error: No compiler specified." >&2
+	printf "Usage:\n\t$0 <clang-command>\n" >&2
+	echo 0
+	exit 1
+fi
+
+if !( $compiler --version | grep -q clang) ; then
+	echo "This is not clang." >&2
+	echo 0
 	exit 1
 fi
 
 MAJOR=$(echo __clang_major__ | $compiler -E -x c - | tail -n 1)
 MINOR=$(echo __clang_minor__ | $compiler -E -x c - | tail -n 1)
-if [ "x$with_patchlevel" != "x" ] ; then
-	PATCHLEVEL=$(echo __clang_patchlevel__ | $compiler -E -x c - | tail -n 1)
-	printf "%02d%02d%02d\\n" $MAJOR $MINOR $PATCHLEVEL
-else
-	printf "%02d%02d\\n" $MAJOR $MINOR
-fi
+PATCHLEVEL=$(echo __clang_patchlevel__ | $compiler -E -x c - | tail -n 1)
+printf "%d%02d%02d\\n" $MAJOR $MINOR $PATCHLEVEL
-- 
2.7.4
