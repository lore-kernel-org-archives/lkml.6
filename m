Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751969AbeELVKD (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 17:10:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:32897 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeELVKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 17:10:02 -0400
Date: Sat, 12 May 2018 14:09:47 -0700
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-f8b64d08dde2714c62751d18ba77f4aeceb161d3@git.kernel.org>
Cc: hpa@zytor.com, mingo@kernel.org, suravee.suthikulpanit@amd.com,
        linux-kernel@vger.kernel.org, bpetkov@suse.de, tglx@linutronix.de,
        bp@suse.de
Reply-To: suravee.suthikulpanit@amd.com, bp@suse.de, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, bpetkov@suse.de, hpa@zytor.com,
        mingo@kernel.org
In-Reply-To: <1524864877-111962-2-git-send-email-suravee.suthikulpanit@amd.com>
References: <1524864877-111962-2-git-send-email-suravee.suthikulpanit@amd.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/CPU/AMD: Have smp_num_siblings and cpu_llc_id
 always be present
Git-Commit-ID: f8b64d08dde2714c62751d18ba77f4aeceb161d3
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

Commit-ID:  f8b64d08dde2714c62751d18ba77f4aeceb161d3
Gitweb:     https://git.kernel.org/tip/f8b64d08dde2714c62751d18ba77f4aeceb161d3
Author:     Borislav Petkov <bpetkov@suse.de>
AuthorDate: Fri, 27 Apr 2018 16:34:34 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 6 May 2018 12:49:14 +0200

x86/CPU/AMD: Have smp_num_siblings and cpu_llc_id always be present

Move smp_num_siblings and cpu_llc_id to cpu/common.c so that they're
always present as symbols and not only in the CONFIG_SMP case. Then,
other code using them doesn't need ugly ifdeffery anymore. Get rid of
some ifdeffery.

Signed-off-by: Borislav Petkov <bpetkov@suse.de>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1524864877-111962-2-git-send-email-suravee.suthikulpanit@amd.com

---
 arch/x86/include/asm/smp.h   |  1 -
 arch/x86/kernel/cpu/amd.c    | 10 +---------
 arch/x86/kernel/cpu/common.c |  7 +++++++
 arch/x86/kernel/smpboot.c    |  7 -------
 4 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index f75bff8f9d82..547c4fe50711 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -171,7 +171,6 @@ static inline int wbinvd_on_all_cpus(void)
 	wbinvd();
 	return 0;
 }
-#define smp_num_siblings	1
 #endif /* CONFIG_SMP */
 
 extern unsigned disabled_cpus;
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 12bc0a1139da..a37a83809665 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -297,7 +297,6 @@ static int nearby_node(int apicid)
 }
 #endif
 
-#ifdef CONFIG_SMP
 /*
  * Fix up cpu_core_id for pre-F17h systems to be in the
  * [0 .. cores_per_node - 1] range. Not really needed but
@@ -375,7 +374,6 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
 		legacy_fixup_core_id(c);
 	}
 }
-#endif
 
 /*
  * On a AMD dual core setup the lower bits of the APIC id distinguish the cores.
@@ -383,7 +381,6 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
  */
 static void amd_detect_cmp(struct cpuinfo_x86 *c)
 {
-#ifdef CONFIG_SMP
 	unsigned bits;
 	int cpu = smp_processor_id();
 
@@ -395,16 +392,11 @@ static void amd_detect_cmp(struct cpuinfo_x86 *c)
 	/* use socket ID also for last level cache */
 	per_cpu(cpu_llc_id, cpu) = c->phys_proc_id;
 	amd_get_topology(c);
-#endif
 }
 
 u16 amd_get_nb_id(int cpu)
 {
-	u16 id = 0;
-#ifdef CONFIG_SMP
-	id = per_cpu(cpu_llc_id, cpu);
-#endif
-	return id;
+	return per_cpu(cpu_llc_id, cpu);
 }
 EXPORT_SYMBOL_GPL(amd_get_nb_id);
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 8a5b185735e1..37c7c8334a00 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -66,6 +66,13 @@ cpumask_var_t cpu_callin_mask;
 /* representing cpus for which sibling maps can be computed */
 cpumask_var_t cpu_sibling_setup_mask;
 
+/* Number of siblings per CPU package */
+int smp_num_siblings = 1;
+EXPORT_SYMBOL(smp_num_siblings);
+
+/* Last level cache ID of each logical CPU */
+DEFINE_PER_CPU_READ_MOSTLY(u16, cpu_llc_id) = BAD_APICID;
+
 /* correctly size the local cpu masks */
 void __init setup_cpu_local_masks(void)
 {
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ff99e2b6fc54..91d48f3eeda8 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -78,13 +78,6 @@
 #include <asm/misc.h>
 #include <asm/qspinlock.h>
 
-/* Number of siblings per CPU package */
-int smp_num_siblings = 1;
-EXPORT_SYMBOL(smp_num_siblings);
-
-/* Last level cache ID of each logical CPU */
-DEFINE_PER_CPU_READ_MOSTLY(u16, cpu_llc_id) = BAD_APICID;
-
 /* representing HT siblings of each logical CPU */
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
 EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
