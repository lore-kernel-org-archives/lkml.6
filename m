Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeEVLc3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 07:32:29 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64768 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752525AbeEVLcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 07:32:24 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Viresh Kumar <viresh.kumar@linaro.org>,
        "Joel Fernandes (Google.)" <joelaf@google.com>
Cc: linux-kernel@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>, Todd Kjos <tkjos@google.com>,
        claudio@evidence.eu.com, kernel-team@android.com,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] schedutil: Allow cpufreq requests to be made even when kthread kicked
Date: Tue, 22 May 2018 13:31:45 +0200
Message-ID: <6163159.YL3rkaEOau@aspire.rjw.lan>
In-Reply-To: <20180522105429.yn2omuz63oa2w3ez@vireshk-i7>
References: <20180518185501.173552-1-joel@joelfernandes.org> <4393838.cQWhzXzUcj@aspire.rjw.lan> <20180522105429.yn2omuz63oa2w3ez@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, May 22, 2018 12:54:29 PM CEST Viresh Kumar wrote:
> On 22-05-18, 12:50, Rafael J. Wysocki wrote:
> > Ugly indeed.
> 
> Hehe. I was thinking, maybe we can write wrapper helpers around lock/unlock
> which are stored as pointers in sg_policy. So that those are only set to
> non-NULL values (or non-Noop routines) for slow-switching single policy or
> any-switching shared policy systems. Then we can get rid of such conditional
> locking attempts :)
> 
> 

So below is my (compiled-only) version of the $subject patch, obviously based
on the Joel's work.

Roughly, what it does is to move the fast_switch_enabled path entirely to
sugov_update_single() and take the spinlock around sugov_update_commit()
in the one-CPU case too.

---
 kernel/sched/cpufreq_schedutil.c |   57 ++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 19 deletions(-)

Index: linux-pm/kernel/sched/cpufreq_schedutil.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
+++ linux-pm/kernel/sched/cpufreq_schedutil.c
@@ -92,9 +92,6 @@ static bool sugov_should_update_freq(str
 	    !cpufreq_can_do_remote_dvfs(sg_policy->policy))
 		return false;
 
-	if (sg_policy->work_in_progress)
-		return false;
-
 	if (unlikely(sg_policy->need_freq_update))
 		return true;
 
@@ -103,25 +100,25 @@ static bool sugov_should_update_freq(str
 	return delta_ns >= sg_policy->freq_update_delay_ns;
 }
 
-static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
-				unsigned int next_freq)
+static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
+				   unsigned int next_freq)
 {
-	struct cpufreq_policy *policy = sg_policy->policy;
-
 	if (sg_policy->next_freq == next_freq)
-		return;
+		return false;
 
 	sg_policy->next_freq = next_freq;
 	sg_policy->last_freq_update_time = time;
 
-	if (policy->fast_switch_enabled) {
-		next_freq = cpufreq_driver_fast_switch(policy, next_freq);
-		if (!next_freq)
-			return;
+	return true;
+}
 
-		policy->cur = next_freq;
-		trace_cpu_frequency(next_freq, smp_processor_id());
-	} else {
+static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
+				unsigned int next_freq)
+{
+	if (!sugov_update_next_freq(sg_policy, time, next_freq))
+		return;
+
+	if (!sg_policy->work_in_progress) {
 		sg_policy->work_in_progress = true;
 		irq_work_queue(&sg_policy->irq_work);
 	}
@@ -277,6 +274,7 @@ static void sugov_update_single(struct u
 {
 	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
+	struct cpufreq_policy *policy = sg_policy->policy;
 	unsigned long util, max;
 	unsigned int next_f;
 	bool busy;
@@ -307,7 +305,23 @@ static void sugov_update_single(struct u
 		sg_policy->cached_raw_freq = 0;
 	}
 
-	sugov_update_commit(sg_policy, time, next_f);
+	if (policy->fast_switch_enabled) {
+		if (!sugov_update_next_freq(sg_policy, time, next_f))
+			return;
+
+		next_f = cpufreq_driver_fast_switch(policy, next_f);
+		if (!next_f)
+			return;
+
+		policy->cur = next_f;
+		trace_cpu_frequency(next_f, smp_processor_id());
+	} else {
+		raw_spin_lock(&sg_policy->update_lock);
+
+		sugov_update_commit(sg_policy, time, next_f);
+
+		raw_spin_unlock(&sg_policy->update_lock);
+	}
 }
 
 static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
@@ -376,13 +390,18 @@ sugov_update_shared(struct update_util_d
 static void sugov_work(struct kthread_work *work)
 {
 	struct sugov_policy *sg_policy = container_of(work, struct sugov_policy, work);
+	unsigned int next_freq;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&sg_policy->update_lock, flags);
+	next_freq = sg_policy->next_freq;
+	sg_policy->work_in_progress = false;
+	raw_spin_unlock_irqrestore(&sg_policy->update_lock, flags);
 
 	mutex_lock(&sg_policy->work_lock);
-	__cpufreq_driver_target(sg_policy->policy, sg_policy->next_freq,
+	__cpufreq_driver_target(sg_policy->policy, next_freq,
 				CPUFREQ_RELATION_L);
 	mutex_unlock(&sg_policy->work_lock);
-
-	sg_policy->work_in_progress = false;
 }
 
 static void sugov_irq_work(struct irq_work *irq_work)
