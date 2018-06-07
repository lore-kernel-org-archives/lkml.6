Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pvP6AsxEGVthGQAAmS7hNA
	; Thu, 07 Jun 2018 14:44:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AAACB6089E; Thu,  7 Jun 2018 14:44:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5FA1A607DC;
	Thu,  7 Jun 2018 14:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5FA1A607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934936AbeFGOon (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:44:43 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40716 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934070AbeFGOoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:44:37 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvby-0005hJ-4I; Thu, 07 Jun 2018 15:09:58 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvaz-0002k3-0L; Thu, 07 Jun 2018 15:08:57 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, bp@alien8.de,
        "David Woodhouse" <dwmw@amazon.co.uk>, peterz@infradead.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>, karahmed@amazon.de
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.455756317@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 049/410] x86/cpuid: Fix up "virtual" IBRS/IBPB/STIBP
 feature bits on Intel
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit 7fcae1118f5fd44a862aa5c3525248e35ee67c3b upstream.

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
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/cpu/common.c | 21 +++++++++++++++++++++
 arch/x86/kernel/cpu/intel.c  | 27 ++++++++-------------------
 2 files changed, 29 insertions(+), 19 deletions(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -682,6 +682,26 @@ static void apply_forced_caps(struct cpu
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
 	u32 tfms, xlvl;
@@ -735,6 +755,7 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_power = cpuid_edx(0x80000007);
 
 	init_scattered_cpuid_features(c);
+	init_speculation_control(c);
 }
 
 static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -105,28 +105,17 @@ static void early_init_intel(struct cpui
 		rdmsr(MSR_IA32_UCODE_REV, lower_word, c->microcode);
 	}
 
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
