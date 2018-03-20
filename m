Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbeCTKBs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 06:01:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53423 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752015AbeCTKBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 06:01:43 -0400
Date: Tue, 20 Mar 2018 03:01:16 -0700
From: tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-d0266046ad54e0c964941364cd82a0d0478ce286@git.kernel.org>
Cc: tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de
In-Reply-To: <20180319154717.705383007@infradead.org>
References: <20180319154717.705383007@infradead.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/build] x86: Remove FAST_FEATURE_TESTS
Git-Commit-ID: d0266046ad54e0c964941364cd82a0d0478ce286
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d0266046ad54e0c964941364cd82a0d0478ce286
Gitweb:     https://git.kernel.org/tip/d0266046ad54e0c964941364cd82a0d0478ce286
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Mon, 19 Mar 2018 16:41:26 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 20 Mar 2018 10:58:03 +0100

x86: Remove FAST_FEATURE_TESTS

Since we want to rely on static branches to avoid speculation, remove
any possible fallback code for static_cpu_has.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: torvalds@linux-foundation.org
Link: https://lkml.kernel.org/r/20180319154717.705383007@infradead.org

---
 arch/x86/Kconfig                  | 11 -----------
 arch/x86/include/asm/cpufeature.h |  8 --------
 2 files changed, 19 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0fa71a78ec99..cb5b5907dbd6 100644
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
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 736771c9822e..b27da9602a6d 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -140,7 +140,6 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
 
 #define setup_force_cpu_bug(bit) setup_force_cpu_cap(bit)
 
-#if defined(CC_HAVE_ASM_GOTO) && defined(CONFIG_X86_FAST_FEATURE_TESTS)
 /*
  * Static testing of CPU features.  Used the same as boot_cpu_has().
  * These will statically patch the target code for additional
@@ -196,13 +195,6 @@ t_no:
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
