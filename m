Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbeEPWqL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 18:46:11 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45915 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751290AbeEPWqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 18:46:09 -0400
X-Google-Smtp-Source: AB8JxZoavwNJWDD/tOIHEIEbpPglC12UtYkf7EB3FesH3Vxz3lYF1nuuv60dmk/PxsiF57mBvFWafw==
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Joel Fernandes <joelaf@google.com>, linux-pm@vger.kernel.org
Subject: [PATCH RFC] schedutil: Allow cpufreq requests to be made even when kthread kicked
Date: Wed, 16 May 2018 15:45:18 -0700
Message-Id: <20180516224518.109891-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is a chance of a schedutil cpufreq update request to be
dropped if there is a pending update request. This pending request can
be delayed if there is a scheduling delay of the irq_work and the wake
up of the schedutil governor kthread.

A very bad scenario is when a schedutil request was already just made,
such as to reduce the CPU frequency, then a newer request to increase
CPU frequency (even sched deadline urgent frequency increase requests)
can be dropped, even though the rate limits suggest that its Ok to
process a request. This is because of the way the work_in_progress flag
is used.

This patch improves the situation by allowing new requests to happen
even though the old one is still being processed. Note that in this
approach, if an irq_work was already issued, we just update next_freq
and don't bother to queue another request so there's no extra work being
done to make this happen.

I had brought up this issue at the OSPM conference and Claudio had a
discussion RFC with an alternate approach [1]. I prefer the approach as
done in the patch below since it doesn't need any new flags and doesn't
cause any other extra overhead.

[1] https://patchwork.kernel.org/patch/10384261/

CC: Viresh Kumar <viresh.kumar@linaro.org>
CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>
CC: Patrick Bellasi <patrick.bellasi@arm.com>
CC: Juri Lelli <juri.lelli@redhat.com>
Cc: Luca Abeni <luca.abeni@santannapisa.it>
CC: Joel Fernandes <joelaf@google.com>
CC: linux-pm@vger.kernel.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
Claudio,
Could you also test this patch for your usecase?

 kernel/sched/cpufreq_schedutil.c | 36 +++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index e13df951aca7..a87fc281893d 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -92,9 +92,6 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 	    !cpufreq_can_do_remote_dvfs(sg_policy->policy))
 		return false;
 
-	if (sg_policy->work_in_progress)
-		return false;
-
 	if (unlikely(sg_policy->need_freq_update)) {
 		sg_policy->need_freq_update = false;
 		/*
@@ -129,8 +126,11 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
 		policy->cur = next_freq;
 		trace_cpu_frequency(next_freq, smp_processor_id());
 	} else {
-		sg_policy->work_in_progress = true;
-		irq_work_queue(&sg_policy->irq_work);
+		/* Don't queue request if one was already queued */
+		if (!sg_policy->work_in_progress) {
+			sg_policy->work_in_progress = true;
+			irq_work_queue(&sg_policy->irq_work);
+		}
 	}
 }
 
@@ -291,6 +291,15 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 
 	ignore_dl_rate_limit(sg_cpu, sg_policy);
 
+	/*
+	 * For slow-switch systems, single policy requests can't run at the
+	 * moment if the governor thread is already processing a pending
+	 * frequency switch request, this can be fixed by acquiring update_lock
+	 * while updating next_freq and work_in_progress but we prefer not to.
+	 */
+	if (sg_policy->work_in_progress)
+		return;
+
 	if (!sugov_should_update_freq(sg_policy, time))
 		return;
 
@@ -382,13 +391,24 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
 static void sugov_work(struct kthread_work *work)
 {
 	struct sugov_policy *sg_policy = container_of(work, struct sugov_policy, work);
+	unsigned int freq;
+	unsigned long flags;
+
+	/*
+	 * Hold sg_policy->update_lock shortly to handle the case where:
+	 * incase sg_policy->next_freq is read here, and then updated by
+	 * sugov_update_shared just before work_in_progress is set to false
+	 * here, we may miss queueing the new update.
+	 */
+	raw_spin_lock_irqsave(&sg_policy->update_lock, flags);
+	freq = sg_policy->next_freq;
+	sg_policy->work_in_progress = false;
+	raw_spin_unlock_irqrestore(&sg_policy->update_lock, flags);
 
 	mutex_lock(&sg_policy->work_lock);
-	__cpufreq_driver_target(sg_policy->policy, sg_policy->next_freq,
+	__cpufreq_driver_target(sg_policy->policy, freq,
 				CPUFREQ_RELATION_L);
 	mutex_unlock(&sg_policy->work_lock);
-
-	sg_policy->work_in_progress = false;
 }
 
 static void sugov_irq_work(struct irq_work *irq_work)
-- 
2.17.0.441.gb46fe60e1d-goog
