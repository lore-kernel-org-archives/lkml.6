Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932186AbeBGAD4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 19:03:56 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:36282 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932152AbeBGADr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 19:03:47 -0500
X-IronPort-AV: E=Sophos;i="5.46,470,1511827200";
   d="scan'208";a="707180262"
From: David Woodhouse <dwmw@amazon.co.uk>
To: tglx@linutronix.de, torvalds@linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, peterz@infradead.org,
        tim.c.chen@linux.intel.com, dave.hansen@intel.com,
        arjan.van.de.ven@intel.com
Subject: [RFC PATCH 4/4] x86/speculation: Support "Enhanced IBRS" on future CPUs
Date: Wed,  7 Feb 2018 00:03:14 +0000
Message-Id: <1517961794-14972-5-git-send-email-dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517961794-14972-1-git-send-email-dwmw@amazon.co.uk>
References: <1517961794-14972-1-git-send-email-dwmw@amazon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original IBRS hack in microcode is horribly slow. For the next
generation of CPUs, as a stopgap until we get a proper fix, Intel
promise an "Enhanced IBRS" which will be fast.

The assumption is that predictions in the BTB/RSB will be tagged with
the VMX mode and ring that they were learned in, and thus we can avoid
consuming unsafe predictions without a performance penalty.

This does not actually *set* the IBRS bit in the SPEC_CTRL register,
because Intel's documentation is wrong. Not wrong in the sense of
"does not accurately describe Intel's planned future hardware", but
more in the sense that if Intel make hardware like that, then they
are Doing It Wrong™.

With IBRS_ALL advertised in IA32_ARCH_CAPABILITIES, the IBRS bit in
the MSR should do *nothing*. The safe mode where the CPU honours the
tags in the BTB/RSB should be enabled *unconditionally*.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/nospec-branch.h |  2 +-
 arch/x86/kernel/cpu/bugs.c           | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 788c4da..9b65211 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -140,7 +140,7 @@ enum spectre_v2_mitigation {
 	SPECTRE_V2_RETPOLINE_MINIMAL_AMD,
 	SPECTRE_V2_RETPOLINE_GENERIC,
 	SPECTRE_V2_RETPOLINE_AMD,
-	SPECTRE_V2_IBRS,
+	SPECTRE_V2_IBRS_ALL,
 };
 
 extern char __indirect_thunk_start[];
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6f6d763..8dbbeda 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -88,6 +88,7 @@ static const char *spectre_v2_strings[] = {
 	[SPECTRE_V2_RETPOLINE_MINIMAL_AMD]	= "Vulnerable: Minimal AMD ASM retpoline",
 	[SPECTRE_V2_RETPOLINE_GENERIC]		= "Mitigation: Full generic retpoline",
 	[SPECTRE_V2_RETPOLINE_AMD]		= "Mitigation: Full AMD retpoline",
+	[SPECTRE_V2_IBRS_ALL]			= "Mitigation: Enhanced IBRS",
 };
 
 #undef pr_fmt
@@ -240,6 +241,15 @@ static void __init spectre_v2_select_mitigation(void)
 
 	case SPECTRE_V2_CMD_FORCE:
 	case SPECTRE_V2_CMD_AUTO:
+		if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES)) {
+			u64 ia32_cap = 0;
+
+			rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
+			if (ia32_cap & ARCH_CAP_IBRS_ALL) {
+				mode = SPECTRE_V2_IBRS_ALL;
+				goto ibrs_all;
+			}
+		}
 		if (IS_ENABLED(CONFIG_RETPOLINE))
 			goto retpoline_auto;
 		break;
@@ -277,6 +287,7 @@ static void __init spectre_v2_select_mitigation(void)
 		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
 	}
 
+ ibrs_all:
 	spectre_v2_enabled = mode;
 	pr_info("%s\n", spectre_v2_strings[mode]);
 
@@ -308,7 +319,7 @@ static void __init spectre_v2_select_mitigation(void)
 	 * Retpoline means the kernel is safe because it has no indirect
 	 * branches. But firmware isn't, so use IBRS to protect that.
 	 */
-	if (boot_cpu_has(X86_FEATURE_IBRS)) {
+	if (mode != SPECTRE_V2_IBRS_ALL && boot_cpu_has(X86_FEATURE_IBRS)) {
 		setup_force_cpu_cap(X86_FEATURE_USE_IBRS_FW);
 		pr_info("Enabling Restricted Speculation for firmware calls\n");
 	}
-- 
2.7.4
