Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D80EC4151A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3674520820
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbfBDItG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:49:06 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46961 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfBDItG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:49:06 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x148mjOT356950
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 00:48:45 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x148mjs1356946;
        Mon, 4 Feb 2019 00:48:45 -0800
Date:   Mon, 4 Feb 2019 00:48:45 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-602cae04c4864bb3487dfe4c2126c8d9e7e1614a@git.kernel.org>
Cc:     acme@redhat.com, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, jolsa@redhat.com, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, stable@vger.kernel.org,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        zhe.he@windriver.com, mingo@kernel.org, peterz@infradead.org
Reply-To: jolsa@redhat.com, linux-kernel@vger.kernel.org,
          stable@vger.kernel.org, alexander.shishkin@linux.intel.com,
          hpa@zytor.com, acme@redhat.com, bigeasy@linutronix.de,
          mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
          zhe.he@windriver.com, torvalds@linux-foundation.org
In-Reply-To: <20181219165350.6s3jvyxbibpvlhtq@linutronix.de>
References: <20181219165350.6s3jvyxbibpvlhtq@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel: Delay memory deallocation until
 x86_pmu_dead_cpu()
Git-Commit-ID: 602cae04c4864bb3487dfe4c2126c8d9e7e1614a
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

Commit-ID:  602cae04c4864bb3487dfe4c2126c8d9e7e1614a
Gitweb:     https://git.kernel.org/tip/602cae04c4864bb3487dfe4c2126c8d9e7e1614a
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Wed, 19 Dec 2018 17:53:50 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 4 Feb 2019 08:44:51 +0100

perf/x86/intel: Delay memory deallocation until x86_pmu_dead_cpu()

intel_pmu_cpu_prepare() allocated memory for ->shared_regs among other
members of struct cpu_hw_events. This memory is released in
intel_pmu_cpu_dying() which is wrong. The counterpart of the
intel_pmu_cpu_prepare() callback is x86_pmu_dead_cpu().

Otherwise if the CPU fails on the UP path between CPUHP_PERF_X86_PREPARE
and CPUHP_AP_PERF_X86_STARTING then it won't release the memory but
allocate new memory on the next attempt to online the CPU (leaking the
old memory).
Also, if the CPU down path fails between CPUHP_AP_PERF_X86_STARTING and
CPUHP_PERF_X86_PREPARE then the CPU will go back online but never
allocate the memory that was released in x86_pmu_dying_cpu().

Make the memory allocation/free symmetrical in regard to the CPU hotplug
notifier by moving the deallocation to intel_pmu_cpu_dead().

This started in commit:

   a7e3ed1e47011 ("perf: Add support for supplementary event registers").

In principle the bug was introduced in v2.6.39 (!), but it will almost
certainly not backport cleanly across the big CPU hotplug rewrite between v4.7-v4.15...

[ bigeasy: Added patch description. ]
[ mingo: Added backporting guidance. ]

Reported-by: He Zhe <zhe.he@windriver.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org> # With developer hat on
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org> # With maintainer hat on
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: acme@kernel.org
Cc: bp@alien8.de
Cc: hpa@zytor.com
Cc: jolsa@kernel.org
Cc: kan.liang@linux.intel.com
Cc: namhyung@kernel.org
Cc: <stable@vger.kernel.org>
Fixes: a7e3ed1e47011 ("perf: Add support for supplementary event registers").
Link: https://lkml.kernel.org/r/20181219165350.6s3jvyxbibpvlhtq@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/core.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 40e12cfc87f6..daafb893449b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3558,6 +3558,14 @@ static void free_excl_cntrs(int cpu)
 }
 
 static void intel_pmu_cpu_dying(int cpu)
+{
+	fini_debug_store_on_cpu(cpu);
+
+	if (x86_pmu.counter_freezing)
+		disable_counter_freeze();
+}
+
+static void intel_pmu_cpu_dead(int cpu)
 {
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
 	struct intel_shared_regs *pc;
@@ -3570,11 +3578,6 @@ static void intel_pmu_cpu_dying(int cpu)
 	}
 
 	free_excl_cntrs(cpu);
-
-	fini_debug_store_on_cpu(cpu);
-
-	if (x86_pmu.counter_freezing)
-		disable_counter_freeze();
 }
 
 static void intel_pmu_sched_task(struct perf_event_context *ctx,
@@ -3663,6 +3666,7 @@ static __initconst const struct x86_pmu core_pmu = {
 	.cpu_prepare		= intel_pmu_cpu_prepare,
 	.cpu_starting		= intel_pmu_cpu_starting,
 	.cpu_dying		= intel_pmu_cpu_dying,
+	.cpu_dead		= intel_pmu_cpu_dead,
 };
 
 static struct attribute *intel_pmu_attrs[];
@@ -3703,6 +3707,8 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.cpu_prepare		= intel_pmu_cpu_prepare,
 	.cpu_starting		= intel_pmu_cpu_starting,
 	.cpu_dying		= intel_pmu_cpu_dying,
+	.cpu_dead		= intel_pmu_cpu_dead,
+
 	.guest_get_msrs		= intel_guest_get_msrs,
 	.sched_task		= intel_pmu_sched_task,
 };
