Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id dfftB4BrGVuTRQAAmS7hNA
	; Thu, 07 Jun 2018 17:31:57 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 837DA608BA; Thu,  7 Jun 2018 17:31:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1F7FB601B4;
	Thu,  7 Jun 2018 17:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1F7FB601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933973AbeFGRbu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:31:50 -0400
Received: from foss.arm.com ([217.140.101.70]:54928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932648AbeFGRbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:31:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AE2D1435;
        Thu,  7 Jun 2018 10:31:49 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 457FE3F59D;
        Thu,  7 Jun 2018 10:31:45 -0700 (PDT)
Date: Thu, 7 Jun 2018 18:31:43 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joelaf@google.com, smuckle@google.com,
        adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
Message-ID: <20180607173143.GD3597@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
 <20180607144409.GB3311@localhost.localdomain>
 <20180607151954.GA3597@e108498-lin.cambridge.arm.com>
 <20180607160419.GD3311@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607160419.GD3311@localhost.localdomain>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 Jun 2018 at 18:04:19 (+0200), Juri Lelli wrote:
> On 07/06/18 16:19, Quentin Perret wrote:
> > On Thursday 07 Jun 2018 at 16:44:09 (+0200), Juri Lelli wrote:
> > > > +	if (!fd->cs_table)
> > > > +		goto free_fd;
> > > > +
> > > > +	/* Copy the span of the frequency domain */
> > > > +	cpumask_copy(&fd->cpus, span);
> > > > +
> > > > +	/* Build the list of capacity states for this freq domain */
> > > > +	for (i = 0, freq = 0; i < nr_states; i++, freq++) {
> > >                      ^                              ^
> > > The fact that this relies on active_power() to use ceil OPP for a given
> > > freq might deserve a comment. Also, is this behaviour of active_power()
> > > standardized?
> > 
> > Right, this can get confusing pretty quickly. There is a comment in
> > include/linux/energy_model.h where the expected behaviour of
> > active_power is explained, but a reminder above this function shouldn't
> > hurt.
> 
> Mmm, not sure if you could actually check that returned freq values are
> actually consistent with the assumption (just in case one didn't do
> homework).

Right, that's a good point. I'll add checks on the parameters modified by
active_power(). Monotonically increasing freq, monotonically increasing
power as well I guess, something along those lines.

> > > > +{
> > > > +	struct em_cs_table *old_table, *new_table;
> > > > +	struct em_freq_domain *fd;
> > > > +	unsigned long flags;
> > > > +	int nr_states, cpu;
> > > > +
> > > > +	read_lock_irqsave(&em_data_lock, flags);
> > > 
> > > Don't you need write_lock_ here, since you are going to exchange the
> > > em tables?
> > 
> > This lock protects the per_cpu() variable itself. Here we only read
> > pointers from that per_cpu variable, and we modify one attribute in
> > the pointed structure. We don't modify the per_cpu table itself. Does
> > that make sense ?
> 
> So, I don't seem to understand what protects the rcu_assign_pointer(s)
> below (as in
> https://elixir.bootlin.com/linux/latest/source/Documentation/RCU/whatisRCU.txt#L395).

Sigh, that's not right :(
I take back my previous message, the write lock _is_ needed. Thanks for
pointing that out ...

Thanks,
Quentin
