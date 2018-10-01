Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE068C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879C62089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="v3ynzaGT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 879C62089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbeJBAmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:42:33 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38930 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeJBAmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:42:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id r9-v6so6150452pgv.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 11:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5rn1oW1z/hfRaBPwTBKTipnUr4t21lKeFoJSkkSjMpo=;
        b=v3ynzaGTlkcGo0UU48t1BVwwVGVk810EOYZ2SqsI8fQG8dl99D1V8mgt310ofEK6g1
         d7PljvmyL65ppcuewi6YcIyHzkHoQWCrnVfPHEXsH1B3MQCwFVANO8RbM1/zR7xwCQOl
         1yHCFyVnphrc+5Vh7D4WOtkhW0yLAooIYD03XYWVjdIwmUxYesXR0SwhmaTL1dhQevRH
         9Jw393Kz6vu1M5gWeZW8pLsmed+xxwQvE57DY3nI6rtei52xD/ENfYl9QG/eGq7WoqjQ
         dh7NNKDCLZs5tuSzVgImseTEEuLDZb07s5+vHrdzNaejUaaWeC2p0gJ6BDwwaiun6msu
         2Vog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5rn1oW1z/hfRaBPwTBKTipnUr4t21lKeFoJSkkSjMpo=;
        b=ir0c1dWBSuBy6hbM1b/WvNoaSvXGG0bzysqEBs1SC4VDjbpk7TTN7DN+0FtviStCWs
         kFAc0muUcUdOQwCGWJ4YhFfReB2818QX6knXiCoQy9pXOKprhiRlEHuEuDSwxIKJxtcX
         meOdV7UFV2P14FO84qGA92ShawyUbQQFac16RlpbtJDBBVS4e84sUOQ/V1fmaVPRKvvK
         5cePBmLx8cSvPVqQfv20YDLVgfNlklV3UoaSpBUDeacPx91oS94OYRxW+8K4ma9d6pAY
         NIiZiIuqKmoGSvqr8k6rDMOx49GdnfwTe0e8RSUWTFgRHwYpXTwMJwUBWOBY3pT1wMer
         /hwQ==
X-Gm-Message-State: ABuFfoiULNBuRwRV7A448C6pgdiay2GZNIS3flB+QRqaREweX0GRiBS/
        xJmMbderTJf0mdZXRt0rEN73fyK1Znc=
X-Google-Smtp-Source: ACcGV611YhJQVPoAdkA9DYVNcjrH0BFPz3RoC0gDkrYQ9nYe435Kw6D6YQ2pnTecPfKFTF3hqhXXhA==
X-Received: by 2002:a63:3747:: with SMTP id g7-v6mr11309249pgn.59.1538417014294;
        Mon, 01 Oct 2018 11:03:34 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.gmail.com with ESMTPSA id d186-v6sm24469261pfg.173.2018.10.01.11.03.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 11:03:33 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kevin Brodsky <kevin.brodsky@arm.com>,
        Mark Salyzyn <salyzyn@android.com>,
        James Morse <james.morse@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        John Stultz <john.stultz@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Andrew Pinski <apinski@cavium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        android-kernel@android.com, Marc Zyngier <marc.zyngier@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: RESEND [PATCH v3 2/3] arm64: compat: Split the sigreturn trampolines and kuser helpers (assembler sources)
Date:   Mon,  1 Oct 2018 10:58:35 -0700
Message-Id: <20181001175845.168430-16-salyzyn@android.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181001175845.168430-1-salyzyn@android.com>
References: <20181001175845.168430-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Brodsky <kevin.brodsky@arm.com>

AArch32 processes are currently installed a special [vectors] page that
contains the sigreturn trampolines and the kuser helpers, at the fixed
address mandated by the kuser helpers ABI.

Having both functionalities in the same page has become problematic,
because:

* It makes it impossible to disable the kuser helpers (the sigreturn
  trampolines cannot be removed), which is possible on arm.

* A future 32-bit vDSO would provide the sigreturn trampolines itself,
  making those in [vectors] redundant.

This patch addresses the problem by moving the sigreturn trampolines
sources to its own file.  Wrapped the comments to reduce the wrath of
checkpatch.pl.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Tested-by: Mark Salyzyn <salyzyn@android.com>
Cc: James Morse <james.morse@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: Andrew Pinski <apinski@cavium.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Jeremy Linton <Jeremy.Linton@arm.com>
Cc: android-kernel@android.com

v2:
- split off from previous v1 'arm64: compat: Add CONFIG_KUSER_HELPERS'
- adjust makefile so one line for each of the assembler source modules

v3:
- rebase
---
 arch/arm64/kernel/Makefile      |  4 +-
 arch/arm64/kernel/kuser32.S     | 48 ++---------------------
 arch/arm64/kernel/sigreturn32.S | 67 +++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 46 deletions(-)
 create mode 100644 arch/arm64/kernel/sigreturn32.S

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 4c8b13bede80..b89a79424912 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -27,8 +27,10 @@ OBJCOPYFLAGS := --prefix-symbols=__efistub_
 $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,objcopy)
 
-arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
+arm64-obj-$(CONFIG_COMPAT)		+= sys32.o signal32.o 	\
 					   sys_compat.o
+arm64-obj-$(CONFIG_COMPAT)		+= sigreturn32.o
+arm64-obj-$(CONFIG_COMPAT)		+= kuser32.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
 arm64-obj-$(CONFIG_ARM64_MODULE_PLTS)	+= module-plts.o
