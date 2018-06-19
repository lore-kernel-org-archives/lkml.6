Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAE7C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483E720874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483E720874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966397AbeFSM7F (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:59:05 -0400
Received: from foss.arm.com ([217.140.101.70]:49674 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965883AbeFSM7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:59:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 773F180D;
        Tue, 19 Jun 2018 05:59:03 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82D6F3F557;
        Tue, 19 Jun 2018 05:58:59 -0700 (PDT)
Date:   Tue, 19 Jun 2018 13:58:58 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
Message-ID: <20180619125857.GY17720@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
 <20180619113408.GQ2458@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619113408.GQ2458@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 Jun 2018 at 13:34:08 (+0200), Peter Zijlstra wrote:
> On Mon, May 21, 2018 at 03:24:58PM +0100, Quentin Perret wrote:
> > +struct em_freq_domain *em_cpu_get(int cpu)
> > +{
> > +	struct em_freq_domain *fd;
> > +	unsigned long flags;
> > +
> > +	read_lock_irqsave(&em_data_lock, flags);
> > +	fd = per_cpu(em_data, cpu);
> > +	read_unlock_irqrestore(&em_data_lock, flags);
> 
> Why can't this use RCU? This is the exact thing read_locks are terrible
> at and RCU excells at.

So the idea was that clients (the scheduler for ex) can get a reference
to a frequency domain object once, and they're guaranteed it always
exists without asking for it again.

For example, my proposal was to have the scheduler (patch 05) build its
own private list of frequency domains on which it can iterate efficiently
in the wake-up path. If we protect this per_cpu variable with RCU, then
this isn't possible any-more. The scheduler will have to re-ask
em_cpu_get() at every wake-up, and that makes iterating over frequency
domains a whole lot more complex.

Does that make any sense ?

Thanks,
Quentin
