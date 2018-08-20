Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4414DC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026C221473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 026C221473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeHTPnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 11:43:00 -0400
Received: from foss.arm.com ([217.140.101.70]:36938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbeHTPnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 11:43:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D46DED1;
        Mon, 20 Aug 2018 05:27:34 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7266D3F2EA;
        Mon, 20 Aug 2018 05:27:31 -0700 (PDT)
Date:   Mon, 20 Aug 2018 13:27:28 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 12/14] sched/core: uclamp: add system default clamps
Message-ID: <20180820122728.GM2960@e110439-lin>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-13-patrick.bellasi@arm.com>
 <2816b340-ca91-4d09-1610-df05a9893da2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2816b340-ca91-4d09-1610-df05a9893da2@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-Aug 12:18, Dietmar Eggemann wrote:
> On 08/06/2018 06:39 PM, Patrick Bellasi wrote:
> >Clamp values cannot be tuned at the root cgroup level. Moreover, because
> >of the delegation model requirements and how the parent clamps
> >propagation works, if we want to enable subgroups to set a non null
> >util.min, we need to be able to configure the root group util.min to the
> >allow the maximum utilization (SCHED_CAPACITY_SCALE = 1024).
> 
> Why 1024 (100)? Would any non 0 value work here?

Something less then 100% will clamp subgroups util.min to that value.
If we want to allow the full span to subgroups, the root group should
not enforce boundaries... hence util.min should be set to 100%.

> [...]
> 
> >@@ -1269,6 +1296,75 @@ static inline void uclamp_group_get(struct task_struct *p,
> >  	uclamp_group_put(clamp_id, prev_group_id);
> >  }
> >+int sched_uclamp_handler(struct ctl_table *table, int write,
> >+			 void __user *buffer, size_t *lenp,
> >+			 loff_t *ppos)
> >+{
> >+	int group_id[UCLAMP_CNT] = { UCLAMP_NOT_VALID };
> >+	struct uclamp_se *uc_se;
> >+	int old_min, old_max;
> >+	int result;
> >+
> >+	mutex_lock(&uclamp_mutex);
> >+
> >+	old_min = sysctl_sched_uclamp_util_min;
> >+	old_max = sysctl_sched_uclamp_util_max;
> >+
> >+	result = proc_dointvec(table, write, buffer, lenp, ppos);
> >+	if (result)
> >+		goto undo;
> >+	if (!write)
> >+		goto done;
> >+
> >+	if (sysctl_sched_uclamp_util_min > sysctl_sched_uclamp_util_max)
> >+		goto undo;
> >+	if (sysctl_sched_uclamp_util_max > 1024)
> >+		goto undo;
> >+
> >+	/* Find a valid group_id for each required clamp value */
> >+	if (old_min != sysctl_sched_uclamp_util_min) {
> >+		result = uclamp_group_find(UCLAMP_MIN, sysctl_sched_uclamp_util_min);
> >+		if (result == -ENOSPC) {
> >+			pr_err("Cannot allocate more than %d UTIL_MIN clamp groups\n",
> >+			       CONFIG_UCLAMP_GROUPS_COUNT);
> >+			goto undo;
> >+		}
> >+		group_id[UCLAMP_MIN] = result;
> >+	}
> >+	if (old_max != sysctl_sched_uclamp_util_max) {
> >+		result = uclamp_group_find(UCLAMP_MAX, sysctl_sched_uclamp_util_max);
> >+		if (result == -ENOSPC) {
> >+			pr_err("Cannot allocate more than %d UTIL_MAX clamp groups\n",
> >+			       CONFIG_UCLAMP_GROUPS_COUNT);
> >+			goto undo;
> >+		}
> >+		group_id[UCLAMP_MAX] = result;
> >+	}
> >+
> >+	/* Update each required clamp group */
> >+	if (old_min != sysctl_sched_uclamp_util_min) {
> >+		uc_se = &uclamp_default[UCLAMP_MIN];
> >+		uclamp_group_get(NULL, UCLAMP_MIN, group_id[UCLAMP_MIN],
> >+				 uc_se, sysctl_sched_uclamp_util_min);
> >+	}
> >+	if (old_max != sysctl_sched_uclamp_util_max) {
> >+		uc_se = &uclamp_default[UCLAMP_MAX];
> >+		uclamp_group_get(NULL, UCLAMP_MAX, group_id[UCLAMP_MAX],
> >+				 uc_se, sysctl_sched_uclamp_util_max);
> >+	}
> >+
> >+	if (result) {
> >+undo:
> >+		sysctl_sched_uclamp_util_min = old_min;
> >+		sysctl_sched_uclamp_util_max = old_max;
> >+	}
> 
> This looks strange! In case uclamp_group_find() returns free_group_id
> instead of -ENOSPC, the sysctl min/max values are reset?
> 
> I was under the assumption that I could specify:
> 
> sysctl_sched_uclamp_util_min = 40 (for boosting)
> sysctl_sched_uclamp_util_max = 80 (for clamping)
> 
> with an empty cpu controller hierarchy and then those values become the
> .effective values of (a first level) task group?

You right, I forgot to reset result=0 once we passed the two
uclamp_group_find() calls. Will fix in v4.

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
