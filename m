Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8699C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E852087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E852087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbeJHRKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:10:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43939 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeJHRKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:10:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w989wlLD560248
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 8 Oct 2018 02:58:47 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w989wlIQ560245;
        Mon, 8 Oct 2018 02:58:47 -0700
Date:   Mon, 8 Oct 2018 02:58:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Chang S. Bae" <tipbot@zytor.com>
Message-ID: <tip-b2e2ba578e016a091eb31565849990fe68c7c599@git.kernel.org>
Cc:     luto@kernel.org, riel@surriel.com, ravi.v.shankar@intel.com,
        markus.t.metzger@intel.com, mingo@kernel.org,
        chang.seok.bae@intel.com, hpa@zytor.com, peterz@infradead.org,
        dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        dave.hansen@linux.intel.com, luto@amacapital.net,
        tglx@linutronix.de, brgerst@gmail.com,
        torvalds@linux-foundation.org, bp@alien8.de
Reply-To: torvalds@linux-foundation.org, bp@alien8.de, brgerst@gmail.com,
          dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, luto@amacapital.net,
          dave.hansen@linux.intel.com, hpa@zytor.com,
          chang.seok.bae@intel.com, mingo@kernel.org, peterz@infradead.org,
          riel@surriel.com, ravi.v.shankar@intel.com, luto@kernel.org,
          markus.t.metzger@intel.com
In-Reply-To: <1537312139-5580-9-git-send-email-chang.seok.bae@intel.com>
References: <1537312139-5580-9-git-send-email-chang.seok.bae@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/vdso: Initialize the CPU/node NR segment
 descriptor earlier
Git-Commit-ID: b2e2ba578e016a091eb31565849990fe68c7c599
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b2e2ba578e016a091eb31565849990fe68c7c599
Gitweb:     https://git.kernel.org/tip/b2e2ba578e016a091eb31565849990fe68c7c599
Author:     Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate: Tue, 18 Sep 2018 16:08:59 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 8 Oct 2018 10:41:10 +0200

x86/vdso: Initialize the CPU/node NR segment descriptor earlier

Currently the CPU/node NR segment descriptor (GDT_ENTRY_CPU_NUMBER) is
initialized relatively late during CPU init, from the vCPU code, which
has a number of disadvantages, such as hotplug CPU notifiers and SMP
cross-calls.

Instead just initialize it much earlier, directly in cpu_init().

This reduces complexity and increases robustness.

[ mingo: Wrote new changelog. ]

Suggested-by: H. Peter Anvin <hpa@zytor.com>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Markus T Metzger <markus.t.metzger@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1537312139-5580-9-git-send-email-chang.seok.bae@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/vdso/vma.c    | 33 +--------------------------------
 arch/x86/kernel/cpu/common.c | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 32 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 39b5584c5808..3f9d43f26f63 100644
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
-	/* Store CPU and node number in limit */
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
index 44c4ef3d989b..a148d18a1ef0 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1669,6 +1669,29 @@ static void wait_for_master_cpu(int cpu)
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
+	/* Store CPU and node number in limit. */
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
@@ -1706,6 +1729,7 @@ void cpu_init(void)
 	    early_cpu_to_node(cpu) != NUMA_NO_NODE)
 		set_numa_node(early_cpu_to_node(cpu));
 #endif
+	setup_getcpu(cpu);
 
 	me = current;
 
