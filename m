Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0114C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C65F2148C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PorcLq9C";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q7cJsDCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C65F2148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390348AbeHPMLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 08:11:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58096 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbeHPMLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 08:11:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 74D02621A4; Thu, 16 Aug 2018 09:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534410838;
        bh=a2RF9pGq3odnEmiDBcmM3HJh/Eu5nlSJA2DNh056jso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PorcLq9CUWGP2AeGRAJD/257SnbaVjq/soFfY5k1nelyJvxTSYrPAe+RobkD+7lc1
         BKxKBq6j8ZNlFPi6gw7DqWYijaYHx4Zvg78fJYKlBplkDZ/LJPFZ20L/7ZtljMAvNx
         MXdViW83T2ffBkU0S+bvOyiBThtU09iBn1QxhBH8=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ADA2861EF9;
        Thu, 16 Aug 2018 09:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534410836;
        bh=a2RF9pGq3odnEmiDBcmM3HJh/Eu5nlSJA2DNh056jso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q7cJsDCKj3qQOmqGAegrH3bn6/dCOJJk9qiloz5+BhQk6IfahRqgu91F5VzJKAzbj
         MxhL1QDr35IUZnL/yM47i+TRwv1PWVKRhqlb23gAL0Pl09z1K6zPDKCjvkjHcx65bW
         ZvXgnxzvjkVY77YQ+K5S/83R0CzN35mTGQwRLvLY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ADA2861EF9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Thu, 16 Aug 2018 14:43:48 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 12/14] sched/core: uclamp: add system default clamps
Message-ID: <20180816091348.GD2661@codeaurora.org>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-13-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806163946.28380-13-patrick.bellasi@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 05:39:44PM +0100, Patrick Bellasi wrote:
> Clamp values cannot be tuned at the root cgroup level. Moreover, because
> of the delegation model requirements and how the parent clamps
> propagation works, if we want to enable subgroups to set a non null
> util.min, we need to be able to configure the root group util.min to the
> allow the maximum utilization (SCHED_CAPACITY_SCALE = 1024).
> 
> Unfortunately this setup will also mean that all tasks running in the
> root group, will always get a maximum util.min clamp, unless they have a
> lower task specific clamp which is definitively not a desirable default
> configuration.
> 
> Let's fix this by explicitly adding a system default configuration
> (sysctl_sched_uclamp_util_{min,max}) which works as a restrictive clamp
> for all tasks running on the root group.
> 
> This interface is available independently from cgroups, thus providing a
> complete solution for system wide utilization clamping configuration.
> 
> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Paul Turner <pjt@google.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Steve Muckle <smuckle@google.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Morten Rasmussen <morten.rasmussen@arm.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org

<snip>

> +/*
> + * Minimum utilization for tasks in the root cgroup
> + * default: 0
> + */
> +unsigned int sysctl_sched_uclamp_util_min;
> +
> +/*
> + * Maximum utilization for tasks in the root cgroup
> + * default: 1024
> + */
> +unsigned int sysctl_sched_uclamp_util_max = 1024;
> +
> +static struct uclamp_se uclamp_default[UCLAMP_CNT];
> +

The default group id for un-clamped root tasks is 0 because of
this declaration, correct?

>  /**
>   * uclamp_map: reference counts a utilization "clamp value"
>   * @value:    the utilization "clamp value" required
> @@ -957,12 +971,25 @@ static inline int uclamp_task_group_id(struct task_struct *p, int clamp_id)
>  	group_id = uc_se->group_id;
>  
>  #ifdef CONFIG_UCLAMP_TASK_GROUP
> +	/*
> +	 * Tasks in the root group, which do not have a task specific clamp
> +	 * value, get the system default calmp value.
> +	 */
> +	if (group_id == UCLAMP_NOT_VALID &&
> +	    task_group(p) == &root_task_group) {
> +		return uclamp_default[clamp_id].group_id;
> +	}
> +
>  	/* Use TG's clamp value to limit task specific values */
>  	uc_se = &task_group(p)->uclamp[clamp_id];
>  	if (group_id == UCLAMP_NOT_VALID ||
>  	    clamp_value > uc_se->effective.value) {
>  		group_id = uc_se->effective.group_id;
>  	}
> +#else
> +	/* By default, all tasks get the system default clamp value */
> +	if (group_id == UCLAMP_NOT_VALID)
> +		return uclamp_default[clamp_id].group_id;
>  #endif
>  
>  	return group_id;
> @@ -1269,6 +1296,75 @@ static inline void uclamp_group_get(struct task_struct *p,
>  	uclamp_group_put(clamp_id, prev_group_id);
>  }
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

uclamp_group_get() also drops the reference on the previous group id.
The initial group id for uclamp_default[] i.e 0 is never claimed by
us. so we end up releasing it. But root group still points to group#0.
is this a problem?

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

