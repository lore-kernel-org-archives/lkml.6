Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932202AbeEWJBl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:01:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34025 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932096AbeEWJBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:01:37 -0400
Date: Wed, 23 May 2018 02:01:27 -0700
From: tip-bot for Dominik Brodowski <tipbot@zytor.com>
Message-ID: <tip-8ecc4979b1bd9c94168e6fc92960033b7a951336@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org,
        linux@dominikbrodowski.net, tglx@linutronix.de, hpa@zytor.com
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        linux@dominikbrodowski.net, hpa@zytor.com
In-Reply-To: <20180522090539.GA24668@light.dominikbrodowski.net>
References: <20180522090539.GA24668@light.dominikbrodowski.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Simplify the CPU bug detection logic
Git-Commit-ID: 8ecc4979b1bd9c94168e6fc92960033b7a951336
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

Commit-ID:  8ecc4979b1bd9c94168e6fc92960033b7a951336
Gitweb:     https://git.kernel.org/tip/8ecc4979b1bd9c94168e6fc92960033b7a951336
Author:     Dominik Brodowski <linux@dominikbrodowski.net>
AuthorDate: Tue, 22 May 2018 11:05:39 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 23 May 2018 10:55:52 +0200

x86/speculation: Simplify the CPU bug detection logic

Only CPUs which speculate can speculate. Therefore, it seems prudent
to test for cpu_no_speculation first and only then determine whether
a specific speculating CPU is susceptible to store bypass speculation.
This is underlined by all CPUs currently listed in cpu_no_speculation
were present in cpu_no_spec_store_bypass as well.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: bp@suse.de
Cc: konrad.wilk@oracle.com
Link: https://lkml.kernel.org/r/20180522090539.GA24668@light.dominikbrodowski.net

---
 arch/x86/kernel/cpu/common.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 78decc3e3067..38276f58d3bf 100644
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
 
@@ -970,6 +962,12 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 {
 	u64 ia32_cap = 0;
 
+	if (x86_match_cpu(cpu_no_speculation))
+		return;
+
+	setup_force_cpu_bug(X86_BUG_SPECTRE_V1);
+	setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
+
 	if (cpu_has(c, X86_FEATURE_ARCH_CAPABILITIES))
 		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
 
@@ -977,12 +975,6 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	   !(ia32_cap & ARCH_CAP_SSB_NO))
 		setup_force_cpu_bug(X86_BUG_SPEC_STORE_BYPASS);
 
-	if (x86_match_cpu(cpu_no_speculation))
-		return;
-
-	setup_force_cpu_bug(X86_BUG_SPECTRE_V1);
-	setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
-
 	if (x86_match_cpu(cpu_no_meltdown))
 		return;
 
