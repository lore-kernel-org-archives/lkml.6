Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61195C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B2020989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B2020989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbeKUUuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:50:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbeKUUuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:50:09 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7DAA5356D3;
        Wed, 21 Nov 2018 10:16:19 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C60F117CCB;
        Wed, 21 Nov 2018 10:16:17 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Vince Weaver <vincent.weaver@maine.edu>
Subject: [PATCH 3/3] perf/x86/intel: Disallow precise_ip on BTS event
Date:   Wed, 21 Nov 2018 11:16:12 +0100
Message-Id: <20181121101612.16272-3-jolsa@kernel.org>
In-Reply-To: <20181121101612.16272-1-jolsa@kernel.org>
References: <20181121101612.16272-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 21 Nov 2018 10:16:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vince reported crash in bts flush code when touching the callchain
data, which was supposed to be initialized as an 'early' callchain,
but intel_pmu_drain_bts_buffer does not do that.

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

It was triggered by fuzzer but can be easily reproduced by:
  # perf record -e cpu/branch-instructions/pu -g -c 1

Peter suggested not to allow branch tracing for precise events:

> Now arguably, this is really stupid behaviour. Who in his right mind
> wants callchain output on BTS entries. And even if they do, BTS +
> precise_ip is nonsensical.
>
> So in my mind disallowing precise_ip on BTS would be the simplest fix.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Fixes: 6cbc304f2f36 ("perf/x86/intel: Fix unwind errors from PEBS entries (mk-II)")
Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/events/intel/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 3fd3842571e8..284893373d69 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3102,6 +3102,10 @@ static int intel_pmu_bts_config(struct perf_event *event)
 		if (!attr->exclude_kernel)
 			return -EOPNOTSUPP;
 
+		/* BTS is not allowed for precise events. */
+		if (attr->precise_ip)
+			return -EOPNOTSUPP;
+
 		/* disallow bts if conflicting events are present */
 		if (x86_add_exclusive(x86_lbr_exclusive_lbr))
 			return -EBUSY;
-- 
2.17.2

