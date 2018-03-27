Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AG47ELvVZELS/X8L+ACttoB2RTldj8TSPvd3z/2PofBcZhbpVzZVYvGKFGn602kzceDpyeCMEILR
ARC-Seal: i=1; a=rsa-sha256; t=1522128618; cv=none;
        d=google.com; s=arc-20160816;
        b=RcJgni2hhwdnmk8MM/Rl2fCS4CN+d99MwvN88oCKH3wo0w62MayZ+b/sRUuPc3MOr/
         Xtpy1WboJo+UXaetwDgim6TG3vwi9m36yjJME7ZPo16S/DU/zc4LaZbuV7krdLhqKKdw
         xZGFnPC33dBtDnC0rwdf/E1s2RilEXD6xBGvUNFLIv+70dnlWc7AOgTWhahljXWzLBQ6
         MG6P/QxyaqZReatk9EJ/FQrwFwAqwEx8NY/rBD9ykUcnAiaUJJGBu7wSRUl3zFQs6rx4
         skfX5t80RUQSV6YiYHDSR6tR/er44TxnA8Qv7NxXclgmHwH+fGgtiz1nKkAi94XeRvlP
         mbyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=Y0EgiF5xffNcee7N9S9KbbQwPIhX8Hv7iF7h8moPLZY=;
        b=KphpJu/ZArGl/wVanEGjjrQvExQUF3peHLkMPmu6jVpWeN/x8FK+ZTBGDM5rPutfwI
         Fq3qsxKdGjoo77pO02sbu/brgF9eDkKgSYGLtYRsnlUUl/QhGwWaBzNnZyzXQzanOqK3
         I0z+UIgXxzDxoTrPOsYTgVOaribv55+wyL8x2QUansInuBYxFi6Pb2JC3GZIy8FJUj60
         V+E3fjb2O3C/KKLWHp2lDmU01Na5g9xOhf91xJMyrV3Thw+d9Tm0Fc4Y2yVKqyVcFMYX
         xk4VKUWF0cnKJd92Qjy28Xr9MhPFBASXr3zoyd/rox3CSHacaAeiQMriDMRAKdkvquEW
         xAFg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=BUh/7azb;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=BUh/7azb;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w2R5TaLv011947
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
Subject: [PATCH v2 12/21] kconfig: show compiler version text in the top comment
Date: Tue, 27 Mar 2018 14:29:26 +0900
Message-Id: <1522128575-5326-13-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067537912515581?=
X-GMAIL-MSGID: =?utf-8?q?1596067537912515581?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The kernel configuration phase is now tightly coupled with the compiler
in use.  It will be nice to show the compiler information in Kconfig.

The compiler information will be displayed like this:

  $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- config
  scripts/kconfig/conf  --oldaskconfig Kconfig
  *
  * Linux/arm64 4.16.0-rc1 Kernel Configuration
  *
  *
  * Compiler: aarch64-linux-gnu-gcc (Linaro GCC 7.2-2017.11) 7.2.1 20171011
  *
  *
  * General setup
  *
  Compile also drivers which will not load (COMPILE_TEST) [N/y/?]

If you use GUI methods such as menuconfig, it will be displayed in the
top menu.

This is simply implemented by using 'comment'.  So, it will be saved
into the .config file as well.

This commit has a very important meaning.  If the compiler is upgraded,
Kconfig must be re-run since different compilers have different sets
of supported options.

All referenced environments are written to include/config/auto.conf.cmd
so that any environment change triggers syncconfig, and prompt the user
to input new values if needed.

With this commit, something like follows will be added to
include/config/auto.conf.cmd

  ifneq "$(CC_VERSION_TEXT)" "aarch64-linux-gnu-gcc (Linaro GCC 7.2-2017.11) 7.2.1 20171011"
  include/config/auto.conf: FORCE
  endif

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 Kconfig  | 2 ++
 Makefile | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Kconfig b/Kconfig
index e6ece5b..99ed4b8 100644
--- a/Kconfig
+++ b/Kconfig
@@ -5,4 +5,6 @@
 #
 mainmenu "Linux/$ARCH $KERNELVERSION Kernel Configuration"
 
+comment "Compiler: $CC_VERSION_TEXT"
+
 source "arch/$SRCARCH/Kconfig"
diff --git a/Makefile b/Makefile
index 5cadffa..3dc9eb8 100644
--- a/Makefile
+++ b/Makefile
@@ -450,6 +450,8 @@ export KBUILD_AFLAGS_MODULE KBUILD_CFLAGS_MODULE KBUILD_LDFLAGS_MODULE
 export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL
 export KBUILD_ARFLAGS
 
+export CC_VERSION_TEXT := $(shell $(CC) --version | head -n 1)
+
 # When compiling out-of-tree modules, put MODVERDIR in the module
 # tree rather than in the kernel tree. The kernel tree might
 # even be read-only.
-- 
2.7.4
