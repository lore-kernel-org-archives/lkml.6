Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A5DC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25EF423F4E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c4jFpsC9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25EF423F4E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753596AbeGFJSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:18:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40558 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753029AbeGFJS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kAfHntu0RaX2PoqyzZNg2STgX5BA7uR12fxiEHbPCQw=; b=c4jFpsC9vlYvu4MQbZYM1Gk6Z
        IXU+uZgb710rr74GGpwkcqHVj66tojP8isDZan5B7JhxM815HgzJ17h+Wbr3gEKmAvRCBRo7eeXCM
        V1Dc3AboNitv9YlD2o5oc5yqbWN7QNQhi4CAQYzpLt6sI8UP4mQtGRFSS9teFlJR72FN3+PS+Miww
        4xBJ9G53VbuYufTZwUDopcQpRz/4dEwt/NCuSpfPK2mhPKLYX76nIVOUByf7l/CP6UmVH0ER/HuuC
        qFXB+cZlmyQDotUDsYEDU9oAOnkVtp5Z2uKay+heqXUW24zAJYDyD8I/5Na6rf/u2G5rlpauyJWwX
        Pl1kyuYQA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbMsh-0004Wt-GD; Fri, 06 Jul 2018 09:18:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F203D20298BAE; Fri,  6 Jul 2018 11:18:21 +0200 (CEST)
Date:   Fri, 6 Jul 2018 11:18:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, valentin.schneider@arm.com,
        patrick.bellasi@arm.com, joel@joelfernandes.org,
        daniel.lezcano@linaro.org, quentin.perret@arm.com,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com
Subject: Re: [PATCH v7 00/11] track CPU utilization
Message-ID: <20180706091821.GK2494@hirez.programming.kicks-ass.net>
References: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
 <20180705123617.GM2458@hirez.programming.kicks-ass.net>
 <20180706060522.537imgcw4b62crph@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706060522.537imgcw4b62crph@vireshk-i7>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 11:35:22AM +0530, Viresh Kumar wrote:
> On 05-07-18, 14:36, Peter Zijlstra wrote:
> > +/*
> > + * This function computes an effective utilization for the given CPU, to be
> > + * used for frequency selection given the linear relation: f = u * f_max.
> > + *
> > + * The scheduler tracks the following metrics:
> > + *
> > + *   cpu_util_{cfs,rt,dl,irq}()
> > + *   cpu_bw_dl()
> > + *
> > + * Where the cfs,rt and dl util numbers are tracked with the same metric and
> > + * synchronized windows and are thus directly comparable.
> > + *
> > + * The cfs,rt,dl utilization are the running times measured with rq->clock_task
> > + * which excludes things like IRQ and steal-time. These latter are then accrued in
> > + * the irq utilization.
> > + *
> > + * The DL bandwidth number otoh is not a measured meric but a value computed
> 
>                                                      metric

Indeed, fixed.

> > + * based on the task model parameters and gives the minimal u required to meet
> 
>                                                                u ?

utilization, but for lazy people :-) I'll use the whole word.

> > + * deadlines.
> > + */


