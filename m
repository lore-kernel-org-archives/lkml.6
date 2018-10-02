Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28D7C64EB5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98581208AE
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98581208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733132AbeJBUTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:19:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36140 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731847AbeJBUTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:19:40 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A8B0C5AA;
        Tue,  2 Oct 2018 13:36:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, acme@kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 45/94] perf/x86/intel/lbr: Fix incomplete LBR call stack
Date:   Tue,  2 Oct 2018 06:24:59 -0700
Message-Id: <20181002132503.619650894@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132500.494838053@linuxfoundation.org>
References: <20181002132500.494838053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit 0592e57b24e7e05ec1f4c50b9666c013abff7017 ]

LBR has a limited stack size. If a task has a deeper call stack than
LBR's stack size, only the overflowed part is reported. A complete call
stack may not be reconstructed by perf tool.

Current code doesn't access all LBR registers. It only read the ones
below the TOS. The LBR registers above the TOS will be discarded
unconditionally.

When a CALL is captured, the TOS is incremented by 1 , modulo max LBR
stack size. The LBR HW only records the call stack information to the
register which the TOS points to. It will not touch other LBR
registers. So the registers above the TOS probably still store the valid
call stack information for an overflowed call stack, which need to be
reported.

To retrieve complete call stack information, we need to start from TOS,
read all LBR registers until an invalid entry is detected.
0s can be used to detect the invalid entry, because:

 - When a RET is captured, the HW zeros the LBR register which TOS points
   to, then decreases the TOS.
 - The LBR registers are reset to 0 when adding a new LBR event or
   scheduling an existing LBR event.
 - A taken branch at IP 0 is not expected

The context switch code is also modified to save/restore all valid LBR
registers. Furthermore, the LBR registers, which don't have valid call
stack information, need to be reset in restore, because they may be
polluted while swapped out.

Here is a small test program, tchain_deep.
Its call stack is deeper than 32.

 noinline void f33(void)
 {
        int i;

        for (i = 0; i < 10000000;) {
                if (i%2)
                        i++;
                else
                        i++;
        }
 }

 noinline void f32(void)
 {
        f33();
 }

 noinline void f31(void)
 {
        f32();
 }

 ... ...

 noinline void f1(void)
 {
        f2();
 }

 int main()
 {
        f1();
 }

Here is the test result on SKX. The max stack size of SKX is 32.

Without the patch:

 $ perf record -e cycles --call-graph lbr -- ./tchain_deep
 $ perf report --stdio
 #
 # Children      Self  Command      Shared Object     Symbol
 # ........  ........  ...........  ................  .................
 #
   100.00%    99.99%  tchain_deep    tchain_deep       [.] f33
            |
             --99.99%--f30
                       f31
                       f32
                       f33

With the patch:

 $ perf record -e cycles --call-graph lbr -- ./tchain_deep
 $ perf report --stdio
 # Children      Self  Command      Shared Object     Symbol
 # ........  ........  ...........  ................  ..................
 #
    99.99%     0.00%  tchain_deep    tchain_deep       [.] f1
            |
            ---f1
               f2
               f3
               f4
               f5
               f6
               f7
               f8
               f9
               f10
               f11
               f12
               f13
               f14
               f15
               f16
               f17
               f18
               f19
               f20
               f21
               f22
               f23
               f24
               f25
               f26
               f27
               f28
               f29
               f30
               f31
               f32
               f33

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: acme@kernel.org
Cc: eranian@google.com
Link: https://lore.kernel.org/lkml/1528213126-4312-1-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/events/intel/lbr.c  |   32 ++++++++++++++++++++++++++------
 arch/x86/events/perf_event.h |    1 +
 2 files changed, 27 insertions(+), 6 deletions(-)

