Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AG47ELuBk0eNc2goBCw/ku2niXJz9lJyGarDdhVM+rJTVNlNYrQt8ssOmamyviSyyw085diD0KrR
ARC-Seal: i=1; a=rsa-sha256; t=1522128618; cv=none;
        d=google.com; s=arc-20160816;
        b=0J55kZgIU72w3DMztI4O21nRm6X8nJqblmJnke3pesB08DvossxPYkFy/8ox76c0eK
         CNJnjrfT8SH/7lDy95YU2BXBapphU1hmz2Eq9aqn68t/74epsoSH7xMh7mf03K2B4uNG
         tOG3qNmF1REvJEHp/ouPHX100ERem75X8rUT1m1ju7Ib1LjlBeHSr+47GJN+7SXm9nmD
         mY1831NOXGPBBXT6TN2iAWwi8jZsP3PgZ3izF8/AI45UYY17P1S1qekSkw/7pumsW7u9
         SGrWbXZ+0xACdONWiP3vVMIE3of2ycpWp9+vSKue62E2wGdqiWXIqW16bbRgHOITUEqv
         NkjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=RGk+aT9ZGpkRkDLDSt7yEl22MZ2hquI+ZQNQeH0HzbI=;
        b=p9n3p3SMb8ZYpY/cCor5jpp0eO7BQAduLaRal+yAQWVJQsn++cwEEqx9TRVe+1yc4v
         VEMd7Yd3D9LrjiI4vPDNctQBEzQnIkSlJfD7l5eOVAj9msO6yjZa248im++tGfkBv+K1
         qaZFUxCt0T1JbavuChLYGJ5nlxCDT7PEF4ioFaf9jheEjH4Fg/HjoUK2zp4eYdeFPtOn
         UsITO7FEhlOB3XlRvz+w2Mf+5Yh6UyWa5foIhi4ukcBPP2HkKTHEEIR34SGZUKTRk8/1
         qr49XmSWsr7PSd1w8Ba3txC/EREapGKTs5EdMB6Vl+Ailtga/HXhMxdXul2gvKzSTNuy
         8uyg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=RICW6Nmi;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=RICW6Nmi;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w2R5TaLl011947
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
Subject: [PATCH v2 02/21] kbuild: remove CONFIG_CROSS_COMPILE support
Date: Tue, 27 Mar 2018 14:29:16 +0900
Message-Id: <1522128575-5326-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067537535425960?=
X-GMAIL-MSGID: =?utf-8?q?1596067537535425960?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Kbuild provides a couple of ways to specify CROSS_COMPILE:

[1] Command line
[2] Environment
[3] arch/*/Makefile (only some architectures)
[4] CONFIG_CROSS_COMPILE

[4] is problematic for the compiler capability tests in Kconfig.
CONFIG_CROSS_COMPILE allows users to change the compiler prefix from
'make menuconfig', etc.  It means, the compiler options would have
to be all re-calculated everytime CONFIG_CROSS_COMPILE is changed.

To avoid complexity and performance issues, I'd like to evaluate
the shell commands statically, i.e. only parsing Kconfig files.

I guess the majority is [1] or [2].  Currently, there are only
4 defconfig files that specify CONFIG_CROSS_COMPILE.
  arch/arm/configs/lpc18xx_defconfig
  arch/hexagon/configs/comet_defconfig
  arch/openrisc/configs/or1ksim_defconfig
  arch/openrisc/configs/simple_smp_defconfig

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 Makefile     | 3 ---
 init/Kconfig | 9 ---------
 2 files changed, 12 deletions(-)

diff --git a/Makefile b/Makefile
index c55cf95..5c395ed 100644
--- a/Makefile
+++ b/Makefile
@@ -316,12 +316,9 @@ SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
 # CROSS_COMPILE can be set on the command line
 # make CROSS_COMPILE=ia64-linux-
 # Alternatively CROSS_COMPILE can be set in the environment.
-# A third alternative is to store a setting in .config so that plain
-# "make" in the configured kernel build directory always uses that.
 # Default value for CROSS_COMPILE is not to prefix executables
 # Note: Some architectures assign CROSS_COMPILE in their arch/*/Makefile
 ARCH		?= $(SUBARCH)
-CROSS_COMPILE	?= $(CONFIG_CROSS_COMPILE:"%"=%)
 
 # Architecture as present in compile.h
 UTS_MACHINE 	:= $(ARCH)
diff --git a/init/Kconfig b/init/Kconfig
index e37f4b2..df18492 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -54,15 +54,6 @@ config INIT_ENV_ARG_LIMIT
 	  Maximum of each of the number of arguments and environment
 	  variables passed to init from the kernel command line.
 
-
-config CROSS_COMPILE
-	string "Cross-compiler tool prefix"
-	help
-	  Same as running 'make CROSS_COMPILE=prefix-' but stored for
-	  default make runs in this kernel build directory.  You don't
-	  need to set this unless you want the configured kernel build
-	  directory to select the cross-compiler automatically.
-
 config COMPILE_TEST
 	bool "Compile also drivers which will not load"
 	depends on !UML
-- 
2.7.4
