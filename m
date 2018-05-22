Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751516AbeEVMXC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 08:23:02 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41935 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbeEVMXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 08:23:00 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Viresh Kumar <viresh.kumar@linaro.org>,
        "Joel Fernandes (Google.)" <joelaf@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>, Todd Kjos <tkjos@google.com>,
        Claudio Scordino <claudio@evidence.eu.com>, kernel-team@android.com,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2] schedutil: Allow cpufreq requests to be made even when kthread kicked
Date: Tue, 22 May 2018 14:22:20 +0200
Message-ID: <4237890.zlzv5C60QP@aspire.rjw.lan>
In-Reply-To: <CAJZ5v0hP+gCiLa+6YvKHaj7u-DuRfmVq_vjFRMj6CnVktJRxVg@mail.gmail.com>
References: <20180518185501.173552-1-joel@joelfernandes.org> <20180522113844.5rz3skjeck57arft@vireshk-i7> <CAJZ5v0hP+gCiLa+6YvKHaj7u-DuRfmVq_vjFRMj6CnVktJRxVg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, May 22, 2018 1:42:05 PM CEST Rafael J. Wysocki wrote:
> On Tue, May 22, 2018 at 1:38 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 22-05-18, 13:31, Rafael J. Wysocki wrote:
> >> So below is my (compiled-only) version of the $subject patch, obviously based
> >> on the Joel's work.
> >>
> >> Roughly, what it does is to move the fast_switch_enabled path entirely to
> >> sugov_update_single() and take the spinlock around sugov_update_commit()
> >> in the one-CPU case too.

[cut]

> >
> > Why do you assume that fast switch isn't possible in shared policy
> > cases ? It infact is already enabled for few drivers.

I hope that fast_switch is not used with devfs_possible_from_any_cpu set in the
one-CPU policy case, as that looks racy even without any patching.

> OK, so the fast_switch thing needs to be left outside of the spinlock
> in the single case only.  Fair enough.

That would be something like the patch below (again, compiled-only).

---
 kernel/sched/cpufreq_schedutil.c |   67 +++++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 20 deletions(-)

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
 
@@ -103,25 +100,41 @@ static bool sugov_should_update_freq(str
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
+static void sugov_fast_switch(struct sugov_policy *sg_policy, u64 time,
+			      unsigned int next_freq)
+{
+	struct cpufreq_policy *policy = sg_policy->policy;
+
+	if (!sugov_update_next_freq(sg_policy, time, next_freq))
+		return;
+
+	next_freq = cpufreq_driver_fast_switch(policy, next_freq);
+	if (!next_freq)
+		return;
+
+	policy->cur = next_freq;
+	trace_cpu_frequency(next_freq, smp_processor_id());
+}
+
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
@@ -307,7 +320,13 @@ static void sugov_update_single(struct u
 		sg_policy->cached_raw_freq = 0;
 	}
 
-	sugov_update_commit(sg_policy, time, next_f);
+	if (sg_policy->policy->fast_switch_enabled) {
+		sugov_fast_switch(sg_policy, time, next_f);
+	} else {
+		raw_spin_lock(&sg_policy->update_lock);
+		sugov_update_commit(sg_policy, time, next_f);
+		raw_spin_unlock(&sg_policy->update_lock);
+	}
 }
 
 static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
@@ -367,7 +386,10 @@ sugov_update_shared(struct update_util_d
 
 	if (sugov_should_update_freq(sg_policy, time)) {
 		next_f = sugov_next_freq_shared(sg_cpu, time);
-		sugov_update_commit(sg_policy, time, next_f);
+		if (sg_policy->policy->fast_switch_enabled)
+			sugov_fast_switch(sg_policy, time, next_f);
+		else
+			sugov_update_commit(sg_policy, time, next_f);
 	}
 
 	raw_spin_unlock(&sg_policy->update_lock);
@@ -376,13 +398,18 @@ sugov_update_shared(struct update_util_d
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
