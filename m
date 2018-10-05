Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F9CC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D3C20875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kI1I9Xac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D3C20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbeJEPLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:11:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51290 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbeJEPLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:11:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id 143-v6so983105wmf.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 01:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bsz7BDS1SKX9gHYXcW+7Yci+Ue2vSEITfG0cme0MbDA=;
        b=kI1I9XaciHUjWQntHHKbdAEv8Lm6aYT5IbNk7lfmiPNfZV7PrVjSNpmFq2Jb0VlwbE
         ZuX3XeBgMPpPy+wOgvVxMR/QHwgKKUOYnCADUKvUpr9aZKOY7+D76TJkI/VCLKkKNez8
         +gmvc8uxFGNprC67bkbat2uDXwlxiRbel6D0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bsz7BDS1SKX9gHYXcW+7Yci+Ue2vSEITfG0cme0MbDA=;
        b=f3ssHLFVB4WIPpDPw85R0ZuObANzq1p/gfm+v5Hg/x8zbL5ZI+GRLFfo0FRu9xBDhv
         w+Iqgm0M546R9yEEnb5vYJkvWtDzqr6P+D+74CNSjsRb0xKzVBsE9ySxk9VkWOi0agpG
         UE1UWMGUce+xF3fRZeAHcaKCNGLa9gWw1pObfTF151YrruAM0eFYhUvmERroxJIXShaT
         3CDxagRhwKwWHXTq/BUMB+Ux7uLPZ0vH7/YdhKkcOurKGfhF62G3AzmOWtyMJGlijBQR
         upIrnfBb/XYbowIixdYgZ4lpi6lfXsqxqzT1kwg58VG3w6D1FHPPr4QSfI3XhWIKH6F7
         JCVw==
X-Gm-Message-State: ABuFfoiZAxtWd4OL2GBtEncpBn+BAbluM7u8TsNgUCPmcYYfxouQPfQP
        Qz/LX19PSwsSJ0vh8XksIK/7JzECvwA=
X-Google-Smtp-Source: ACcGV62etp+lM1HN/t1sYejJBWMbHx2UjdBHB+cI2jGegnJnCQHI4XozZ0fBzC1R8f1Ib4p8VBAR+g==
X-Received: by 2002:a1c:14d1:: with SMTP id 200-v6mr7367930wmu.106.1538727221719;
        Fri, 05 Oct 2018 01:13:41 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:112:6f00:697e:67d9:a05d:22c7])
        by smtp.gmail.com with ESMTPSA id t4-v6sm6565620wrb.45.2018.10.05.01.13.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 01:13:40 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 2/9] arm64: kernel: add arch support for patchable function pointers
Date:   Fri,  5 Oct 2018 10:13:26 +0200
Message-Id: <20181005081333.15018-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement arm64 support for patchable function pointers by emitting
them as branch instructions (and a couple of NOPs in case the new
target is out of range of a normal branch instruction.)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Kconfig           |  1 +
 arch/arm64/include/asm/ffp.h | 35 ++++++++++++++++++++
 arch/arm64/kernel/insn.c     | 22 ++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b1a0e95c751..db8c9e51c56d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -102,6 +102,7 @@ config ARM64
 	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_BITREVERSE
+	select HAVE_ARCH_FFP
 	select HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
diff --git a/arch/arm64/include/asm/ffp.h b/arch/arm64/include/asm/ffp.h
new file mode 100644
index 000000000000..678dc1262218
--- /dev/null
+++ b/arch/arm64/include/asm/ffp.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_FFP_H
+#define __ASM_FFP_H
+
+struct ffp {
+	u32	insn[5];
+	u32	def_branch;
+};
+
+#define DECLARE_FFP(_fn, _def)						\
+	extern typeof(_def) _fn;					\
+	extern struct ffp const __ffp_ ## _fn
+
+#define DEFINE_FFP(_fn, _def)						\
+	DECLARE_FFP(_fn, _def);						\
+	asm("	.pushsection	\".text\", \"ax\", %progbits	\n"	\
+	    "	.align		3				\n"	\
+	    "	.globl		" #_fn "			\n"	\
+	    "	.globl		__ffp_" #_fn "			\n"	\
+	    #_fn " :						\n"	\
+	    "__ffp_" #_fn " :					\n"	\
+	    "		b	" #_def "			\n"	\
+	    "		nop					\n"	\
+	    "		nop					\n"	\
+	    "		nop					\n"	\
+	    "		nop					\n"	\
+	    "		b	" #_def "			\n"	\
+	    "	.popsection					\n");	\
+	EXPORT_SYMBOL(__ffp_ ## _fn)
+
+extern void ffp_set_target(const struct ffp *m, void *new_fn);
+extern void ffp_reset_target(const struct ffp *m);
+
+#endif
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index 2b3413549734..a2ed547fd171 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -30,6 +30,7 @@
 #include <asm/cacheflush.h>
 #include <asm/debug-monitors.h>
 #include <asm/fixmap.h>
+#include <asm/ffp.h>
 #include <asm/insn.h>
 #include <asm/kprobes.h>
 
@@ -1603,3 +1604,24 @@ u32 aarch64_insn_gen_extr(enum aarch64_insn_variant variant,
 	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RN, insn, Rn);
 	return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RM, insn, Rm);
 }
+
+void ffp_set_target(const struct ffp *m, void *new_fn)
+{
+	u32 branch = aarch64_insn_gen_branch_imm((u64)m, (u64)new_fn,
+						 AARCH64_INSN_BRANCH_NOLINK);
+
+	if (branch == AARCH64_BREAK_FAULT) {
+		/* TODO out of range - use a PLT sequence instead */
+	} else {
+		aarch64_insn_patch_text((void *[]){ (void *)m }, &branch, 1);
+	}
+}
+EXPORT_SYMBOL(ffp_set_target);
+
+void ffp_reset_target(const struct ffp *m)
+{
+	u32 branch = le32_to_cpu(m->def_branch);
+
+	aarch64_insn_patch_text((void *[]){ (void *)m }, &branch, 1);
+}
+EXPORT_SYMBOL(ffp_reset_target);
-- 
2.11.0

