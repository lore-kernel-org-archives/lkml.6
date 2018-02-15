Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224ZWiq3vY1yrgRCvjRx+vTZIkobKoSQFspV2vChhQ4guNVdEWoj4HK2ik8GpHpz3LMpsPCj
ARC-Seal: i=1; a=rsa-sha256; t=1518708679; cv=none;
        d=google.com; s=arc-20160816;
        b=Suh5VkV1Vvgqeiq4sprdtKUD46OwcSYPRdDdUfQn270gR2DYAB0axpEh7qaY2ezvZi
         RV6dvN2k4vIp6QfkOWlpOy2Q7Q3MRtchjYGLY8pIDaCOva3V+Kx3lWdiD8g3Bi+qinpj
         XY9DUS5jfcHtBJrBBGjqdMpL2ZpaVmYzeBfAKXJJ0sAbAV2tYn/+JK6ZzSPHQcAzR4+f
         VKzHc2JEi75MifdMb1IxCviAFhIP+jNi0L+W1fxgew+6qYeOW79L7r7OWF/+z0SjwVpd
         WdpJpmVM3bQezMJR7bea8lyNUH+nG3/cWz6eY9kEVT3i7D1GODJ7azwh2UTMDyr0M54V
         YY0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YjszP90imBsNwQVO+UmldSkkJVrSGXwbvLVkQ2VoOeY=;
        b=tcrdAKOgMTDaikEXPXO3CaQbsaTZ0FK+s+bZFVaQClRzXILpajyk0qRXRYimM5WU0B
         DbPsLmN7fm8pnqhzBl4AfsSDW3KxsgtrRNYemb0+OPqQXvzjEAKEzWAcOtuzVwplxTyD
         QHhxXn6JWAM9mnZLYFiiaV/k7uRngtczeeXwl9EhtzgOa+GMc6WBcSxopZVpLUk2Q0gd
         2vt59ncVSELRfyNZvF+97afwa4WCdGixNKWAbjB/9hNxfxpOu6mesDXlik4OW/4WlPOE
         KsZi7q+DjXYagPxjuiqLT7DqEfIUCL2iZoP8LOZdZPcmps1460qp/JxCvvsqgFw9PVBg
         mjrg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Laura Abbott <labbott@redhat.com>,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 039/195] [Variant 3/Meltdown] arm64: entry: Add fake CPU feature for unmapping the kernel at EL0
Date: Thu, 15 Feb 2018 16:15:30 +0100
Message-Id: <20180215151707.693049610@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481472153728221?=
X-GMAIL-MSGID: =?utf-8?q?1592481472153728221?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit ea1e3de85e94 upstream.

Allow explicit disabling of the entry trampoline on the kernel command
line (kpti=off) by adding a fake CPU feature (ARM64_UNMAP_KERNEL_AT_EL0)
that can be used to toggle the alternative sequences in our entry code and
avoid use of the trampoline altogether if desired. This also allows us to
make use of a static key in arm64_kernel_unmapped_at_el0().

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/cpucaps.h |    3 +-
 arch/arm64/include/asm/mmu.h     |    3 +-
 arch/arm64/kernel/cpufeature.c   |   41 +++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/entry.S        |    9 ++++----
 4 files changed, 50 insertions(+), 6 deletions(-)

--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -40,7 +40,8 @@
 #define ARM64_WORKAROUND_858921			19
 #define ARM64_WORKAROUND_CAVIUM_30115		20
 #define ARM64_HAS_DCPOP				21
+#define ARM64_UNMAP_KERNEL_AT_EL0		23
 
-#define ARM64_NCAPS				22
+#define ARM64_NCAPS				24
 
 #endif /* __ASM_CPUCAPS_H */
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -36,7 +36,8 @@ typedef struct {
 
 static inline bool arm64_kernel_unmapped_at_el0(void)
 {
-	return IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0);
+	return IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0) &&
+	       cpus_have_const_cap(ARM64_UNMAP_KERNEL_AT_EL0);
 }
 
 extern void paging_init(void);
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -796,6 +796,40 @@ static bool has_no_fpsimd(const struct a
 					ID_AA64PFR0_FP_SHIFT) < 0;
 }
 
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
+
+static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
+				int __unused)
+{
+	/* Forced on command line? */
+	if (__kpti_forced) {
+		pr_info_once("kernel page table isolation forced %s by command line option\n",
+			     __kpti_forced > 0 ? "ON" : "OFF");
+		return __kpti_forced > 0;
+	}
+
+	/* Useful for KASLR robustness */
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
+		return true;
+
+	return false;
+}
+
+static int __init parse_kpti(char *str)
+{
+	bool enabled;
+	int ret = strtobool(str, &enabled);
+
+	if (ret)
+		return ret;
+
+	__kpti_forced = enabled ? 1 : -1;
+	return 0;
+}
+__setup("kpti=", parse_kpti);
+#endif	/* CONFIG_UNMAP_KERNEL_AT_EL0 */
+
 static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "GIC system register CPU interface",
@@ -882,6 +916,13 @@ static const struct arm64_cpu_capabiliti
 		.def_scope = SCOPE_SYSTEM,
 		.matches = hyp_offset_low,
 	},
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+	{
+		.capability = ARM64_UNMAP_KERNEL_AT_EL0,
+		.def_scope = SCOPE_SYSTEM,
+		.matches = unmap_kernel_at_el0,
+	},
+#endif
 	{
 		/* FP/SIMD is not implemented */
 		.capability = ARM64_HAS_NO_FPSIMD,
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -74,6 +74,7 @@
 	.macro kernel_ventry, el, label, regsize = 64
 	.align 7
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+alternative_if ARM64_UNMAP_KERNEL_AT_EL0
 	.if	\el == 0
 	.if	\regsize == 64
 	mrs	x30, tpidrro_el0
@@ -82,6 +83,7 @@
 	mov	x30, xzr
 	.endif
 	.endif
+alternative_else_nop_endif
 #endif
 
 	sub	sp, sp, #S_FRAME_SIZE
@@ -321,10 +323,9 @@ alternative_else_nop_endif
 	ldr	lr, [sp, #S_LR]
 	add	sp, sp, #S_FRAME_SIZE		// restore sp
 
-#ifndef CONFIG_UNMAP_KERNEL_AT_EL0
-	eret
-#else
 	.if	\el == 0
+alternative_insn eret, nop, ARM64_UNMAP_KERNEL_AT_EL0
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 	bne	4f
 	msr	far_el1, x30
 	tramp_alias	x30, tramp_exit_native
@@ -332,10 +333,10 @@ alternative_else_nop_endif
 4:
 	tramp_alias	x30, tramp_exit_compat
 	br	x30
+#endif
 	.else
 	eret
 	.endif
-#endif
 	.endm
 
 	.macro	irq_stack_entry
