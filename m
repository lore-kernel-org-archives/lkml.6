Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932360AbeCKMkL (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 08:40:11 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34189 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932180AbeCKMjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 08:39:04 -0400
X-Google-Smtp-Source: AG47ELv9T60ncVbfcKZxCNbjcjSHVzjt666BgVXrxuFb/lLrV5u3l4/jmIqDoKLZ9TYRiJ0SvMaTHQ==
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Russell King <linux@armlinux.org.uk>,
        Paul Mackerras <paulus@samba.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>,
        James Morris <james.l.morris@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nico@linaro.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: [PATCH v8 2/6] module: allow symbol exports to be disabled
Date: Sun, 11 Mar 2018 12:38:11 +0000
Message-Id: <20180311123815.17916-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180311123815.17916-1-ard.biesheuvel@linaro.org>
References: <20180311123815.17916-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow existing C code to be incorporated into the decompressor or
the UEFI stub, introduce a CPP macro that turns all EXPORT_SYMBOL_xxx
declarations into nops, and #define it in places where such exports
are undesirable. Note that this gets rid of a rather dodgy redefine
of linux/export.h's header guard.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/boot/compressed/kaslr.c      |  5 +----
 drivers/firmware/efi/libstub/Makefile |  3 ++-
 include/linux/export.h                | 11 ++++++++++-
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 8199a6187251..3a2a6d7049e4 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -23,11 +23,8 @@
  * _ctype[] in lib/ctype.c is needed by isspace() of linux/ctype.h.
  * While both lib/ctype.c and lib/cmdline.c will bring EXPORT_SYMBOL
  * which is meaningless and will cause compiling error in some cases.
- * So do not include linux/export.h and define EXPORT_SYMBOL(sym)
- * as empty.
  */
-#define _LINUX_EXPORT_H
-#define EXPORT_SYMBOL(sym)
+#define __DISABLE_EXPORTS
 
 #include "misc.h"
 #include "error.h"
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 7b3ba40f0745..896a882c89f4 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -20,7 +20,8 @@ cflags-$(CONFIG_EFI_ARMSTUB)	+= -I$(srctree)/scripts/dtc/libfdt
 KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
 				   -D__NO_FORTIFY \
 				   $(call cc-option,-ffreestanding) \
-				   $(call cc-option,-fno-stack-protector)
+				   $(call cc-option,-fno-stack-protector) \
+				   -D__DISABLE_EXPORTS
 
 GCOV_PROFILE			:= n
 KASAN_SANITIZE			:= n
diff --git a/include/linux/export.h b/include/linux/export.h
index 1a1dfdb2a5c6..25005b55b079 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -72,7 +72,16 @@ extern struct module __this_module;
 	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
 	= { (unsigned long)&sym, __kstrtab_##sym }
 
-#if defined(__KSYM_DEPS__)
+#if defined(__DISABLE_EXPORTS)
+
+/*
+ * Allow symbol exports to be disabled completely so that C code may
+ * be reused in other execution contexts such as the UEFI stub or the
+ * decompressor.
+ */
+#define __EXPORT_SYMBOL(sym, sec)
+
+#elif defined(__KSYM_DEPS__)
 
 /*
  * For fine grained build dependencies, we want to tell the build system
-- 
2.15.1
