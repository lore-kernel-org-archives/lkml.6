Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E223CECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9737C20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lmjgDtGg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9737C20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390493AbeGTNe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:34:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40442 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389388AbeGTNe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A2fuy2d8TuT+/DT9WP3SrgZwq+pMXz5gjfUr3o1USGM=; b=lmjgDtGgclFnsi9EIr1SbBOgn
        gdawULZyv+hW50kPA4iyPSdwYbgHHEskChNe8mrD0GwVvFCQQcHUqeS3N3qMUM0P+8xtCFGe7tQwk
        vK4LzxRC6GbSyiTVM5YWS9jf4sJxfL15LXJBc7OyALzhliCmgWKKKPWdImRjM+4uWxMSaP751hPeR
        SA0tQTmuE7RwbuM0nPO0Y35WqzDhX9USnbOW2n2MwDgb+zfk/S5ww5QseLo+g1PPUbRKTpTJ6OAWm
        UJB/l1iQiM5EBgRxowld+OYgFch/2beqws2yjHDoizClexvVhAENMrnX3Ujgt8XlscUxR9CZWQisC
        TLNLsfQ4Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fgUnZ-0005W0-HI; Fri, 20 Jul 2018 12:46:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C880220275F36; Fri, 20 Jul 2018 14:46:15 +0200 (CEST)
Date:   Fri, 20 Jul 2018 14:46:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH V3] sched/deadline: Update rq_clock of later_rq when
 pushing a task
Message-ID: <20180720124615.GM2476@hirez.programming.kicks-ass.net>
References: <ca31d073a4788acf0684a8b255f14fea775ccf20.1532077269.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca31d073a4788acf0684a8b255f14fea775ccf20.1532077269.git.bristot@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 11:16:30AM +0200, Daniel Bristot de Oliveira wrote:
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index fbfc3f1d368a..8b50eea4b607 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2090,8 +2090,14 @@ static int push_dl_task(struct rq *rq)
>  	sub_rq_bw(&next_task->dl, &rq->dl);
>  	set_task_cpu(next_task, later_rq->cpu);
>  	add_rq_bw(&next_task->dl, &later_rq->dl);
> +
> +	/*
> +	 * Update the later_rq clock here, because the clock is used
> +	 * by the cpufreq_update_util() inside __add_running_bw().
> +	 */
> +	update_rq_clock(later_rq);
>  	add_running_bw(&next_task->dl, &later_rq->dl);
> -	activate_task(later_rq, next_task, 0);
> +	activate_task(later_rq, next_task, ENQUEUE_NOCLOCK);
>  	ret = 1;
>  
>  	resched_curr(later_rq);

Why isn't push_rt_task() affected by the very same issue?
