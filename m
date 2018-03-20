Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753125AbeCTLJY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:09:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53075 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752939AbeCTLJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:09:21 -0400
Date: Tue, 20 Mar 2018 04:08:31 -0700
From: tip-bot for Patrick Bellasi <tipbot@zytor.com>
Message-ID: <tip-a07630b8b2c16f82fd5b71d890079f4dd7599c1d@git.kernel.org>
Cc: juri.lelli@redhat.com, joelaf@google.com, patrick.bellasi@arm.com,
        peterz@infradead.org, morten.rasmussen@arm.com, tglx@linutronix.de,
        tkjos@android.com, torvalds@linux-foundation.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        smuckle@google.com, rafael.j.wysocki@intel.com, mingo@kernel.org,
        dietmar.eggemann@arm.com, pjt@google.com, viresh.kumar@linaro.org,
        hpa@zytor.com
Reply-To: patrick.bellasi@arm.com, tglx@linutronix.de,
        morten.rasmussen@arm.com, tkjos@android.com, peterz@infradead.org,
        juri.lelli@redhat.com, joelaf@google.com, dietmar.eggemann@arm.com,
        mingo@kernel.org, pjt@google.com, rafael.j.wysocki@intel.com,
        hpa@zytor.com, viresh.kumar@linaro.org, torvalds@linux-foundation.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        smuckle@google.com
In-Reply-To: <20180309095245.11071-4-patrick.bellasi@arm.com>
References: <20180309095245.11071-4-patrick.bellasi@arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/cpufreq/schedutil: Use util_est for OPP
 selection
Git-Commit-ID: a07630b8b2c16f82fd5b71d890079f4dd7599c1d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a07630b8b2c16f82fd5b71d890079f4dd7599c1d
Gitweb:     https://git.kernel.org/tip/a07630b8b2c16f82fd5b71d890079f4dd7599c1d
Author:     Patrick Bellasi <patrick.bellasi@arm.com>
AuthorDate: Fri, 9 Mar 2018 09:52:44 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Mar 2018 08:11:08 +0100

sched/cpufreq/schedutil: Use util_est for OPP selection

When schedutil looks at the CPU utilization, the current PELT value for
that CPU is returned straight away. In certain scenarios this can have
undesired side effects and delays on frequency selection.

For example, since the task utilization is decayed at wakeup time, a
long sleeping big task newly enqueued does not add immediately a
significant contribution to the target CPU. This introduces some latency
before schedutil will be able to detect the best frequency required by
that task.

Moreover, the PELT signal build-up time is a function of the current
frequency, because of the scale invariant load tracking support. Thus,
starting from a lower frequency, the utilization build-up time will
increase even more and further delays the selection of the actual
frequency which better serves the task requirements.

In order to reduce these kind of latencies, we integrate the usage
of the CPU's estimated utilization in the sugov_get_util function.

This allows to properly consider the expected utilization of a CPU which,
for example, has just got a big task running after a long sleep period.
Ultimately this allows to select the best frequency to run a task
right after its wake-up.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steve Muckle <smuckle@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Todd Kjos <tkjos@android.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: http://lkml.kernel.org/r/20180309095245.11071-4-patrick.bellasi@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/sched.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 22909ffc04fb..c3deaee7a7a2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2163,6 +2163,13 @@ static inline unsigned long cpu_util_dl(struct rq *rq)
 
 static inline unsigned long cpu_util_cfs(struct rq *rq)
 {
-	return rq->cfs.avg.util_avg;
+	unsigned long util = READ_ONCE(rq->cfs.avg.util_avg);
+
+	if (sched_feat(UTIL_EST)) {
+		util = max_t(unsigned long, util,
+			     READ_ONCE(rq->cfs.avg.util_est.enqueued));
+	}
+
+	return util;
 }
 #endif
