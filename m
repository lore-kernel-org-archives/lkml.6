Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B976C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98CE21479
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iETq0ghz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C98CE21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934344AbeGDIlU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:41:20 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36936 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933324AbeGDIiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:38:51 -0400
Received: by mail-ed1-f67.google.com with SMTP id v22-v6so3464603edq.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 01:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WwDzIwe447IcZCAIGu+8yb3n66DKqmjIylDR9Nx0qlM=;
        b=iETq0ghz2rcIjYDEH/K2UNHIhKkUiwML5a0df6hgI4a7Nx4F7NBPxcz3ngH7Y9oa1L
         L44DDfe5KlmSEncVAizmGhIjM0rtsKzkUH/13i8+M8NTQdiXYhV+oHUV00DqiUUisZYU
         aNvd6P4F8rohT+ixA21/ID5MCu88JTnWThcsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WwDzIwe447IcZCAIGu+8yb3n66DKqmjIylDR9Nx0qlM=;
        b=rd4Ecg56QfvMBdUsvsTBF+zkfrNExz8AGJRNSuQJ4uJxm6bTdUsu+LnFMs4jTsn1Yc
         Dp38GHYN6QS7gLKimYW3Y1UqM/wUfRN6L9jqtIPO8c52Qv1HYA94+NHP18FoU4WyR9bp
         8Lp5b1NsByzFPZBDT7P4jUW+YBFN/B6hRtyHwSYugwycjKdiR/ROTylX2RJ/N6YSAka/
         LlQOfRJ9OBKEAMLYwkIs+dwpIUqiXtdyOUjwRH7THyIsIhH2l3RiNdXxA9suZQT1CH2e
         /3oBFyEMUXoUf4H+bOUNxK2R/yyC0UGGCikGWMNyqvwkjwS8qMnBE8jG8upCtf6JJ6JW
         rQNw==
X-Gm-Message-State: APt69E2ZiUpsxTENvpgSyT/ZcM35GEA/S1uI+Qr25jppFnR/qo3PCEBC
        F76R3OnJlqPBlrTekS/ixhpTKtqcNg0=
X-Google-Smtp-Source: AAOMgpdx3QJdy485MbXIPPbXj+TuJFRPgrwQphodhMxSY5Z3X6Q+PKeyFs+lNTi3ta99W+oCiqzMVA==
X-Received: by 2002:a50:81a4:: with SMTP id 33-v6mr1701948ede.200.1530693529463;
        Wed, 04 Jul 2018 01:38:49 -0700 (PDT)
Received: from ards-mac-mini.arnhem.chello.nl (dhcp-077-251-017-237.chello.nl. [77.251.17.237])
        by smtp.gmail.com with ESMTPSA id k13-v6sm1821740edj.55.2018.07.04.01.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 01:38:48 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
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
        James Morris <jmorris@namei.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nico@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: [PATCH v10 2/6] module: allow symbol exports to be disabled
Date:   Wed,  4 Jul 2018 10:36:47 +0200
Message-Id: <20180704083651.24360-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180704083651.24360-1-ard.biesheuvel@linaro.org>
References: <20180704083651.24360-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow existing C code to be incorporated into the decompressor or
the UEFI stub, introduce a CPP macro that turns all EXPORT_SYMBOL_xxx
declarations into nops, and #define it in places where such exports
are undesirable. Note that this gets rid of a rather dodgy redefine
of linux/export.h's header guard.

Acked-by: Nicolas Pitre <nico@linaro.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/boot/compressed/kaslr.c      |  5 +----
 drivers/firmware/efi/libstub/Makefile |  3 ++-
 include/linux/export.h                | 11 ++++++++++-
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index b87a7582853d..ed7a123bba42 100644
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
index a34e9290a699..0d0d3483241c 100644
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
index b768d6dd3c90..ea7df303d68d 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -66,7 +66,16 @@ extern struct module __this_module;
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
2.17.1

