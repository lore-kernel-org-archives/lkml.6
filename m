Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F738C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B746205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B746205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbeJPXzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:55:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49619 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbeJPXzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:55:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9GG3rTv4157071
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 16 Oct 2018 09:03:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9GG3rM54157068;
        Tue, 16 Oct 2018 09:03:53 -0700
Date:   Tue, 16 Oct 2018 09:03:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-d4ae552982de39417d17f823df1f06b1cbc3686c@git.kernel.org>
Cc:     acme@kernel.org, eranian@google.com, acme@redhat.com,
        alexander.shishkin@linux.intel.com, vincent.weaver@maine.edu,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        jolsa@redhat.com, jolsa@kernel.org, mpetlan@redhat.com,
        hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, peterz@infradead.org,
          hpa@zytor.com, mingo@kernel.org, mpetlan@redhat.com,
          jolsa@kernel.org, jolsa@redhat.com,
          torvalds@linux-foundation.org, tglx@linutronix.de,
          vincent.weaver@maine.edu, alexander.shishkin@linux.intel.com,
          acme@redhat.com, acme@kernel.org, eranian@google.com
In-Reply-To: <20180906135748.GC9577@krava>
References: <20180906135748.GC9577@krava>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel: Export mem events only if there's
 PEBS support
Git-Commit-ID: d4ae552982de39417d17f823df1f06b1cbc3686c
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

Commit-ID:  d4ae552982de39417d17f823df1f06b1cbc3686c
Gitweb:     https://git.kernel.org/tip/d4ae552982de39417d17f823df1f06b1cbc3686c
Author:     Jiri Olsa <jolsa@redhat.com>
AuthorDate: Thu, 6 Sep 2018 15:57:48 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 16 Oct 2018 17:29:07 +0200

perf/x86/intel: Export mem events only if there's PEBS support

Memory events depends on PEBS support and access to LDLAT MSR, but we
display them in /sys/devices/cpu/events even if the CPU does not
provide those, like for KVM guests.

That brings the false assumption that those events should be
available, while they fail event to open.

Separating the mem-* events attributes and merging them with
cpu_events only if there's PEBS support detected.

We could also check if LDLAT MSR is available, but the PEBS check
seems to cover the need now.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: http://lkml.kernel.org/r/20180906135748.GC9577@krava
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/core.c       |  8 ++---
 arch/x86/events/intel/core.c | 69 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 56 insertions(+), 21 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 06b708494898..de32741d041a 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1652,9 +1652,9 @@ __init struct attribute **merge_attr(struct attribute **a, struct attribute **b)
 	struct attribute **new;
 	int j, i;
 
-	for (j = 0; a[j]; j++)
+	for (j = 0; a && a[j]; j++)
 		;
-	for (i = 0; b[i]; i++)
+	for (i = 0; b && b[i]; i++)
 		j++;
 	j++;
 
