Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E17C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66892145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="FVMM3bva"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388164AbeLQQWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:22:24 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:28169 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbeLQQWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:22:23 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id wBHG3bRm008119;
        Tue, 18 Dec 2018 01:03:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com wBHG3bRm008119
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545062633;
        bh=aE8w1NqgjkmgVSBM/qyCPbbjO7TRIj12O6ZaY8+0nvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FVMM3bvablEfwC9sMJh0fK94pVwA5UoONl7LYqmkjBBy6mBnYx4klFaiV7vgKjIw5
         H7QP+rNCMFJmeTQlyhy1irDQ223b0QdzkxusGECKA3izCOAvT9eXo4M4wioFAzeG5L
         HUh3fDSf1PJ+FBkiYBEDWIEjSFFNiMH+y32WUiSmx2nx/pJqGJMNUCsVduWRMUBOmr
         72tr/dNyUEycSwFFBJKPqijE0dd0c83ofWnv89dJ1E2N4p4Fi1/5NBTHusapt0OBX0
         Cn8jS010tzWT4wBiF8pVMbtQ6zLXS/21m1XMYOCLtMLg3ZeBnzYgUyCwmGma0eeKPZ
         f4zPjvk9n8O3Q==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Richard Biener <rguenther@suse.de>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Nadav Amit <namit@vmware.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH v3 09/12] Revert "kbuild/Makefile: Prepare for using macros in inline assembly code to work around asm() related GCC inlining bugs"
Date:   Tue, 18 Dec 2018 01:03:24 +0900
Message-Id: <1545062607-8599-10-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
References: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 77b0bf55bc675233d22cd5df97605d516d64525e.

A few days after the patch set applied, discussion started to solve
the issue more elegantly with the help of compiler:

  https://lkml.org/lkml/2018/10/7/92

The new syntax "asm inline" was implemented by Segher Boessenkool, and
now queued up for GCC 9. (People were positive even for back-porting it
to older compilers).

Since the in-kernel workarounds merged, some issues have been reported.
The current urgent issue is distro packages for module building. More
fundamentally, we cannot build external modules after 'make clean'
because *.s files are globally removed.

We could fix those in Makefiles, but I do not want to mess up the build
system any more.

Given that this issue will be solved in a cleaner way sooner or later,
let's revert the in-kernel workarounds, and wait for GCC 9.

Link: https://lkml.org/lkml/2018/11/15/467
Link: https://marc.info/?t=154212770600037&r=1&w=2
Reported-by: Sedat Dilek <sedat.dilek@gmail.com> # deb/rpm package
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Nadav Amit <namit@vmware.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
---


 Makefile                 | 9 ++-------
 arch/x86/Makefile        | 7 -------
 arch/x86/kernel/macros.S | 7 -------
 scripts/Kbuild.include   | 4 +---
 scripts/mod/Makefile     | 2 --
 5 files changed, 3 insertions(+), 26 deletions(-)
 delete mode 100644 arch/x86/kernel/macros.S

diff --git a/Makefile b/Makefile
index 56d5270..885c74b 100644
--- a/Makefile
+++ b/Makefile
@@ -1081,7 +1081,7 @@ scripts: scripts_basic scripts_dtc asm-generic gcc-plugins $(autoksyms_h)
 # version.h and scripts_basic is processed / created.
 
 # Listed in dependency order
-PHONY += prepare archprepare macroprepare prepare0 prepare1 prepare2 prepare3
+PHONY += prepare archprepare prepare0 prepare1 prepare2 prepare3
 
 # prepare3 is used to check if we are building in a separate output directory,
 # and if so do:
@@ -1104,9 +1104,7 @@ prepare2: prepare3 outputmakefile asm-generic
 prepare1: prepare2 $(version_h) $(autoksyms_h) include/generated/utsrelease.h
 	$(cmd_crmodverdir)
 
-macroprepare: prepare1 archmacros
-
-archprepare: archheaders archscripts macroprepare scripts_basic
+archprepare: archheaders archscripts prepare1 scripts_basic
 
 prepare0: archprepare gcc-plugins
 	$(Q)$(MAKE) $(build)=.
@@ -1174,9 +1172,6 @@ archheaders:
 PHONY += archscripts
 archscripts:
 
-PHONY += archmacros
-archmacros:
-
 PHONY += __headers
 __headers: $(version_h) scripts_basic uapi-asm-generic archheaders archscripts
 	$(Q)$(MAKE) $(build)=scripts build_unifdef
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 75ef499..85a66c4 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -232,13 +232,6 @@ archscripts: scripts_basic
 archheaders:
 	$(Q)$(MAKE) $(build)=arch/x86/entry/syscalls all
 
-archmacros:
-	$(Q)$(MAKE) $(build)=arch/x86/kernel arch/x86/kernel/macros.s
-
-ASM_MACRO_FLAGS = -Wa,arch/x86/kernel/macros.s
-export ASM_MACRO_FLAGS
-KBUILD_CFLAGS += $(ASM_MACRO_FLAGS)
-
 ###
 # Kernel objects
 
diff --git a/arch/x86/kernel/macros.S b/arch/x86/kernel/macros.S
deleted file mode 100644
index cfc1c7d..0000000
--- a/arch/x86/kernel/macros.S
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-/*
- * This file includes headers whose assembly part includes macros which are
- * commonly used. The macros are precompiled into assmebly file which is later
- * assembled together with each compiled file.
- */
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index bb01555..3d09844 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -115,9 +115,7 @@ __cc-option = $(call try-run,\
 
 # Do not attempt to build with gcc plugins during cc-option tests.
 # (And this uses delayed resolution so the flags will be up to date.)
-# In addition, do not include the asm macros which are built later.
-CC_OPTION_FILTERED = $(GCC_PLUGINS_CFLAGS) $(ASM_MACRO_FLAGS)
-CC_OPTION_CFLAGS = $(filter-out $(CC_OPTION_FILTERED),$(KBUILD_CFLAGS))
+CC_OPTION_CFLAGS = $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS))
 
 # cc-option
 # Usage: cflags-y += $(call cc-option,-march=winchip-c6,-march=i586)
diff --git a/scripts/mod/Makefile b/scripts/mod/Makefile
index a5b4af4..42c5d50 100644
--- a/scripts/mod/Makefile
+++ b/scripts/mod/Makefile
@@ -4,8 +4,6 @@ OBJECT_FILES_NON_STANDARD := y
 hostprogs-y	:= modpost mk_elfconfig
 always		:= $(hostprogs-y) empty.o
 
-CFLAGS_REMOVE_empty.o := $(ASM_MACRO_FLAGS)
-
 modpost-objs	:= modpost.o file2alias.o sumversion.o
 
 devicetable-offsets-file := devicetable-offsets.h
-- 
2.7.4

