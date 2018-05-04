Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751775AbeEDJrV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 05:47:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37550 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbeEDJrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 05:47:20 -0400
Date: Fri, 4 May 2018 11:47:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Rohit Jain <rohit.k.jain@oracle.com>
Cc: matt@codeblueprint.co.uk, mingo@kernel.org, dhaval.giani@oracle.com,
        subhra.mazumdar@oracle.com, steven.sistare@oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] sched/core: Don't schedule threads on pre-empted vcpus
Message-ID: <20180504094716.GL12217@hirez.programming.kicks-ass.net>
References: <1525294330-7759-1-git-send-email-rohit.k.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525294330-7759-1-git-send-email-rohit.k.jain@oracle.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 01:52:10PM -0700, Rohit Jain wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5e10aae..75d1ecf 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4033,6 +4033,9 @@ int idle_cpu(int cpu)
>  		return 0;
>  #endif
>  
> +	if (vcpu_is_preempted(cpu))
> +		return 0;
> +
>  	return 1;
>  }

Basically OK with this, but did you consider idle_cpu() usage outside of
select_idle_sibling()?

For instance, I think got_nohz_idle_kick() isn't quite right with this
on. Similarly for scheduler_tick(), that wants the actual idle state.
