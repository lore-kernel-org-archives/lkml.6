Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x227+fNpThpxFPxqz9BicRY8sijkC12fIS56w3OlQsswhC8T3Di71vYezBWPMit4ckAcFUir8
ARC-Seal: i=1; a=rsa-sha256; t=1518806386; cv=none;
        d=google.com; s=arc-20160816;
        b=Oe6t8cyV1UzVivI4BtkOhW9BcWzNRbfG7H8nxIXtXcH8vDB9WRtRjd2spv33R/2T6L
         vvvGa8V040045swra74EGEnbZ+qk2MRgoySI0WiTjrAawGYa1LCNOzPPpuyBqeYK7TdW
         loFs/9gkMNb1nQr7Epu+ORtHqon3xkWf7O9rfdhgOA0rXOhUeVkPMG+w63xcKIegmMX7
         BDG0oZgZOsiZspvDZj+Roxgu53H1C5yG2NIGI05b/JQjYXWVyeJ3EMSjUjgFwJFXcMCx
         2dX5sTMOAmFk3kt/LQcP2f4SK5sVqiOqmhP/ro0YBnj16dLdJOAjriYIvwaGAMJVw454
         ZSIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=TcwbpsyunP2zGuqv8JQctkwE0xC6/BHmB73ouAOs6XY=;
        b=vOHzg2Lj5zL5CHpZ45m6PCwP/lrfQLXPi4NBFyoE5s4ZwEctBJa42TS7oK4eollOAS
         clJNrRYx9DjmP0RJfKLFFDQJFtXt+ve6XeVVjAk/xaXqCaY8UpoM9bw7+bHaoczKuqLV
         23w1akcV2akDULb1GJOww6HgXWndcTO9stVCcHYOdQ6g6ES/vJpajhEuVJ4mTkPpg9lr
         ELOJYh1uQDnCrdNkd1Zju2E/306iQHJBlmTO2zt2KRVU/lv7+7uaorONFiHH4O5wA0aQ
         5aUqrbr69d2GjQhh2PmAF1UnFWfLBiQ0CodFcbr1S822lR/YV7l/AxxdfqZ5szSAklJ8
         cTqA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=lDEQnHgg;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=lDEQnHgg;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w1GIdBT5013418
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
Subject: [PATCH 02/23] kbuild: remove CONFIG_CROSS_COMPILE support
Date: Sat, 17 Feb 2018 03:38:30 +0900
Message-Id: <1518806331-7101-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583924954666942?=
X-GMAIL-MSGID: =?utf-8?q?1592583924954666942?=
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

 Makefile     | 3 ---
 init/Kconfig | 9 ---------
 2 files changed, 12 deletions(-)

diff --git a/Makefile b/Makefile
index a27e6d8..94a957e 100644
--- a/Makefile
+++ b/Makefile
@@ -307,12 +307,9 @@ SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
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
