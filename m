Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E318C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D8D22082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbfBDMfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 07:35:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727310AbfBDMfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 07:35:36 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4516180F6D;
        Mon,  4 Feb 2019 12:35:35 +0000 (UTC)
Received: from krava (unknown [10.43.17.135])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2FDAA106F74E;
        Mon,  4 Feb 2019 12:35:32 +0000 (UTC)
Date:   Mon, 4 Feb 2019 13:35:32 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, eranian@google.com,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] perf: Add check_period pmu callback
Message-ID: <20190204123532.GA4794@krava>
References: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com>
 <20190130183648.GA24233@krava>
 <20190131082711.GC24233@krava>
 <20190201074353.GA8778@krava>
 <alpine.DEB.2.21.1902011125290.25915@macbook-air>
 <20190201173816.GA19907@krava>
 <alpine.DEB.2.21.1902021255370.5674@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1902021255370.5674@macbook-air>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 04 Feb 2019 12:35:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2019 at 12:58:07PM -0500, Vince Weaver wrote:
> On Fri, 1 Feb 2019, Jiri Olsa wrote:
> 
> > > 
> > > I've just started fuzzing with the patch applied.  Often it takes a few 
> > > hours to trigger the bug.
> > 
> > cool, thanks
> 
> I let it run overnight and no crash.
> 
> > > Added question about this bug.  It appeared that the crash was triggered 
> > > by the BTS driver over-writing kernel memory.  The data being written, was 
> > > this user controllable?  Meaning, is this a security issue being fixed, or 
> > > just a crashing issue?
> > 
> > yea, I have an example that can trigger it immediately
> 
> I mean: the crash is happening because data structures are getting 
> over-written by the BTS driver.  Depending who and what is doing this, 
> this could be a security issue (i.e. if it was raw BTS data that was 
> partially userspace controlled values).  Though even if this were the case 
> it would probably be hard to exploit.

well, I'm not sure about other exploits,
but single program can crash the server 

attaching the complete patch (and cc-ing Ingo)

jirka


---
Vince (and later on Ravi) reported crash in BTS code during
fuzzing with following backtrace:

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
  - create 'almost' BTS event with precise_ip and callchains,
    (perf command line -e option equiv.):

    -e cpu/branch-instructions/up -c 2 -g

  - change the period of that event to '1', which will turn
    it to BTS event, with precise_ip and callchains

That will immediately cause crash in perf_prepare_sample
function because precise_ip events are expected to come
in with callchain data initialized, but that's not the
case for intel_pmu_drain_bts_buffer caller.

Adding a check_period callback to be called before the period
is changed via PERF_EVENT_IOC_PERIOD. It will deny the change
if the event would become BTS. Plus adding also the limit_period
check as well.

Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/events/core.c       | 14 ++++++++++++++
 arch/x86/events/intel/core.c |  9 +++++++++
 arch/x86/events/perf_event.h | 16 ++++++++++++++--
 include/linux/perf_event.h   |  5 +++++
 kernel/events/core.c         | 16 ++++++++++++++++
 5 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 374a19712e20..b684f0294f35 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2278,6 +2278,19 @@ void perf_check_microcode(void)
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
@@ -2302,6 +2315,7 @@ static struct pmu pmu = {
 	.event_idx		= x86_pmu_event_idx,
 	.sched_task		= x86_pmu_sched_task,
 	.task_ctx_size          = sizeof(struct x86_perf_task_context),
+	.check_period		= x86_pmu_check_period,
 };
 
 void arch_perf_update_userpage(struct perf_event *event,
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 40e12cfc87f6..d6532ae099f7 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3584,6 +3584,11 @@ static void intel_pmu_sched_task(struct perf_event_context *ctx,
 	intel_pmu_lbr_sched_task(ctx, sched_in);
 }
 
+static int intel_pmu_check_period(struct perf_event *event, u64 value)
+{
+	return intel_pmu_has_bts_period(event, value) ? -EINVAL : 0;
+}
+
 PMU_FORMAT_ATTR(offcore_rsp, "config1:0-63");
 
 PMU_FORMAT_ATTR(ldlat, "config1:0-15");
@@ -3663,6 +3668,8 @@ static __initconst const struct x86_pmu core_pmu = {
 	.cpu_prepare		= intel_pmu_cpu_prepare,
 	.cpu_starting		= intel_pmu_cpu_starting,
 	.cpu_dying		= intel_pmu_cpu_dying,
+
+	.check_period		= intel_pmu_check_period,
 };
 
 static struct attribute *intel_pmu_attrs[];
@@ -3705,6 +3712,8 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.cpu_dying		= intel_pmu_cpu_dying,
 	.guest_get_msrs		= intel_guest_get_msrs,
 	.sched_task		= intel_pmu_sched_task,
+
+	.check_period		= intel_pmu_check_period,
 };
 
 static __init void intel_clovertown_quirk(void)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 78d7b7031bfc..d46fd6754d92 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -646,6 +646,11 @@ struct x86_pmu {
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
@@ -857,7 +862,7 @@ static inline int amd_pmu_init(void)
 
 #ifdef CONFIG_CPU_SUP_INTEL
 
-static inline bool intel_pmu_has_bts(struct perf_event *event)
+static inline bool intel_pmu_has_bts_period(struct perf_event *event, u64 period)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	unsigned int hw_event, bts_event;
@@ -868,7 +873,14 @@ static inline bool intel_pmu_has_bts(struct perf_event *event)
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
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index dec882fc451b..fb1de91e1e0b 100644
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
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 280a72b3a553..45ac90d3ba24 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4969,6 +4969,11 @@ static void __perf_event_period(struct perf_event *event,
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
@@ -4985,6 +4990,9 @@ static int perf_event_period(struct perf_event *event, u64 __user *arg)
 	if (event->attr.freq && value > sysctl_perf_event_sample_rate)
 		return -EINVAL;
 
+	if (perf_event_check_period(event, value))
+		return -EINVAL;
+
 	event_function_call(event, __perf_event_period, &value);
 
 	return 0;
@@ -9601,6 +9609,11 @@ static int perf_pmu_nop_int(struct pmu *pmu)
 	return 0;
 }
 
+static int perf_event_nop_int(struct perf_event *event, u64 value)
+{
+	return 0;
+}
+
 static DEFINE_PER_CPU(unsigned int, nop_txn_flags);
 
 static void perf_pmu_start_txn(struct pmu *pmu, unsigned int flags)
@@ -9901,6 +9914,9 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 		pmu->pmu_disable = perf_pmu_nop_void;
 	}
 
+	if (!pmu->check_period)
+		pmu->check_period = perf_event_nop_int;
+
 	if (!pmu->event_idx)
 		pmu->event_idx = perf_event_idx_default;
 
-- 
2.17.2

