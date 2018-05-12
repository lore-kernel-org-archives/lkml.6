Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbeELVLi (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 17:11:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47721 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751806AbeELVLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 17:11:37 -0400
Date: Sat, 12 May 2018 14:11:21 -0700
From: tip-bot for Suravee Suthikulpanit <tipbot@zytor.com>
Message-ID: <tip-68091ee7ac3c1a8786fe1bebbd616b14236efb99@git.kernel.org>
Cc: suravee.suthikulpanit@amd.com, mingo@kernel.org, bp@suse.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: suravee.suthikulpanit@amd.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, bp@suse.de, hpa@zytor.com,
        tglx@linutronix.de
In-Reply-To: <1524864877-111962-5-git-send-email-suravee.suthikulpanit@amd.com>
References: <1524864877-111962-5-git-send-email-suravee.suthikulpanit@amd.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/CPU/AMD: Calculate last level cache ID from
 number of sharing threads
Git-Commit-ID: 68091ee7ac3c1a8786fe1bebbd616b14236efb99
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

Commit-ID:  68091ee7ac3c1a8786fe1bebbd616b14236efb99
Gitweb:     https://git.kernel.org/tip/68091ee7ac3c1a8786fe1bebbd616b14236efb99
Author:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
AuthorDate: Fri, 27 Apr 2018 16:34:37 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 6 May 2018 12:49:15 +0200

x86/CPU/AMD: Calculate last level cache ID from number of sharing threads

Last Level Cache ID can be calculated from the number of threads sharing
the cache, which is available from CPUID Fn0x8000001D (Cache Properties).
This is used to left-shift the APIC ID to derive LLC ID.

Therefore, default to this method unless the APIC ID enumeration does not
follow the scheme.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1524864877-111962-5-git-send-email-suravee.suthikulpanit@amd.com

---
 arch/x86/include/asm/cacheinfo.h |  7 +++++++
 arch/x86/kernel/cpu/amd.c        | 19 +++----------------
 arch/x86/kernel/cpu/cacheinfo.c  | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/cacheinfo.h b/arch/x86/include/asm/cacheinfo.h
new file mode 100644
index 000000000000..e958e28f7ab5
--- /dev/null
+++ b/arch/x86/include/asm/cacheinfo.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_CACHEINFO_H
+#define _ASM_X86_CACHEINFO_H
+
+void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id);
+
+#endif /* _ASM_X86_CACHEINFO_H */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index a37a83809665..bf27246bb7bd 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -9,6 +9,7 @@
 #include <linux/random.h>
 #include <asm/processor.h>
 #include <asm/apic.h>
+#include <asm/cacheinfo.h>
 #include <asm/cpu.h>
 #include <asm/smp.h>
 #include <asm/pci-direct.h>
@@ -343,22 +344,8 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
 				c->x86_max_cores /= smp_num_siblings;
 		}
 
-		/*
-		 * We may have multiple LLCs if L3 caches exist, so check if we
-		 * have an L3 cache by looking at the L3 cache CPUID leaf.
-		 */
-		if (cpuid_edx(0x80000006)) {
-			if (c->x86 == 0x17) {
-				/*
-				 * LLC is at the core complex level.
-				 * Core complex id is ApicId[3].
-				 */
-				per_cpu(cpu_llc_id, cpu) = c->apicid >> 3;
-			} else {
-				/* LLC is at the node level. */
-				per_cpu(cpu_llc_id, cpu) = node_id;
-			}
-		}
+		cacheinfo_amd_init_llc_id(c, cpu, node_id);
+
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
 		u64 value;
 
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 54d04d574148..a2e03c9401a1 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -637,6 +637,45 @@ static int find_num_cache_leaves(struct cpuinfo_x86 *c)
 	return i;
 }
 
+void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id)
+{
+	/*
+	 * We may have multiple LLCs if L3 caches exist, so check if we
+	 * have an L3 cache by looking at the L3 cache CPUID leaf.
+	 */
+	if (!cpuid_edx(0x80000006))
+		return;
+
+	if (c->x86 < 0x17) {
+		/* LLC is at the node level. */
+		per_cpu(cpu_llc_id, cpu) = node_id;
+	} else if (c->x86 == 0x17 &&
+		   c->x86_model >= 0 && c->x86_model <= 0x1F) {
+		/*
+		 * LLC is at the core complex level.
+		 * Core complex ID is ApicId[3] for these processors.
+		 */
+		per_cpu(cpu_llc_id, cpu) = c->apicid >> 3;
+	} else {
+		/*
+		 * LLC ID is calculated from the number of threads sharing the
+		 * cache.
+		 * */
+		u32 eax, ebx, ecx, edx, num_sharing_cache = 0;
+		u32 llc_index = find_num_cache_leaves(c) - 1;
+
+		cpuid_count(0x8000001d, llc_index, &eax, &ebx, &ecx, &edx);
+		if (eax)
+			num_sharing_cache = ((eax >> 14) & 0xfff) + 1;
+
+		if (num_sharing_cache) {
+			int bits = get_count_order(num_sharing_cache) - 1;
+
+			per_cpu(cpu_llc_id, cpu) = c->apicid >> bits;
+		}
+	}
+}
+
 void init_amd_cacheinfo(struct cpuinfo_x86 *c)
 {
 
