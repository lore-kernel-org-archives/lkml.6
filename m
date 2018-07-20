Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768CBECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1FE20854
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1FE20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388414AbeGTNTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:19:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39264 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732931AbeGTNTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:19:32 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 64913CBE;
        Fri, 20 Jul 2018 12:30:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.9 49/66] arm64: alternatives: Add dynamic patching feature
Date:   Fri, 20 Jul 2018 14:14:06 +0200
Message-Id: <20180720121410.074383586@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121407.228772286@linuxfoundation.org>
References: <20180720121407.228772286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

Commit dea5e2a4c5bcf196f879a66cebdcca07793e8ba4 upstream.

We've so far relied on a patching infrastructure that only gave us
a single alternative, without any way to provide a range of potential
replacement instructions. For a single feature, this is an all or
nothing thing.

It would be interesting to have a more flexible grained way of patching
the kernel though, where we could dynamically tune the code that gets
injected.

In order to achive this, let's introduce a new form of dynamic patching,
assiciating a callback to a patching site. This callback gets source and
target locations of the patching request, as well as the number of
instructions to be patched.

Dynamic patching is declared with the new ALTERNATIVE_CB and alternative_cb
directives:

	asm volatile(ALTERNATIVE_CB("mov %0, #0\n", callback)
		     : "r" (v));
or
	alternative_cb callback
		mov	x0, #0
	alternative_cb_end

where callback is the C function computing the alternative.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/alternative.h |   41 ++++++++++++++++++++++++++++---
 arch/arm64/kernel/alternative.c      |   45 +++++++++++++++++++++++++----------
 2 files changed, 70 insertions(+), 16 deletions(-)

--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -4,6 +4,8 @@
 #include <asm/cpucaps.h>
 #include <asm/insn.h>
 
+#define ARM64_CB_PATCH ARM64_NCAPS
+
 #ifndef __ASSEMBLY__
 
 #include <linux/init.h>
@@ -21,12 +23,19 @@ struct alt_instr {
 	u8  alt_len;		/* size of new instruction(s), <= orig_len */
 };
 
+typedef void (*alternative_cb_t)(struct alt_instr *alt,
+				 __le32 *origptr, __le32 *updptr, int nr_inst);
+
 void __init apply_alternatives_all(void);
 void apply_alternatives(void *start, size_t length);
 
-#define ALTINSTR_ENTRY(feature)						      \
+#define ALTINSTR_ENTRY(feature,cb)					      \
 	" .word 661b - .\n"				/* label           */ \
+	" .if " __stringify(cb) " == 0\n"				      \
 	" .word 663f - .\n"				/* new instruction */ \
+	" .else\n"							      \
+	" .word " __stringify(cb) "- .\n"		/* callback */	      \
+	" .endif\n"							      \
 	" .hword " __stringify(feature) "\n"		/* feature bit     */ \
 	" .byte 662b-661b\n"				/* source len      */ \
 	" .byte 664f-663f\n"				/* replacement len */
