Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x225+hKp6d7OxeetNTsBr0u15zPy3d/3cu7hjWVX0DSXOIoCnCCxyb57tYQqLCJli4576+DgA
ARC-Seal: i=1; a=rsa-sha256; t=1518806395; cv=none;
        d=google.com; s=arc-20160816;
        b=VVoC2xhT/SnlfZEUEMLbAAuodrkSe6Q2pi5ZNdilK5gNH1RntsZ/pxL5r6QT8jwlKw
         5rd4A7MeBCva3+aOZUT8hZRiPFBVSZBdNHD2ur96qiIHz6H+77k7LBVKp7BU5j/kbOxj
         xw/23ILT1EZl53sSZPZiLuI/cY56Qd/UUXiac3kCtMgJPCDhvg1MEwBxlRGIjYDis2zP
         f4v+HvaFIy485s5axMKZ7tzO4ubc2EMR3Fk8qWJcwFeCqsEYUL/rwAOvl0qF5ZlIRYbi
         TOHDWXAd3OLL/LE2mo+ETlqdyecEiL06ld5FUdE+62smLJXpkmK6cGtSjlzLdvo5mKdO
         85ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=D0SFCGOFIy+/Nth0+l6GLQfAxw29uEAyFnvGWq1jc7A=;
        b=Ljeez9BfL8KaFPXFolnR6AYBzFF7T75X9aMilSYghUlOt1fbbmEkm4TUdibOUAj3gd
         VYz9Y4tPkzD2+yRx5E5PkIim0CA2d2zpE3imgXWylWrYrl9596HCQ0HCuToQLVo9Envl
         2754Mq+BnQfI7YinY1bKG5tlypzlUXOrN/ZTTwjrr4lkciaz3VOtzHwmWMhwaIylAihA
         veE29d7qCRIGeilnZ4l5eV39iNaUQNhEfPmcwvoygE1fo2sZbX9YsiQCmVipWZMBfBnq
         lMDX8ZcDr+0/wD3GDVJuMleekCQ2KamD4f6cIghZIAfDDCQXfsylf+HBxlsIAOIFCV+u
         mklg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=Yt/IrWbd;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=Yt/IrWbd;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w1GIdBTK013418
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
Subject: [PATCH 17/23] kconfig: add CC_IS_CLANG and CLANG_VERSION
Date: Sat, 17 Feb 2018 03:38:45 +0900
Message-Id: <1518806331-7101-18-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583934887028081?=
X-GMAIL-MSGID: =?utf-8?q?1592583934887028081?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This will be useful to describe the clang version dependency.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 init/Kconfig             |  8 ++++++++
 scripts/clang-version.sh | 24 +++++++++++-------------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index f2da5e9..1b751bc 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -21,6 +21,14 @@ config GCC_VERSION
 	default $(shell-stdout $srctree/scripts/gcc-version.sh -p $CC | sed 's/^0*//') if CC_IS_GCC
 	default 0
 
+config CC_IS_CLANG
+	bool
+	default $(shell $CC --version | grep -q clang)
+
+config CLANG_VERSION
+	int
+	default $(shell-stdout $srctree/scripts/clang-version.sh $CC)
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
