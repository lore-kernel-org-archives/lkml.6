Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 79127606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbeFFOhq (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 10:37:46 -0400
Received: from foss.arm.com ([217.140.101.70]:41150 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752114AbeFFOhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 10:37:45 -0400
Date: Wed, 6 Jun 2018 15:37:39 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mingo@redhat.com,
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
Message-ID: <20180606143739.GF10870@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
 <b47cb1f1-6ca1-7674-903f-724be43a57a0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b47cb1f1-6ca1-7674-903f-724be43a57a0@arm.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar,

On Wednesday 06 Jun 2018 at 15:12:15 (+0200), Dietmar Eggemann wrote:
> > +static void fd_update_cs_table(struct em_cs_table *cs_table, int cpu)
> > +{
> > +	unsigned long cmax = arch_scale_cpu_capacity(NULL, cpu);
> > +	int max_cap_state = cs_table->nr_cap_states - 1;
> > +	unsigned long fmax = cs_table->state[max_cap_state].frequency;
> > +	int i;
> > +
> > +	for (i = 0; i < cs_table->nr_cap_states; i++)
> > +		cs_table->state[i].capacity = cmax *
> > +					cs_table->state[i].frequency / fmax;
> > +}
> 
> This has issues on a 32bit system. cs_table->state[i].capacity (unsigned
> long) overflows with the frequency values stored in Hz.

Ah, thank you very much for pointing this out ! I haven't tried on a 32bit
machine yet, my bad. I'll fix that for v4.

> 
> Maybe something like this to cure it:
> 
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 6ad53f1cf7e6..c13b3eb8bf35 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -144,9 +144,11 @@ static void fd_update_cs_table(struct em_cs_table *cs_table, int cpu)
>  	unsigned long fmax = cs_table->state[max_cap_state].frequency;
>  	int i;
>  
> -	for (i = 0; i < cs_table->nr_cap_states; i++)
> -		cs_table->state[i].capacity = cmax *
> -					cs_table->state[i].frequency / fmax;
> +	for (i = 0; i < cs_table->nr_cap_states; i++) {
> +		u64 val = (u64)cmax * cs_table->state[i].frequency;
> +		do_div(val, fmax);
> +		cs_table->state[i].capacity = (unsigned long)val;
> +	}
>  }

Hmmm yes, that should work.

> 
> This brings me to another question. Let's say there are multiple users of
> the Energy Model in the system. Shouldn't the units of frequency and power
> not standardized, maybe Mhz and mW?
> The task scheduler doesn't care since it is only interested in power diffs
> but other user might do.

So the good thing about specifying units is that we can probably assume
ranges on the values. If the power is in mW, assuming that we're talking
about a single CPU, it'll probably fit in 16 bits. 65W/core should be
a reasonable upper-bound ?
But there are also vendors who might not be happy with disclosing absolute
values ... These are sometimes considered sensitive and only relative
numbers are discussed publicly. Now, you can also argue that we already
have units specified in IPA for ex, and that it doesn't really matter if
a driver "lies" about the real value, as long as the ratios are correct.
And I guess that anyone can do measurement on the hardware and get those
values anyway. So specifying a unit (mW) for the power is probably a
good idea.

For the frequency, I would rather keep it consistent with what CPUFreq
manages. But that should be specified somewhere, I agree.

What do you think ?

Thanks !
Quentin
