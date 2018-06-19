Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26BAC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832532083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 832532083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937530AbeFSJkK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:40:10 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45868 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937452AbeFSJkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:40:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A04E31435;
        Tue, 19 Jun 2018 02:40:08 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC4FD3F25D;
        Tue, 19 Jun 2018 02:40:04 -0700 (PDT)
Date:   Tue, 19 Jun 2018 10:40:03 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joelaf@google.com, smuckle@google.com,
        adharmap@quicinc.com, skannan@quicinc.com, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v3 10/10] arch_topology: Start Energy Aware Scheduling
Message-ID: <20180619094002.GR17720@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-11-quentin.perret@arm.com>
 <20180619091841.GD9208@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619091841.GD9208@codeaurora.org>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavan,

On Tuesday 19 Jun 2018 at 14:48:41 (+0530), Pavan Kondeti wrote:
> On Mon, May 21, 2018 at 03:25:05PM +0100, Quentin Perret wrote:
> 
> <snip>
> 
> > +static void start_eas_workfn(struct work_struct *work);
> > +static DECLARE_WORK(start_eas_work, start_eas_workfn);
> > +
> >  static int
> >  init_cpu_capacity_callback(struct notifier_block *nb,
> >  			   unsigned long val,
> > @@ -204,6 +209,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
> >  		free_raw_capacity();
> >  		pr_debug("cpu_capacity: parsing done\n");
> >  		schedule_work(&parsing_done_work);
> > +		schedule_work(&start_eas_work);
> >  	}
> >  
> >  	return 0;
> > @@ -249,6 +255,19 @@ static void parsing_done_workfn(struct work_struct *work)
> >  	free_cpumask_var(cpus_to_visit);
> >  }
> >  
> > +static void start_eas_workfn(struct work_struct *work)
> > +{
> > +	/* Make sure the EM knows about the updated CPU capacities. */
> > +	rcu_read_lock();
> > +	em_rescale_cpu_capacity();
> > +	rcu_read_unlock();
> > +
> > +	/* Inform the scheduler about the EM availability. */
> > +	cpus_read_lock();
> > +	rebuild_sched_domains();
> > +	cpus_read_unlock();
> > +}
> 
> Rebuilding the sched domains is unnecessary for the platform that don't have
> energy-model. In fact, we can completely avoid scheduling this work.

Good point, we might be able to save a little bit of work there.
Now, you will reach this point only if dmips-capacity-mhz values are
specified in DT for you platform, which is usually done only for
big.LITTLE-like Arm platforms. And there are good chances that you want
to have an Energy Model as well for these platforms, so in practice that
won't make a massive difference I suppose ...

> There seems to be a sysfs interface exposed by this driver to change cpu_scale.
> Should we worry about it? I don't know what is the usecase for changing the
> cpu_scale from user space.

This is something I've been wondering as well. TBH, I'm not sure what to
do in this case. And I'm not sure to know what is the use-case either.
Debugging purpose I assume ?

Juri, did you have a specific use-case for this feature when the
arch_topology driver was first introduced ? Or was it just to align
with the existing arm/arm64 code ?

The reason I didn't call the em_rescale_cpu_capacity() function when CPU
capacities are written from sysfs is because that interface allows to have
CPUs with different capacities in the same freq_domain, which is against
the assumptions we have in the EM framework.

> 
> Are we expecting that the energy-model is populated by this time? If it is
> not, should not we build the sched domains again after the energy-model is
> populated?

Yes, the assumption is that drivers have provided the EM by this time.
I'll send a v4 of this patch set very soon with an example of cpufreq
driver modification.

Thanks,
Quentin
