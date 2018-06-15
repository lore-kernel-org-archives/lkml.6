Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094D1C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B877E208DA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B877E208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966062AbeFOQa0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:30:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38172 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965947AbeFOQaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:30:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 31ECA81663FF;
        Fri, 15 Jun 2018 16:30:13 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DDD11102E22;
        Fri, 15 Jun 2018 16:30:11 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     x86@kernel.org
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: [PATCH] x86/hyper-v: use cheaper HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE} hypercalls when possible
Date:   Fri, 15 Jun 2018 18:30:10 +0200
Message-Id: <20180615163010.20381-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 15 Jun 2018 16:30:13 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 15 Jun 2018 16:30:13 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on Hyper-V style PV TLB flush support in KVM I noticed that
real Windows guests use TLB flush hypercall in a somewhat smarter way: when
the flush needs to be performed on a subset of first 64 vCPUs or on all
present vCPUs Windows avoids more expensive hypercalls which support
sparse CPU sets and uses their 'cheap' counterparts. This means that
HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED name is actually a misnomer: EX
hypercalls (which support sparse CPU sets) are "available", not
"recommended". This makes sense as they are actually harder to parse.

Nothing stops us from being equally 'smart' in Linux too. Switch to
doing cheaper hypercalls whenever possible.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/hyperv/mmu.c | 68 ++++++++++++++++++++-------------------------------
 1 file changed, 27 insertions(+), 41 deletions(-)

diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index de27615c51ea..7519a44b462e 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -16,6 +16,8 @@
 /* Each gva in gva_list encodes up to 4096 pages to flush */
 #define HV_TLB_FLUSH_UNIT (4096 * PAGE_SIZE)
 
+static u64 hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
+				      const struct flush_tlb_info *info);
 
 /*
  * Fills in gva_list starting from offset. Returns the number of items added.
@@ -93,10 +95,19 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
 	if (cpumask_equal(cpus, cpu_present_mask)) {
 		flush->flags |= HV_FLUSH_ALL_PROCESSORS;
 	} else {
+		/*
+		 * It is highly likely that VP ids are in ascending order
+		 * matching Linux CPU ids; Check VP index for the highest CPU
+		 * in the supplied set to see if EX hypercall is required.
+		 * This is just a best guess but should work most of the time.
+		 */
+		if (hv_cpu_number_to_vp_number(cpumask_last(cpus)) >= 64)
+			goto do_ex_hypercall;
+
 		for_each_cpu(cpu, cpus) {
 			vcpu = hv_cpu_number_to_vp_number(cpu);
 			if (vcpu >= 64)
-				goto do_native;
+				goto do_ex_hypercall;
 
 			__set_bit(vcpu, (unsigned long *)
 				  &flush->processor_mask);
@@ -123,7 +134,12 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
 		status = hv_do_rep_hypercall(HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST,
 					     gva_n, 0, flush, NULL);
 	}
+	goto check_status;
+
+do_ex_hypercall:
+	status = hyperv_flush_tlb_others_ex(cpus, info);
 
+check_status:
 	local_irq_restore(flags);
 
 	if (!(status & HV_HYPERCALL_RESULT_MASK))
@@ -132,35 +148,22 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
 	native_flush_tlb_others(cpus, info);
 }
 
-static void hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
-				       const struct flush_tlb_info *info)
+static u64 hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
+				      const struct flush_tlb_info *info)
 {
 	int nr_bank = 0, max_gvas, gva_n;
 	struct hv_tlb_flush_ex **flush_pcpu;
 	struct hv_tlb_flush_ex *flush;
-	u64 status = U64_MAX;
-	unsigned long flags;
-
-	trace_hyperv_mmu_flush_tlb_others(cpus, info);
+	u64 status;
 
-	if (!hv_hypercall_pg)
-		goto do_native;
-
-	if (cpumask_empty(cpus))
-		return;
-
-	local_irq_save(flags);
+	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
+		return U64_MAX;
 
 	flush_pcpu = (struct hv_tlb_flush_ex **)
 		     this_cpu_ptr(hyperv_pcpu_input_arg);
 
 	flush = *flush_pcpu;
 
-	if (unlikely(!flush)) {
-		local_irq_restore(flags);
-		goto do_native;
-	}
-
 	if (info->mm) {
 		/*
 		 * AddressSpace argument must match the CR3 with PCID bits
@@ -176,15 +179,8 @@ static void hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 
 	flush->hv_vp_set.valid_bank_mask = 0;
 
-	if (!cpumask_equal(cpus, cpu_present_mask)) {
-		flush->hv_vp_set.format = HV_GENERIC_SET_SPARSE_4K;
-		nr_bank = cpumask_to_vpset(&(flush->hv_vp_set), cpus);
-	}
-
-	if (!nr_bank) {
-		flush->hv_vp_set.format = HV_GENERIC_SET_ALL;
-		flush->flags |= HV_FLUSH_ALL_PROCESSORS;
-	}
+	flush->hv_vp_set.format = HV_GENERIC_SET_SPARSE_4K;
+	nr_bank = cpumask_to_vpset(&(flush->hv_vp_set), cpus);
 
 	/*
 	 * We can flush not more than max_gvas with one hypercall. Flush the
@@ -213,12 +209,7 @@ static void hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 			gva_n, nr_bank, flush, NULL);
 	}
 
-	local_irq_restore(flags);
-
-	if (!(status & HV_HYPERCALL_RESULT_MASK))
-		return;
-do_native:
-	native_flush_tlb_others(cpus, info);
+	return status;
 }
 
 void hyperv_setup_mmu_ops(void)
@@ -226,11 +217,6 @@ void hyperv_setup_mmu_ops(void)
 	if (!(ms_hyperv.hints & HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED))
 		return;
 
-	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED)) {
-		pr_info("Using hypercall for remote TLB flush\n");
-		pv_mmu_ops.flush_tlb_others = hyperv_flush_tlb_others;
-	} else {
-		pr_info("Using ext hypercall for remote TLB flush\n");
-		pv_mmu_ops.flush_tlb_others = hyperv_flush_tlb_others_ex;
-	}
+	pr_info("Using hypercall for remote TLB flush\n");
+	pv_mmu_ops.flush_tlb_others = hyperv_flush_tlb_others;
 }
-- 
2.14.4

