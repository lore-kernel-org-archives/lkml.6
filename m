Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752577AbeCTKBT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 06:01:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58127 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752270AbeCTKBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 06:01:16 -0400
Date: Tue, 20 Mar 2018 03:00:47 -0700
From: tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-e501ce957a786ecd076ea0cfb10b114e6e4d0f40@git.kernel.org>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, mingo@kernel.org
Reply-To: mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20180319201327.GJ4043@hirez.programming.kicks-ass.net>
References: <20180319201327.GJ4043@hirez.programming.kicks-ass.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/build] x86: Force asm-goto
Git-Commit-ID: e501ce957a786ecd076ea0cfb10b114e6e4d0f40
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e501ce957a786ecd076ea0cfb10b114e6e4d0f40
Gitweb:     https://git.kernel.org/tip/e501ce957a786ecd076ea0cfb10b114e6e4d0f40
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Wed, 17 Jan 2018 11:42:07 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 20 Mar 2018 10:58:02 +0100

x86: Force asm-goto

We want to start using asm-goto to guarantee the absence of dynamic
branches (and thus speculation).

A primary prerequisite for this is of course that the compiler
supports asm-goto. This effecively lifts the minimum GCC version to
build an x86 kernel to gcc-4.5.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: torvalds@linux-foundation.org
Link: https://lkml.kernel.org/r/20180319201327.GJ4043@hirez.programming.kicks-ass.net
---
 Makefile          | 13 +++++++------
 arch/x86/Makefile |  4 ++++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index d65e2e229017..6fb6fd28a124 100644
--- a/Makefile
+++ b/Makefile
@@ -494,6 +494,13 @@ RETPOLINE_CFLAGS_CLANG := -mretpoline-external-thunk
 RETPOLINE_CFLAGS := $(call cc-option,$(RETPOLINE_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_CFLAGS_CLANG)))
 export RETPOLINE_CFLAGS
 
+# check for 'asm goto'
+ifeq ($(call shell-cached,$(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(CC) $(KBUILD_CFLAGS)), y)
+  CC_HAVE_ASM_GOTO := 1
+  KBUILD_CFLAGS += -DCC_HAVE_ASM_GOTO
+  KBUILD_AFLAGS += -DCC_HAVE_ASM_GOTO
+endif
+
 ifeq ($(config-targets),1)
 # ===========================================================================
 # *config targets only - make sure prerequisites are updated, and descend
@@ -658,12 +665,6 @@ KBUILD_CFLAGS += $(call cc-ifversion, -lt, 0409, \
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
 
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 498c1b812300..d798e36d103c 100644
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
