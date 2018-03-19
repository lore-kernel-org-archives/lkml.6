Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936682AbeCSWdW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 18:33:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50880 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933449AbeCSPsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:05 -0400
Message-Id: <20180319154717.652679334@infradead.org>
User-Agent: quilt/0.63-1
Date: Mon, 19 Mar 2018 16:41:25 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 1/2] x86: Force asm-goto
References: <20180319154124.337947038@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-x86-force-asm-goto.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to start using asm-goto to guarantee the absence of dynamic
branches (and thus speculation).

A primary prerequisite for this is of course that the compiler
supports asm-goto. This effecively lifts the minimum GCC version to
build an x86 kernel to gcc-4.5.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 Makefile          |   13 +++++++------
 arch/x86/Makefile |    4 ++++
 2 files changed, 11 insertions(+), 6 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -494,6 +494,13 @@ RETPOLINE_CFLAGS_CLANG := -mretpoline-ex
 RETPOLINE_CFLAGS := $(call cc-option,$(RETPOLINE_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_CFLAGS_CLANG)))
 export RETPOLINE_CFLAGS
 
+# check for 'asm goto'
+ifeq ($(shell $(srctree)/scripts/gcc-goto.sh $(CC) $(KBUILD_CFLAGS)), y)
+  CC_HAVE_ASM_GOTO := 1
+  KBUILD_CFLAGS += -DCC_HAVE_ASM_GOTO
+  KBUILD_AFLAGS += -DCC_HAVE_ASM_GOTO
+endif
+
 ifeq ($(config-targets),1)
 # ===========================================================================
 # *config targets only - make sure prerequisites are updated, and descend
@@ -658,12 +665,6 @@ KBUILD_CFLAGS += $(call cc-ifversion, -l
 # Tell gcc to never replace conditional load with a non-conditional one
 KBUILD_CFLAGS	+= $(call cc-option,--param=allow-store-data-races=0)
 
-# check for 'asm goto'
-ifeq ($(call shell-cached,$(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(CC) $(KBUILD_CFLAGS)), y)
-	KBUILD_CFLAGS += -DCC_HAVE_ASM_GOTO
-	KBUILD_AFLAGS += -DCC_HAVE_ASM_GOTO
-endif
-
 include scripts/Makefile.kcov
 include scripts/Makefile.gcc-plugins
 
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -181,6 +181,10 @@ ifdef CONFIG_FUNCTION_GRAPH_TRACER
   endif
 endif
 
+ifndef CC_HAVE_ASM_GOTO
+  $(error Compiler lacks asm-goto support.)
+endif
+
 #
 # Jump labels need '-maccumulate-outgoing-args' for gcc < 4.5.2 to prevent a
 # GCC bug (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=46226).  There's no way