@@ -44,15 +53,18 @@ void apply_alternatives(void *start, siz
  * but most assemblers die if insn1 or insn2 have a .inst. This should
  * be fixed in a binutils release posterior to 2.25.51.0.2 (anything
  * containing commit 4e4d08cf7399b606 or c1baaddf8861).
+ *
+ * Alternatives with callbacks do not generate replacement instructions.
  */
-#define __ALTERNATIVE_CFG(oldinstr, newinstr, feature, cfg_enabled)	\
+#define __ALTERNATIVE_CFG(oldinstr, newinstr, feature, cfg_enabled, cb)	\
 	".if "__stringify(cfg_enabled)" == 1\n"				\
 	"661:\n\t"							\
 	oldinstr "\n"							\
 	"662:\n"							\
 	".pushsection .altinstructions,\"a\"\n"				\
-	ALTINSTR_ENTRY(feature)						\
+	ALTINSTR_ENTRY(feature,cb)					\
 	".popsection\n"							\
+	" .if " __stringify(cb) " == 0\n"				\
 	".pushsection .altinstr_replacement, \"a\"\n"			\
 	"663:\n\t"							\
 	newinstr "\n"							\
@@ -60,11 +72,17 @@ void apply_alternatives(void *start, siz
 	".popsection\n\t"						\
 	".org	. - (664b-663b) + (662b-661b)\n\t"			\
 	".org	. - (662b-661b) + (664b-663b)\n"			\
+	".else\n\t"							\
+	"663:\n\t"							\
+	"664:\n\t"							\
+	".endif\n"							\
 	".endif\n"
 
 #define _ALTERNATIVE_CFG(oldinstr, newinstr, feature, cfg, ...)	\
-	__ALTERNATIVE_CFG(oldinstr, newinstr, feature, IS_ENABLED(cfg))
+	__ALTERNATIVE_CFG(oldinstr, newinstr, feature, IS_ENABLED(cfg), 0)
 
+#define ALTERNATIVE_CB(oldinstr, cb) \
+	__ALTERNATIVE_CFG(oldinstr, "NOT_AN_INSTRUCTION", ARM64_CB_PATCH, 1, cb)
 #else
 
 #include <asm/assembler.h>
@@ -131,6 +149,14 @@ void apply_alternatives(void *start, siz
 661:
 .endm
 
+.macro alternative_cb cb
+	.set .Lasm_alt_mode, 0
+	.pushsection .altinstructions, "a"
+	altinstruction_entry 661f, \cb, ARM64_CB_PATCH, 662f-661f, 0
+	.popsection
+661:
+.endm
+
 /*
  * Provide the other half of the alternative code sequence.
  */
@@ -157,6 +183,13 @@ void apply_alternatives(void *start, siz
 .endm
 
 /*
+ * Callback-based alternative epilogue
+ */
+.macro alternative_cb_end
+662:
+.endm
+
+/*
  * Provides a trivial alternative or default sequence consisting solely
  * of NOPs. The number of NOPs is chosen automatically to match the
  * previous case.
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -28,7 +28,7 @@
 #include <asm/sections.h>
 #include <linux/stop_machine.h>
 
-#define __ALT_PTR(a,f)		(u32 *)((void *)&(a)->f + (a)->f)
+#define __ALT_PTR(a,f)		((void *)&(a)->f + (a)->f)
 #define ALT_ORIG_PTR(a)		__ALT_PTR(a, orig_offset)
 #define ALT_REPL_PTR(a)		__ALT_PTR(a, alt_offset)
 
@@ -107,31 +107,52 @@ static u32 get_alt_insn(struct alt_instr
 	return insn;
 }
 
+static void patch_alternative(struct alt_instr *alt,
+			      __le32 *origptr, __le32 *updptr, int nr_inst)
+{
+	__le32 *replptr;
+	int i;
+
+	replptr = ALT_REPL_PTR(alt);
+	for (i = 0; i < nr_inst; i++) {
+		u32 insn;
+
+		insn = get_alt_insn(alt, origptr + i, replptr + i);
+		updptr[i] = cpu_to_le32(insn);
+	}
+}
+
 static void __apply_alternatives(void *alt_region)
 {
 	struct alt_instr *alt;
 	struct alt_region *region = alt_region;
-	u32 *origptr, *replptr;
+	__le32 *origptr;
+	alternative_cb_t alt_cb;
 
 	for (alt = region->begin; alt < region->end; alt++) {
-		u32 insn;
-		int i, nr_inst;
+		int nr_inst;
 
-		if (!cpus_have_cap(alt->cpufeature))
+		/* Use ARM64_CB_PATCH as an unconditional patch */
+		if (alt->cpufeature < ARM64_CB_PATCH &&
+		    !cpus_have_cap(alt->cpufeature))
 			continue;
 
-		BUG_ON(alt->alt_len != alt->orig_len);
+		if (alt->cpufeature == ARM64_CB_PATCH)
+			BUG_ON(alt->alt_len != 0);
+		else
+			BUG_ON(alt->alt_len != alt->orig_len);
 
 		pr_info_once("patching kernel code\n");
 
 		origptr = ALT_ORIG_PTR(alt);
-		replptr = ALT_REPL_PTR(alt);
-		nr_inst = alt->alt_len / sizeof(insn);
+		nr_inst = alt->orig_len / AARCH64_INSN_SIZE;
 
-		for (i = 0; i < nr_inst; i++) {
-			insn = get_alt_insn(alt, origptr + i, replptr + i);
-			*(origptr + i) = cpu_to_le32(insn);
-		}
+		if (alt->cpufeature < ARM64_CB_PATCH)
+			alt_cb = patch_alternative;
+		else
+			alt_cb  = ALT_REPL_PTR(alt);
+
+		alt_cb(alt, origptr, origptr, nr_inst);
 
 		flush_icache_range((uintptr_t)origptr,
 				   (uintptr_t)(origptr + nr_inst));


