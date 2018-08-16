Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEEFC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F302148C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eI41sope";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mJ9pY54H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F302148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390300AbeHPMGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 08:06:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53822 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731148AbeHPMGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 08:06:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 20DA76219F; Thu, 16 Aug 2018 09:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534410556;
        bh=D6+ZfYVj5z4ke9Sfkn/YqsovGpH9r6jzVIBRXq5WsrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eI41sopeVGMb7gbn3NdJ6kwwyaNDa43haVYMpNkSv5ijYFt9d2zJgelSBQVTaUBqA
         ZAPGhGB2ALKCxO25fbGf9hbjyQAU7yiAvV1uQDT3V9zQ6NVyr5TJBbrGqwkxzR7F18
         HZFximya4RtXvf+x0oBqE+9ugKu3SfU7zs08/qCs=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D5B3E62159;
        Thu, 16 Aug 2018 09:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534410554;
        bh=D6+ZfYVj5z4ke9Sfkn/YqsovGpH9r6jzVIBRXq5WsrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mJ9pY54H0A0x5D0Dj7h1UfYTkxt1VRUtC32ejqXxecZazEXOi9vkcDA4wgKUgHfN0
         r1/qkHENwBRDNNGHFJAHE9YKt+WhwLYSSi9vVqdAvdJGW5pm3NF1JfpODFZjyfqvXT
         5e0nShSfJDnH82t7f8QOp19KCr5LJC8C7orQaNzE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D5B3E62159
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Thu, 16 Aug 2018 14:39:06 +0530
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
Subject: Re: [PATCH v3 09/14] sched/core: uclamp: propagate parent clamps
Message-ID: <20180816090906.GC2661@codeaurora.org>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-10-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806163946.28380-10-patrick.bellasi@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 05:39:41PM +0100, Patrick Bellasi wrote:
> In order to properly support hierarchical resources control, the cgroup
> delegation model requires that attribute writes from a child group never
> fail but still are (potentially) constrained based on parent's assigned
> resources. This requires to properly propagate and aggregate parent
> attributes down to its descendants.
> 
> Let's implement this mechanism by adding a new "effective" clamp value
> for each task group. The effective clamp value is defined as the smaller
> value between the clamp value of a group and the effective clamp value
> of its parent. This represent also the clamp value which is actually
> used to clamp tasks in each task group.
> 
> Since it can be interesting for tasks in a cgroup to know exactly what
> is the currently propagated/enforced configuration, the effective clamp
> values are exposed to user-space by means of a new pair of read-only
> attributes: cpu.util.{min,max}.effective.
> 
> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
>  

<snip>

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 8f48e64fb8a6..3fac2d098084 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -589,6 +589,11 @@ struct uclamp_se {
>  	unsigned int value;
>  	/* Utilization clamp group for this constraint */
>  	unsigned int group_id;
> +	/* Effective clamp  for tasks in this group */
> +	struct {
> +		unsigned int value;
> +		unsigned int group_id;
> +	} effective;
>  };

Are these needed when CONFIG_UCLAMP_TASK_GROUP is disabled?

>  
>  union rcu_special {
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2ba55a4afffb..f692df3787bd 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1237,6 +1237,8 @@ static inline void init_uclamp_sched_group(void)
>  		uc_se = &root_task_group.uclamp[clamp_id];
>  		uc_se->value = uclamp_none(clamp_id);
>  		uc_se->group_id = group_id;
> +		uc_se->effective.value = uclamp_none(clamp_id);
> +		uc_se->effective.group_id = group_id;
>  
>  		/* Attach root TG's clamp group */
>  		uc_map[group_id].se_count = 1;
>  

<snip>

> @@ -7622,11 +7687,19 @@ static struct cftype cpu_legacy_files[] = {
>  		.read_u64 = cpu_util_min_read_u64,
>  		.write_u64 = cpu_util_min_write_u64,
>  	},
> +	{
> +		.name = "util.min.effective",
> +		.read_u64 = cpu_util_min_effective_read_u64,
> +	},
>  	{
>  		.name = "util.max",
>  		.read_u64 = cpu_util_max_read_u64,
>  		.write_u64 = cpu_util_max_write_u64,
>  	},
> +	{
> +		.name = "util.max.effective",
> +		.read_u64 = cpu_util_max_effective_read_u64,
> +	},
>  #endif
>  	{ }	/* Terminate */
>  };

Is there any reason why these are not added for the default hierarchy?

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

