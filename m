Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752510AbeEPFvk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 01:51:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:52029 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751389AbeEPFvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 01:51:38 -0400
From: Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH] Makefile: disable PIE before testing asm goto
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andreas Faerber <afaerber@suse.com>
Message-Id: <20180516055136.6F4EAA095A@unicorn.suse.cz>
Date: Wed, 16 May 2018 07:51:36 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit e501ce957a78 ("x86: Force asm-goto"), aarch64 build on
distributions which enable PIE by default (e.g. openSUSE Tumbleweed) does
not detect support for asm goto correctly. The problem is that ARM specific
part of scripts/gcc-goto.sh fails with PIE even with recent gcc versions.
Moving the asm goto detection up in Makefile put it before the place where
we disable PIE. As a result, kernel is built without jump label support.

Move the lines disabling PIE before the asm goto test to make it work.

Fixes: e501ce957a78 ("x86: Force asm-goto")
Reported-by: Andreas Faerber <afaerber@suse.com>
Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index ba3106b36597..5532a15c4781 100644
--- a/Makefile
+++ b/Makefile
@@ -500,6 +500,9 @@ RETPOLINE_CFLAGS_CLANG := -mretpoline-external-thunk
 RETPOLINE_CFLAGS := $(call cc-option,$(RETPOLINE_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_CFLAGS_CLANG)))
 export RETPOLINE_CFLAGS
 
+KBUILD_CFLAGS	+= $(call cc-option,-fno-PIE)
+KBUILD_AFLAGS	+= $(call cc-option,-fno-PIE)
+
 # check for 'asm goto'
 ifeq ($(call shell-cached,$(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(CC) $(KBUILD_CFLAGS)), y)
   CC_HAVE_ASM_GOTO := 1
@@ -621,8 +624,6 @@ endif # $(dot-config)
 # Defaults to vmlinux, but the arch makefile usually adds further targets
 all: vmlinux
 
-KBUILD_CFLAGS	+= $(call cc-option,-fno-PIE)
-KBUILD_AFLAGS	+= $(call cc-option,-fno-PIE)
 CFLAGS_GCOV	:= -fprofile-arcs -ftest-coverage -fno-tree-loop-im $(call cc-disable-warning,maybe-uninitialized,)
 export CFLAGS_GCOV CFLAGS_KCOV
 
-- 
2.16.3
