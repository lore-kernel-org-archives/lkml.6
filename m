Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5752C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C712089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfAGVAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:00:35 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:59607 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfAGVAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 16:00:35 -0500
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x07KxpNT027499;
        Tue, 8 Jan 2019 05:59:51 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Tue, 08 Jan 2019 05:59:51 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x07KxoBJ027495
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 8 Jan 2019 05:59:51 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 2/2] memcg: do not report racy no-eligible OOM tasks
To:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
References: <20190107143802.16847-1-mhocko@kernel.org>
 <20190107143802.16847-3-mhocko@kernel.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <fa8892d1-4a38-dccd-9597-923924aa0a66@i-love.sakura.ne.jp>
Date:   Tue, 8 Jan 2019 05:59:49 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190107143802.16847-3-mhocko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/07 23:38, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> Tetsuo has reported [1] that a single process group memcg might easily
> swamp the log with no-eligible oom victim reports due to race between
> the memcg charge and oom_reaper

This explanation is outdated. I reported that one memcg OOM killer can
kill all processes in that memcg. I expect the changelog to be updated.

> 
> Thread 1		Thread2				oom_reaper
> try_charge		try_charge
> 			  mem_cgroup_out_of_memory
> 			    mutex_lock(oom_lock)
>   mem_cgroup_out_of_memory
>     mutex_lock(oom_lock)
> 			      out_of_memory
> 			        select_bad_process
> 				oom_kill_process(current)
> 				  wake_oom_reaper
> 							  oom_reap_task
> 							  MMF_OOM_SKIP->victim
> 			    mutex_unlock(oom_lock)
>     out_of_memory
>       select_bad_process # no task
> 
> If Thread1 didn't race it would bail out from try_charge and force the
> charge. We can achieve the same by checking tsk_is_oom_victim inside
> the oom_lock and therefore close the race.
> 
> [1] http://lkml.kernel.org/r/bb2074c0-34fe-8c2c-1c7d-db71338f1e7f@i-love.sakura.ne.jp
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/memcontrol.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index af7f18b32389..90eb2e2093e7 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1387,10 +1387,22 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  		.gfp_mask = gfp_mask,
>  		.order = order,
>  	};
> -	bool ret;
> +	bool ret = true;
>  
>  	mutex_lock(&oom_lock);

And because of "[PATCH 1/2] mm, oom: marks all killed tasks as oom
victims", mark_oom_victim() will be called on current thread even if
we used mutex_lock_killable(&oom_lock) here, like you said

  mutex_lock_killable would take care of exiting task already. I would
  then still prefer to check for mark_oom_victim because that is not racy
  with the exit path clearing signals. I can update my patch to use
  _killable lock variant if we are really going with the memcg specific
  fix.

. If current thread is not yet killed by the OOM killer but can terminate
without invoking the OOM killer, using mutex_lock_killable(&oom_lock) here
saves some processes. What is the race you are referring by "racy with the
exit path clearing signals" ?

> +
> +	/*
> +	 * multi-threaded tasks might race with oom_reaper and gain
> +	 * MMF_OOM_SKIP before reaching out_of_memory which can lead
> +	 * to out_of_memory failure if the task is the last one in
> +	 * memcg which would be a false possitive failure reported
> +	 */

Not only out_of_memory() failure. Current thread needlessly tries to
select next OOM victim. out_of_memory() failure is nothing but a result
of no eligible candidate case.

> +	if (tsk_is_oom_victim(current))
> +		goto unlock;
> +
>  	ret = out_of_memory(&oc);
> +
> +unlock:
>  	mutex_unlock(&oom_lock);
>  	return ret;
>  }
> 

