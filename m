Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756431AbeDYTtZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 15:49:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36934 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbeDYTtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 15:49:23 -0400
Date: Wed, 25 Apr 2018 21:49:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Juri Lelli <juri.lelli@gmail.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/rt: Rework for_each_process_thread() iterations
 in tg_has_rt_tasks()
Message-ID: <20180425194915.GH4064@hirez.programming.kicks-ass.net>
References: <152415882713.2054.8734093066910722403.stgit@localhost.localdomain>
 <20180420092540.GG24599@localhost.localdomain>
 <0d7fbdab-b972-7f86-4090-b49f9315c868@virtuozzo.com>
 <854a5fb1-a9c1-023f-55ec-17fa14ad07d5@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <854a5fb1-a9c1-023f-55ec-17fa14ad07d5@virtuozzo.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 01:06:31PM +0300, Kirill Tkhai wrote:
> @@ -2406,12 +2407,15 @@ static inline int tg_has_rt_tasks(struct task_group *tg)
>  	if (task_group_is_autogroup(tg))
>  		return 0;
>  
> -	for_each_process_thread(g, p) {
> -		if (rt_task(p) && task_group(p) == tg)
> -			return 1;
> -	}
> +	css_task_iter_start(&tg->css, 0, &it);
> +	while ((task = css_task_iter_next(&it)))
> +		if (rt_task(task)) {
> +			ret = 1;
> +			break;
> +		}

Aside from the missing {} there, the patch looks OK I suppose.

The races found seems somewhat dodgy, but like you argue, they're not in
fact new :/


> +	css_task_iter_end(&it);
>  
> -	return 0;
> +	return ret;
>  }
>  
