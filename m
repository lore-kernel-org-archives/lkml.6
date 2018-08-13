Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23929C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF742189A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF742189A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbeHMSbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 14:31:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728661AbeHMSbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 14:31:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 65B0A40216E6;
        Mon, 13 Aug 2018 15:48:23 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF6682142F20;
        Mon, 13 Aug 2018 15:48:21 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: [RFC] perf/x86/intel: Export mem events only if there's PEBs support
Date:   Mon, 13 Aug 2018 17:48:20 +0200
Message-Id: <20180813154820.16991-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 13 Aug 2018 15:48:23 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 13 Aug 2018 15:48:23 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
we had some reports that we show mem* events on KVM servers
where they are not available, this patch hides them if there's
no PEBs available

currently on those servers we fail to open mem* events,
because we can't access LDLAT msr

however that's not so easy/straight forward to check,
so I thought we could use check on PEBs instead, which
needs to be there for mem events as well and seems to
be enough to check

thoughts? thanks,
jirka


---
Memory events depends on PEBs support and access to LDLAT msr,
but we display them in /sys/devices/cpu/events even if the cpu
does not provide those, like for KVM guests.

That brings the false assumption that those events should
be available, while they fail event to open.

Separating the mem-* events attributes and merging them
with cpu_events only if there's PEBs support detected.

We could also check if LDLAT msr is available, but the
PEBs check seems to cover the need now.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/events/core.c       |  8 +++---
 arch/x86/events/intel/core.c | 54 ++++++++++++++++++++++++++----------
 2 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 5f4829f10129..1a17004f6559 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1631,9 +1631,9 @@ __init struct attribute **merge_attr(struct attribute **a, struct attribute **b)
 	struct attribute **new;
 	int j, i;
 
-	for (j = 0; a[j]; j++)
+	for (j = 0; a && a[j]; j++)
 		;
-	for (i = 0; b[i]; i++)
+	for (i = 0; b && b[i]; i++)
 		j++;
 	j++;
 
@@ -1642,9 +1642,9 @@ __init struct attribute **merge_attr(struct attribute **a, struct attribute **b)
 		return NULL;
 
 	j = 0;
-	for (i = 0; a[i]; i++)
+	for (i = 0; a && a[i]; i++)
 		new[j++] = a[i];
-	for (i = 0; b[i]; i++)
+	for (i = 0; b && b[i]; i++)
 		new[j++] = b[i];
 	new[j] = NULL;
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 035c37481f57..04d077177e3c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -242,7 +242,7 @@ EVENT_ATTR_STR(mem-loads,	mem_ld_nhm,	"event=0x0b,umask=0x10,ldlat=3");
 EVENT_ATTR_STR(mem-loads,	mem_ld_snb,	"event=0xcd,umask=0x1,ldlat=3");
 EVENT_ATTR_STR(mem-stores,	mem_st_snb,	"event=0xcd,umask=0x2");
 
