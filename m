Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F51CC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5000920652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5000920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbeJDQ4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:56:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50751 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbeJDQ4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:56:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w94A1T5g2701311
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 4 Oct 2018 03:01:29 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w94A1Tj82701308;
        Thu, 4 Oct 2018 03:01:29 -0700
Date:   Thu, 4 Oct 2018 03:01:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nadav Amit <tipbot@zytor.com>
Message-ID: <tip-77b0bf55bc675233d22cd5df97605d516d64525e@git.kernel.org>
Cc:     luto@amacapital.net, linux-kernel@vger.kernel.org,
        sam@ravnborg.org, mingo@kernel.org, yamada.masahiro@socionext.com,
        tglx@linutronix.de, namit@vmware.com, michal.lkml@markovi.net,
        brgerst@gmail.com, hpa@zytor.com, keescook@chromium.org,
        peterz@infradead.org, dvlasenk@redhat.com,
        torvalds@linux-foundation.org, bp@alien8.de
Reply-To: peterz@infradead.org, bp@alien8.de, dvlasenk@redhat.com,
          torvalds@linux-foundation.org, keescook@chromium.org,
          hpa@zytor.com, namit@vmware.com, brgerst@gmail.com,
          michal.lkml@markovi.net, mingo@kernel.org, sam@ravnborg.org,
          luto@amacapital.net, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, yamada.masahiro@socionext.com
In-Reply-To: <20181003213100.189959-3-namit@vmware.com>
References: <20181003213100.189959-3-namit@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/build] kbuild/Makefile: Prepare for using macros in inline
 assembly code to work around asm() related GCC inlining bugs
Git-Commit-ID: 77b0bf55bc675233d22cd5df97605d516d64525e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  77b0bf55bc675233d22cd5df97605d516d64525e
Gitweb:     https://git.kernel.org/tip/77b0bf55bc675233d22cd5df97605d516d64525e
Author:     Nadav Amit <namit@vmware.com>
AuthorDate: Wed, 3 Oct 2018 14:30:52 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 4 Oct 2018 10:57:09 +0200

kbuild/Makefile: Prepare for using macros in inline assembly code to work around asm() related GCC inlining bugs

Using macros in inline assembly allows us to work around bugs
in GCC's inlining decisions.

Compile macros.S and use it to assemble all C files.
Currently only x86 will use it.

Background:

The inlining pass of GCC doesn't include an assembler, so it's not aware
of basic properties of the generated code, such as its size in bytes,
or that there are such things as discontiuous blocks of code and data
due to the newfangled linker feature called 'sections' ...

Instead GCC uses a lazy and fragile heuristic: it does a linear count of
certain syntactic and whitespace elements in inlined assembly block source
code, such as a count of new-lines and semicolons (!), as a poor substitute
for "code size and complexity".

Unsurprisingly this heuristic falls over and breaks its neck whith certain
common types of kernel code that use inline assembly, such as the frequent
practice of putting useful information into alternative sections.

As a result of this fresh, 20+ years old GCC bug, GCC's inlining decisions
are effectively disabled for inlined functions that make use of such asm()
blocks, because GCC thinks those sections of code are "large" - when in
reality they are often result in just a very low number of machine
instructions.

This absolute lack of inlining provess when GCC comes across such asm()
blocks both increases generated kernel code size and causes performance
overhead, which is particularly noticeable on paravirt kernels, which make
frequent use of these inlining facilities in attempt to stay out of the
way when running on baremetal hardware.

