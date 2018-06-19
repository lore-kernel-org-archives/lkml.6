Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3B3C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531142083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LunzgRMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 531142083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966975AbeFSQVN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:21:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54252 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966646AbeFSQVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FkFY/njUBC8BUERXpPyVsL5EYTnXxjo21r7S0mmXik8=; b=LunzgRMSzDVW984GLofwv2Bh8
        k2dbp4wtIplhFAQjb7iHigAHbKraZ6JBaW21Zg4gsh7thYDJaFBYRtUtoMZjBffeI3qYP5ayVc5C2
        3/k6fmFGuAp8uHlqfwlqRw6mKBcOJTZ4b9V4BFZLxom45Yfj6lL0pRUW7eWLcJVMDs62q/VPTpKeI
        Dn2OSxKfOiHFF6Wd9lq0Rvo/jW0GgBdLz3sax/J11WHqsviQr1Duf4lAR8MHEA1yhsLQI5I5r61sD
        Khbbn7mhilcrPRA0UAxKSDRGv1QRKDBb83x4meEsHhZOuc7UCdDUUbCGKlX0hTL6ZLBy5yRlQl7s2
        uae2THwng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVJN7-0005XO-7j; Tue, 19 Jun 2018 16:20:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A16A820298BAC; Tue, 19 Jun 2018 18:20:42 +0200 (CEST)
Date:   Tue, 19 Jun 2018 18:20:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v3 05/10] sched/topology: Reference the Energy Model
 of CPUs when available
Message-ID: <20180619162042.GT2458@hirez.programming.kicks-ass.net>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-6-quentin.perret@arm.com>
 <20180619122632.GS2458@hirez.programming.kicks-ass.net>
 <20180619132449.GA17720@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619132449.GA17720@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 02:24:49PM +0100, Quentin Perret wrote:
> On Tuesday 19 Jun 2018 at 14:26:32 (+0200), Peter Zijlstra wrote:

> > I'm confused by this patch,... what does it do? Why is em_cpu_get()
> > (after you fix it) not sufficient?
> 
> Hmm, so maybe the confusing part is that this patch does two things:
> 1. it checks all conditions for starting EAS are met
>   (SD_ASYM_CPUCAPACITY is set, the EM covers all online CPUs, the EM
>   isn't too complex to be used during wakeup);
> 2. it builds a list of frequency domains for the private use of the
>    scheduler in latency sensitive code paths,
  3. and sets the static key

> So I guess your question is more about 2. It is nice to have a list of
> frequency domains because that makes iteration over frequency domains
> in the wake-up path very easy, and efficient (for_each_freq_domain() is
> used in find_energy_efficient_cpu() and compute_energy(), patches 07 and
> 09/10).
> And also, by making the scheduler maintain that list, we can be more
> hotplug-aware. If you hotplug out all CPUs of a freq domain, the scheduler
> can remove it from its list and have one less element to iterate against.
> The idea was tp remove the unused things on hotplug, just like for
> sched domains.
> 
> I think that not having that list would mean to play with cpumasks in
> find_energy_efficient_cpu() and in compute_energy() to keep track of the
> CPUs we have visited and stuff like that. That's doable but probably more
> complex, and not more efficient, I think.
> 
> Is the overall idea any clearer ?

Right, so I would not do that many things at once. Also be more explicit
about what data structure, and why.

That said, I think the whole for_each_freq_domain() thing as done is
broken. You've completely ignored the arguments to
partition_sched_domains(). What happens if you create partitions right
along the frequency domains?

So you really want an argument to for_each_freq_domain() to indicate
who's frequency domains you want to iterate. And then I think it's
easiest if you hook into build_sched_domains() instead, because you
really want a list per root_domain I suspect (and an empty list if there
is but one entry on).
