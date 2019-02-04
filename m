Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB21C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7312082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hmowftci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbfBDPGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:06:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50564 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfBDPGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 10:06:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WOFqt207wWEoQmqQn4ZGpnswYEH20X8mBi+tGJ21E6g=; b=Hmowftcixv3NVHSMRm9rFTdBc
        EA8k4krdGwev96puLYO+mrXhavcDlmhymPfRJljLqRsOPCgxzx38oS5MEeqq4pqkExqYc7POcWJxb
        +6uPBjNVVW13jLzCYhT/adQaAa9YPonL/XvMa19CrF5ahNABcGu1JaBFDRUdBNdAbf4bIJrnw6zXq
        Xfo+682S6rz8qylBghYdkzR9FATd9HYgXrkmA03SHvP4KLUSx9HnfLyOSCYQUZXyjWbouj8Pgy9px
        5xz/E65E6G6N8sRh80ENE0JV7/GOFj8Q+Q/cm6XKmbFsh9iEJn5aOXJONCwBXZE3PkA+tYQSAjRUX
        M+NvF/EqQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqfpK-0008Vk-Qt; Mon, 04 Feb 2019 15:06:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F32C4202A2A0F; Mon,  4 Feb 2019 16:06:23 +0100 (CET)
Date:   Mon, 4 Feb 2019 16:06:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bp@alien8.de, mingo@redhat.com, ak@linux.intel.com,
        eranian@google.com
Subject: Re: [PATCH V6 2/5] perf/x86/kvm: Avoid unnecessary work in guest
 filtering
Message-ID: <20190204150623.GF17528@hirez.programming.kicks-ass.net>
References: <1548106951-4811-1-git-send-email-kan.liang@linux.intel.com>
 <1548106951-4811-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548106951-4811-2-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 01:42:28PM -0800, kan.liang@linux.intel.com wrote:

So what's wrong with the below?

Installing a quirk for 

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3781,7 +3781,7 @@ static const struct x86_cpu_desc isolati
 	{}
 };
 
-static void intel_check_isolation(void)
+static void intel_check_pebs_isolation(void)
 {
 	x86_pmu.pebs_no_isolation = !x86_cpu_has_min_microcode_rev(isolation_ucodes);
 }
@@ -3891,12 +3891,6 @@ static __init void intel_sandybridge_qui
 	cpus_read_unlock();
 }
 
-static __init void intel_isolation_quirk(void)
-{
-	x86_pmu.check_microcode = intel_check_isolation;
-	intel_check_isolation();
-}
-
 static const struct { int id; char *name; } intel_arch_events_map[] __initconst = {
 	{ PERF_COUNT_HW_CPU_CYCLES, "cpu cycles" },
 	{ PERF_COUNT_HW_INSTRUCTIONS, "instructions" },
@@ -4213,6 +4207,7 @@ __init int intel_pmu_init(void)
 	}
 
 	intel_ds_init();
+	intel_check_pebs_isolation();
 
 	x86_add_quirk(intel_arch_events_quirk); /* Install first, so it runs last */
 
@@ -4239,7 +4234,6 @@ __init int intel_pmu_init(void)
 
 		x86_pmu.event_constraints = intel_core2_event_constraints;
 		x86_pmu.pebs_constraints = intel_core2_pebs_event_constraints;
-		x86_pmu.pebs_no_isolation = 1;
 		pr_cont("Core2 events, ");
 		name = "core2";
 		break;
@@ -4271,7 +4265,6 @@ __init int intel_pmu_init(void)
 		intel_pmu_pebs_data_source_nhm();
 		x86_add_quirk(intel_nehalem_quirk);
 		x86_pmu.pebs_no_tlb = 1;
-		x86_pmu.pebs_no_isolation = 1;
 		extra_attr = nhm_format_attr;
 
 		pr_cont("Nehalem events, ");
@@ -4291,7 +4284,6 @@ __init int intel_pmu_init(void)
 		x86_pmu.event_constraints = intel_gen_event_constraints;
 		x86_pmu.pebs_constraints = intel_atom_pebs_event_constraints;
 		x86_pmu.pebs_aliases = intel_pebs_aliases_core2;
