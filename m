Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032615AbeCSWdR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 18:33:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50878 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933716AbeCSPsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:04 -0400
Message-Id: <20180319154717.705383007@infradead.org>
User-Agent: quilt/0.63-1
Date: Mon, 19 Mar 2018 16:41:26 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 2/2] x86: Remove FAST_FEATURE_TESTS
References: <20180319154124.337947038@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-x86-remove-fast-feature.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we want to rely on static branches to avoid speculation, remove
any possible fallback code for static_cpu_has.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/Kconfig                  |   11 -----------
 arch/x86/include/asm/cpufeature.h |    8 --------
 2 files changed, 19 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -393,17 +393,6 @@ config X86_FEATURE_NAMES
 
 	  If in doubt, say Y.
 
-config X86_FAST_FEATURE_TESTS
-	bool "Fast CPU feature tests" if EMBEDDED
-	default y
-	---help---
-	  Some fast-paths in the kernel depend on the capabilities of the CPU.
-	  Say Y here for the kernel to patch in the appropriate code at runtime
-	  based on the capabilities of the CPU. The infrastructure for patching
-	  code at runtime takes up some additional space; space-constrained
-	  embedded systems may wish to say N here to produce smaller, slightly
-	  slower code.
-
 config X86_X2APIC
 	bool "Support x2apic"
 	depends on X86_LOCAL_APIC && X86_64 && (IRQ_REMAP || HYPERVISOR_GUEST)
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -140,7 +140,6 @@ extern void clear_cpu_cap(struct cpuinfo
 
 #define setup_force_cpu_bug(bit) setup_force_cpu_cap(bit)
 
-#if defined(CC_HAVE_ASM_GOTO) && defined(CONFIG_X86_FAST_FEATURE_TESTS)
 /*
  * Static testing of CPU features.  Used the same as boot_cpu_has().
  * These will statically patch the target code for additional
@@ -196,13 +195,6 @@ static __always_inline __pure bool _stat
 		boot_cpu_has(bit) :				\
 		_static_cpu_has(bit)				\
 )
-#else
-/*
- * Fall back to dynamic for gcc versions which don't support asm goto. Should be
- * a minority now anyway.
- */
-#define static_cpu_has(bit)		boot_cpu_has(bit)
-#endif
 
 #define cpu_has_bug(c, bit)		cpu_has(c, (bit))
 #define set_cpu_bug(c, bit)		set_cpu_cap(c, (bit))
