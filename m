Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbeEVJF6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 05:05:58 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:34394 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeEVJF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 05:05:57 -0400
Date: Tue, 22 May 2018 11:05:39 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: konrad.wilk@oracle.com, tglx@linutronix.de, mingo@kernel.org,
        bp@suse.de
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/speculation: Simplify the CPU bug detection logic
Message-ID: <20180522090539.GA24668@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only CPUs which speculate can speculate. Therefore, it seems prudent
to test for cpu_no_speculation first and only then determine whether
a specific speculating CPU is susceptible to store bypass speculation.
This is underlined by all CPUs currently listed in cpu_no_speculation
were present in cpu_no_spec_store_bypass as well.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/kernel/cpu/common.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 78decc3e3067..2fcc1fbf11b0 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -942,12 +942,8 @@ static const __initconst struct x86_cpu_id cpu_no_meltdown[] = {
 	{}
 };
 
+/* Only list CPUs which speculate but are non susceptible to SSB */
 static const __initconst struct x86_cpu_id cpu_no_spec_store_bypass[] = {
-	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_PINEVIEW	},
-	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_LINCROFT	},
-	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_PENWELL		},
-	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_CLOVERVIEW	},
-	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_CEDARVIEW	},
 	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_SILVERMONT1	},
 	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_AIRMONT		},
 	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_SILVERMONT2	},
@@ -955,14 +951,10 @@ static const __initconst struct x86_cpu_id cpu_no_spec_store_bypass[] = {
 	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_CORE_YONAH		},
 	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_XEON_PHI_KNL		},
 	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_XEON_PHI_KNM		},
-	{ X86_VENDOR_CENTAUR,	5,					},
-	{ X86_VENDOR_INTEL,	5,					},
-	{ X86_VENDOR_NSC,	5,					},
 	{ X86_VENDOR_AMD,	0x12,					},
 	{ X86_VENDOR_AMD,	0x11,					},
 	{ X86_VENDOR_AMD,	0x10,					},
 	{ X86_VENDOR_AMD,	0xf,					},
-	{ X86_VENDOR_ANY,	4,					},
 	{}
 };
 
@@ -973,16 +965,16 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	if (cpu_has(c, X86_FEATURE_ARCH_CAPABILITIES))
 		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
 
-	if (!x86_match_cpu(cpu_no_spec_store_bypass) &&
-	   !(ia32_cap & ARCH_CAP_SSB_NO))
-		setup_force_cpu_bug(X86_BUG_SPEC_STORE_BYPASS);
-
 	if (x86_match_cpu(cpu_no_speculation))
 		return;
 
 	setup_force_cpu_bug(X86_BUG_SPECTRE_V1);
 	setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
 
+	if (!x86_match_cpu(cpu_no_spec_store_bypass) &&
+	   !(ia32_cap & ARCH_CAP_SSB_NO))
+		setup_force_cpu_bug(X86_BUG_SPEC_STORE_BYPASS);
+
 	if (x86_match_cpu(cpu_no_meltdown))
 		return;
 
-- 
2.17.0