--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -342,7 +342,7 @@ static void __intel_pmu_lbr_restore(stru
 
 	mask = x86_pmu.lbr_nr - 1;
 	tos = task_ctx->tos;
-	for (i = 0; i < tos; i++) {
+	for (i = 0; i < task_ctx->valid_lbrs; i++) {
 		lbr_idx = (tos - i) & mask;
 		wrlbr_from(lbr_idx, task_ctx->lbr_from[i]);
 		wrlbr_to  (lbr_idx, task_ctx->lbr_to[i]);
@@ -350,6 +350,15 @@ static void __intel_pmu_lbr_restore(stru
 		if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO)
 			wrmsrl(MSR_LBR_INFO_0 + lbr_idx, task_ctx->lbr_info[i]);
 	}
+
+	for (; i < x86_pmu.lbr_nr; i++) {
+		lbr_idx = (tos - i) & mask;
+		wrlbr_from(lbr_idx, 0);
+		wrlbr_to(lbr_idx, 0);
+		if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO)
+			wrmsrl(MSR_LBR_INFO_0 + lbr_idx, 0);
+	}
+
 	wrmsrl(x86_pmu.lbr_tos, tos);
 	task_ctx->lbr_stack_state = LBR_NONE;
 }
@@ -357,7 +366,7 @@ static void __intel_pmu_lbr_restore(stru
 static void __intel_pmu_lbr_save(struct x86_perf_task_context *task_ctx)
 {
 	unsigned lbr_idx, mask;
-	u64 tos;
+	u64 tos, from;
 	int i;
 
 	if (task_ctx->lbr_callstack_users == 0) {
@@ -367,13 +376,17 @@ static void __intel_pmu_lbr_save(struct
 
 	mask = x86_pmu.lbr_nr - 1;
 	tos = intel_pmu_lbr_tos();
-	for (i = 0; i < tos; i++) {
+	for (i = 0; i < x86_pmu.lbr_nr; i++) {
 		lbr_idx = (tos - i) & mask;
-		task_ctx->lbr_from[i] = rdlbr_from(lbr_idx);
+		from = rdlbr_from(lbr_idx);
+		if (!from)
+			break;
+		task_ctx->lbr_from[i] = from;
 		task_ctx->lbr_to[i]   = rdlbr_to(lbr_idx);
 		if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO)
 			rdmsrl(MSR_LBR_INFO_0 + lbr_idx, task_ctx->lbr_info[i]);
 	}
+	task_ctx->valid_lbrs = i;
 	task_ctx->tos = tos;
 	task_ctx->lbr_stack_state = LBR_VALID;
 }
@@ -522,7 +535,7 @@ static void intel_pmu_lbr_read_32(struct
  */
 static void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 {
-	bool need_info = false;
+	bool need_info = false, call_stack = false;
 	unsigned long mask = x86_pmu.lbr_nr - 1;
 	int lbr_format = x86_pmu.intel_cap.lbr_format;
 	u64 tos = intel_pmu_lbr_tos();
@@ -533,7 +546,7 @@ static void intel_pmu_lbr_read_64(struct
 	if (cpuc->lbr_sel) {
 		need_info = !(cpuc->lbr_sel->config & LBR_NO_INFO);
 		if (cpuc->lbr_sel->config & LBR_CALL_STACK)
-			num = tos;
+			call_stack = true;
 	}
 
 	for (i = 0; i < num; i++) {
@@ -546,6 +559,13 @@ static void intel_pmu_lbr_read_64(struct
 		from = rdlbr_from(lbr_idx);
 		to   = rdlbr_to(lbr_idx);
 
+		/*
+		 * Read LBR call stack entries
+		 * until invalid entry (0s) is detected.
+		 */
+		if (call_stack && !from)
+			break;
+
 		if (lbr_format == LBR_FORMAT_INFO && need_info) {
 			u64 info;
 
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -633,6 +633,7 @@ struct x86_perf_task_context {
 	u64 lbr_to[MAX_LBR_ENTRIES];
 	u64 lbr_info[MAX_LBR_ENTRIES];
 	int tos;
+	int valid_lbrs;
 	int lbr_callstack_users;
 	int lbr_stack_state;
 };


