Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93828C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B56620823
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AgdX6hXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfBKJaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:30:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39274 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfBKJaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:30:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aKRhkuXk46b93kwjrTxIMTwquIkphDB1CHjLoQSZ7/M=; b=AgdX6hXEyJCeHJ8ctqbXXPTIf
        DvJ/dm9U5KVxP/bzrjn9D4bCfmRhUNiQmesq3wXdELrpawGqsLZFW07VKJbyj3uAmVkVHfPHj9zSt
        YORsu6U7GozBztG26JBoE9Gb6qPVwRUOhEuBuy5f6Rx/7UkD2MSA5+qacvt/LimCwf6MphyRKj1Hx
        u5SPclEY7XbR3Q/g94ZyDll9YLQyjj6CFegkqsCGSkCVA3CwRkKYlu6dCSg7omeV3FOi7UheIJONa
        uA0nCpApBPVonJv5ep50GIJZiOqIlmoSIhs8cZNX/O+gMIEPcSiGY105QKeRHtiItO3QGKK4BqlwW
        t8y4GpObg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gt7us-0005FV-0v; Mon, 11 Feb 2019 09:30:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E6E9321A7CCE6; Mon, 11 Feb 2019 10:30:14 +0100 (CET)
Date:   Mon, 11 Feb 2019 10:30:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/fair: Improve the for loop in
 select_idle_core()
Message-ID: <20190211093014.GS32511@hirez.programming.kicks-ass.net>
References: <f91c5e118183e79d4a982e9ac4ce5e47948f6c1b.1549536337.git.viresh.kumar@linaro.org>
 <6b165676325a47d67e667582a7b78da85c5c118a.1549536337.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b165676325a47d67e667582a7b78da85c5c118a.1549536337.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 04:16:06PM +0530, Viresh Kumar wrote:
> @@ -6081,10 +6082,14 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
>  	for_each_cpu_wrap(core, cpus, target) {
>  		bool idle = true;
>  
> -		for_each_cpu(cpu, cpu_smt_mask(core)) {
> -			cpumask_clear_cpu(cpu, cpus);
> -			if (!available_idle_cpu(cpu))
> +		smt = cpu_smt_mask(core);
> +		cpumask_andnot(cpus, cpus, smt);

So where the previous code was like 1-2 stores, you just added 16.

(assuming 64bit and NR_CPUS=1024)

And we still do the iteration anyway:

> +		for_each_cpu(cpu, smt) {
> +			if (!available_idle_cpu(cpu)) {
>  				idle = false;
> +				break;
> +			}
>  		}

An actual improvement would've been:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 38d4669aa2ef..2d352d6d15c7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6082,7 +6082,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 		bool idle = true;
 
 		for_each_cpu(cpu, cpu_smt_mask(core)) {
-			cpumask_clear_cpu(cpu, cpus);
+			__cpumask_clear_cpu(cpu, cpus);
 			if (!available_idle_cpu(cpu))
 				idle = false;
 		}
