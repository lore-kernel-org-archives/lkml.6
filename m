Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753594AbeA3Wkz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:40:55 -0500
Received: from terminus.zytor.com ([65.50.211.136]:48863 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbeA3Wk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:40:26 -0500
Date: Tue, 30 Jan 2018 14:39:20 -0800
From: tip-bot for David Woodhouse <tipbot@zytor.com>
Message-ID: <tip-7fcae1118f5fd44a862aa5c3525248e35ee67c3b@git.kernel.org>
Cc: mingo@kernel.org, hpa@zytor.com, dwmw@amazon.co.uk, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, dwmw@amazon.co.uk,
        hpa@zytor.com, mingo@kernel.org
In-Reply-To: <1517322623-15261-1-git-send-email-dwmw@amazon.co.uk>
References: <1517322623-15261-1-git-send-email-dwmw@amazon.co.uk>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/cpuid: Fix up "virtual" IBRS/IBPB/STIBP feature
 bits on Intel
Git-Commit-ID: 7fcae1118f5fd44a862aa5c3525248e35ee67c3b
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

Commit-ID:  7fcae1118f5fd44a862aa5c3525248e35ee67c3b
Gitweb:     https://git.kernel.org/tip/7fcae1118f5fd44a862aa5c3525248e35ee67c3b
Author:     David Woodhouse <dwmw@amazon.co.uk>
AuthorDate: Tue, 30 Jan 2018 14:30:23 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 30 Jan 2018 22:35:05 +0100

x86/cpuid: Fix up "virtual" IBRS/IBPB/STIBP feature bits on Intel

Despite the fact that all the other code there seems to be doing it, just
using set_cpu_cap() in early_intel_init() doesn't actually work.

For CPUs with PKU support, setup_pku() calls get_cpu_cap() after
c->c_init() has set those feature bits. That resets those bits back to what
was queried from the hardware.

Turning the bits off for bad microcode is easy to fix. That can just use
setup_clear_cpu_cap() to force them off for all CPUs.

I was less keen on forcing the feature bits *on* that way, just in case
of inconsistencies. I appreciate that the kernel is going to get this
utterly wrong if CPU features are not consistent, because it has already
applied alternatives by the time secondary CPUs are brought up.

But at least if setup_force_cpu_cap() isn't being used, we might have a
chance of *detecting* the lack of the corresponding bit and either
panicking or refusing to bring the offending CPU online.

So ensure that the appropriate feature bits are set within get_cpu_cap()
regardless of how many extra times it's called.

Fixes: 2961298e ("x86/cpufeatures: Clean up Spectre v2 related CPUID flags")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: karahmed@amazon.de
Cc: peterz@infradead.org
Cc: bp@alien8.de
Link: https://lkml.kernel.org/r/1517322623-15261-1-git-send-email-dwmw@amazon.co.uk

---
 arch/x86/kernel/cpu/common.c | 21 +++++++++++++++++++++
 arch/x86/kernel/cpu/intel.c  | 27 ++++++++-------------------
 2 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c7c996a..dd09270 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -750,6 +750,26 @@ static void apply_forced_caps(struct cpuinfo_x86 *c)
 	}
 }
 
+static void init_speculation_control(struct cpuinfo_x86 *c)
+{
+	/*
+	 * The Intel SPEC_CTRL CPUID bit implies IBRS and IBPB support,
+	 * and they also have a different bit for STIBP support. Also,
+	 * a hypervisor might have set the individual AMD bits even on
+	 * Intel CPUs, for finer-grained selection of what's available.
+	 *
+	 * We use the AMD bits in 0x8000_0008 EBX as the generic hardware
+	 * features, which are visible in /proc/cpuinfo and used by the
+	 * kernel. So set those accordingly from the Intel bits.
+	 */
+	if (cpu_has(c, X86_FEATURE_SPEC_CTRL)) {
+		set_cpu_cap(c, X86_FEATURE_IBRS);
+		set_cpu_cap(c, X86_FEATURE_IBPB);
+	}
+	if (cpu_has(c, X86_FEATURE_INTEL_STIBP))
+		set_cpu_cap(c, X86_FEATURE_STIBP);
+}
+
 void get_cpu_cap(struct cpuinfo_x86 *c)
 {
 	u32 eax, ebx, ecx, edx;
@@ -844,6 +864,7 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_capability[CPUID_8000_000A_EDX] = cpuid_edx(0x8000000a);
 
 	init_scattered_cpuid_features(c);
+	init_speculation_control(c);
 
 	/*
 	 * Clear/Set all flags overridden by options, after probe.
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 6936d14..319bf98 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -175,28 +175,17 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	if (c->x86 >= 6 && !cpu_has(c, X86_FEATURE_IA64))
 		c->microcode = intel_get_microcode_revision();
 
-	/*
-	 * The Intel SPEC_CTRL CPUID bit implies IBRS and IBPB support,
-	 * and they also have a different bit for STIBP support. Also,
-	 * a hypervisor might have set the individual AMD bits even on
-	 * Intel CPUs, for finer-grained selection of what's available.
-	 */
-	if (cpu_has(c, X86_FEATURE_SPEC_CTRL)) {
-		set_cpu_cap(c, X86_FEATURE_IBRS);
-		set_cpu_cap(c, X86_FEATURE_IBPB);
-	}
-	if (cpu_has(c, X86_FEATURE_INTEL_STIBP))
-		set_cpu_cap(c, X86_FEATURE_STIBP);
-
 	/* Now if any of them are set, check the blacklist and clear the lot */
-	if ((cpu_has(c, X86_FEATURE_IBRS) || cpu_has(c, X86_FEATURE_IBPB) ||
+	if ((cpu_has(c, X86_FEATURE_SPEC_CTRL) ||
+	     cpu_has(c, X86_FEATURE_INTEL_STIBP) ||
+	     cpu_has(c, X86_FEATURE_IBRS) || cpu_has(c, X86_FEATURE_IBPB) ||
 	     cpu_has(c, X86_FEATURE_STIBP)) && bad_spectre_microcode(c)) {
 		pr_warn("Intel Spectre v2 broken microcode detected; disabling Speculation Control\n");
-		clear_cpu_cap(c, X86_FEATURE_IBRS);
-		clear_cpu_cap(c, X86_FEATURE_IBPB);
-		clear_cpu_cap(c, X86_FEATURE_STIBP);
-		clear_cpu_cap(c, X86_FEATURE_SPEC_CTRL);
-		clear_cpu_cap(c, X86_FEATURE_INTEL_STIBP);
+		setup_clear_cpu_cap(X86_FEATURE_IBRS);
+		setup_clear_cpu_cap(X86_FEATURE_IBPB);
+		setup_clear_cpu_cap(X86_FEATURE_STIBP);
+		setup_clear_cpu_cap(X86_FEATURE_SPEC_CTRL);
+		setup_clear_cpu_cap(X86_FEATURE_INTEL_STIBP);
 	}
 
 	/*
