Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B019CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76BF020811
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896831;
	bh=RvbQBeaXP2ONzvtX0a2mxmLz7hSu2O566CDDmrjhRxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QjZVkANtdzw1K09nQilbydtR2Z4enmo8T6kNqAKZyL63YNnuFeBMo3GT2AZLooult
	 sJ7W3QXgT5w2HNCEbvFjTVSKHLgCNQhGIwzm7Et6CIU3sgoXvJ61rGBqPlEqq3V2HF
	 xTV7WOC5cnhOsaOr3wEuskwxNGYdo9RkwMLpN7GE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388745AbfBKOxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:53:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:40288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387780AbfBKOxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:53:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07D5520700;
        Mon, 11 Feb 2019 14:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896825;
        bh=RvbQBeaXP2ONzvtX0a2mxmLz7hSu2O566CDDmrjhRxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MgZEXKh7uQNRvbOXZqcpNTdTjqJO40hOWILad1YgSElgPRI/wwD5jx3tJcyI/Jci2
         N5NNego9DXpC85HrHNCPd5FMNTeg9k5VoDaa83iL7rj9k4/63pAG5+OrhTLfR0viuW
         caCA+zmVH1W0wfPG7Gui9fXKtzvZADwVOlo6vHjU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, He Zhe <zhe.he@windriver.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, acme@kernel.org,
        bp@alien8.de, hpa@zytor.com, jolsa@kernel.org,
        kan.liang@linux.intel.com, namhyung@kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.19 313/313] perf/x86/intel: Delay memory deallocation until x86_pmu_dead_cpu()
Date:   Mon, 11 Feb 2019 15:19:53 +0100
Message-Id: <20190211141913.704871356@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

From: Peter Zijlstra <peterz@infradead.org>

commit 602cae04c4864bb3487dfe4c2126c8d9e7e1614a upstream.

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
[ He Zhe: Fixes conflict caused by missing disable_counter_freeze which is
 introduced since v4.20 af3bdb991a5cb. ]
Signed-off-by: He Zhe <zhe.he@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/events/intel/core.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3440,6 +3440,11 @@ static void free_excl_cntrs(int cpu)
 
 static void intel_pmu_cpu_dying(int cpu)
 {
+	fini_debug_store_on_cpu(cpu);
+}
+
+static void intel_pmu_cpu_dead(int cpu)
+{
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
 	struct intel_shared_regs *pc;
 
@@ -3451,8 +3456,6 @@ static void intel_pmu_cpu_dying(int cpu)
 	}
 
 	free_excl_cntrs(cpu);
-
-	fini_debug_store_on_cpu(cpu);
 }
 
 static void intel_pmu_sched_task(struct perf_event_context *ctx,
@@ -3541,6 +3544,7 @@ static __initconst const struct x86_pmu
 	.cpu_prepare		= intel_pmu_cpu_prepare,
 	.cpu_starting		= intel_pmu_cpu_starting,
 	.cpu_dying		= intel_pmu_cpu_dying,
+	.cpu_dead		= intel_pmu_cpu_dead,
 };
 
 static struct attribute *intel_pmu_attrs[];
@@ -3581,6 +3585,8 @@ static __initconst const struct x86_pmu
 	.cpu_prepare		= intel_pmu_cpu_prepare,
 	.cpu_starting		= intel_pmu_cpu_starting,
 	.cpu_dying		= intel_pmu_cpu_dying,
+	.cpu_dead		= intel_pmu_cpu_dead,
+
 	.guest_get_msrs		= intel_guest_get_msrs,
 	.sched_task		= intel_pmu_sched_task,
 };


