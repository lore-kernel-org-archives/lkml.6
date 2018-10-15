Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F42C7112A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A738F2064E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TcZyAkll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A738F2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeJORFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 13:05:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46528 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeJORFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 13:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lHyV6tM6w23MBxqLQo8ahT5lSUhfoK38X/VXPayNnYg=; b=TcZyAkll1IXkFBjXKfV5xwmvB
        zxCkjvQFdRmXMymmZpscROgK4E5kkBj95aYR/6oFSVu/gXuUYJTKsvWJBd4+w4jg1sOrNrLg1/X1Q
        O9dtapI2Kg6nLh1nJjEsenX1GJ+5oge/un0KjbFaud7rZJZqnu3ID5SOpsro1LKc4n8ikujSYW0rA
        ffau4IgXkWdFeUg1KFOefR0fV4fpGAcPu9+i+wZrE9shgw4Mqf+x2xs5p+FcsFkOGsz5QgoZUjIGj
        sZuaAIS4YS8HgN3jEf3OtqVZ8L+jOqNvzK0TVnSg9bNcpvuWxIZ7ZfxdiuLjG85virbZQPeg/1+XD
        grLfDP2ww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBz3C-0000yb-LT; Mon, 15 Oct 2018 09:20:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C637820158F7C; Mon, 15 Oct 2018 11:20:32 +0200 (CEST)
Date:   Mon, 15 Oct 2018 11:20:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     mingo@redhat.com, rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched/rt : return accurate release rq lock info
Message-ID: <20181015092032.GO9867@hirez.programming.kicks-ass.net>
References: <1538778131-44406-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538778131-44406-1-git-send-email-peng.hao2@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 06, 2018 at 06:22:11AM +0800, Peng Hao wrote:
> find_lock_lowest_rq may or not releease rq lock when return
> lowest_rq=NULL, but it is fuzzy.
> If not releasing rq lock, it is unnecessary to re-call
> pick_next_pushable_task.
> When CONFIG_PREEMPT=n, not releasing rq lock and return
> lowest_rq=null frequently happens in a simple test case:
> Four different rt priority tasks run on limited two cpus.
> Thanks for Steven Rostedt's advice.

Can we please write a more coherent Changelog, the above is very hard to
read.

Maybe something along the lines of:

Subject: sched/rt: Reduce push_rt_task() retries

Improve push_rt_task() by propagating the double_lock_balance() usage
from find_lock_lowest_rq(), thereby reducing the number of cases where
we have to assume rq->lock was dropped.


> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  kernel/sched/rt.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 2e2955a..be0fc43 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1754,7 +1754,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>  				     !task_on_rq_queued(task))) {
>  
>  				double_unlock_balance(rq, lowest_rq);
> -				lowest_rq = NULL;
> +				lowest_rq = RETRY_TASK;
>  				break;
>  			}
>  		}

I'm confused.. should not:

		/* try again */
		double_unlock_balance(rq, lowest_rq);
		lowest_rq = NULL;

also return RETRY_TASK? That also is in the double_lock_balance() path
and will this have had rq->lock() released.