-		x86_pmu.pebs_no_isolation = 1;
 		pr_cont("Atom events, ");
 		name = "bonnell";
 		break;
@@ -4313,7 +4305,6 @@ __init int intel_pmu_init(void)
 		x86_pmu.extra_regs = intel_slm_extra_regs;
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 		x86_pmu.cpu_events = slm_events_attrs;
-		x86_pmu.pebs_no_isolation = 1;
 		extra_attr = slm_format_attr;
 		pr_cont("Silvermont events, ");
 		name = "silvermont";
@@ -4341,7 +4332,6 @@ __init int intel_pmu_init(void)
 		x86_pmu.lbr_pt_coexist = true;
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 		x86_pmu.cpu_events = glm_events_attrs;
-		x86_pmu.pebs_no_isolation = 1;
 		extra_attr = slm_format_attr;
 		pr_cont("Goldmont events, ");
 		name = "goldmont";
@@ -4369,7 +4359,6 @@ __init int intel_pmu_init(void)
 		x86_pmu.flags |= PMU_FL_PEBS_ALL;
 		x86_pmu.get_event_constraints = glp_get_event_constraints;
 		x86_pmu.cpu_events = glm_events_attrs;
-		x86_pmu.pebs_no_isolation = 1;
 		/* Goldmont Plus has 4-wide pipeline */
 		event_attr_td_total_slots_scale_glm.event_str = "4";
 		extra_attr = slm_format_attr;
@@ -4403,7 +4392,6 @@ __init int intel_pmu_init(void)
 			X86_CONFIG(.event=0xb1, .umask=0x3f, .inv=1, .cmask=1);
 
 		intel_pmu_pebs_data_source_nhm();
-		x86_pmu.pebs_no_isolation = 1;
 		extra_attr = nhm_format_attr;
 		pr_cont("Westmere events, ");
 		name = "westmere";
@@ -4434,7 +4422,6 @@ __init int intel_pmu_init(void)
 		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
 
 		x86_pmu.cpu_events = snb_events_attrs;
-		x86_pmu.pebs_no_isolation = 1;
 		mem_attr = snb_mem_events_attrs;
 
 		/* UOPS_ISSUED.ANY,c=1,i=1 to count stall cycles */
@@ -4474,7 +4461,6 @@ __init int intel_pmu_init(void)
 		/* all extra regs are per-cpu when HT is on */
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
-		x86_pmu.pebs_no_isolation = 1;
 		x86_pmu.cpu_events = snb_events_attrs;
 		mem_attr = snb_mem_events_attrs;
 
@@ -4493,7 +4479,6 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_HASWELL_X:
 	case INTEL_FAM6_HASWELL_ULT:
 	case INTEL_FAM6_HASWELL_GT3E:
-		x86_add_quirk(intel_isolation_quirk);
 		x86_add_quirk(intel_ht_bug);
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, hsw_hw_cache_event_ids, sizeof(hw_cache_event_ids));
@@ -4526,7 +4511,6 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_BROADWELL_XEON_D:
 	case INTEL_FAM6_BROADWELL_GT3E:
 	case INTEL_FAM6_BROADWELL_X:
-		x86_add_quirk(intel_isolation_quirk);
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, hsw_hw_cache_event_ids, sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, hsw_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
@@ -4579,7 +4563,6 @@ __init int intel_pmu_init(void)
 		/* all extra regs are per-cpu when HT is on */
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
-		x86_pmu.pebs_no_isolation = 1;
 		extra_attr = slm_format_attr;
 		pr_cont("Knights Landing/Mill events, ");
 		name = "knights-landing";
@@ -4590,7 +4573,6 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_SKYLAKE_X:
 	case INTEL_FAM6_KABYLAKE_MOBILE:
 	case INTEL_FAM6_KABYLAKE_DESKTOP:
-		x86_add_quirk(intel_isolation_quirk);
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, skl_hw_cache_event_ids, sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, skl_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
