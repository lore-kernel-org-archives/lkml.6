Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x226oECv0X81yD0ciPGvebKCDZJGtvzZXaGdH/VccY4n/o/JL/EqDxG+ZUiLJFPe+9mjrKX0F
ARC-Seal: i=1; a=rsa-sha256; t=1518106812; cv=none;
        d=google.com; s=arc-20160816;
        b=WH6AoqRk/lML8CzUbLtJ3188CuvrSi8bg/sNiXXediyoL3ZYl1qeTHKnIM1UHGRA6p
         3mvZE9ZO5Re8XelFCigBr01HN2NkZf0ndvLf91lgdIMMx84Z5N2Z5Qf/S7c7pg05H9N3
         ZP4skrHbt//WYUz2yju/E6a3v0nQhtW99bQV/O7ZOTU9CDL3RU+cxVx/OE0Ks731UrnB
         fJBsOjELeWJmTr3X1mAFIfA8luiw6BtqEgelg/q3YgbgeHNERgvidSDYUO0SPvAjw57E
         7t/BlkXY21Rj7/usaOyKU2j6/zrbFDSwTO4xeepAGKk5nRxICDXd5Sroblqz2fk5Xcgm
         3geg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=/g1y1Iw1M86dfdHAksqnjpCIIERRxDGzTanKycUqsIw=;
        b=PYqHK4VrKxkY/yCtLCDH6YNZ1/RQlm6N3ylhte20cJHj2gQbEgVSKbDT1E8wLVTq+m
         Y9I0OPob6tPPQq541rRwau3xTAN/MyMuqh6H+Yfe81cbI8ly4WWW98ZSRldWigBDoW5a
         D11R0ANy998n5ffCJPFuUiNKmZ1awV+QfrkUBvYW3Enc42GGxoQHfQomXwKDfh8G8A2n
         IssReX3hX1084F5nN54HouwWnKfXo5JYG6JaC+gJ8SnmUZirDEOaBcPVkGes/YWChfPE
         8bCdQ84bN6Gj3x/Iv8848wr8cgDLrcJzyKbgWYh9kk3f6RfVJavnxoMHACYNbyIbq/LF
         hWyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=zcIAyvom;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.79 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=zcIAyvom;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.79 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w18GJP1H021191
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Pavel Machek <pavel@ucw.cz>, linux-s390@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/7] kconfig: invoke silentoldconfig when compiler is updated
Date: Fri,  9 Feb 2018 01:19:10 +0900
Message-Id: <1518106752-29228-6-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
References: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368907801402?=
X-GMAIL-MSGID: =?utf-8?q?1591850368907801402?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Moving compiler option tests to Kconfig means you need to re-run
Kconfig when you update your compiler.  All CC_HAS_... symbols
and other symbols that depend on them must be re-calculated.

It will be nice to detect the compiler update and automatically
invoke silentoldconfig.

This can be done by adding one environment.  With this, silentoldconfig
will add something like follows into include/config/auto.conf.cmd:

ifneq "$(CC_VERSION_TEXT)" "gcc (Ubuntu 5.4.0-6ubuntu1~16.04.6) 5.4.0 20160609"
include/config/auto.conf: FORCE
endif

CC_VERSION_TEXT contains the first line of "$(CC) --version".  If this text
is changed, silentoldconfig will be invoked.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile     | 2 ++
 init/Kconfig | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/Makefile b/Makefile
index 2ee49c9..9afd617 100644
--- a/Makefile
+++ b/Makefile
@@ -441,6 +441,8 @@ export KBUILD_AFLAGS_MODULE KBUILD_CFLAGS_MODULE KBUILD_LDFLAGS_MODULE
 export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL
 export KBUILD_ARFLAGS
 
+export CC_VERSION_TEXT := $(shell $(CC) --version | head -n 1)
+
 # When compiling out-of-tree modules, put MODVERDIR in the module
 # tree rather than in the kernel tree. The kernel tree might
 # even be read-only.
diff --git a/init/Kconfig b/init/Kconfig
index e37f4b2..64f9dd2 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -16,6 +16,15 @@ config DEFCONFIG_LIST
 	default "$ARCH_DEFCONFIG"
 	default "arch/$ARCH/defconfig"
 
+# CC_VERSION_TEXT is needed here to invoke Kconfig when compiler is updated
+config CC_VERSION_TEXT
+	string
+	option env="CC_VERSION_TEXT"
+	help
+	  This is used to detect if the compiler is changed. If the version
+	  text does not match, silentoldconfig will be invoked because we need
+	  to re-compute compiler capabilities and symbols that depends on them.
+
 config CONSTRUCTORS
 	bool
 	depends on !UML
-- 
2.7.4
