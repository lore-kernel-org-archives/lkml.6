Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CA5C5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D122086E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="KGBjRQKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D122086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933304AbeGJBgu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 21:36:50 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:30112 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754580AbeGJBgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 21:36:43 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w6A1ZWJu027668;
        Tue, 10 Jul 2018 10:35:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w6A1ZWJu027668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531186533;
        bh=jnGQr9wGQbDJeGs5a28ylyB4ALcWW0obUjiDpiiJCT0=;
        h=From:To:Cc:Subject:Date:From;
        b=KGBjRQKu/iLrQPlqe1d1cD5Exsnc8r8yUYZiVa51edOpN6ZIJJiBHF19A0PpEDzPf
         +IofkOjAaGsNgYoRLkoxXaejC2b/GPaF7i2PjN8TK5LxMHkeCBXcL5F8m+zNfR2lc0
         7kuqLXPltjedS+pQJI5zYEZYi6SH5dAGdG3UDoTch9qy5gtwmGnFGmOIpnMIoRG+tV
         1lcypGlLDZ+s/aUSMbOiMjVlhF2TRSjq8exKvJ6ZUgaUtAUwaFLYi072rwU0p4Evx/
         h3Fj7poYLSqtM6fODMGl4GHxznN15SJ1yN4bLT7AZPqKsuFR+IcwH9j7RbdGujz5ev
         5WYsPUJD4NhXg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH v2] objtool: move libelf detection to Kconfig from Makefile
Date:   Tue, 10 Jul 2018 10:35:16 +0900
Message-Id: <1531186516-15764-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, users are allowed to enable STACK_VALIDATION regardless
of the compiler capability.  The top-level Makefile warns or breaks
the build if it turns out that the host compiler cannot link libelf.

Move the libelf test to Kconfig so that users can enable the feature
only when the host compiler can build the objtool.  The ugly check
in the Makefile will go away.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---

Changes in v2:
  - Move package information to help of STACK_VALIDATION

 Makefile               | 14 +-------------
 arch/x86/Kconfig       |  2 +-
 arch/x86/Kconfig.debug |  2 +-
 lib/Kconfig.debug      |  6 +++++-
 scripts/Makefile.build |  2 --
 5 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/Makefile b/Makefile
index 925c55f..65befa0 100644
--- a/Makefile
+++ b/Makefile
@@ -927,19 +927,7 @@ endif
 export mod_sign_cmd
 
 ifdef CONFIG_STACK_VALIDATION
-  has_libelf := $(call try-run,\
-		echo "int main() {}" | $(HOSTCC) -xc -o /dev/null -lelf -,1,0)
-  ifeq ($(has_libelf),1)
-    objtool_target := tools/objtool FORCE
-  else
-    ifdef CONFIG_UNWINDER_ORC
-      $(error "Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel")
-    else
-      $(warning "Cannot use CONFIG_STACK_VALIDATION=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel")
-    endif
-    SKIP_STACK_VALIDATION := 1
-    export SKIP_STACK_VALIDATION
-  endif
+    objtool_target := tools/objtool
 endif
 
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f1dbb4e..c1ded99 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -434,7 +434,7 @@ config GOLDFISH
 config RETPOLINE
 	bool "Avoid speculative indirect branches in kernel"
 	default y
-	select STACK_VALIDATION if HAVE_STACK_VALIDATION
+	imply STACK_VALIDATION
 	help
 	  Compile kernel with the retpoline compiler options to guard against
 	  kernel-to-user data leaks by avoiding speculative indirect
diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index c6dd1d9..4713b3c 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -364,7 +364,7 @@ choice
 config UNWINDER_ORC
 	bool "ORC unwinder"
 	depends on X86_64
-	select STACK_VALIDATION
+	depends on STACK_VALIDATION
 	---help---
 	  This option enables the ORC (Oops Rewind Capability) unwinder for
 	  unwinding kernel stack traces.  It uses a custom data format which is
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 8838d11..f4d48af 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -364,7 +364,7 @@ config FRAME_POINTER
 config STACK_VALIDATION
 	bool "Compile-time stack metadata validation"
 	depends on HAVE_STACK_VALIDATION
-	default n
+	depends on $(success,echo "int main() {}" | $(HOSTCC) -xc -o /dev/null -lelf -)
 	help
 	  Add compile-time checks to validate stack metadata, including frame
 	  pointers (if CONFIG_FRAME_POINTER is enabled).  This helps ensure
@@ -373,6 +373,10 @@ config STACK_VALIDATION
 	  This is also a prerequisite for generation of ORC unwind data, which
 	  is needed for CONFIG_UNWINDER_ORC.
 
+	  To enable this, the host compiler needs to be able to link libelf.
+	  If it is missing on your system, please install libelf-dev,
+	  libelf-devel or elfutils-libelf-devel.
+
 	  For more information, see
 	  tools/objtool/Documentation/stack-validation.txt.
 
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index e7889f4..154205b 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -243,7 +243,6 @@ endif # -record-mcount
 endif # CONFIG_FTRACE_MCOUNT_RECORD
 
 ifdef CONFIG_STACK_VALIDATION
-ifneq ($(SKIP_STACK_VALIDATION),1)
 
 __objtool_obj := $(objtree)/tools/objtool/objtool
 
@@ -282,7 +281,6 @@ objtool_obj = $(if $(patsubst y%,, \
 	$(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n), \
 	$(__objtool_obj))
 
-endif # SKIP_STACK_VALIDATION
 endif # CONFIG_STACK_VALIDATION
 
 # Rebuild all objects when objtool changes, or is enabled/disabled.
-- 
2.7.4

