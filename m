Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967258AbeBNKgq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:36:46 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37682 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967159AbeBNKgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:36:43 -0500
X-Google-Smtp-Source: AH8x2255vGfuqDyD8pWbqzhZj6C2+ltd9PUph9g58/4hE3eb1uoXPBWZrk7CJ79MvPJG8evKSNhE7Q==
Date: Wed, 14 Feb 2018 11:36:39 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: peterz@infradead.org, lizefan@huawei.com, mingo@redhat.com,
        rostedt@goodmis.org, claudio@evidence.eu.com, bristot@redhat.com,
        tommaso.cucinotta@santannapisa.it, luca.abeni@santannapisa.it,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 04/10] sched/core: Prevent race condition between
 cpuset and __sched_setscheduler()
Message-ID: <20180214103639.GR12979@localhost.localdomain>
References: <1518553967-20656-1-git-send-email-mathieu.poirier@linaro.org>
 <1518553967-20656-5-git-send-email-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518553967-20656-5-git-send-email-mathieu.poirier@linaro.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 13/02/18 13:32, Mathieu Poirier wrote:
> No synchronisation mechanism exist between the cpuset subsystem and calls
> to function __sched_setscheduler().  As such it is possible that new root
> domains are created on the cpuset side while a deadline acceptance test
> is carried out in __sched_setscheduler(), leading to a potential oversell
> of CPU bandwidth.
> 
> By making available the cpuset_mutex to the core scheduler it is possible
> to prevent situations such as the one described above from happening.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---

[...]

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f727c3d0064c..0d8badcf1f0f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4176,6 +4176,13 @@ static int __sched_setscheduler(struct task_struct *p,
>  	}
>  
>  	/*
> +	 * Make sure we don't race with the cpuset subsystem where root
> +	 * domains can be rebuilt or modified while operations like DL
> +	 * admission checks are carried out.
> +	 */
> +	cpuset_lock();
> +
> +	/*

Mmm, I'm afraid we can't do this. __sched_setscheduler might be called
from interrupt contex by normalize_rt_tasks().

Best,

- Juri
