Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A95CC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C5820B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UGN68F6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbfAaT3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:29:03 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44493 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbfAaT3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:29:01 -0500
Received: by mail-pg1-f195.google.com with SMTP id t13so1762832pgr.11
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ev8JPAf+GoLzOHws3FGQ46h+PQ2kpPn+0k5OrkzIAiY=;
        b=UGN68F6ZcLmOxFwtzgS7fsHrX5YxpIwlbBo6TP7Fu9IW9TkcJwup0pITpRMnT+nuDf
         w4uVcT3v7EO3VxAHFUNjGW+EnaOJTtgrWJXaaq86yPeAy8pj6KU8MV8M8h5PqTGfo9ga
         2/GbaYCZllZLW9JbM9nvcbFpNgpUUiyzG27bA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ev8JPAf+GoLzOHws3FGQ46h+PQ2kpPn+0k5OrkzIAiY=;
        b=qNS/8W51xCzvf+i4/WWClY24YmxYNE/bwZZI0ZowxpN1+KQpuBrr/hYvab3YyHnZWD
         F0p5qRGuHW7IG2riISHQoUdlFR/9YG+DrVQ9zbJgYe/mp9oIGVn2Bt02sMvmmtgd+9wr
         IgNa3Sk8oTkkeXfFBD1opnlcMOpeDI3nmE1Ss5+a4YODeBTq7s37xm3Ez4wpJXHRUKUf
         6NVi+cmX33c5Pw3We8dkXpfb+05TiEaigCwHKnJ5H18M8azOZe5AZ8dWM+Wkv1RGTNp0
         gSiknRAFrZoFkWd5JuM/8FRIJD04TgedoZc1YOnAZROrm9LC8uWr8L1ifeKOb/SDw2BQ
         3vNA==
X-Gm-Message-State: AJcUuke9tR3ia8a0r+Cdynhd9dzV5NZtTpOuP3yAT6Q/8dkax8t4N7fn
        jvWq3EnmXaQFOY+fO3iJ5oyJDlfkLQc=
X-Google-Smtp-Source: ALg8bN4NDirLuK4HzuFomYq8ZzIZ6jTLOGbE6YQz67HSslDD7eHHzc2BLBM7I6v0SC+n1ZYpkGgPIw==
X-Received: by 2002:a62:1f9d:: with SMTP id l29mr36074865pfj.14.1548962940145;
        Thu, 31 Jan 2019 11:29:00 -0800 (PST)
Received: from skynet.sea.corp.google.com ([2620:15c:17:4:29de:3bb1:1270:e679])
        by smtp.gmail.com with ESMTPSA id s130sm11164399pgc.60.2019.01.31.11.28.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:28:59 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, Thomas Garnier <thgarnie@chromium.org>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Garnier <thgarnie@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Joerg Roedel <jroedel@suse.de>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Jordan Borgner <mail@jordan-borgner.de>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 18/27] xen: Adapt assembly for PIE support
Date:   Thu, 31 Jan 2019 11:24:25 -0800
Message-Id: <20190131192533.34130-19-thgarnie@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190131192533.34130-1-thgarnie@chromium.org>
References: <20190131192533.34130-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the assembly code to use the new _ASM_MOVABS macro which get a
symbol reference while being PIE compatible. Adapt the relocation tool
to ignore 32-bit Xen code.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/platform/pvh/head.S | 14 ++++++++++----
 arch/x86/tools/relocs.c      | 16 +++++++++++++++-
 arch/x86/xen/xen-head.S      | 11 ++++++-----
 3 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 1f8825bbaffb..e52d8b31e01d 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -103,8 +103,8 @@ ENTRY(pvh_start_xen)
 	call xen_prepare_pvh
 
 	/* startup_64 expects boot_params in %rsi. */
-	mov $_pa(pvh_bootparams), %rsi
-	mov $_pa(startup_64), %rax
+	movabs $_pa(pvh_bootparams), %rsi
+	movabs $_pa(startup_64), %rax
 	jmp *%rax
 
 #else /* CONFIG_X86_64 */
@@ -150,10 +150,16 @@ END(pvh_start_xen)
 
 	.section ".init.data","aw"
 	.balign 8
+	/*
+	 * Use an ASM_PTR (quad on x64) for _pa(gdt_start) because PIE requires
+	 * a pointer size storage value before applying the relocation. On
+	 * 32-bit _ASM_PTR will be a long which is aligned the space needed for
+	 * relocation.
+	 */
 gdt:
 	.word gdt_end - gdt_start
-	.long _pa(gdt_start)
-	.word 0
+	_ASM_PTR _pa(gdt_start)
+	.balign 8
 gdt_start:
 	.quad 0x0000000000000000            /* NULL descriptor */
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 2a3c703218cc..1b5ee38446b6 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -837,6 +837,16 @@ static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
 		strncmp(symname, "init_per_cpu_", 13);
 }
 
+/*
+ * Check if the 32-bit relocation is within the xenpvh 32-bit code.
+ * If so, ignores it.
+ */
+static int is_in_xenpvh_assembly(Elf_Addr offset)
+{
+	Elf_Sym *sym = sym_lookup("pvh_start_xen");
+	return sym && (offset >= sym->st_value) &&
+		(offset < (sym->st_value + sym->st_size));
+}
 
 static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 		      const char *symname)
@@ -909,8 +919,12 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 		 * the relocations are processed.
 		 * Make sure that the offset will fit.
 		 */
-		if (r_type != R_X86_64_64 && (int32_t)offset != (int64_t)offset)
+		if (r_type != R_X86_64_64 &&
+		    (int32_t)offset != (int64_t)offset) {
+			if (is_in_xenpvh_assembly(offset))
+				break;
 			die("Relocation offset doesn't fit in 32 bits\n");
+		}
 
 		if (r_type == R_X86_64_64)
 			add_reloc(&relocs64, offset);
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 5077ead5e59c..4418ff0a1d96 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -28,14 +28,15 @@ ENTRY(startup_xen)
 
 	/* Clear .bss */
 	xor %eax,%eax
-	mov $__bss_start, %_ASM_DI
-	mov $__bss_stop, %_ASM_CX
+	_ASM_MOVABS $__bss_start, %_ASM_DI
+	_ASM_MOVABS $__bss_stop, %_ASM_CX
 	sub %_ASM_DI, %_ASM_CX
 	shr $__ASM_SEL(2, 3), %_ASM_CX
 	rep __ASM_SIZE(stos)
 
-	mov %_ASM_SI, xen_start_info
-	mov $init_thread_union+THREAD_SIZE, %_ASM_SP
+	_ASM_MOVABS $xen_start_info, %_ASM_AX
+	_ASM_MOV %_ASM_SI, (%_ASM_AX)
+	_ASM_MOVABS $init_thread_union+THREAD_SIZE, %_ASM_SP
 
 #ifdef CONFIG_X86_64
 	/* Set up %gs.
@@ -46,7 +47,7 @@ ENTRY(startup_xen)
 	 * init data section till per cpu areas are set up.
 	 */
 	movl	$MSR_GS_BASE,%ecx
-	movq	$INIT_PER_CPU_VAR(irq_stack_union),%rax
+	movabsq	$INIT_PER_CPU_VAR(irq_stack_union),%rax
 	cdq
 	wrmsr
 #endif
-- 
2.20.1.495.gaa96b0ce6b-goog

