Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F21DC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF38B26F02
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kWQofeSW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF38B26F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754908AbeFZSa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:30:26 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:47062 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbeFZS2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:28:46 -0400
Received: by mail-wr0-f194.google.com with SMTP id l14-v6so13143197wrq.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 11:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0rtlaTwu4CCqZ4xjhd2DpZMexFkKmZwXAJxYNg8GKrI=;
        b=kWQofeSWgXoFjz/j8asPkjzideKiaqYlr9d9vbu/r2+CWpyREDbBaoDmBUxiu0peFH
         HPq9AnjbD8tgNgl/vBzBFgNM5iwiBgZc2u4TDt0NhyvsxqwUZQNyAQ7opJ3P/nUOKwvH
         PTdbLXYvfUfdjZZ95APglwOGZ39x0iuVko2X4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0rtlaTwu4CCqZ4xjhd2DpZMexFkKmZwXAJxYNg8GKrI=;
        b=PItl72HI+6VlGSrsXcHZbvp/U2BtT9zE3wP5ZRkgf368rq7VvOXap6XVVm8IJrrLSk
         8w9SmDw6gOR+FSjhA8CgTF2a1JVO8yaN9j9RZAEIApYXsEFxoz7UvDb/qMARw5TRARzO
         4Ff8Ii8Rr+hcW/9SJEk06kLKoj37rjeCb1ZA+5WXtwjykgB+SJB1iCx2goXL5gkR/5GQ
         kbI+WV0em52SgSW41WnJF5q1rCtUNMu1UXwH2it4t0gg+cARvrv666AcrMxnI/2cypvS
         ZJWxItKNWieCo5lxEINktgde0ORiYZ5sdQtbtwDxoOhmM7rX88FaQfPBU5/BnAh0BwFd
         XaEg==
X-Gm-Message-State: APt69E1QGin5pzoTMf1jpEvBIvNIuOBII6lEK8d7kBSvqT8WdHFO4HHe
        q9AaIEpzu8SW6SwIydUHcuKzutw6K9I=
X-Google-Smtp-Source: AAOMgpcsaI7g0EkQkI2f7EhPDlW/ATjGUpG2MyKr4CfAaHK4w2A7DuCRUIfeMS0l22l/rbNtj9usdA==
X-Received: by 2002:adf:ebc3:: with SMTP id v3-v6mr2414460wrn.33.1530037724454;
        Tue, 26 Jun 2018 11:28:44 -0700 (PDT)
Received: from rev02.home ([2a01:cb1d:112:6f00:d037:e907:f0a2:a5ea])
        by smtp.gmail.com with ESMTPSA id s17-v6sm1707664wmc.34.2018.06.26.11.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 11:28:43 -0700 (PDT)
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
Subject: [PATCH v9 2/6] module: allow symbol exports to be disabled
Date:   Tue, 26 Jun 2018 20:27:57 +0200
Message-Id: <20180626182802.19932-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180626182802.19932-1-ard.biesheuvel@linaro.org>
References: <20180626182802.19932-1-ard.biesheuvel@linaro.org>
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
2.11.0