@@ -1663,9 +1663,9 @@ __init struct attribute **merge_attr(struct attribute **a, struct attribute **b)
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
index ab01ef9ddd77..0fb8659b20d8 100644
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
@@ -3912,8 +3916,6 @@ EVENT_ATTR_STR(cycles-t,	cycles_t,	"event=0x3c,in_tx=1");
 EVENT_ATTR_STR(cycles-ct,	cycles_ct,	"event=0x3c,in_tx=1,in_tx_cp=1");
 
 static struct attribute *hsw_events_attrs[] = {
-	EVENT_PTR(mem_ld_hsw),
-	EVENT_PTR(mem_st_hsw),
 	EVENT_PTR(td_slots_issued),
 	EVENT_PTR(td_slots_retired),
 	EVENT_PTR(td_fetch_bubbles),
@@ -3924,6 +3926,12 @@ static struct attribute *hsw_events_attrs[] = {
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
@@ -3940,13 +3948,6 @@ static struct attribute *hsw_tsx_events_attrs[] = {
 	NULL
 };
 
-static __init struct attribute **get_hsw_events_attrs(void)
-{
-	return boot_cpu_has(X86_FEATURE_RTM) ?
-		merge_attr(hsw_events_attrs, hsw_tsx_events_attrs) :
-		hsw_events_attrs;
-}
-
 static ssize_t freeze_on_smi_show(struct device *cdev,
 				  struct device_attribute *attr,
 				  char *buf)
@@ -4023,9 +4024,32 @@ static struct attribute *intel_pmu_attrs[] = {
 	NULL,
 };
 
+static __init struct attribute **
+get_events_attrs(struct attribute **base,
+		 struct attribute **mem,
+		 struct attribute **tsx)
+{
+	struct attribute **attrs = base;
+	struct attribute **old;
+
+	if (mem && x86_pmu.pebs)
+		attrs = merge_attr(attrs, mem);
+
+	if (tsx && boot_cpu_has(X86_FEATURE_RTM)) {
+		old = attrs;
+		attrs = merge_attr(attrs, tsx);
+		if (old != base)
+			kfree(old);
+	}
+
+	return attrs;
+}
+
 __init int intel_pmu_init(void)
 {
 	struct attribute **extra_attr = NULL;
+	struct attribute **mem_attr = NULL;
+	struct attribute **tsx_attr = NULL;
 	struct attribute **to_free = NULL;
 	union cpuid10_edx edx;
 	union cpuid10_eax eax;
@@ -4137,7 +4161,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.enable_all = intel_pmu_nhm_enable_all;
 		x86_pmu.extra_regs = intel_nehalem_extra_regs;
 
-		x86_pmu.cpu_events = nhm_events_attrs;
+		mem_attr = nhm_mem_events_attrs;
 
 		/* UOPS_ISSUED.STALLED_CYCLES */
 		intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
@@ -4266,7 +4290,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.extra_regs = intel_westmere_extra_regs;
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 
-		x86_pmu.cpu_events = nhm_events_attrs;
+		mem_attr = nhm_mem_events_attrs;
 
 		/* UOPS_ISSUED.STALLED_CYCLES */
 		intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
@@ -4306,6 +4330,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
 
 		x86_pmu.cpu_events = snb_events_attrs;
+		mem_attr = snb_mem_events_attrs;
 
 		/* UOPS_ISSUED.ANY,c=1,i=1 to count stall cycles */
 		intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
@@ -4346,6 +4371,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
 
 		x86_pmu.cpu_events = snb_events_attrs;
+		mem_attr = snb_mem_events_attrs;
 
 		/* UOPS_ISSUED.ANY,c=1,i=1 to count stall cycles */
 		intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
@@ -4380,10 +4406,12 @@ __init int intel_pmu_init(void)
 
 		x86_pmu.hw_config = hsw_hw_config;
 		x86_pmu.get_event_constraints = hsw_get_event_constraints;
-		x86_pmu.cpu_events = get_hsw_events_attrs();
+		x86_pmu.cpu_events = hsw_events_attrs;
 		x86_pmu.lbr_double_abort = true;
 		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
 			hsw_format_attr : nhm_format_attr;
+		mem_attr = hsw_mem_events_attrs;
+		tsx_attr = hsw_tsx_events_attrs;
 		pr_cont("Haswell events, ");
 		name = "haswell";
 		break;
@@ -4419,10 +4447,12 @@ __init int intel_pmu_init(void)
 
 		x86_pmu.hw_config = hsw_hw_config;
 		x86_pmu.get_event_constraints = hsw_get_event_constraints;
-		x86_pmu.cpu_events = get_hsw_events_attrs();
+		x86_pmu.cpu_events = hsw_events_attrs;
 		x86_pmu.limit_period = bdw_limit_period;
 		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
 			hsw_format_attr : nhm_format_attr;
+		mem_attr = hsw_mem_events_attrs;
+		tsx_attr = hsw_tsx_events_attrs;
 		pr_cont("Broadwell events, ");
 		name = "broadwell";
 		break;
@@ -4478,7 +4508,9 @@ __init int intel_pmu_init(void)
 			hsw_format_attr : nhm_format_attr;
 		extra_attr = merge_attr(extra_attr, skl_format_attr);
 		to_free = extra_attr;
-		x86_pmu.cpu_events = get_hsw_events_attrs();
+		x86_pmu.cpu_events = hsw_events_attrs;
+		mem_attr = hsw_mem_events_attrs;
+		tsx_attr = hsw_tsx_events_attrs;
 		intel_pmu_pebs_data_source_skl(
 			boot_cpu_data.x86_model == INTEL_FAM6_SKYLAKE_X);
 		pr_cont("Skylake events, ");
@@ -4511,6 +4543,9 @@ __init int intel_pmu_init(void)
 		WARN_ON(!x86_pmu.format_attrs);
 	}
 
+	x86_pmu.cpu_events = get_events_attrs(x86_pmu.cpu_events,
+					      mem_attr, tsx_attr);
+
 	if (x86_pmu.num_counters > INTEL_PMC_MAX_GENERIC) {
 		WARN(1, KERN_ERR "hw perf events %d > max(%d), clipping!",
 		     x86_pmu.num_counters, INTEL_PMC_MAX_GENERIC);
