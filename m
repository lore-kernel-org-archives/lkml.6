Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x226SiTSRpl1yn+36LpBufGCX5BZTl2ViQPyAoqagmfYmJYqkQdMwJmdtMvllczw4d7ClagxC
ARC-Seal: i=1; a=rsa-sha256; t=1518806395; cv=none;
        d=google.com; s=arc-20160816;
        b=WO6E1GwQ/sIVyEAZN16isb81AoKIm+fJGJeDZn5h2YP49snSV4UzV6xACMS1Mjxh8Z
         lQdp8AmGrjIkNn2JDkyBANcj1Iif01mDeNotM1jWmQnFeNP5hgtsnlOk1uqHsFrs7bNw
         nBKIoOI2uoyqvNQC8iIPhb2rpxyC+OQM1lbylgWwQQ0NCkZd9DZBmR2+Pqcsf/SjMB2x
         nZYwasxMUMCdjLQQFiPWINvSddWPR/bvmahuXdm2jspNDFdUKx+1fsEdhHHcmT3M4PMK
         fTqeune7QQTV8o9/I+flvhsTC5nJCioqhCeH6N09DUUE6Zj9EMlrfrvtC13Tx8E2RNB0
         ki8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=NNUronc0b0DxbhAtpAXfRP7LuUaytEfPMCerNrVvsRI=;
        b=IsF5Vqh83KTEBR8GzpiPIP0yxeMvlxL7dUOcRObsxXzHLvmjLPLhOPICjvcQ9sQCXI
         MXxOpfHLp5EL4a2gGzdgZf8vw7nZ9oqcv7/VROiwSkqPVHCD0zaIq/NwBqo/xNlWr4Dx
         BysJFWrUz4TTDQ4UEThHQl3gUaM73QLP78VQECywul0gHounv8BT/ci9f3cGeEtMYmL3
         hatERDY0MZMH6v3NtRwe+lDyRBn7lXjCEMyOBw2JatjHorV3dZtZAwgavZtxXGwotHch
         m0rj8p5N5awPJ6tY2IKiUy8afbdwGxpfYecKjVxDLgMbPbf8jGCNa2bZPfgNdYTMiv5I
         Vgxg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=c1puTWxM;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=c1puTWxM;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w1GIdBTM013418
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
Subject: [PATCH 19/23] kcov: imply GCC_PLUGINS and GCC_PLUGIN_SANCOV instead of select'ing them
Date: Sat, 17 Feb 2018 03:38:47 +0900
Message-Id: <1518806331-7101-20-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583935677866437?=
X-GMAIL-MSGID: =?utf-8?q?1592583935677866437?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As Documentation/kbuild/kconfig-language.txt notes, 'select' should be
used with care - it forces a lower limit of another symbol, ignoring
the dependency.  In this case, KCOV can select GCC_PLUGINS even if
'depends on HAVE_GCC_PLUGINS' is unmet.

'imply' is modest enough to observe the dependency, and this makes
sense.  If you enable KCOV, you will probably want to enable
GCC_PLUGIN_SANCOV, but it should not break the dependency.

I also remove unneeded code, I just happened to notice.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 lib/Kconfig.debug | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 6088408..1216ce6 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -743,8 +743,8 @@ config KCOV
 	bool "Code coverage for fuzzing"
 	depends on ARCH_HAS_KCOV
 	select DEBUG_FS
-	select GCC_PLUGINS if !COMPILE_TEST
-	select GCC_PLUGIN_SANCOV if !COMPILE_TEST
+	imply GCC_PLUGINS
+	imply GCC_PLUGIN_SANCOV
 	help
 	  KCOV exposes kernel code coverage information in a form suitable
 	  for coverage-guided fuzzing (randomized testing).
@@ -758,7 +758,6 @@ config KCOV
 config KCOV_ENABLE_COMPARISONS
 	bool "Enable comparison operands collection by KCOV"
 	depends on KCOV
-	default n
 	help
 	  KCOV also exposes operands of every comparison in the instrumented
 	  code along with operand sizes and PCs of the comparison instructions.
@@ -768,7 +767,7 @@ config KCOV_ENABLE_COMPARISONS
 config KCOV_INSTRUMENT_ALL
 	bool "Instrument all code by default"
 	depends on KCOV
-	default y if KCOV
+	default y
 	help
 	  If you are doing generic system call fuzzing (like e.g. syzkaller),
 	  then you will want to instrument the whole kernel and you should
-- 
2.7.4
