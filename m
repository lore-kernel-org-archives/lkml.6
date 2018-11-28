Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99F2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9407520989
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9407520989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbeK1WzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 17:55:05 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36852 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727585AbeK1WzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 17:55:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 795773650;
        Wed, 28 Nov 2018 03:53:41 -0800 (PST)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 413823F59C;
        Wed, 28 Nov 2018 03:53:39 -0800 (PST)
Date:   Wed, 28 Nov 2018 11:53:36 +0000
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        pkondeti@codeaurora.org, Quentin Perret <quentin.perret@arm.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v7 2/2] sched/fair: update scale invariance of PELT
Message-ID: <20181128115336.GB23094@e110439-lin>
References: <1542711308-25256-1-git-send-email-vincent.guittot@linaro.org>
 <1542711308-25256-3-git-send-email-vincent.guittot@linaro.org>
 <CAKfTPtD=sV3zJiZMfCFi92_f6j-jTO9D5RsEBAXHVa6VN3Urwg@mail.gmail.com>
 <20181128100241.GA2131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128100241.GA2131@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-Nov 11:02, Peter Zijlstra wrote:
> On Wed, Nov 28, 2018 at 10:54:13AM +0100, Vincent Guittot wrote:
> 
> > Is there anything else that I should do for these patches ?
> 
> IIRC, Morten mention they break util_est; Patrick was going to explain.

I guess the problem is that, once we cross the current capacity,
strictly speaking util_avg does not represent anymore a utilization.

With the new signal this could happen and we end up storing estimated
utilization samples which will overestimate the task requirements.

We will have a spike in estimated utilization at next wakeup, since we
use MAX(util_avg@dequeue_time, ewma). Potentially we also inflate the EWMA in
case we collect multiple samples above the current capacity.

So, a possible fix could be to avoid storing util_est samples if we
end up with a utilization above the current capacity.

Something like:

----8<---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ac855b2f4774..93e0cf5d8a76 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3661,6 +3661,10 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
 	if (!task_sleep)
 		return;
 
+	/* Skip samples which do not represent an actual utilization */
+	if (unlikely(task_util(p) > capacity_of(task_cpu(p))))
+		return;
+
 	/*
 	 * If the PELT values haven't changed since enqueue time,
 	 * skip the util_est update.
---8<---

Could that work ?

Maybe using a new utility function to wrap the new check.

-- 
#include <best/regards.h>

Patrick Bellasi
