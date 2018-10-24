Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D3AECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA852082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA852082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbeJYBah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:30:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45620 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeJYBah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 21:30:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C2CFA78;
        Wed, 24 Oct 2018 10:01:47 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16C9D3F627;
        Wed, 24 Oct 2018 10:01:43 -0700 (PDT)
Date:   Wed, 24 Oct 2018 18:01:37 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     "Ye, Xiaolong" <xiaolong.ye@intel.com>,
        Joel Fernandes <joelaf@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@android.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul Turner <pjt@google.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steve Muckle <smuckle@google.com>, "lkp@01.org" <lkp@01.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Chris Redpath <chris.redpath@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [LKP] [lkp-robot] [sched/fair] d519329f72: unixbench.score -9.9%
 regression
Message-ID: <20181024170137.GA13236@e110439-lin>
References: <20180402032000.GD3101@yexl-desktop>
 <20181024064100.GA27054@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024064100.GA27054@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-Oct 14:41, Aaron Lu wrote:
> On Mon, Apr 02, 2018 at 11:20:00AM +0800, Ye, Xiaolong wrote:
> > 
> > Greeting,
> > 
> > FYI, we noticed a -9.9% regression of unixbench.score due to commit:
> > 
> > 
> > commit: d519329f72a6f36bc4f2b85452640cfe583b4f81 ("sched/fair: Update util_est only on util_avg updates")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > in testcase: unixbench
> > on test machine: 8 threads Intel(R) Core(TM) i7 CPU 870 @ 2.93GHz with 6G memory
> > with following parameters:
> > 
> >         runtime: 300s
> >         nr_task: 100%
> >         test: execl
> > 
> > test-description: UnixBench is the original BYTE UNIX benchmark suite aims to test performance of Unix-like system.
> > test-url: https://github.com/kdlucas/byte-unixbench

Hi Aaron,
 
> I tested this workload on different machines with this commit
> d519329f72a6f36bc4f2b85452 and its parent a07630b8b2c16f82, I also
> tested with v4.19-rc8 to see if the regression is gone -
> the performance drop is there with v4.19-rc8 and with different
> machines so I assume this regression is not solved yet.
>
> Here are detailed data:
> 
> cmdline used to run this workload:
> ./Run execl -c $nr_cpu -i 30

I had a better look into this issue and found that something like this
could be the cure for the execl throughput regression:

---8<---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 908c9cdae2f0..c34d41b542fc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6258,8 +6258,17 @@ static unsigned long cpu_util_wake(int cpu, struct task_struct *p)
 	 * covered by the following code when estimated utilization is
 	 * enabled.
 	 */
-	if (sched_feat(UTIL_EST))
-		util = max(util, READ_ONCE(cfs_rq->avg.util_est.enqueued));
+	if (sched_feat(UTIL_EST)) {
+		unsigned int estimated =
+			READ_ONCE(cfs_rq->avg.util_est.enqueued);
+
+		if (unlikely(current == p)) {
+			estimated -= min_t(unsigned int, estimated,
+				(_task_util_est(p) | UTIL_AVG_UNCHANGED));
+		}
+
+		util = max(util, estimated);
+	}

 	/*
 	 * Utilization (estimated) can exceed the CPU capacity, thus let's
---8<---

I'll test this better on a machine on my side and send out a proper
patch by tomorrow.

> Please let me know if you need other information, thanks.

Would be nice if you can test the above on your side too.

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
