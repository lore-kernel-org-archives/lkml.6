Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753872AbeDMFKi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 01:10:38 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:55144 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752849AbeDMFIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 01:08:37 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w3D56lgK029209
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 26/30] gcc-plugins: move GCC version check for PowerPC to Kconfig
Date: Fri, 13 Apr 2018 14:06:35 +0900
Message-Id: <1523595999-27433-27-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For PowerPC, GCC 5.2 is the requirement for GCC plugins.  Move the
version check to Kconfig so that the GCC plugin menus will be hidden
if an older compiler is in use.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---

Changes in v3:
  - Move comment to Kconfig as well

Changes in v2: None

 arch/powerpc/Kconfig         | 2 +-
 scripts/Makefile.gcc-plugins | 8 --------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 73ce5dd..512fcc1 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -195,7 +195,7 @@ config PPC
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
-	select HAVE_GCC_PLUGINS
+	select HAVE_GCC_PLUGINS			if GCC_VERSION >= 50200   # plugin support on gcc <= 5.1 is buggy on PPC
 	select HAVE_GENERIC_GUP
 	select HAVE_HW_BREAKPOINT		if PERF_EVENTS && (PPC_BOOK3S || PPC_8xx)
 	select HAVE_IDE
diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index 0ce3802..1e92353 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -53,14 +53,6 @@ gcc-plugins-check: FORCE
 ifdef CONFIG_GCC_PLUGINS
   ifeq ($(PLUGINCC),)
     ifneq ($(GCC_PLUGINS_CFLAGS),)
-      # Various gccs between 4.5 and 5.1 have bugs on powerpc due to missing
-      # header files. gcc <= 4.6 doesn't work at all, gccs from 4.8 to 5.1 have
-      # issues with 64-bit targets.
-      ifeq ($(ARCH),powerpc)
-        ifeq ($(call cc-ifversion, -le, 0501, y), y)
-	  @echo "Cannot use CONFIG_GCC_PLUGINS: plugin support on gcc <= 5.1 is buggy on powerpc, please upgrade to gcc 5.2 or newer" >&2 && exit 1
-        endif
-      endif
       ifeq ($(call cc-ifversion, -ge, 0405, y), y)
 	$(Q)$(srctree)/scripts/gcc-plugin.sh --show-error "$(__PLUGINCC)" "$(HOSTCXX)" "$(CC)" || true
 	@echo "Cannot use CONFIG_GCC_PLUGINS: your gcc installation does not support plugins, perhaps the necessary headers are missing?" >&2 && exit 1
-- 
2.7.4