-static struct attribute *nhm_events_attrs[] = {
+static struct attribute *nhm_mem_events_attrs[] = {
 	EVENT_PTR(mem_ld_nhm),
 	NULL,
 };
@@ -278,8 +278,6 @@ EVENT_ATTR_STR_HT(topdown-recovery-bubbles.scale, td_recovery_bubbles_scale,
 	"4", "2");
 
 static struct attribute *snb_events_attrs[] = {
-	EVENT_PTR(mem_ld_snb),
-	EVENT_PTR(mem_st_snb),
 	EVENT_PTR(td_slots_issued),
 	EVENT_PTR(td_slots_retired),
 	EVENT_PTR(td_fetch_bubbles),
@@ -290,6 +288,12 @@ static struct attribute *snb_events_attrs[] = {
 	NULL,
 };
 
+static struct attribute *snb_mem_events_attrs[] = {
+	EVENT_PTR(mem_ld_snb),
+	EVENT_PTR(mem_st_snb),
+	NULL,
+};
+
 static struct event_constraint intel_hsw_event_constraints[] = {
 	FIXED_EVENT_CONSTRAINT(0x00c0, 0), /* INST_RETIRED.ANY */
 	FIXED_EVENT_CONSTRAINT(0x003c, 1), /* CPU_CLK_UNHALTED.CORE */
@@ -3764,8 +3768,6 @@ EVENT_ATTR_STR(cycles-t,	cycles_t,	"event=0x3c,in_tx=1");
 EVENT_ATTR_STR(cycles-ct,	cycles_ct,	"event=0x3c,in_tx=1,in_tx_cp=1");
 
 static struct attribute *hsw_events_attrs[] = {
-	EVENT_PTR(mem_ld_hsw),
-	EVENT_PTR(mem_st_hsw),
 	EVENT_PTR(td_slots_issued),
 	EVENT_PTR(td_slots_retired),
 	EVENT_PTR(td_fetch_bubbles),
@@ -3776,6 +3778,12 @@ static struct attribute *hsw_events_attrs[] = {
 	NULL
 };
 
+static struct attribute *hsw_mem_events_attrs[] = {
+	EVENT_PTR(mem_ld_hsw),
+	EVENT_PTR(mem_st_hsw),
+	NULL,
+};
+
 static struct attribute *hsw_tsx_events_attrs[] = {
 	EVENT_PTR(tx_start),
 	EVENT_PTR(tx_commit),
@@ -3792,11 +3800,13 @@ static struct attribute *hsw_tsx_events_attrs[] = {
 	NULL
 };
 
-static __init struct attribute **get_hsw_events_attrs(void)
+static __init struct attribute **get_hsw_events_attrs(bool *alloc)
 {
-	return boot_cpu_has(X86_FEATURE_RTM) ?
-		merge_attr(hsw_events_attrs, hsw_tsx_events_attrs) :
-		hsw_events_attrs;
+	if (boot_cpu_has(X86_FEATURE_RTM)) {
+		*alloc = true;
+		return merge_attr(hsw_events_attrs, hsw_tsx_events_attrs);
+	}
+	return hsw_events_attrs;
 }
 
 static ssize_t freeze_on_smi_show(struct device *cdev,
@@ -3878,7 +3888,9 @@ static struct attribute *intel_pmu_attrs[] = {
 __init int intel_pmu_init(void)
 {
 	struct attribute **extra_attr = NULL;
+	struct attribute **mem_attr = NULL;
 	struct attribute **to_free = NULL;
+	bool alloc_events = false;
 	union cpuid10_edx edx;
 	union cpuid10_eax eax;
 	union cpuid10_ebx ebx;
@@ -3986,7 +3998,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.enable_all = intel_pmu_nhm_enable_all;
 		x86_pmu.extra_regs = intel_nehalem_extra_regs;
 
-		x86_pmu.cpu_events = nhm_events_attrs;
+		mem_attr = nhm_mem_events_attrs;
 
 		/* UOPS_ISSUED.STALLED_CYCLES */
 		intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
@@ -4112,7 +4124,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.extra_regs = intel_westmere_extra_regs;
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 
-		x86_pmu.cpu_events = nhm_events_attrs;
+		mem_attr = nhm_mem_events_attrs;
 
 		/* UOPS_ISSUED.STALLED_CYCLES */
 		intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
@@ -4152,6 +4164,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
 
 		x86_pmu.cpu_events = snb_events_attrs;
+		mem_attr = snb_mem_events_attrs;
 
 		/* UOPS_ISSUED.ANY,c=1,i=1 to count stall cycles */
 		intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
@@ -4192,6 +4205,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
 
 		x86_pmu.cpu_events = snb_events_attrs;
+		mem_attr = snb_mem_events_attrs;
 
 		/* UOPS_ISSUED.ANY,c=1,i=1 to count stall cycles */
 		intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
@@ -4226,10 +4240,11 @@ __init int intel_pmu_init(void)
 
 		x86_pmu.hw_config = hsw_hw_config;
 		x86_pmu.get_event_constraints = hsw_get_event_constraints;
-		x86_pmu.cpu_events = get_hsw_events_attrs();
+		x86_pmu.cpu_events = get_hsw_events_attrs(&alloc_events);
 		x86_pmu.lbr_double_abort = true;
 		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
 			hsw_format_attr : nhm_format_attr;
+		mem_attr = hsw_mem_events_attrs;
 		pr_cont("Haswell events, ");
 		name = "haswell";
 		break;
@@ -4265,10 +4280,11 @@ __init int intel_pmu_init(void)
 
 		x86_pmu.hw_config = hsw_hw_config;
 		x86_pmu.get_event_constraints = hsw_get_event_constraints;
-		x86_pmu.cpu_events = get_hsw_events_attrs();
+		x86_pmu.cpu_events = get_hsw_events_attrs(&alloc_events);
 		x86_pmu.limit_period = bdw_limit_period;
 		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
 			hsw_format_attr : nhm_format_attr;
+		mem_attr = hsw_mem_events_attrs;
 		pr_cont("Broadwell events, ");
 		name = "broadwell";
 		break;
@@ -4324,7 +4340,8 @@ __init int intel_pmu_init(void)
 			hsw_format_attr : nhm_format_attr;
 		extra_attr = merge_attr(extra_attr, skl_format_attr);
 		to_free = extra_attr;
-		x86_pmu.cpu_events = get_hsw_events_attrs();
+		x86_pmu.cpu_events = get_hsw_events_attrs(&alloc_events);
+		mem_attr = hsw_mem_events_attrs;
 		intel_pmu_pebs_data_source_skl(
 			boot_cpu_data.x86_model == INTEL_FAM6_SKYLAKE_X);
 		pr_cont("Skylake events, ");
@@ -4357,6 +4374,15 @@ __init int intel_pmu_init(void)
 		WARN_ON(!x86_pmu.format_attrs);
 	}
 
+	if (x86_pmu.pebs && mem_attr) {
+		struct attribute **attr = x86_pmu.cpu_events;
+
+		x86_pmu.cpu_events = merge_attr(x86_pmu.cpu_events, mem_attr);
+
+		if (alloc_events)
+			kfree(attr);
+	}
+
 	if (x86_pmu.num_counters > INTEL_PMC_MAX_GENERIC) {
 		WARN(1, KERN_ERR "hw perf events %d > max(%d), clipping!",
 		     x86_pmu.num_counters, INTEL_PMC_MAX_GENERIC);
-- 
2.17.1

