Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BF9C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57AD320866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AD320866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbeINBU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 21:20:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:56110 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbeINBU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 21:20:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2018 13:09:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,370,1531810800"; 
   d="scan'208";a="262395032"
Received: from otc-brkl-02.jf.intel.com ([10.54.39.19])
  by fmsmga005.fm.intel.com with ESMTP; 13 Sep 2018 13:09:42 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, tglx@linutronix.de, acme@kernel.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/intel/lbr: Optimize context switches for LBR
Date:   Thu, 13 Sep 2018 16:08:51 -0400
Message-Id: <1536869331-63561-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.4.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

LBR can bring big overhead when the benchmark has high context switches.
For example, a sub benchmark of Dacapo, avrora.

Baseline: java -jar dacapo-9.12-MR1-bach.jar avrora -n 20
With LBR: perf record --branch-filter any,u -- java -jar
dacapo-9.12-MR1-bach.jar avrora -n 20

Baseline (ms)    With LBR (ms)    Overhead
6508		 19831		  205%

In principle the LBRs need to be flushed between threads. So does
current code.

However in practice the LBRs clear very quickly when any code runs,
so it is unlikely to be a functional problem of LBR use for sampling
if there is a small leak shortly after each context switch.
It is mainly a security issue that we don't want to leak anything to an
attacker.

Different threads in a process already must trust each other so we can
safely leak in this case without opening security holes.

When switching to kernel threads (such as the common switch to idle
case) which also share the same mm and are guaranteed to not be
attackers.

For those cases, resetting the LBRs can be safely avoid.
Checking ctx_id, only resetting the LBRs when switching to a different
user process.

With the patch,
Baseline (ms)    With LBR (ms)    Overhead
6508		 10350            59%

Reported-by: Sandhya Viswanathan <sandhya.viswanathan@intel.com>
Suggested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/lbr.c  | 16 ++++++++++++++--
 arch/x86/events/perf_event.h |  1 +
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index f3e006b..26344c4 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -444,9 +444,21 @@ void intel_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in)
 	 * are not tagged with an identifier, we need to wipe the LBR, even for
 	 * per-cpu events. You simply cannot resolve the branches from the old
 	 * address space.
+	 * We don't need to wipe the LBR for a kernel thread which share the
+	 * same mm with previous user thread.
 	 */
-	if (sched_in)
-		intel_pmu_lbr_reset();
+	if (!current || !current->mm)
+		return;
+	if (sched_in) {
+		/*
+		 * Only flush when switching to user threads
+		 * and mm context changed
+		 */
+		if (current->mm->context.ctx_id != cpuc->last_ctx_id)
+			intel_pmu_lbr_reset();
+	} else {
+		cpuc->last_ctx_id = current->mm->context.ctx_id;
+	}
 }
 
 static inline bool branch_user_callstack(unsigned br_sel)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 1562863..3aa3379 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -217,6 +217,7 @@ struct cpu_hw_events {
 	u64				br_sel;
 	struct x86_perf_task_context	*last_task_ctx;
 	int				last_log_id;
+	u64				last_ctx_id;
 
 	/*
 	 * Intel host/guest exclude bits
-- 
2.4.11

