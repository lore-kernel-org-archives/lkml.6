Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2A2ECDFB3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 22:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B272089D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 22:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B272089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeGOXLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 19:11:23 -0400
Received: from smtprelay0040.hostedemail.com ([216.40.44.40]:41051 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727046AbeGOXLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 19:11:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id D00981801EDC9;
        Sun, 15 Jul 2018 22:46:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: able94_7635239b43705
X-Filterd-Recvd-Size: 3072
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Sun, 15 Jul 2018 22:46:52 +0000 (UTC)
Message-ID: <1db704b2e118b91c05ff37cd74c9adb818a4d033.camel@perches.com>
Subject: Re: [PATCH 09/11] sched: use pelt for scale_rt_capacity()
From:   Joe Perches <joe@perches.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, patrick.bellasi@arm.com,
        joel@joelfernandes.org, daniel.lezcano@linaro.org,
        quentin.perret@arm.com, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, Ingo Molnar <mingo@redhat.com>
Date:   Sun, 15 Jul 2018 15:46:49 -0700
In-Reply-To: <20180715221538.GA23280@gmail.com>
References: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
         <1530200714-4504-10-git-send-email-vincent.guittot@linaro.org>
         <20180715221538.GA23280@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-16 at 00:15 +0200, Ingo Molnar wrote:
> * Vincent Guittot <vincent.guittot@linaro.org> wrote:
> 
> > The utilization of the CPU by rt, dl and interrupts are now tracked with
> > PELT so we can use these metrics instead of rt_avg to evaluate the remaining
> > capacity available for cfs class.
> > 
> > scale_rt_capacity() behavior has been changed and now returns the remaining
> > capacity available for cfs instead of a scaling factor because rt, dl and
> > interrupt provide now absolute utilization value.
> > 
> > The same formula as schedutil is used:
> >   irq util_avg + (1 - irq util_avg / max capacity ) * /Sum rq util_avg
> > but the implementation is different because it doesn't return the same value
> > and doesn't benefit of the same optimization
[]
> I have applied the delta fix below for simplicity, but what we really want is a 
> cleanup of that function to eliminate the #ifdefs. One solution would be to factor 
> out the 'irq' utilization value into a helper inline, and double check that if the 
> configs are off the compiler does the right thing and eliminates this identity 
> transformation for the irq==0 case:
[]
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
[]
> @@ -7550,7 +7550,10 @@ static unsigned long scale_rt_capacity(int cpu)
>  {
>  	struct rq *rq = cpu_rq(cpu);
>  	unsigned long max = arch_scale_cpu_capacity(NULL, cpu);
> -	unsigned long used, irq, free;
> +	unsigned long used, free;
> +#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
> +	unsigned long irq;
> +#endif
>  
>  #if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)

Perhaps combine these two #if defined blocks into
a single block

>  	irq = READ_ONCE(rq->avg_irq.util_avg);
