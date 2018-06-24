Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947D7C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE8924EF0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE8924EF0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbeFXNHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 09:07:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39129 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751926AbeFXNHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 09:07:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5OD6mld836248
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 24 Jun 2018 06:06:48 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5OD6mKi836245;
        Sun, 24 Jun 2018 06:06:48 -0700
Date:   Sun, 24 Jun 2018 06:06:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vitaly Kuznetsov <tipbot@zytor.com>
Message-ID: <tip-0e4c88f37693d4857fc0be66e548e2eb8b3d8a15@git.kernel.org>
Cc:     Michael.H.Kelley@microsoft.com, kys@microsoft.com,
        sthemmin@microsoft.com, mikelley@microsoft.com,
        haiyangz@microsoft.com, hpa@zytor.com, mingo@kernel.org,
        vkuznets@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Tianyu.Lan@microsoft.com
Reply-To: sthemmin@microsoft.com, kys@microsoft.com,
          Michael.H.Kelley@microsoft.com, linux-kernel@vger.kernel.org,
          Tianyu.Lan@microsoft.com, tglx@linutronix.de,
          vkuznets@redhat.com, haiyangz@microsoft.com, mingo@kernel.org,
          hpa@zytor.com, mikelley@microsoft.com
In-Reply-To: <20180621133238.30757-1-vkuznets@redhat.com>
References: <20180621133238.30757-1-vkuznets@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/hyperv] x86/hyper-v: Use cheaper
 HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE} hypercalls when possible
Git-Commit-ID: 0e4c88f37693d4857fc0be66e548e2eb8b3d8a15
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

Commit-ID:  0e4c88f37693d4857fc0be66e548e2eb8b3d8a15
Gitweb:     https://git.kernel.org/tip/0e4c88f37693d4857fc0be66e548e2eb8b3d8a15
Author:     Vitaly Kuznetsov <vkuznets@redhat.com>
AuthorDate: Thu, 21 Jun 2018 15:32:38 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 24 Jun 2018 15:01:14 +0200

x86/hyper-v: Use cheaper HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE} hypercalls when possible

While working on Hyper-V style PV TLB flush support in KVM I noticed that
real Windows guests use TLB flush hypercall in a somewhat smarter way:

  When the flush needs to be performed on a subset of first 64 vCPUs or on
  all present vCPUs Windows avoids more expensive hypercalls which support
  sparse CPU sets and uses their 'cheap' counterparts.

This means that HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED name is actually a
misnomer: EX hypercalls (which support sparse CPU sets) are "available",
not "recommended". This makes sense as they are actually harder to parse.

Nothing stops us from being equally 'smart' in Linux too. Switch to doing
cheaper hypercalls whenever possible.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc: devel@linuxdriverproject.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/20180621133238.30757-1-vkuznets@redhat.com

---
 arch/x86/hyperv/mmu.c | 73 ++++++++++++++++++++++-----------------------------
 1 file changed, 32 insertions(+), 41 deletions(-)

diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index de27615c51ea..0d90e515ec98 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -16,6 +16,8 @@
 /* Each gva in gva_list encodes up to 4096 pages to flush */
 #define HV_TLB_FLUSH_UNIT (4096 * PAGE_SIZE)
 
+static u64 hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
+				      const struct flush_tlb_info *info);
 
 /*
  * Fills in gva_list starting from offset. Returns the number of items added.
@@ -93,10 +95,24 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
 	if (cpumask_equal(cpus, cpu_present_mask)) {
 		flush->flags |= HV_FLUSH_ALL_PROCESSORS;
 	} else {
+		/*
+		 * From the supplied CPU set we need to figure out if we can get
+		 * away with cheaper HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE}
+		 * hypercalls. This is possible when the highest VP number in
+		 * the set is < 64. As VP numbers are usually in ascending order
+		 * and match Linux CPU ids, here is an optimization: we check
+		 * the VP number for the highest bit in the supplied set first
+		 * so we can quickly find out if using *_EX hypercalls is a
+		 * must. We will also check all VP numbers when walking the
+		 * supplied CPU set to remain correct in all cases.
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
@@ -123,7 +139,12 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
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
@@ -132,35 +153,22 @@ do_native:
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
@@ -176,15 +184,8 @@ static void hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 
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
@@ -213,12 +214,7 @@ static void hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
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
@@ -226,11 +222,6 @@ void hyperv_setup_mmu_ops(void)
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