diff --git a/arch/arm64/kernel/kuser32.S b/arch/arm64/kernel/kuser32.S
index 997e6b27ff6a..d15b5c2935b3 100644
--- a/arch/arm64/kernel/kuser32.S
+++ b/arch/arm64/kernel/kuser32.S
@@ -20,16 +20,13 @@
  *
  * AArch32 user helpers.
  *
- * Each segment is 32-byte aligned and will be moved to the top of the high
- * vector page.  New segments (if ever needed) must be added in front of
- * existing ones.  This mechanism should be used only for things that are
- * really small and justified, and not be abused freely.
+ * These helpers are provided for compatibility with AArch32 binaries that
+ * still need them. They are installed at a fixed address by
+ * aarch32_setup_additional_pages().
  *
  * See Documentation/arm/kernel_user_helpers.txt for formal definitions.
  */
 
-#include <asm/unistd.h>
-
 	.align	5
 	.globl	__kuser_helper_start
 __kuser_helper_start:
@@ -77,42 +74,3 @@ __kuser_helper_version:			// 0xffff0ffc
 	.word	((__kuser_helper_end - __kuser_helper_start) >> 5)
 	.globl	__kuser_helper_end
 __kuser_helper_end:
-
-/*
- * AArch32 sigreturn code
- *
- * For ARM syscalls, the syscall number has to be loaded into r7.
- * We do not support an OABI userspace.
- *
- * For Thumb syscalls, we also pass the syscall number via r7. We therefore
- * need two 16-bit instructions.
- */
-	.globl __aarch32_sigret_code_start
-__aarch32_sigret_code_start:
-
-	/*
-	 * ARM Code
-	 */
-	.byte	__NR_compat_sigreturn, 0x70, 0xa0, 0xe3	// mov	r7, #__NR_compat_sigreturn
-	.byte	__NR_compat_sigreturn, 0x00, 0x00, 0xef	// svc	#__NR_compat_sigreturn
-
-	/*
-	 * Thumb code
-	 */
-	.byte	__NR_compat_sigreturn, 0x27			// svc	#__NR_compat_sigreturn
-	.byte	__NR_compat_sigreturn, 0xdf			// mov	r7, #__NR_compat_sigreturn
-
-	/*
-	 * ARM code
-	 */
-	.byte	__NR_compat_rt_sigreturn, 0x70, 0xa0, 0xe3	// mov	r7, #__NR_compat_rt_sigreturn
-	.byte	__NR_compat_rt_sigreturn, 0x00, 0x00, 0xef	// svc	#__NR_compat_rt_sigreturn
-
-	/*
-	 * Thumb code
-	 */
-	.byte	__NR_compat_rt_sigreturn, 0x27			// svc	#__NR_compat_rt_sigreturn
-	.byte	__NR_compat_rt_sigreturn, 0xdf			// mov	r7, #__NR_compat_rt_sigreturn
-
-        .globl __aarch32_sigret_code_end
-__aarch32_sigret_code_end:
diff --git a/arch/arm64/kernel/sigreturn32.S b/arch/arm64/kernel/sigreturn32.S
new file mode 100644
index 000000000000..6ecda4d84cd5
--- /dev/null
+++ b/arch/arm64/kernel/sigreturn32.S
@@ -0,0 +1,67 @@
+/*
+ * sigreturn trampolines for AArch32.
+ *
+ * Copyright (C) 2005-2011 Nicolas Pitre <nico@fluxnic.net>
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ *
+ * AArch32 sigreturn code
+ *
+ * For ARM syscalls, the syscall number has to be loaded into r7.
+ * We do not support an OABI userspace.
+ *
+ * For Thumb syscalls, we also pass the syscall number via r7. We therefore
+ * need two 16-bit instructions.
+ */
+
+#include <asm/unistd.h>
+
+	.globl __aarch32_sigret_code_start
+__aarch32_sigret_code_start:
+
+	/*
+	 * ARM Code
+	 */
+	// mov	r7, #__NR_compat_sigreturn
+	.byte	__NR_compat_sigreturn, 0x70, 0xa0, 0xe3
+	// svc	#__NR_compat_sigreturn
+	.byte	__NR_compat_sigreturn, 0x00, 0x00, 0xef
+
+	/*
+	 * Thumb code
+	 */
+	// svc	#__NR_compat_sigreturn
+	.byte	__NR_compat_sigreturn, 0x27
+	// mov	r7, #__NR_compat_sigreturn
+	.byte	__NR_compat_sigreturn, 0xdf
+
+	/*
+	 * ARM code
+	 */
+	// mov	r7, #__NR_compat_rt_sigreturn
+	.byte	__NR_compat_rt_sigreturn, 0x70, 0xa0, 0xe3
+	// svc	#__NR_compat_rt_sigreturn
+	.byte	__NR_compat_rt_sigreturn, 0x00, 0x00, 0xef
+
+	/*
+	 * Thumb code
+	 */
+	// svc	#__NR_compat_rt_sigreturn
+	.byte	__NR_compat_rt_sigreturn, 0x27
+	// mov	r7, #__NR_compat_rt_sigreturn
+	.byte	__NR_compat_rt_sigreturn, 0xdf
+
+        .globl __aarch32_sigret_code_end
+__aarch32_sigret_code_end:
-- 
2.19.0.605.g01d371f741-goog

