Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7F6C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46B52184E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbeLRLZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:25:50 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:55661 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeLRLZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:25:50 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gZDVB-0007TC-TC; Tue, 18 Dec 2018 12:25:30 +0100
Date:   Tue, 18 Dec 2018 12:25:23 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     zhe.he@windriver.com, acme@kernel.org, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, bp@alien8.de, hpa@zytor.com,
        jolsa@kernel.org, jolsa@redhat.com, kan.liang@linux.intel.com,
        mingo@redhat.com, namhyung@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel: Avoid unnecessary reallocations of memory
 allocated in cpu hotplug prepare state
In-Reply-To: <20181218110209.GD15430@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1812181223220.1519@nanos.tec.linutronix.de>
References: <1545129033-21757-1-git-send-email-zhe.he@windriver.com> <20181218110209.GD15430@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018, Peter Zijlstra wrote:
> On Tue, Dec 18, 2018 at 06:30:33PM +0800, zhe.he@windriver.com wrote:
> > Besides, in preempt-rt full mode, the freeing can happen in atomic context and
> > thus cause the following BUG.
> 
> Hurm, I though we fixed all those long ago..

Either we missed that one or it came back somehow.

> And no, the patch is horrible; that's what we have things like
> x86_pmu::cpu_dead() for.

Like the below?

Thanks,

	tglx

8<------------

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3559,6 +3559,14 @@ static void free_excl_cntrs(int cpu)
 
 static void intel_pmu_cpu_dying(int cpu)
 {
+	fini_debug_store_on_cpu(cpu);
+
+	if (x86_pmu.counter_freezing)
+		disable_counter_freeze();
+}
+
+static void intel_pmu_cpu_dead(int cpu)
+{
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
@@ -3663,6 +3666,7 @@ static __initconst const struct x86_pmu
 	.cpu_prepare		= intel_pmu_cpu_prepare,
 	.cpu_starting		= intel_pmu_cpu_starting,
 	.cpu_dying		= intel_pmu_cpu_dying,
+	.cpu_dead		= intel_pmu_cpu_dead,
 };
 
 static struct attribute *intel_pmu_attrs[];
@@ -3703,6 +3707,7 @@ static __initconst const struct x86_pmu
 	.cpu_prepare		= intel_pmu_cpu_prepare,
 	.cpu_starting		= intel_pmu_cpu_starting,
 	.cpu_dying		= intel_pmu_cpu_dying,
+	.cpu_dead		= intel_pmu_cpu_dead,
 	.guest_get_msrs		= intel_guest_get_msrs,
 	.sched_task		= intel_pmu_sched_task,
 };

