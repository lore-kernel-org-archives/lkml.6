Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144B9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E142148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E142148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbeKLEGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 23:06:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49674 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729390AbeKLEGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 23:06:09 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A38644E90E;
        Sun, 11 Nov 2018 18:16:55 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-16.brq.redhat.com [10.40.204.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 725F160C6A;
        Sun, 11 Nov 2018 18:16:51 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Vince Weaver <vincent.weaver@maine.edu>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] perf/x86/intel: Init early callchain for bts event
Date:   Sun, 11 Nov 2018 19:16:50 +0100
Message-Id: <20181111181650.4839-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sun, 11 Nov 2018 18:16:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vince reported crash in bts flush code when touching the
callchain data, which was supposed to be initialized
as an 'early' callchain data.

  BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
  ...
  Call Trace:
   <IRQ>
   intel_pmu_drain_bts_buffer+0x151/0x220
   ? intel_get_event_constraints+0x219/0x360
   ? perf_assign_events+0xe2/0x2a0
   ? select_idle_sibling+0x22/0x3a0
   ? __update_load_avg_se+0x1ec/0x270
   ? enqueue_task_fair+0x377/0xdd0
   ? cpumask_next_and+0x19/0x20
   ? load_balance+0x134/0x950
   ? check_preempt_curr+0x7a/0x90
   ? ttwu_do_wakeup+0x19/0x140
   x86_pmu_stop+0x3b/0x90
   x86_pmu_del+0x57/0x160
   event_sched_out.isra.106+0x81/0x170
   group_sched_out.part.108+0x51/0xc0
   __perf_event_disable+0x7f/0x160
   event_function+0x8c/0xd0
   remote_function+0x3c/0x50
   flush_smp_call_function_queue+0x35/0xe0
   smp_call_function_single_interrupt+0x3a/0xd0
   call_function_single_interrupt+0xf/0x20
   </IRQ>

It was triggered by fuzzer by can be easilt reproduced by:
  # perf record -e cpu/branch-instructions/p -g -c 1

The problem is that bts drain code does not initialize sample's
early callchain data and calls perf_prepare_sample with NULL
sample->callchain, even if it's expected to exist via
__PERF_SAMPLE_CALLCHAIN_EARLY sample type bit.

The fix initializes the callchain data for this case with
empty callchain, because bts does not report callchains.

Cc: Vince Weaver <vincent.weaver@maine.edu>
Fixes: 6cbc304f2f36 ("perf/x86/intel: Fix unwind errors from PEBS entries (mk-II)")
Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/events/intel/ds.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index b7b01d762d32..1049b547fdfe 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -577,6 +577,8 @@ void intel_pmu_disable_bts(void)
 	update_debugctlmsr(debugctlmsr);
 }
 
+static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
+
 int intel_pmu_drain_bts_buffer(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -612,6 +614,9 @@ int intel_pmu_drain_bts_buffer(void)
 
 	perf_sample_data_init(&data, 0, event->hw.last_period);
 
+	if (event->attr.sample_type & __PERF_SAMPLE_CALLCHAIN_EARLY)
+		data.callchain = &__empty_callchain;
+
 	/*
 	 * BTS leaks kernel addresses in branches across the cpl boundary,
 	 * such as traps or system calls, so unless the user is asking for
-- 
2.17.2

