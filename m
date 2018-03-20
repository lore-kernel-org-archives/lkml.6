Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752843AbeCTLRf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:17:35 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:56148 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751913AbeCTLRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:17:32 -0400
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH] x86/speculation: Fill the RSB on context switch also on
 non-IBPB CPUs
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw@amazon.co.uk>,
        KarimAllah Ahmed <karahmed@amazon.de>, Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>, thomas.lendacky@amd.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Message-ID: <9eb945bd-f77e-0301-d977-d1acf931b19d@maciej.szmigiero.name>
Date: Tue, 20 Mar 2018 12:17:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we run on a CPU that does not have IBPB support RSB entries from one
userspace process can influence 'ret' target prediction in another
userspace process after a context switch.

Since it is unlikely that existing RSB entries from the previous task match
the new task call stack we can use the existing unconditional
RSB-filling-on-context-switch infrastructure to protect against such
userspace-to-userspace attacks.

This patch brings a change in behavior only for the following CPU types:
* Intel pre-Skylake CPUs without updated microcode,
* AMD Family 15h model >60h, Family 17h CPUs without updated microcode.

Other CPU types either already do the RSB filling on context switch for
other reasons or do support IBPB for more complete userspace-to-userspace
protection.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 arch/x86/kernel/cpu/bugs.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index bfca937bdcc3..777bae86e159 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -280,8 +280,11 @@ static void __init spectre_v2_select_mitigation(void)
 	/*
 	 * If neither SMEP nor PTI are available, there is a risk of
 	 * hitting userspace addresses in the RSB after a context switch
-	 * from a shallow call stack to a deeper one. To prevent this fill
-	 * the entire RSB, even when using IBRS.
+	 * from a shallow call stack to a deeper one.
+	 * Also, if the CPU does not have IBPB support then one userspace
+	 * process can influence 'ret' target prediction for another
+	 * userspace process.
+	 * To prevent this fill the entire RSB, even when using IBRS.
 	 *
 	 * Skylake era CPUs have a separate issue with *underflow* of the
 	 * RSB, when they will predict 'ret' targets from the generic BTB.
@@ -290,7 +293,8 @@ static void __init spectre_v2_select_mitigation(void)
 	 * switch is required.
 	 */
 	if ((!boot_cpu_has(X86_FEATURE_PTI) &&
-	     !boot_cpu_has(X86_FEATURE_SMEP)) || is_skylake_era()) {
+	     !boot_cpu_has(X86_FEATURE_SMEP)) ||
+	     !boot_cpu_has(X86_FEATURE_IBPB) || is_skylake_era()) {
 		setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
 		pr_info("Spectre v2 mitigation: Filling RSB on context switch\n");
 	}
