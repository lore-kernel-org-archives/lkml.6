Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E20EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 276F520866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276F520866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394030AbeKVUxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:53:51 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51319 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390595AbeKVUxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:53:51 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAMAEVs53744268
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Nov 2018 02:14:31 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAMAEVME3744265;
        Thu, 22 Nov 2018 02:14:31 -0800
Date:   Thu, 22 Nov 2018 02:14:31 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-472de49fdc53365c880ab81ae2b5cfdd83db0b06@git.kernel.org>
Cc:     peterz@infradead.org, alexander.shishkin@linux.intel.com,
        mingo@kernel.org, jolsa@redhat.com, eranian@google.com,
        a.p.zijlstra@chello.nl, torvalds@linux-foundation.org,
        stable@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        acme@redhat.com, vincent.weaver@maine.edu, acme@kernel.org,
        jolsa@kernel.org, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, torvalds@linux-foundation.org,
          stable@vger.kernel.org, acme@redhat.com, tglx@linutronix.de,
          vincent.weaver@maine.edu, jolsa@kernel.org, acme@kernel.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          peterz@infradead.org, alexander.shishkin@linux.intel.com,
          jolsa@redhat.com, a.p.zijlstra@chello.nl, eranian@google.com
In-Reply-To: <20181121101612.16272-3-jolsa@kernel.org>
References: <20181121101612.16272-3-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/intel: Disallow precise_ip on BTS events
Git-Commit-ID: 472de49fdc53365c880ab81ae2b5cfdd83db0b06
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

Commit-ID:  472de49fdc53365c880ab81ae2b5cfdd83db0b06
Gitweb:     https://git.kernel.org/tip/472de49fdc53365c880ab81ae2b5cfdd83db0b06
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 21 Nov 2018 11:16:12 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 22 Nov 2018 09:45:10 +0100

perf/x86/intel: Disallow precise_ip on BTS events

Vince reported a crash in the BTS flush code when touching the callchain
data, which was supposed to be initialized as an 'early' callchain,
but intel_pmu_drain_bts_buffer() does not do that:

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
Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: <stable@vger.kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 6cbc304f2f36 ("perf/x86/intel: Fix unwind errors from PEBS entries (mk-II)")
Link: http://lkml.kernel.org/r/20181121101612.16272-3-jolsa@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a15a73788693..ecc3e34ca955 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3106,6 +3106,10 @@ static int intel_pmu_bts_config(struct perf_event *event)
 		if (!attr->exclude_kernel)
 			return -EOPNOTSUPP;
 
+		/* BTS is not allowed for precise events. */
+		if (attr->precise_ip)
+			return -EOPNOTSUPP;
+
 		/* disallow bts if conflicting events are present */
 		if (x86_add_exclusive(x86_lbr_exclusive_lbr))
 			return -EBUSY;
