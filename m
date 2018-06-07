Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 0MYEOrdlGVvNCgAAmS7hNA
	; Thu, 07 Jun 2018 17:06:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 63743607E7; Thu,  7 Jun 2018 17:06:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B01D960115;
	Thu,  7 Jun 2018 17:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B01D960115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934908AbeFGRGd (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:06:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:32208 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934581AbeFGRGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:06:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 10:06:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,487,1520924400";
   d="scan'208";a="206183231"
Received: from chang-linux-2.sc.intel.com ([10.3.52.139])
  by orsmga004.jf.intel.com with ESMTP; 07 Jun 2018 10:06:24 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 7/7] x86/vdso: Move out the CPU number store
Date: Thu,  7 Jun 2018 10:06:08 -0700
Message-Id: <1528391168-22224-8-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528391168-22224-1-git-send-email-chang.seok.bae@intel.com>
References: <1528391168-22224-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU (and node) number will be written, as early enough,
to the segment limit of per CPU data and TSC_AUX MSR entry.
The information has been retrieved by vgetcpu in user space
and will be also loaded from the paranoid entry, when
FSGSBASE enabled.

Now storing CPU number to the CPU_NUMBER segment limit is
done during the bootstrap, while MSR TSC_AUX is written
during each CPU initialization that is still before IST
setup.

The redundant setting of the segment in entry/vdso/vma.c
was removed; a substantial code removal. It removes a
hotplug notifier, makes a facility useful to both the kernel
and userspace unconditionally available much sooner.
(Thanks to HPA for suggesting the cleanup)

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/vdso/vma.c      | 41 +----------------------------------------
 arch/x86/kernel/cpu/common.c   | 13 +++++++++++++
 arch/x86/kernel/setup_percpu.c | 25 +++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 40 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 1fc93da..3f9d43f 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -332,43 +332,6 @@ static __init int vdso_setup(char *s)
 	return 0;
 }
 __setup("vdso=", vdso_setup);
-#endif
-
-#ifdef CONFIG_X86_64
-static void vgetcpu_cpu_init(void *arg)
-{
-	int cpu = smp_processor_id();
-	struct desc_struct d = { };
-	unsigned long node = 0;
-	unsigned long cpu_number = 0;
-#ifdef CONFIG_NUMA
-	node = cpu_to_node(cpu);
-#endif
-	cpu_number = make_lsl_tscp(cpu, node);
-
-	if (static_cpu_has(X86_FEATURE_RDTSCP))
-		write_rdtscp_aux(cpu_number);
-
-	/* Store cpu number in limit */
-	d.limit0 = cpu_number;
-	d.limit1 = cpu_number >> 16;
-
-	d.type = 5;		/* RO data, expand down, accessed */
-	d.dpl = 3;		/* Visible to user code */
-	d.s = 1;		/* Not a system segment */
-	d.p = 1;		/* Present */
-	d.d = 1;		/* 32-bit */
-
-	write_gdt_entry(get_cpu_gdt_rw(cpu),
-			GDT_ENTRY_CPU_NUMBER,
-			&d,
-			DESCTYPE_S);
-}
-
-static int vgetcpu_online(unsigned int cpu)
-{
-	return smp_call_function_single(cpu, vgetcpu_cpu_init, NULL, 1);
-}
 
 static int __init init_vdso(void)
 {
@@ -378,9 +341,7 @@ static int __init init_vdso(void)
 	init_vdso_image(&vdso_image_x32);
 #endif
 
-	/* notifier priority > KVM */
-	return cpuhp_setup_state(CPUHP_AP_X86_VDSO_VMA_ONLINE,
-				 "x86/vdso/vma:online", vgetcpu_online, NULL);
+	return 0;
 }
 subsys_initcall(init_vdso);
 #endif /* CONFIG_X86_64 */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 38276f5..9becdf5 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1606,6 +1606,18 @@ static void wait_for_master_cpu(int cpu)
 #endif
 }
 
+#ifdef CONFIG_X86_64
+static void setup_cpu_number(int cpu)
+{
+	/*
+	 * The cpu number is also stored in the CPU_NUMBER
+	 * segment limit
+	 */
+	if (static_cpu_has(X86_FEATURE_RDTSCP))
+		write_rdtscp_aux(make_lsl_tscp(cpu, early_cpu_to_node(cpu)));
+}
+#endif
+
 /*
  * cpu_init() initializes state that is per-CPU. Some data is already
  * initialized (naturally) in the bootstrap process, such as the GDT
@@ -1643,6 +1655,7 @@ void cpu_init(void)
 	    early_cpu_to_node(cpu) != NUMA_NO_NODE)
 		set_numa_node(early_cpu_to_node(cpu));
 #endif
+	setup_cpu_number(cpu);
 
 	me = current;
 
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index ea554f8..20bb78d 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -163,6 +163,30 @@ static inline void setup_percpu_segment(int cpu)
 #endif
 }
 
+static inline void setup_cpu_number_segment(int cpu)
+{
+#ifdef CONFIG_X86_64
+	unsigned long node = early_cpu_to_node(cpu);
+	unsigned long cpu_number = make_lsl_tscp(cpu, node);
+	struct desc_struct d = { };
+
+	/* Store cpu number in limit */
+	d.limit0 = cpu_number;
+	d.limit1 = cpu_number >> 16;
+
+	d.type = 5;		/* RO data, expand down, accessed */
+	d.dpl = 3;		/* Visible to user code */
+	d.s = 1;		/* Not a system segment */
+	d.p = 1;		/* Present */
+	d.d = 1;		/* 32-bit */
+
+	write_gdt_entry(get_cpu_gdt_rw(cpu),
+			GDT_ENTRY_CPU_NUMBER,
+			&d,
+			DESCTYPE_S);
+#endif
+}
+
 void __init setup_per_cpu_areas(void)
 {
 	unsigned int cpu;
@@ -223,6 +247,7 @@ void __init setup_per_cpu_areas(void)
 		per_cpu(cpu_number, cpu) = cpu;
 		setup_percpu_segment(cpu);
 		setup_stack_canary_segment(cpu);
+		setup_cpu_number_segment(cpu);
 		/*
 		 * Copy data used in early init routines from the
 		 * initial arrays to the per cpu data areas.  These
-- 
2.7.4
