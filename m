Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44840C43615
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058AC208F7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058AC208F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeHWUPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:15:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:1816 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726881AbeHWUPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:15:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2018 09:45:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,278,1531810800"; 
   d="scan'208";a="227129280"
Received: from chang-linux-2.sc.intel.com ([10.3.52.139])
  by orsmga004.jf.intel.com with ESMTP; 23 Aug 2018 09:45:16 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH V5 8/8] x86/vdso: Move out the CPU initialization
Date:   Thu, 23 Aug 2018 09:44:38 -0700
Message-Id: <1535042678-31366-9-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535042678-31366-1-git-send-email-chang.seok.bae@intel.com>
References: <1535042678-31366-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU and node number will be written, as early enough,
to the segment limit of per CPU data and TSC_AUX MSR entry.
The information has been retrieved by vgetcpu in user space
and will be also loaded from the paranoid entry, when
FSGSBASE enabled.

The new setup function is named after the getcpu(2) system
call, and will be called during each CPU initialization
(before setting up IST). It makes a facility useful to both
the kernel and userspace unconditionally available much
sooner.

The change brings a substantial code removal. The redundant
setting of the segment in entry/vdso/vma.c and hotplug
notifier are removed.

Suggested-by: H. Peter Anvin <hpa@zytor.com>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/entry/vdso/vma.c    | 33 +--------------------------------
 arch/x86/kernel/cpu/common.c | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 32 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 378732a..3f9d43f 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -332,35 +332,6 @@ static __init int vdso_setup(char *s)
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
-	unsigned long cpudata = vdso_encode_cpu_node(cpu, cpu_to_node(cpu));
-
-	if (static_cpu_has(X86_FEATURE_RDTSCP))
-		write_rdtscp_aux(cpudata);
-
-	/* Store cpu and node number in limit */
-	d.limit0 = cpudata;
-	d.limit1 = cpudata >> 16;
-
-	d.type = 5;		/* RO data, expand down, accessed */
-	d.dpl = 3;		/* Visible to user code */
-	d.s = 1;		/* Not a system segment */
-	d.p = 1;		/* Present */
-	d.d = 1;		/* 32-bit */
-
-	write_gdt_entry(get_cpu_gdt_rw(cpu), GDT_ENTRY_CPU_NUMBER, &d, DESCTYPE_S);
-}
-
-static int vgetcpu_online(unsigned int cpu)
-{
-	return smp_call_function_single(cpu, vgetcpu_cpu_init, NULL, 1);
-}
 
 static int __init init_vdso(void)
 {
@@ -370,9 +341,7 @@ static int __init init_vdso(void)
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
index eb4cb3e..e418e31 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1651,6 +1651,29 @@ static void wait_for_master_cpu(int cpu)
 #endif
 }
 
+#ifdef CONFIG_X86_64
+static void setup_getcpu(int cpu)
+{
+	unsigned long cpudata = vdso_encode_cpu_node(cpu, early_cpu_to_node(cpu));
+	struct desc_struct d = { };
+
+	if (static_cpu_has(X86_FEATURE_RDTSCP))
+		write_rdtscp_aux(cpudata);
+
+	/* Store cpu and node number in limit. */
+	d.limit0 = cpudata;
+	d.limit1 = cpudata >> 16;
+
+	d.type = 5;		/* RO data, expand down, accessed */
+	d.dpl = 3;		/* Visible to user code */
+	d.s = 1;		/* Not a system segment */
+	d.p = 1;		/* Present */
+	d.d = 1;		/* 32-bit */
+
+	write_gdt_entry(get_cpu_gdt_rw(cpu), GDT_ENTRY_CPU_NUMBER, &d, DESCTYPE_S);
+}
+#endif
+
 /*
  * cpu_init() initializes state that is per-CPU. Some data is already
  * initialized (naturally) in the bootstrap process, such as the GDT
@@ -1688,6 +1711,7 @@ void cpu_init(void)
 	    early_cpu_to_node(cpu) != NUMA_NO_NODE)
 		set_numa_node(early_cpu_to_node(cpu));
 #endif
+	setup_getcpu(cpu);
 
 	me = current;
 
-- 
2.7.4

