Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72C7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642A32064D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p9BOGgb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642A32064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388107AbeGWJkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:40:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36844 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387869AbeGWJkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Aae0eJ4rAQ/c4ZYMPvwCCAGNoI3zU8R2l0dhohlyaAc=; b=p9BOGgb8pY+GjftD51S/VwqOd
        798v53T8CMw2gGmrjuo9uyHjXbC3v5FWp+AbJArI6b2r+tznxhxKmBeygTb1Eok8E9SN4o9smN0RV
        +sU0B9K+MRVbA+awcPYDBkHMqF31xkroHRkog+PlyCpzpDqE2LYm/P7IzidrkrV5CloItgWB4wlDB
        ViMdbBgee3SLu7MH06bBFZmxxpt4HCcnEzeTJK4hrBJ8+oWkMyGkgOzufi+h1UVvScGwEnz7Zmg3+
        VHpAMg0I5izwY9g6A0wtlDTLmMK1l5JdUexTNZalRSos9xMrC+lzfmPlHoJsRDNUC4mVPZCBBirXB
        qLbHxgbRw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhWOO-0004sT-Hh; Mon, 23 Jul 2018 08:40:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 42A3420275F47; Mon, 23 Jul 2018 10:40:31 +0200 (CEST)
Date:   Mon, 23 Jul 2018 10:40:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chen Lin <chen.lin130@zte.com.cn>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn,
        tan.hu@zte.com.cn.cn, Chen Lin <cheng.lin130@zte.com.cn>,
        Tan Hu <tan.hu@zte.com.cn>
Subject: Re: [PATCH] sched/numa: do not balance tasks onto isolated cpus
Message-ID: <20180723084031.GX2494@hirez.programming.kicks-ass.net>
References: <1532324370-80651-1-git-send-email-chen.lin130@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532324370-80651-1-git-send-email-chen.lin130@zte.com.cn>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 01:39:30PM +0800, Chen Lin wrote:
> From: Chen Lin <cheng.lin130@zte.com.cn>
> 
> NUMA balancing has not taken *isolcpus(isolated cpus)* into 
> consideration. It may migrate tasks onto isolated cpus and the 
> migrated tasks will never escape from the isolated cpus, which will
> break the isolation provided by *isolcpus* boot parameter and 
> intrduce various problems.
> 
> This patch ensure NUMA balancing not to balance tasks onto iaolated
> cpus. 

I'm not sure what kernel you're patching, but cpu_isolated_map doesn't
exist anymore. Also, if it steps on isolated CPUs, this is the wrong fix
anyway. Load-balancing should be constrained to the current root domain.

> Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
> Signed-off-by: Tan Hu <tan.hu@zte.com.cn>
> Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>

This SoB chain is invalid.

> ---
>  kernel/sched/core.c | 9 ++++++---
>  kernel/sched/fair.c | 3 ++-
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index fe365c9..f9ce90c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1302,10 +1302,12 @@ int migrate_swap(struct task_struct *cur, struct task_struct *p)
>  	if (!cpu_active(arg.src_cpu) || !cpu_active(arg.dst_cpu))
>  		goto out;
> 
> -	if (!cpumask_test_cpu(arg.dst_cpu, &arg.src_task->cpus_allowed))
> +	if ((!cpumask_test_cpu(arg.dst_cpu, &arg.src_task->cpus_allowed))
> +            || cpumask_test_cpu(arg.dst_cpu, cpu_isolated_map))
>  		goto out;
> 
> -	if (!cpumask_test_cpu(arg.src_cpu, &arg.dst_task->cpus_allowed))
> +	if ((!cpumask_test_cpu(arg.src_cpu, &arg.dst_task->cpus_allowed))
> +            || cpumask_test_cpu(arg.src_cpu, cpu_isolated_map))
>  		goto out;
> 
>  	trace_sched_swap_numa(cur, arg.src_cpu, p, arg.dst_cpu);
> @@ -5508,7 +5510,8 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
>  	if (curr_cpu == target_cpu)
>  		return 0;
> 
> -	if (!cpumask_test_cpu(target_cpu, &p->cpus_allowed))
> +	if ((!cpumask_test_cpu(target_cpu, &p->cpus_allowed))
> +            || cpumask_test_cpu(target_cpu, cpu_isolated_map))
>  		return -EINVAL;
> 
>  	/* TODO: This is not properly updating schedstats */
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2f0a0be..a91f8fe 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1724,7 +1724,8 @@ static void task_numa_find_cpu(struct task_numa_env *env,
> 
>  	for_each_cpu(cpu, cpumask_of_node(env->dst_nid)) {
>  		/* Skip this CPU if the source task cannot migrate */
> -		if (!cpumask_test_cpu(cpu, &env->p->cpus_allowed))
> +		if ((!cpumask_test_cpu(cpu, &env->p->cpus_allowed))
> +                    || cpumask_test_cpu(cpu, cpu_isolated_map))
>  			continue;
> 
>  		env->dst_cpu = cpu;
> --
> 1.8.3.1
> 
