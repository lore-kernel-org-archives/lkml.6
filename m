Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x227ov2NJ8QuqIC3wE6ftqfh7jHizssnDX09N3TE980gIrbVbCEoukjldGwSVxeHrdapQIym8
ARC-Seal: i=1; a=rsa-sha256; t=1518806395; cv=none;
        d=google.com; s=arc-20160816;
        b=cD5hTtmNkmL8o2XrEQ49e4s5tretaWnfcUTGP2KDv4jQFAR8PH3ZuyduWNEef7OVIj
         xxU6+HHkbl7G2SrRqHboQoCNXT3K3TXcJ0L8or9dCbrwTN0xnXgTsXsegnL7tUMn8TV/
         TtFV7NyypkNoIpxbAOhM5tKML0rqVZV36b1h77/qWYo6ULtOWC9AgdY3z4h4a051NMVz
         adD7fZH7ALZLK4r/11loDv5qXoB982JTfuQTKUfB4vfgj6A9gTrT7OhzZtSb22Gra5aR
         nqrJgBLDGL3mAvDtxWNl3eenYGRrggsljCBul87JNPbyMzZ4oJ1R71lS369X0YZ45rxC
         7rQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=EiehZoLPDaIFPIKHmPipZDDhu3qP0WJWAhF2I/M1qZI=;
        b=vzgT5jRLaKo8XnBT0Vgyv63lUMu2zlnQfqEBI/Jfqjk6d1IpS1Kc9M09dwYhIaeEVt
         Fw/jaR7YzWS1FC2JIqCJFjxtUAYwPFqq0w6noO3vVc8amQ/qHokfpBwFNmLAfWGhXzo6
         r+q/VBYwjgPw6AAHU6WOY+doUpAJ39FL15u+C7YpEwxcXnBF3kE/34qnIVnRf01BA+dU
         zunttfaOaGEHryfng9mofYpeGH1xuXVjhOmXjFToFl6wnQuxUUIaIvzTehjRvKqWKvmx
         m6H8/IwM3OGIkjZOjL7P2LONXp5OXYL9hvmd1CjctE0VVa2Gs0WqfHiwXrJJe+J6j01H
         FUdQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=juhLG5ru;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=juhLG5ru;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w1GIdBTH013418
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
Subject: [PATCH 14/23] kconfig: show compiler version text in the top comment
Date: Sat, 17 Feb 2018 03:38:42 +0900
Message-Id: <1518806331-7101-15-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583935408194961?=
X-GMAIL-MSGID: =?utf-8?q?1592583935408194961?=
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

This commit has a very important meaning.  If the compile is upgraded,
Kconfig must be re-run since different compilers have different sets
of supported options.

All referenced environments are written to include/config/auto.conf.cmd
so that any environment change triggers silentoldconfig, and prompt
the user to input new values if needed.

With this commit, something like follows will be added to
include/config/auto.conf.cmd

  ifneq "$(CC_VERSION_TEXT)" "aarch64-linux-gnu-gcc (Linaro GCC 7.2-2017.11) 7.2.1 20171011"
  include/config/auto.conf: FORCE
  endif

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

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
index 6491404..b8df04b 100644
--- a/Makefile
+++ b/Makefile
@@ -438,6 +438,8 @@ export KBUILD_AFLAGS_MODULE KBUILD_CFLAGS_MODULE KBUILD_LDFLAGS_MODULE
 export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL
 export KBUILD_ARFLAGS
 
+export CC_VERSION_TEXT := $(shell $(CC) --version | head -n 1)
+
 # When compiling out-of-tree modules, put MODVERDIR in the module
 # tree rather than in the kernel tree. The kernel tree might
 # even be read-only.
-- 
2.7.4
