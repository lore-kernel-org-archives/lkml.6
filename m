Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933173AbeDXMrW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:47:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60726 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933161AbeDXMrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:47:17 -0400
Date: Tue, 24 Apr 2018 14:47:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: subhra mazumdar <subhra.mazumdar@oracle.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com,
        daniel.lezcano@linaro.org, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com
Subject: Re: [PATCH 2/3] sched: introduce per-cpu var next_cpu to track
 search limit
Message-ID: <20180424124712.GR4082@hirez.programming.kicks-ass.net>
References: <20180424004116.28151-1-subhra.mazumdar@oracle.com>
 <20180424004116.28151-3-subhra.mazumdar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424004116.28151-3-subhra.mazumdar@oracle.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 05:41:15PM -0700, subhra mazumdar wrote:
> @@ -17,6 +17,7 @@
>  #include <trace/events/sched.h>
>  
>  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> +DEFINE_PER_CPU_SHARED_ALIGNED(int, next_cpu);
>  
>  #if defined(CONFIG_SCHED_DEBUG) && defined(HAVE_JUMP_LABEL)
>  /*
> @@ -6018,6 +6019,7 @@ void __init sched_init(void)
>  		struct rq *rq;
>  
>  		rq = cpu_rq(i);
> +		per_cpu(next_cpu, i) = -1;

If you leave it uninitialized it'll be 0, and we can avoid that extra
branch in the next patch, no?
