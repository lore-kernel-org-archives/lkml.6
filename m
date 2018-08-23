Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295BEC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8ADA20839
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8ADA20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387859AbeHWMU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:20:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51718 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbeHWMU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:20:58 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 91422C5C;
        Thu, 23 Aug 2018 08:52:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rohit Khanna <rokhanna@nvidia.com>,
        Alexander Van Brunt <avanbrunt@nvidia.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 133/324] arm64: Avoid flush_icache_range() in alternatives patching code
Date:   Thu, 23 Aug 2018 09:53:19 +0200
Message-Id: <20180823075002.625165495@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

[ Upstream commit 429388682dc266e7a693f9c27e3aabd341d55343 ]

The implementation of flush_icache_range() includes instruction sequences
which are themselves patched at runtime, so it is not safe to call from
the patching framework.

This patch reworks the alternatives cache-flushing code so that it rolls
its own internal D-cache maintenance using DC CIVAC before invalidating
the entire I-cache after all alternatives have been applied at boot.
Modules don't cause any issues, since flush_icache_range() is safe to
call by the time they are loaded.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: Rohit Khanna <rokhanna@nvidia.com>
Cc: Alexander Van Brunt <avanbrunt@nvidia.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/alternative.h |    7 ++++
 arch/arm64/kernel/alternative.c      |   51 ++++++++++++++++++++++++++++++-----
 arch/arm64/kernel/module.c           |    5 +--
 3 files changed, 52 insertions(+), 11 deletions(-)

--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -28,7 +28,12 @@ typedef void (*alternative_cb_t)(struct
 				 __le32 *origptr, __le32 *updptr, int nr_inst);
 
 void __init apply_alternatives_all(void);
-void apply_alternatives(void *start, size_t length);
+
+#ifdef CONFIG_MODULES
+void apply_alternatives_module(void *start, size_t length);
+#else
+static inline void apply_alternatives_module(void *start, size_t length) { }
+#endif
 
 #define ALTINSTR_ENTRY(feature,cb)					      \
 	" .word 661b - .\n"				/* label           */ \
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -122,7 +122,30 @@ static void patch_alternative(struct alt
 	}
 }
 
-static void __apply_alternatives(void *alt_region, bool use_linear_alias)
+/*
+ * We provide our own, private D-cache cleaning function so that we don't
+ * accidentally call into the cache.S code, which is patched by us at
+ * runtime.
+ */
+static void clean_dcache_range_nopatch(u64 start, u64 end)
+{
+	u64 cur, d_size, ctr_el0;
+
+	ctr_el0 = read_sanitised_ftr_reg(SYS_CTR_EL0);
+	d_size = 4 << cpuid_feature_extract_unsigned_field(ctr_el0,
+							   CTR_DMINLINE_SHIFT);
+	cur = start & ~(d_size - 1);
+	do {
+		/*
+		 * We must clean+invalidate to the PoC in order to avoid
+		 * Cortex-A53 errata 826319, 827319, 824069 and 819472
+		 * (this corresponds to ARM64_WORKAROUND_CLEAN_CACHE)
+		 */
+		asm volatile("dc civac, %0" : : "r" (cur) : "memory");
+	} while (cur += d_size, cur < end);
+}
+
+static void __apply_alternatives(void *alt_region, bool is_module)
 {
 	struct alt_instr *alt;
 	struct alt_region *region = alt_region;
@@ -145,7 +168,7 @@ static void __apply_alternatives(void *a
 		pr_info_once("patching kernel code\n");
 
 		origptr = ALT_ORIG_PTR(alt);
-		updptr = use_linear_alias ? lm_alias(origptr) : origptr;
+		updptr = is_module ? origptr : lm_alias(origptr);
 		nr_inst = alt->orig_len / AARCH64_INSN_SIZE;
 
 		if (alt->cpufeature < ARM64_CB_PATCH)
@@ -155,8 +178,20 @@ static void __apply_alternatives(void *a
 
 		alt_cb(alt, origptr, updptr, nr_inst);
 
-		flush_icache_range((uintptr_t)origptr,
-				   (uintptr_t)(origptr + nr_inst));
+		if (!is_module) {
+			clean_dcache_range_nopatch((u64)origptr,
+						   (u64)(origptr + nr_inst));
+		}
+	}
+
+	/*
+	 * The core module code takes care of cache maintenance in
+	 * flush_module_icache().
+	 */
+	if (!is_module) {
+		dsb(ish);
+		__flush_icache_all();
+		isb();
 	}
 }
 
@@ -178,7 +213,7 @@ static int __apply_alternatives_multi_st
 		isb();
 	} else {
 		BUG_ON(alternatives_applied);
-		__apply_alternatives(&region, true);
+		__apply_alternatives(&region, false);
 		/* Barriers provided by the cache flushing */
 		WRITE_ONCE(alternatives_applied, 1);
 	}
@@ -192,12 +227,14 @@ void __init apply_alternatives_all(void)
 	stop_machine(__apply_alternatives_multi_stop, NULL, cpu_online_mask);
 }
 
-void apply_alternatives(void *start, size_t length)
+#ifdef CONFIG_MODULES
+void apply_alternatives_module(void *start, size_t length)
 {
 	struct alt_region region = {
 		.begin	= start,
 		.end	= start + length,
 	};
 
-	__apply_alternatives(&region, false);
+	__apply_alternatives(&region, true);
 }
+#endif
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -448,9 +448,8 @@ int module_finalize(const Elf_Ehdr *hdr,
 	const char *secstrs = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 
 	for (s = sechdrs, se = sechdrs + hdr->e_shnum; s < se; s++) {
-		if (strcmp(".altinstructions", secstrs + s->sh_name) == 0) {
-			apply_alternatives((void *)s->sh_addr, s->sh_size);
-		}
+		if (strcmp(".altinstructions", secstrs + s->sh_name) == 0)
+			apply_alternatives_module((void *)s->sh_addr, s->sh_size);
 #ifdef CONFIG_ARM64_MODULE_PLTS
 		if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
 		    !strcmp(".text.ftrace_trampoline", secstrs + s->sh_name))


