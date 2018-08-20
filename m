Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB8FC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D76B21534
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D76B21534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeHTNdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 09:33:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35626 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbeHTNdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 09:33:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4885480D;
        Mon, 20 Aug 2018 03:18:45 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.emea.arm.com [10.4.12.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEB3D3F2EA;
        Mon, 20 Aug 2018 03:18:41 -0700 (PDT)
Subject: Re: [PATCH v3 12/14] sched/core: uclamp: add system default clamps
To:     Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
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
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-13-patrick.bellasi@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <2816b340-ca91-4d09-1610-df05a9893da2@arm.com>
Date:   Mon, 20 Aug 2018 12:18:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180806163946.28380-13-patrick.bellasi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2018 06:39 PM, Patrick Bellasi wrote:
> Clamp values cannot be tuned at the root cgroup level. Moreover, because
> of the delegation model requirements and how the parent clamps
> propagation works, if we want to enable subgroups to set a non null
> util.min, we need to be able to configure the root group util.min to the
> allow the maximum utilization (SCHED_CAPACITY_SCALE = 1024).

Why 1024 (100)? Would any non 0 value work here?

[...]

> @@ -1269,6 +1296,75 @@ static inline void uclamp_group_get(struct task_struct *p,
>   	uclamp_group_put(clamp_id, prev_group_id);
>   }
>   
> +int sched_uclamp_handler(struct ctl_table *table, int write,
> +			 void __user *buffer, size_t *lenp,
> +			 loff_t *ppos)
> +{
> +	int group_id[UCLAMP_CNT] = { UCLAMP_NOT_VALID };
> +	struct uclamp_se *uc_se;
> +	int old_min, old_max;
> +	int result;
> +
> +	mutex_lock(&uclamp_mutex);
> +
> +	old_min = sysctl_sched_uclamp_util_min;
> +	old_max = sysctl_sched_uclamp_util_max;
> +
> +	result = proc_dointvec(table, write, buffer, lenp, ppos);
> +	if (result)
> +		goto undo;
> +	if (!write)
> +		goto done;
> +
> +	if (sysctl_sched_uclamp_util_min > sysctl_sched_uclamp_util_max)
> +		goto undo;
> +	if (sysctl_sched_uclamp_util_max > 1024)
> +		goto undo;
> +
> +	/* Find a valid group_id for each required clamp value */
> +	if (old_min != sysctl_sched_uclamp_util_min) {
> +		result = uclamp_group_find(UCLAMP_MIN, sysctl_sched_uclamp_util_min);
> +		if (result == -ENOSPC) {
> +			pr_err("Cannot allocate more than %d UTIL_MIN clamp groups\n",
> +			       CONFIG_UCLAMP_GROUPS_COUNT);
> +			goto undo;
> +		}
> +		group_id[UCLAMP_MIN] = result;
> +	}
> +	if (old_max != sysctl_sched_uclamp_util_max) {
> +		result = uclamp_group_find(UCLAMP_MAX, sysctl_sched_uclamp_util_max);
> +		if (result == -ENOSPC) {
> +			pr_err("Cannot allocate more than %d UTIL_MAX clamp groups\n",
> +			       CONFIG_UCLAMP_GROUPS_COUNT);
> +			goto undo;
> +		}
> +		group_id[UCLAMP_MAX] = result;
> +	}
> +
> +	/* Update each required clamp group */
> +	if (old_min != sysctl_sched_uclamp_util_min) {
> +		uc_se = &uclamp_default[UCLAMP_MIN];
> +		uclamp_group_get(NULL, UCLAMP_MIN, group_id[UCLAMP_MIN],
> +				 uc_se, sysctl_sched_uclamp_util_min);
> +	}
> +	if (old_max != sysctl_sched_uclamp_util_max) {
> +		uc_se = &uclamp_default[UCLAMP_MAX];
> +		uclamp_group_get(NULL, UCLAMP_MAX, group_id[UCLAMP_MAX],
> +				 uc_se, sysctl_sched_uclamp_util_max);
> +	}
> +
> +	if (result) {
> +undo:
> +		sysctl_sched_uclamp_util_min = old_min;
> +		sysctl_sched_uclamp_util_max = old_max;
> +	}

This looks strange! In case uclamp_group_find() returns free_group_id 
instead of -ENOSPC, the sysctl min/max values are reset?

I was under the assumption that I could specify:

sysctl_sched_uclamp_util_min = 40 (for boosting)
sysctl_sched_uclamp_util_max = 80 (for clamping)

with an empty cpu controller hierarchy and then those values become the 
.effective values of (a first level) task group?

[...]
