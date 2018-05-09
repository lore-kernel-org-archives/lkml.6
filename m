Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934291AbeEIJpY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 05:45:24 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52583 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933783AbeEIJpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 05:45:22 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: linux-pm@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, claudio@evidence.eu.com,
        patrick.bellasi@arm.com, juri.lelli@redhat.com, joelaf@google.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: schedutil: Avoid using invalid next_freq
Date: Wed, 09 May 2018 11:44:56 +0200
Message-ID: <2276196.ev9rMjHTR0@aspire.rjw.lan>
In-Reply-To: <872c3f8690d9362820639d91a807e535f10a9a36.1525761635.git.viresh.kumar@linaro.org>
References: <872c3f8690d9362820639d91a807e535f10a9a36.1525761635.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If the next_freq field of struct sugov_policy is set to UINT_MAX,
it shouldn't be used for updating the CPU frequency (this is a
special "invalid" value), but after commit b7eaf1aab9f8 (cpufreq:
schedutil: Avoid reducing frequency of busy CPUs prematurely) it
may be passed as the new frequency to sugov_update_commit() in
sugov_update_single().

Fix that by adding an extra check for the special UINT_MAX value
of next_freq to sugov_update_single().

Fixes: b7eaf1aab9f8 (cpufreq: schedutil: Avoid reducing frequency of busy CPUs prematurely)
Reported-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: 4.12+ <stable@vger.kernel.org> # 4.12+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/sched/cpufreq_schedutil.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-pm/kernel/sched/cpufreq_schedutil.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
+++ linux-pm/kernel/sched/cpufreq_schedutil.c
@@ -305,7 +305,8 @@ static void sugov_update_single(struct u
 	 * Do not reduce the frequency if the CPU has not been idle
 	 * recently, as the reduction is likely to be premature then.
 	 */
-	if (busy && next_f < sg_policy->next_freq) {
+	if (busy && next_f < sg_policy->next_freq &&
+	    sg_policy->next_freq != UINT_MAX) {
 		next_f = sg_policy->next_freq;
 
 		/* Reset cached freq as next_freq has changed */
