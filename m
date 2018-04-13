Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753679AbeDMFNs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 01:13:48 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:54503 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751041AbeDMFIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 01:08:16 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w3D56lgD029209
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 19/30] kconfig: show compiler version text in the top comment
Date: Fri, 13 Apr 2018 14:06:28 +0900
Message-Id: <1523595999-27433-20-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

This is simply implemented by using the 'comment' statement.  So, it
will be saved into the .config file as well.

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
Reviewed-by: Kees Cook <keescook@chromium.org>
---

Changes in v3: None
Changes in v2: None

 Kconfig  | 2 ++
 Makefile | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Kconfig b/Kconfig
index 4af1b42..5b55d87 100644
--- a/Kconfig
+++ b/Kconfig
@@ -5,4 +5,6 @@
 #
 mainmenu "Linux/$(ARCH) $(KERNELVERSION) Kernel Configuration"
 
+comment "Compiler: $(CC_VERSION_TEXT)"
+
 source "arch/$(SRCARCH)/Kconfig"
diff --git a/Makefile b/Makefile
index ca3e3e8..4b36329 100644
--- a/Makefile
+++ b/Makefile
@@ -442,6 +442,8 @@ export KBUILD_AFLAGS_MODULE KBUILD_CFLAGS_MODULE KBUILD_LDFLAGS_MODULE
 export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL
 export KBUILD_ARFLAGS
 
+export CC_VERSION_TEXT := $(shell $(CC) --version | head -n 1)
+
 # When compiling out-of-tree modules, put MODVERDIR in the module
 # tree rather than in the kernel tree. The kernel tree might
 # even be read-only.
-- 
2.7.4
