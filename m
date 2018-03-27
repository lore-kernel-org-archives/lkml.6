Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AG47ELuiu3oIYYcGqCLksSo4aOTe/Q/1iIB+UF+XtG1Sm7ceCCLejSYNZqD2ESDQr45goc12FwZW
ARC-Seal: i=1; a=rsa-sha256; t=1522128625; cv=none;
        d=google.com; s=arc-20160816;
        b=Qleoi0Actmaae/mSjXJb0/2VOB5EQTIVJm32gi3KWJ7iliJ1D4+ZgdDc7524e2O0ZO
         kIYTqN+uMZeXnkz0pkFlhVqUAWRA/FAZbv3oZtyU1eVknZb0+0Vu/XYmufjbi6f3oFre
         PYJnWt6XUtsJZz7R6bi3sk3K/gPRk3RKxq9Rbl4iQC5WunZMzhR3DviOryt3ReeXyoDj
         on5e9zHK1v17f4Gn/qY3OadL80vMg19ocjoNTFLRA8wXTkoS4/+TV/LBTqrGA7zAKz08
         Tv4cyzgyzh8/N1R/9ZJ17X2U6WHB+uwuhJ12RVca66esg/3M+cLMNBMPcZOvxOrebU6W
         vrTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=4pG48S2UlrsOT3ejNrzGZWeQQuZhLyLMFh52VdRj5G0=;
        b=I8ShA7dotl5Brx433H+3NY05EA3cZbHotAucbrgOFjNZpPmSfnwnsQ0/7iRlitBLD1
         +hgoJCcd7FHjLyxol6Lh4UFH7pLitG5uPxABQBfxD5dOwvtQy0rGag7j93fapTzdSKsJ
         Fn6uSGfW2xXznZurwIzhOwZaVace0hyWp6sfsYk3u7ZMTLGSrhVSykYGdC3q5AKaPWN/
         7yZcljxeBnYH5kbjAElwYBJ7a2HbEVTmbyjr/wXhp1YdZdq1Wa8KgoISblosLG5NpK6x
         bUvOFGm3xwZA7QtKrzebwRPKd9eYfp4uGF8C9rBeRWKQZfCyCK2YYSbYxEokll/t2+Z7
         GC9w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=rcvuR9M/;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=rcvuR9M/;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w2R5TaM1011947
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
Subject: [PATCH v2 16/21] kcov: imply GCC_PLUGINS and GCC_PLUGIN_SANCOV instead of select'ing them
Date: Tue, 27 Mar 2018 14:29:30 +0900
Message-Id: <1522128575-5326-17-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067544988572436?=
X-GMAIL-MSGID: =?utf-8?q?1596067544988572436?=
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
  - Drop depends on GCC_VERSION

---

Changes in v2: None

 lib/Kconfig.debug | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5be22e4..8243c9d 100644
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
