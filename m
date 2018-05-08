Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753512AbeEHAPV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 20:15:21 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55458 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752954AbeEHAPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 20:15:20 -0400
Subject: Re: [RFC] sched: Distinguish between idle_cpu calls based on desired
 effect
To: Rohit Jain <rohit.k.jain@oracle.com>, matt@codeblueprint.co.uk,
        peterz@infradead.org
Cc: mingo@kernel.org, dhaval.giani@oracle.com, subhra.mazumdar@oracle.com,
        steven.sistare@oracle.com, linux-kernel@vger.kernel.org
References: <1525736477-8184-1-git-send-email-rohit.k.jain@oracle.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <366af1f5-9837-8a0c-3550-1a3d9a8e9de9@infradead.org>
Date: Mon, 7 May 2018 17:15:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525736477-8184-1-git-send-email-rohit.k.jain@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2018 04:41 PM, Rohit Jain wrote:
> In commit 247f2f6f3c706b40b5f3886646f3eb53671258bf we distinguish
> between idle_cpu when the vcpu is not running for scheduling threads.
> However, idle_cpu function is used at other places for actually checking
> whether the state of the CPU is idle or not. Hence splitting the use of
> that function based on the desired return value.
> 
> Signed-off-by: Rohit Jain <rohit.k.jain@oracle.com>
> ---
>  include/linux/sched.h |  1 +
>  kernel/sched/core.c   | 14 ++++++++++++++
>  kernel/sched/fair.c   | 20 ++++++++++----------
>  3 files changed, 25 insertions(+), 10 deletions(-)
> 

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 71bdb86..171e160 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4028,6 +4028,20 @@ int idle_cpu(int cpu)
>  		return 0;
>  #endif
>  
> +	return 1;
> +}
> +
> +/**
> + * idle_cpu - is a given CPU idle for enqueuing work.

    * available_idle_cpu -

> + * @cpu: the processor in question.
> + *
> + * Return: 1 if the CPU is currently idle. 0 otherwise.
> + */
> +int available_idle_cpu(int cpu)
> +{
> +	if (!idle_cpu(cpu))
> +		return 0;
> +
>  	if (vcpu_is_preempted(cpu))
>  		return 0;
>  


-- 
~Randy
