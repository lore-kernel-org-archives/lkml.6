Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752055AbeELVMk (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 17:12:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38905 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751806AbeELVMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 17:12:39 -0400
Date: Sat, 12 May 2018 14:12:30 -0700
From: tip-bot for Suravee Suthikulpanit <tipbot@zytor.com>
Message-ID: <tip-3986a0a805e668a63fac0ca2cdfa8db951f87c4b@git.kernel.org>
Cc: suravee.suthikulpanit@amd.com, hpa@zytor.com, tglx@linutronix.de,
        bp@suse.de, linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, suravee.suthikulpanit@amd.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, bp@suse.de
In-Reply-To: <1524865681-112110-3-git-send-email-suravee.suthikulpanit@amd.com>
References: <1524865681-112110-3-git-send-email-suravee.suthikulpanit@amd.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/CPU/AMD: Derive CPU topology from CPUID function
 0xB when available
Git-Commit-ID: 3986a0a805e668a63fac0ca2cdfa8db951f87c4b
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

Commit-ID:  3986a0a805e668a63fac0ca2cdfa8db951f87c4b
Gitweb:     https://git.kernel.org/tip/3986a0a805e668a63fac0ca2cdfa8db951f87c4b
Author:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
AuthorDate: Fri, 27 Apr 2018 16:48:01 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 6 May 2018 12:49:16 +0200

x86/CPU/AMD: Derive CPU topology from CPUID function 0xB when available

Derive topology information from Extended Topology Enumeration (CPUID
function 0xB) when the information is available.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1524865681-112110-3-git-send-email-suravee.suthikulpanit@amd.com

---
 arch/x86/kernel/cpu/amd.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index bf27246bb7bd..55361ee04cc5 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -327,6 +327,7 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
 
 	/* get information required for multi-node processors */
 	if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
+		int err;
 		u32 eax, ebx, ecx, edx;
 
 		cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
@@ -344,6 +345,14 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
 				c->x86_max_cores /= smp_num_siblings;
 		}
 
+		/*
+		 * In case leaf B is available, use it to derive
+		 * topology information.
+		 */
+		err = detect_extended_topology(c);
+		if (!err)
+			c->x86_coreid_bits = get_count_order(c->x86_max_cores);
+
 		cacheinfo_amd_init_llc_id(c, cpu, node_id);
 
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
@@ -378,7 +387,6 @@ static void amd_detect_cmp(struct cpuinfo_x86 *c)
 	c->phys_proc_id = c->initial_apicid >> bits;
 	/* use socket ID also for last level cache */
 	per_cpu(cpu_llc_id, cpu) = c->phys_proc_id;
-	amd_get_topology(c);
 }
 
 u16 amd_get_nb_id(int cpu)
@@ -821,6 +829,7 @@ static void init_amd(struct cpuinfo_x86 *c)
 	/* Multi core CPU? */
 	if (c->extended_cpuid_level >= 0x80000008) {
 		amd_detect_cmp(c);
+		amd_get_topology(c);
 		srat_detect_node(c);
 	}
 
