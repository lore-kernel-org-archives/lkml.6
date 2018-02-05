Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752719AbeBEK5S (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 05:57:18 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54680 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751705AbeBEK5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 05:57:13 -0500
X-Google-Smtp-Source: AH8x226cKfGvXUYVWetyVgrFU55ovz5hqobcfJ/IB9nfcpigLig/CVu8ZTzpeKPMB7ICUhNaNaY5rg==
Date: Mon, 5 Feb 2018 11:57:08 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Wen Yang <wen.yang99@zte.com.cn>
Cc: mingo@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
        jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn
Subject: Re: [PATCH] sched/rt: Make update_curr_rt() more accurate
Message-ID: <20180205105708.upjcsok3zbk5zxlk@gmail.com>
References: <1517800721-42092-1-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517800721-42092-1-git-send-email-wen.yang99@zte.com.cn>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Wen Yang <wen.yang99@zte.com.cn> wrote:

> rq->clock_task may be updated between the two calls of 
> rq_clock_task() in update_curr_rt(). Calling rq_clock_task() only
> once makes it more accurate and efficient, taking update_curr() as
> reference.
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
> ---
>  kernel/sched/rt.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 4056c19..d6d2a65 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -950,12 +950,13 @@ static void update_curr_rt(struct rq *rq)
>  {
>  	struct task_struct *curr = rq->curr;
>  	struct sched_rt_entity *rt_se = &curr->rt;
> +	u64 now = rq_clock_task(rq);
>  	u64 delta_exec;
>  
>  	if (curr->sched_class != &rt_sched_class)
>  		return;
>  
> -	delta_exec = rq_clock_task(rq) - curr->se.exec_start;
> +	delta_exec = now - curr->se.exec_start;

Small nit: shouldn't we calculate 'now' after the return?

OTOH that 'return' should only be triggered statistically AFAICS, i.e. very 
rarely.

Thanks,

	Ingo
