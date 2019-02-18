Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C51C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FE120838
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550500814;
	bh=ySj82Tshm0Jic1xID2V2JAo3GvZjMBUtqIK2YAZtpW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JwaFAcQyRFHIwyQsyUEOC8dOA6hhcoDzqIFrJa8BYWm/8bX5zgPCTjkf7y063qJNv
	 EgLakgwC6e3kVCoI1sC2pPWBkriOjoQ0uM1HlvuLIhj4p5azhMUb+oVq3ePWe4PlxQ
	 kKb1XtxMte8Mt/ssgzdpvDBKSHdjvTy4LZYqUWU4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732636AbfBRNwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:52:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:60056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732583AbfBRNwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:52:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59BD121905;
        Mon, 18 Feb 2019 13:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497929;
        bh=ySj82Tshm0Jic1xID2V2JAo3GvZjMBUtqIK2YAZtpW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t2xgKV6bdC8W0REig2ZlAKeaaJrW0YIPP1PB292EUqqDw0rA5UJvzRLu1XeL+cP9F
         vGljiPNtVsV4X71K550q1oOyEBOvBRjdYdFpeka9U65CyIdVGa0BaIfzSrS1KGEaqO
         mhceDM0P9pJJhLt0qPA5dA5SgM2qW71rW2sEI1tY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vince Weaver <vincent.weaver@maine.edu>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.19 55/85] perf/x86: Add check_period PMU callback
Date:   Mon, 18 Feb 2019 14:43:21 +0100
Message-Id: <20190218133505.457458353@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133459.758004711@linuxfoundation.org>
References: <20190218133459.758004711@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@redhat.com>

commit 81ec3f3c4c4d78f2d3b6689c9816bfbdf7417dbb upstream.

