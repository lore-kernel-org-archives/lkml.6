Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B44C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 599CC20882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n0TsWF/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 599CC20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbeINAXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 20:23:19 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33740 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbeINAXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 20:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=16p4hRpGa2bIicIpj23kA3cO8z3ANLIBH+tTb51RoE4=; b=n0TsWF/6i94Czn2801hcG6BSS
        wWbL1nhbh4KPHom09reeRGJSFULBovISi9wOFwV74BQj9Kzo8TRn9SRWNDZNLh5rzlyRYI6naSWWN
        GcPGGMqOfTF72m8tWWbgZ1H2IVbMnZdjhq9e0sDolFBzTo74pVxc0F8D2vLRoKSTMi8vpYoJW3n+A
        B8KwzrjATOIO/T/RZ+Qx0dys1LDDc66Ej+wyEA46YGSSJ+5AtNWFTEt/qaL7Tqt2/RmqZ0aRaSzi+
        I7Rftiwbh7xC9INAZNVWLQaUJSMt0KxQv3h8qbmrJZeoaddWhDPhblCFXGEMv+ejWY6WXe0hPI3Zd
        UeBzq9+gw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0X2A-0004vd-L5; Thu, 13 Sep 2018 19:12:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 23B24202C1A34; Thu, 13 Sep 2018 21:12:09 +0200 (CEST)
Date:   Thu, 13 Sep 2018 21:12:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 03/16] sched/core: uclamp: add CPU's clamp groups
 accounting
Message-ID: <20180913191209.GY24082@hirez.programming.kicks-ass.net>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-4-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828135324.21976-4-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 02:53:11PM +0100, Patrick Bellasi wrote:
> +static inline void uclamp_cpu_get_id(struct task_struct *p,
> +				     struct rq *rq, int clamp_id)
> +{
> +	struct uclamp_group *uc_grp;
> +	struct uclamp_cpu *uc_cpu;
> +	int clamp_value;
> +	int group_id;
> +
> +	/* Every task must reference a clamp group */
> +	group_id = p->uclamp[clamp_id].group_id;

> +}
> +
> +static inline void uclamp_cpu_put_id(struct task_struct *p,
> +				     struct rq *rq, int clamp_id)
> +{
> +	struct uclamp_group *uc_grp;
> +	struct uclamp_cpu *uc_cpu;
> +	unsigned int clamp_value;
> +	int group_id;
> +
> +	/* New tasks don't have a previous clamp group */
> +	group_id = p->uclamp[clamp_id].group_id;
> +	if (group_id == UCLAMP_NOT_VALID)
> +		return;

*confused*, so on enqueue they must have a group_id, but then on dequeue
they might no longer have?

> +}

> @@ -1110,6 +1313,7 @@ static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
>  	if (!(flags & ENQUEUE_RESTORE))
>  		sched_info_queued(rq, p);
>  
> +	uclamp_cpu_get(rq, p);
>  	p->sched_class->enqueue_task(rq, p, flags);
>  }
>  
> @@ -1121,6 +1325,7 @@ static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
>  	if (!(flags & DEQUEUE_SAVE))
>  		sched_info_dequeued(rq, p);
>  
> +	uclamp_cpu_put(rq, p);
>  	p->sched_class->dequeue_task(rq, p, flags);
>  }

The ordering, is that right? We get while the task isn't enqueued yet,
which would suggest we put when the task is dequeued.
