Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752911AbeDJM1M (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:27:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:41649 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752584AbeDJM1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:27:11 -0400
Date: Tue, 10 Apr 2018 14:27:06 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] ringbuffer: Don't choose the process with adj equal
 OOM_SCORE_ADJ_MIN
Message-ID: <20180410122706.GH21835@dhcp22.suse.cz>
References: <20180410061447.GQ21835@dhcp22.suse.cz>
 <CAGWkznGrugH0VqJyd5ZPiSBMOZ4SbbNpKiHVXM27Q-ep4SYb-Q@mail.gmail.com>
 <20180410074921.GU21835@dhcp22.suse.cz>
 <CAGWkznHQSZ5jPF2njOp0BritTmKiGOToq5bAz1bhzzmFi_01nA@mail.gmail.com>
 <20180410081231.GV21835@dhcp22.suse.cz>
 <CAGWkznEM=AX=3LWDmgyz4GRkWy81TNdFQQXZ7+W4=Ek4ZsnsJw@mail.gmail.com>
 <20180410090128.GY21835@dhcp22.suse.cz>
 <CAGWkznEf0siz1-RFSJwuKCjUtbKM=P1djo2Nc7sU1GS0AgWv2w@mail.gmail.com>
 <20180410104902.GC21835@dhcp22.suse.cz>
 <20180410082316.263d34ec@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410082316.263d34ec@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-04-18 08:23:16, Steven Rostedt wrote:
> On Tue, 10 Apr 2018 12:49:02 +0200
> Michal Hocko <mhocko@kernel.org> wrote:
> 
> > But you do realize that what you are proposing is by no means any safer,
> > don't you? The memory allocated for the ring buffer is _not_ accounted
> > to any process and as such it is not considered by the oom killer when
> > picking up an oom victim so you are quite likely to pick up an innocent
> > process to be killed. So basically you are risking an allocation runaway
> > completely hidden from the OOM killer. Now, the downside of the patch is
> > that the OOM_SCORE_ADJ_MIN task might get killed which is something that
> > shouldn't happen because it is a contract. I would call this an
> > unsolvable problem and a inherent broken design of the oom disabled
> > task. So far I haven't heard a single _argument_ why supporting such a
> > weird cornercase is desirable when your application can trivial do
> > 
> > fork(); set_oom_score_adj(); exec("echo $VAR > $RINGBUFFER_FILE")
> 
> We could do this as a compromise:
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index c9cb9767d49b..40c2e0a56c51 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -1185,6 +1185,12 @@ static int __rb_allocate_pages(long nr_pages, struct list_head *pages, int cpu)
>  	 */
>  	mflags = GFP_KERNEL | __GFP_RETRY_MAYFAIL;
>  
> +	/* If we can't OOM this task, then only allocate without reclaim */
> +	if (unlikely(current->signal->oom_score_adj == OOM_SCORE_ADJ_MIN)) {
> +		mflags = GFP_KERNEL | __GFP_NORETRY;
> +		user_thread = false; /* do not set oom_origin */
> +	}
> +
>  	/*
>  	 * If a user thread allocates too much, and si_mem_available()
>  	 * reports there's enough memory, even though there is not.
> 
> This way, if one sets OOM_SCORE_ADJ_MIN, then we wont set oom_origin
> for the task, but we also wont try hard to allocate memory if there is
> nothing immediately available.

I would rather that the code outside of MM not touch implementation
details like OOM_SCORE_ADJ_MIN. It is really hard to get rid of abusers
whenever you try to change something in MM then. Especially when the
usecase is quite dubious.
-- 
Michal Hocko
SUSE Labs