Vince (and later on Ravi) reported crashes in the BTS code during
fuzzing with the following backtrace:

  general protection fault: 0000 [#1] SMP PTI
  ...
  RIP: 0010:perf_prepare_sample+0x8f/0x510
  ...
  Call Trace:
   <IRQ>
   ? intel_pmu_drain_bts_buffer+0x194/0x230
   intel_pmu_drain_bts_buffer+0x160/0x230
   ? tick_nohz_irq_exit+0x31/0x40
   ? smp_call_function_single_interrupt+0x48/0xe0
   ? call_function_single_interrupt+0xf/0x20
   ? call_function_single_interrupt+0xa/0x20
   ? x86_schedule_events+0x1a0/0x2f0
   ? x86_pmu_commit_txn+0xb4/0x100
   ? find_busiest_group+0x47/0x5d0
   ? perf_event_set_state.part.42+0x12/0x50
   ? perf_mux_hrtimer_restart+0x40/0xb0
   intel_pmu_disable_event+0xae/0x100
   ? intel_pmu_disable_event+0xae/0x100
   x86_pmu_stop+0x7a/0xb0
   x86_pmu_del+0x57/0x120
   event_sched_out.isra.101+0x83/0x180
   group_sched_out.part.103+0x57/0xe0
   ctx_sched_out+0x188/0x240
   ctx_resched+0xa8/0xd0
   __perf_event_enable+0x193/0x1e0
   event_function+0x8e/0xc0
   remote_function+0x41/0x50
   flush_smp_call_function_queue+0x68/0x100
   generic_smp_call_function_single_interrupt+0x13/0x30
   smp_call_function_single_interrupt+0x3e/0xe0
   call_function_single_interrupt+0xf/0x20
   </IRQ>

The reason is that while event init code does several checks
for BTS events and prevents several unwanted config bits for
BTS event (like precise_ip), the PERF_EVENT_IOC_PERIOD allows
to create BTS event without those checks being done.

Following sequence will cause the crash:

If we create an 'almost' BTS event with precise_ip and callchains,
and it into a BTS event it will crash the perf_prepare_sample()
function because precise_ip events are expected to come
in with callchain data initialized, but that's not the
case for intel_pmu_drain_bts_buffer() caller.

Adding a check_period callback to be called before the period
is changed via PERF_EVENT_IOC_PERIOD. It will deny the change
if the event would become BTS. Plus adding also the limit_period
check as well.

Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: <stable@vger.kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20190204123532.GA4794@krava
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/events/core.c       |   14 ++++++++++++++
 arch/x86/events/intel/core.c |    9 +++++++++
 arch/x86/events/perf_event.h |   16 ++++++++++++++--
 include/linux/perf_event.h   |    5 +++++
 kernel/events/core.c         |   16 ++++++++++++++++
 5 files changed, 58 insertions(+), 2 deletions(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2253,6 +2253,19 @@ void perf_check_microcode(void)
 		x86_pmu.check_microcode();
 }
 
+static int x86_pmu_check_period(struct perf_event *event, u64 value)
+{
+	if (x86_pmu.check_period && x86_pmu.check_period(event, value))
+		return -EINVAL;
+
+	if (value && x86_pmu.limit_period) {
+		if (x86_pmu.limit_period(event, value) > value)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 static struct pmu pmu = {
 	.pmu_enable		= x86_pmu_enable,
 	.pmu_disable		= x86_pmu_disable,
@@ -2277,6 +2290,7 @@ static struct pmu pmu = {
 	.event_idx		= x86_pmu_event_idx,
 	.sched_task		= x86_pmu_sched_task,
 	.task_ctx_size          = sizeof(struct x86_perf_task_context),
+	.check_period		= x86_pmu_check_period,
 };
 
 void arch_perf_update_userpage(struct perf_event *event,
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3465,6 +3465,11 @@ static void intel_pmu_sched_task(struct
 	intel_pmu_lbr_sched_task(ctx, sched_in);
 }
 
+static int intel_pmu_check_period(struct perf_event *event, u64 value)
+{
+	return intel_pmu_has_bts_period(event, value) ? -EINVAL : 0;
+}
+
 PMU_FORMAT_ATTR(offcore_rsp, "config1:0-63");
 
 PMU_FORMAT_ATTR(ldlat, "config1:0-15");
@@ -3545,6 +3550,8 @@ static __initconst const struct x86_pmu
 	.cpu_starting		= intel_pmu_cpu_starting,
 	.cpu_dying		= intel_pmu_cpu_dying,
 	.cpu_dead		= intel_pmu_cpu_dead,
+
+	.check_period		= intel_pmu_check_period,
 };
 
 static struct attribute *intel_pmu_attrs[];
@@ -3589,6 +3596,8 @@ static __initconst const struct x86_pmu
 
 	.guest_get_msrs		= intel_guest_get_msrs,
 	.sched_task		= intel_pmu_sched_task,
+
+	.check_period		= intel_pmu_check_period,
 };
 
 static __init void intel_clovertown_quirk(void)
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -644,6 +644,11 @@ struct x86_pmu {
 	 * Intel host/guest support (KVM)
 	 */
 	struct perf_guest_switch_msr *(*guest_get_msrs)(int *nr);
+
+	/*
+	 * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
+	 */
+	int (*check_period) (struct perf_event *event, u64 period);
 };
 
 struct x86_perf_task_context {
@@ -855,7 +860,7 @@ static inline int amd_pmu_init(void)
 
 #ifdef CONFIG_CPU_SUP_INTEL
 
-static inline bool intel_pmu_has_bts(struct perf_event *event)
+static inline bool intel_pmu_has_bts_period(struct perf_event *event, u64 period)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	unsigned int hw_event, bts_event;
@@ -866,7 +871,14 @@ static inline bool intel_pmu_has_bts(str
 	hw_event = hwc->config & INTEL_ARCH_EVENT_MASK;
 	bts_event = x86_pmu.event_map(PERF_COUNT_HW_BRANCH_INSTRUCTIONS);
 
-	return hw_event == bts_event && hwc->sample_period == 1;
+	return hw_event == bts_event && period == 1;
+}
+
+static inline bool intel_pmu_has_bts(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	return intel_pmu_has_bts_period(event, hwc->sample_period);
 }
 
 int intel_pmu_save_and_restart(struct perf_event *event);
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -447,6 +447,11 @@ struct pmu {
 	 * Filter events for PMU-specific reasons.
 	 */
 	int (*filter_match)		(struct perf_event *event); /* optional */
+
+	/*
+	 * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
+	 */
+	int (*check_period)		(struct perf_event *event, u64 value); /* optional */
 };
 
 enum perf_addr_filter_action_t {
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4963,6 +4963,11 @@ static void __perf_event_period(struct p
 	}
 }
 
+static int perf_event_check_period(struct perf_event *event, u64 value)
+{
+	return event->pmu->check_period(event, value);
+}
+
 static int perf_event_period(struct perf_event *event, u64 __user *arg)
 {
 	u64 value;
@@ -4979,6 +4984,9 @@ static int perf_event_period(struct perf
 	if (event->attr.freq && value > sysctl_perf_event_sample_rate)
 		return -EINVAL;
 
+	if (perf_event_check_period(event, value))
+		return -EINVAL;
+
 	event_function_call(event, __perf_event_period, &value);
 
 	return 0;
@@ -9362,6 +9370,11 @@ static int perf_pmu_nop_int(struct pmu *
 	return 0;
 }
 
+static int perf_event_nop_int(struct perf_event *event, u64 value)
+{
+	return 0;
+}
+
 static DEFINE_PER_CPU(unsigned int, nop_txn_flags);
 
 static void perf_pmu_start_txn(struct pmu *pmu, unsigned int flags)
@@ -9662,6 +9675,9 @@ got_cpu_context:
 		pmu->pmu_disable = perf_pmu_nop_void;
 	}
 
+	if (!pmu->check_period)
+		pmu->check_period = perf_event_nop_int;
+
 	if (!pmu->event_idx)
 		pmu->event_idx = perf_event_idx_default;
 