Instead of fixing the compiler we use a workaround: we set an assembly macro
and call it from the inlined assembly block. As a result GCC considers the
inline assembly block as a single instruction. (Which it often isn't but I digress.)

This uglifies and bloats the source code - for example just the refcount
related changes have this impact:

 Makefile                 |    9 +++++++--
 arch/x86/Makefile        |    7 +++++++
 arch/x86/kernel/macros.S |    7 +++++++
 scripts/Kbuild.include   |    4 +++-
 scripts/mod/Makefile     |    2 ++
 5 files changed, 26 insertions(+), 3 deletions(-)

Yay readability and maintainability, it's not like assembly code is hard to read
and maintain ...

We also hope that GCC will eventually get fixed, but we are not holding
our breath for that. Yet we are optimistic, it might still happen, any decade now.

[ mingo: Wrote new changelog describing the background. ]

Tested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kbuild@vger.kernel.org
Link: http://lkml.kernel.org/r/20181003213100.189959-3-namit@vmware.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Makefile                 | 9 +++++++--
 arch/x86/Makefile        | 7 +++++++
 arch/x86/kernel/macros.S | 7 +++++++
 scripts/Kbuild.include   | 4 +++-
 scripts/mod/Makefile     | 2 ++
 5 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 6c3da3e10f07..6c40d547513c 100644
--- a/Makefile
+++ b/Makefile
@@ -1071,7 +1071,7 @@ scripts: scripts_basic asm-generic gcc-plugins $(autoksyms_h)
 # version.h and scripts_basic is processed / created.
 
 # Listed in dependency order
-PHONY += prepare archprepare prepare0 prepare1 prepare2 prepare3
+PHONY += prepare archprepare macroprepare prepare0 prepare1 prepare2 prepare3
 
 # prepare3 is used to check if we are building in a separate output directory,
 # and if so do:
@@ -1094,7 +1094,9 @@ prepare2: prepare3 outputmakefile asm-generic
 prepare1: prepare2 $(version_h) $(autoksyms_h) include/generated/utsrelease.h
 	$(cmd_crmodverdir)
 
-archprepare: archheaders archscripts prepare1 scripts_basic
+macroprepare: prepare1 archmacros
+
+archprepare: archheaders archscripts macroprepare scripts_basic
 
 prepare0: archprepare gcc-plugins
 	$(Q)$(MAKE) $(build)=.
@@ -1162,6 +1164,9 @@ archheaders:
 PHONY += archscripts
 archscripts:
 
+PHONY += archmacros
+archmacros:
+
 PHONY += __headers
 __headers: $(version_h) scripts_basic uapi-asm-generic archheaders archscripts
 	$(Q)$(MAKE) $(build)=scripts build_unifdef
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 0e496ed476d4..5b562e464009 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -236,6 +236,13 @@ archscripts: scripts_basic
 archheaders:
 	$(Q)$(MAKE) $(build)=arch/x86/entry/syscalls all
 
+archmacros:
+	$(Q)$(MAKE) $(build)=arch/x86/kernel arch/x86/kernel/macros.s
+
+ASM_MACRO_FLAGS = -Wa,arch/x86/kernel/macros.s -Wa,-
+export ASM_MACRO_FLAGS
+KBUILD_CFLAGS += $(ASM_MACRO_FLAGS)
+
 ###
 # Kernel objects
 
diff --git a/arch/x86/kernel/macros.S b/arch/x86/kernel/macros.S
new file mode 100644
index 000000000000..cfc1c7d1a6eb
--- /dev/null
+++ b/arch/x86/kernel/macros.S
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * This file includes headers whose assembly part includes macros which are
+ * commonly used. The macros are precompiled into assmebly file which is later
+ * assembled together with each compiled file.
+ */
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index ce53639a864a..8aeb60eb6ee3 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -115,7 +115,9 @@ __cc-option = $(call try-run,\
 
 # Do not attempt to build with gcc plugins during cc-option tests.
 # (And this uses delayed resolution so the flags will be up to date.)
-CC_OPTION_CFLAGS = $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS))
+# In addition, do not include the asm macros which are built later.
+CC_OPTION_FILTERED = $(GCC_PLUGINS_CFLAGS) $(ASM_MACRO_FLAGS)
+CC_OPTION_CFLAGS = $(filter-out $(CC_OPTION_FILTERED),$(KBUILD_CFLAGS))
 
 # cc-option
 # Usage: cflags-y += $(call cc-option,-march=winchip-c6,-march=i586)
diff --git a/scripts/mod/Makefile b/scripts/mod/Makefile
index 42c5d50f2bcc..a5b4af47987a 100644
--- a/scripts/mod/Makefile
+++ b/scripts/mod/Makefile
@@ -4,6 +4,8 @@ OBJECT_FILES_NON_STANDARD := y
 hostprogs-y	:= modpost mk_elfconfig
 always		:= $(hostprogs-y) empty.o
 
+CFLAGS_REMOVE_empty.o := $(ASM_MACRO_FLAGS)
+
 modpost-objs	:= modpost.o file2alias.o sumversion.o
 
 devicetable-offsets-file := devicetable-offsets.h
