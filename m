Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752899AbeA3Oaq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 09:30:46 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:17169 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752495AbeA3Oan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 09:30:43 -0500
X-IronPort-AV: E=Sophos;i="5.46,435,1511827200";
   d="scan'208";a="591283487"
From: David Woodhouse <dwmw@amazon.co.uk>
To: tglx@linutronix.de, karahmed@amazon.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, peterz@infradead.org
Subject: [PATCH v2] x86/cpuid: Fix up "virtual" IBRS/IBPB/STIBP feature bits on Intel
Date: Tue, 30 Jan 2018 14:30:23 +0000
Message-Id: <1517322623-15261-1-git-send-email-dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Despite the fact that all the other code there seems to be doing it,
just using set_cpu_cap() in early_intel_init() doesn't actually work.

For CPUs with PKU support, setup_pku() calls get_cpu_cap() after
c->c_init() has set those feature bits. That resets those bits back
to what was queried from the hardware.

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

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Fixes: 2961298e ("x86/cpufeatures: Clean up Spectre v2 related CPUID flags")
---

So...

We now understand why this didn't show up in my initial testing. It's not
*just* that I'm incompetent; it's setup_pku() which stomps on the bits
when it calls get_cpu_cap() again.

So Boris was right, and it would have been nicer if we hadn't been 
(ab)using the AMD bits as our generic visible feature bits for these.
Then they wouldn't have been stomped on again by get_cpu_cap() reading
the corresponding words from the hardware. Except...

Boris proposes that we introduce three new bits for IBRS/IBPB/STIBP and
make the AMD bits "hidden" too. So we'd need to set those new virtual
bits when *either* the AMD or the Intel feature bits are set.

That means we'd still have to add some code *somewhere* to set those
virtual bits. The AMD hardware bits, in particular, might be set even
by a hypervisor running on Intel CPUs since they allow combinations
like "IBPB only" to be advertised while the Intel-defined bits don't.

So we'd have to add code in a generic code path *anyway* to do that.

And since the main objection to my v1 patch was that it was adding the
code in a generic code path, it doesn't seem to be much of an improvement.

This v2 patch moves said code from scattered.c, which wasn't really
the right place, to a subfunction called from get_cpu_cap() directly.
You could do the shift to a separate three virtual feature bits on
top of this if you *really* wanted. I just don't see the point. 

We are, of course, still utterly hosed if the CPU capabilities are
inconsistent. But at least I didn't make things worse by making that
harder to detect by using setup_force_cpu_cap().

 arch/x86/kernel/cpu/common.c | 21 +++++++++++++++++++++
 arch/x86/kernel/cpu/intel.c  | 27 ++++++++-------------------
 2 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 970ee06..f9d8460 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -726,6 +726,26 @@ static void apply_forced_caps(struct cpuinfo_x86 *c)
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
@@ -820,6 +840,7 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_capability[CPUID_8000_000A_EDX] = cpuid_edx(0x8000000a);
 
 	init_scattered_cpuid_features(c);
+	init_speculation_control(c);
 
 	/*
 	 * Clear/Set all flags overridden by options, after probe.
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 0c8b916..4cf4f8c 100644
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
-- 
2.7.4
