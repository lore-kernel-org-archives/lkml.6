Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A298DC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DAD62086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="liHY87sA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DAD62086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933183AbeFLMww (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 08:52:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36654 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754223AbeFLMwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 08:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iW1N7nazOG3nFnLgR1E6cE44LszNz5mvWvdQT6g4Cqg=; b=liHY87sAWqHXYhpVk2v5IrWS6
        Gr1GANzKDlZdn+4N9T86cWwuMCZz6/6BXWVXsODkopM66pG98RlJ7GcrxcblUwik1KspAm6uPFHqJ
        GxC+/+ev8U0D4WSlcpjtTPatKbn4GZxx24rSJn74ymV2z6MLICmaAD2Cf/J7VzR8ABL6dpscIPK2l
        bP/BU8SB0paE5Kpr1DSVVf/IRSdWJOLnZeG2252k67YMfdavvquTjHZToNX2pH9daA2tIDf3SmSdr
        gYUS5i+K7nik2fZysauk9fXa6NAspWNZkgdM0sqBcTsa7xj4Pe0esMNZPt43FXCxvwDxq3aCaN14h
        V77th8SPw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSin2-0007Iu-Kh; Tue, 12 Jun 2018 12:52:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1EAFA201EA7A3; Tue, 12 Jun 2018 14:52:47 +0200 (CEST)
Date:   Tue, 12 Jun 2018 14:52:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     viresh.kumar@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH V6] powercap/drivers/idle_injection: Add an idle
 injection framework
Message-ID: <20180612125247.GO12217@hirez.programming.kicks-ass.net>
References: <1528804816-32636-1-git-send-email-daniel.lezcano@linaro.org>
 <20180612123036.GJ12180@hirez.programming.kicks-ass.net>
 <16d5649d-863c-10c7-9287-202568e713e6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16d5649d-863c-10c7-9287-202568e713e6@linaro.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 02:44:29PM +0200, Daniel Lezcano wrote:
> On 12/06/2018 14:30, Peter Zijlstra wrote:
> > On Tue, Jun 12, 2018 at 02:00:11PM +0200, Daniel Lezcano wrote:
> >> +static void __idle_injection_wakeup(struct idle_injection_device *ii_dev)
> >> +{
> >> +	struct idle_injection_thread *iit;
> >> +	struct cpumask tmp;
> >> +	unsigned int cpu;
> >> +
> >> +	cpumask_and(&tmp, ii_dev->cpumask, cpu_online_mask);
> > 
> > You should not be having a cpumask on the stack. Those things can be
> > ginormous.
> 
> Ok, the kernel code uses of cpumask_t on the stack when dealing with
> cpumask_and. I assume it is also not recommended.

Yes, that should all get fixed. It's mostly legacy code I suppose. It's
been at least 10 years I think since we merged the whole
CPUMASK_OFFSTACK stuff.

> What would be the best practice ? Allocate a per cpumask at init time as
> a temporary mask to work with ?

In this case, you can do:

+       for_each_cpu_and(cpu, &ii_dev->cpumask, cpu_online_mask) {
+               iit = per_cpu_ptr(&idle_injection_thread, cpu);
+               iit->should_run = 1;
+               wake_up_process(iit->tsk);
+       }
