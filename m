Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E872C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232F9214FF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232F9214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbeHBMn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 08:43:59 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:31538 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbeHBMn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 08:43:59 -0400
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w72ArLLX072539;
        Thu, 2 Aug 2018 19:53:21 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Thu, 02 Aug 2018 19:53:21 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w72ArFBQ072519
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 2 Aug 2018 19:53:21 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2 3/3] mm, oom: introduce memory.oom.group
To:     Roman Gushchin <guro@fb.com>, linux-mm@kvack.org
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
References: <20180802003201.817-1-guro@fb.com>
 <20180802003201.817-4-guro@fb.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <879f1767-8b15-4e83-d9ef-d8df0e8b4d83@i-love.sakura.ne.jp>
Date:   Thu, 2 Aug 2018 19:53:13 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180802003201.817-4-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/08/02 9:32, Roman Gushchin wrote:
> For some workloads an intervention from the OOM killer
> can be painful. Killing a random task can bring
> the workload into an inconsistent state.
> 
> Historically, there are two common solutions for this
> problem:
> 1) enabling panic_on_oom,
> 2) using a userspace daemon to monitor OOMs and kill
>    all outstanding processes.
> 
> Both approaches have their downsides:
> rebooting on each OOM is an obvious waste of capacity,
> and handling all in userspace is tricky and requires
> a userspace agent, which will monitor all cgroups
> for OOMs.

We could start a one-time userspace agent which handles
an cgroup OOM event and then terminates...



> +/**
> + * mem_cgroup_get_oom_group - get a memory cgroup to clean up after OOM
> + * @victim: task to be killed by the OOM killer
> + * @oom_domain: memcg in case of memcg OOM, NULL in case of system-wide OOM
> + *
> + * Returns a pointer to a memory cgroup, which has to be cleaned up
> + * by killing all belonging OOM-killable tasks.
> + *
> + * Caller has to call mem_cgroup_put() on the returned non-NULL memcg.
> + */
> +struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
> +					    struct mem_cgroup *oom_domain)
> +{
> +	struct mem_cgroup *oom_group = NULL;
> +	struct mem_cgroup *memcg;
> +
> +	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> +		return NULL;
> +
> +	if (!oom_domain)
> +		oom_domain = root_mem_cgroup;
> +
> +	rcu_read_lock();
> +
> +	memcg = mem_cgroup_from_task(victim);

Isn't this racy? I guess that memcg of this "victim" can change to
somewhere else from the one as of determining the final candidate.
This "victim" might have already passed exit_mm()/cgroup_exit() from do_exit().
This "victim" might be moving to a memcg which is different from the one
determining the final candidate.

> +	if (memcg == root_mem_cgroup)
> +		goto out;
> +
> +	/*
> +	 * Traverse the memory cgroup hierarchy from the victim task's
> +	 * cgroup up to the OOMing cgroup (or root) to find the
> +	 * highest-level memory cgroup with oom.group set.
> +	 */
> +	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
> +		if (memcg->oom_group)
> +			oom_group = memcg;
> +
> +		if (memcg == oom_domain)
> +			break;
> +	}
> +
> +	if (oom_group)
> +		css_get(&oom_group->css);
> +out:
> +	rcu_read_unlock();
> +
> +	return oom_group;
> +}



> @@ -974,7 +988,23 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
>  	}
>  	read_unlock(&tasklist_lock);
>  
> +	/*
> +	 * Do we need to kill the entire memory cgroup?
> +	 * Or even one of the ancestor memory cgroups?
> +	 * Check this out before killing the victim task.
> +	 */
> +	oom_group = mem_cgroup_get_oom_group(victim, oc->memcg);
> +
>  	__oom_kill_process(victim);
> +
> +	/*
> +	 * If necessary, kill all tasks in the selected memory cgroup.
> +	 */
> +	if (oom_group) {

Isn't "killing a child process of the biggest memory hog" and "killing all
processes which belongs to a memcg which the child process of the biggest
memory hog belongs to" strange? The intent of selecting a child is to try
to minimize lost work while the intent of oom_cgroup is to try to discard
all work. If oom_cgroup is enabled, I feel that we should

  pr_err("%s: Kill all processes in ", message);
  pr_cont_cgroup_path(memcg->css.cgroup);
  pr_cont(" due to memory.oom.group set\n");

without

  pr_err("%s: Kill process %d (%s) score %u or sacrifice child\n", message, task_pid_nr(p), p->comm, points);

(I mean, don't try to select a child).

> +		mem_cgroup_print_oom_group(oom_group);
> +		mem_cgroup_scan_tasks(oom_group, oom_kill_memcg_member, NULL);
> +		mem_cgroup_put(oom_group);
> +	}
>  }
>  
>  /*

