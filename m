Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A7528607E5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933524AbeFFQ7x (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 12:59:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43240 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932200AbeFFQ7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 12:59:52 -0400
Date: Wed, 6 Jun 2018 17:59:46 +0100
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
Message-ID: <20180606165946.GK10870@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
 <20180606164734.GC15894@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606164734.GC15894@localhost.localdomain>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 Jun 2018 at 18:47:34 (+0200), Juri Lelli wrote:
> Hi Quentin,
> 
> On 21/05/18 15:24, Quentin Perret wrote:
> 
> [...]
> 
> > +#ifdef CONFIG_ENERGY_MODEL
> 
> [...]
> 
> > +struct em_data_callback {
> > +	/**
> > +	 * active_power() - Provide power at the next capacity state of a CPU
> > +	 * @power	: Active power at the capacity state (modified)
> > +	 * @freq	: Frequency at the capacity state (modified)
> > +	 * @cpu		: CPU for which we do this operation
> > +	 *
> > +	 * active_power() must find the lowest capacity state of 'cpu' above
> > +	 * 'freq' and update 'power' and 'freq' to the matching active power
> > +	 * and frequency.
> > +	 *
> > +	 * Return 0 on success.
> > +	 */
> > +	int (*active_power) (unsigned long *power, unsigned long *freq, int cpu);
> > +};
> 
> [...]
> 
> > +#else
> > +struct em_freq_domain;
> > +struct em_data_callback;
> 
> This doesn't compile for CONFIG_ENERGY_MODEL=n:
> 
> drivers/cpufreq/cpufreq-dt.c:164:9: error: variable 'em_cb' has initializer but incomplete type                                                          
>   struct em_data_callback em_cb = { &dev_pm_opp_of_estimate_power };                       
>            ^~~~~~~~~~~~~~~~

Ah, this is an issue with a patch which isn't part of this patch-set ...
But yeah, that's a valid point :-)

> Guess you need some sort of macro to init the struct (w/o introducing
> ifdeffery into drivers code)?

Yes, the EM framework should provide a generic way of doing this
initialization with nice stubs for CONFIG_ENERGY_MODEL=n, otherwise we
risk wild fixes in the drivers I suppose. I'll fix that in v4.

Thanks for pointing that out !
Quentin
