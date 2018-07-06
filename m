Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203D0C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB82B23F4E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mlfNQfKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB82B23F4E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753648AbeGFJOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:14:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38500 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753177AbeGFJOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gKR+oYdc7LwjQZafHpW8uMEL81WnzH5yBD+p+u/u9Ds=; b=mlfNQfKYBluT0G3CzQ2RqNhdx
        Q7LLBTt732rGN3mf9hUuV8Qx6zSzia/NYbVZB8iTE0+apNLTqloy3BfRwDx2bKZ0k05+rj96eUsrC
        I3RlWX9TkCqHRk0zUIL2CshR0InIgl4y42Gy/7YshrLFrDNUrQsVJ1YQ3Z7K/2ojY4ogxxyCweRiN
        oT3FYwIW2xVeiaOXvjKTPXoW0Qku6VHFqAc2O482qGqDG39xU+OFoc8DOLKCqA5XUPyitH26CEv76
        RZKVMczH3MaCZc7pGWw2ENk7tMch6KZSAOvsWjpo6iwpDI4gCP2SGDOTybxQROjevgPPXEZDEMFYB
        vqAKEutHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbMoy-0002ko-1i; Fri, 06 Jul 2018 09:14:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 901BC20298BAE; Fri,  6 Jul 2018 11:14:29 +0200 (CEST)
Date:   Fri, 6 Jul 2018 11:14:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, valentin.schneider@arm.com,
        patrick.bellasi@arm.com, joel@joelfernandes.org,
        daniel.lezcano@linaro.org, quentin.perret@arm.com,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 07/11] cpufreq/schedutil: take into account interrupt
Message-ID: <20180706091429.GJ2494@hirez.programming.kicks-ass.net>
References: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
 <1530200714-4504-8-git-send-email-vincent.guittot@linaro.org>
 <20180706060033.rcgzfs6pouqssiqh@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706060033.rcgzfs6pouqssiqh@vireshk-i7>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 11:30:33AM +0530, Viresh Kumar wrote:
> On 28-06-18, 17:45, Vincent Guittot wrote:
> > The time spent under interrupt can be significant but it is not reflected
> > in the utilization of CPU when deciding to choose an OPP. Now that we have
> > access to this metric, schedutil can take it into account when selecting
> > the OPP for a CPU.
> > rqs utilization don't see the time spend under interrupt context and report
> > their value in the normal context time window. We need to compensate this when
> > adding interrupt utilization
> > 
> > The CPU utilization is :
> >   irq util_avg + (1 - irq util_avg / max capacity ) * /Sum rq util_avg
> > 
> > A test with iperf on hikey (octo arm64) gives:
> > iperf -c server_address -r -t 5
> > 
> > w/o patch		w/ patch
> > Tx 276 Mbits/sec        304 Mbits/sec +10%
> > Rx 299 Mbits/sec        328 Mbits/sec +09%
> > 
> > 8 iterations
> > stdev is lower than 1%
> > Only WFI idle state is enable (shallowest diel state)

Also s/diel/idle/

> > +	/*
> > +	 * Interrupt time is not seen by rqs utilization nso we can compare
> 
>                                                          nso ?
> 
> > +	 * them with the CPU capacity
> > +	 */

Already fixed ;-)
