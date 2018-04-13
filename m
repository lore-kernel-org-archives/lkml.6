Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753584AbeDMFJ1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 01:09:27 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:56558 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753296AbeDMFJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 01:09:24 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w3D56lgO029209
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 30/30] kbuild: test dead code/data elimination support in Kconfig
Date: Fri, 13 Apr 2018 14:06:39 +0900
Message-Id: <1523595999-27433-31-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This config option should be enabled only when both the compiler and
the linker support necessary flags.  Add proper dependencies to Kconfig.

Unlike 'select', 'imply' is modest enough to observe those dependencies.
I suggested this in the help message.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2: None

 Makefile     | 8 ++------
 arch/Kconfig | 4 +++-
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 88733b7..92db767 100644
--- a/Makefile
+++ b/Makefile
@@ -754,8 +754,8 @@ KBUILD_CFLAGS += $(call cc-option, -fno-inline-functions-called-once)
 endif
 
 ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
-KBUILD_CFLAGS	+= $(call cc-option,-ffunction-sections,)
-KBUILD_CFLAGS	+= $(call cc-option,-fdata-sections,)
+KBUILD_CFLAGS	+= -ffunction-sections -fdata-sections
+LDFLAGS_vmlinux	+= --gc-sections
 endif
 
 # arch Makefile may override CC so keep this after arch Makefile is included
@@ -819,10 +819,6 @@ LDFLAGS_BUILD_ID := $(call ld-option, --build-id)
 KBUILD_LDFLAGS_MODULE += $(LDFLAGS_BUILD_ID)
 LDFLAGS_vmlinux += $(LDFLAGS_BUILD_ID)
 
-ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
-LDFLAGS_vmlinux	+= $(call ld-option, --gc-sections,)
-endif
-
 ifeq ($(CONFIG_STRIP_ASM_SYMS),y)
 LDFLAGS_vmlinux	+= $(call ld-option, -X,)
 endif
diff --git a/arch/Kconfig b/arch/Kconfig
index 95b9b2e..e88f1ba 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -597,8 +597,10 @@ config CC_STACKPROTECTOR_STRONG
 
 config LD_DEAD_CODE_DATA_ELIMINATION
 	bool
+	depends on $(cc-option -ffunction-sections -fdata-sections)
+	depends on $(ld-option --gc-sections)
 	help
-	  Select this if the architecture wants to do dead code and
+	  Imply this if the architecture wants to do dead code and
 	  data elimination with the linker by compiling with
 	  -ffunction-sections -fdata-sections and linking with
 	  --gc-sections.
-- 
2.7.4
