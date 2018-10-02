Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884ACC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0712082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0712082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbeJBVYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:24:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39652 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbeJBVYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:24:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D22CC18A;
        Tue,  2 Oct 2018 07:40:33 -0700 (PDT)
Received: from queper01-lin (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B44E23F5A0;
        Tue,  2 Oct 2018 07:40:29 -0700 (PDT)
Date:   Tue, 2 Oct 2018 15:40:28 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@codeaurora.org,
        skannan@codeaurora.org, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [PATCH v7 03/14] PM: Introduce an Energy Model management
 framework
Message-ID: <20181002144025.wnanxibhdcnl23sf@queper01-lin>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-4-quentin.perret@arm.com>
 <20181002123031.GZ3439@hirez.programming.kicks-ass.net>
 <20181002125115.245r3ocusvyiexno@queper01-lin>
 <20181002134857.GE26858@hirez.programming.kicks-ass.net>
 <20181002140430.fpeiqzblbcaewg6n@queper01-lin>
 <20181002142924.GI26858@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002142924.GI26858@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 Oct 2018 at 16:29:24 (+0200), Peter Zijlstra wrote:
> On Tue, Oct 02, 2018 at 03:05:23PM +0100, Quentin Perret wrote:
> > On Tuesday 02 Oct 2018 at 15:48:57 (+0200), Peter Zijlstra wrote:
> > > +/**
> > > + * em_cpu_get() - Return the performance domain for a CPU
> > > + * @cpu : CPU to find the performance domain for
> > > + *
> > > + * Return: the performance domain to which 'cpu' belongs, or NULL if it doesn't
> > > + * exist.
> > > + */
> > > +struct em_perf_domain *em_cpu_get(int cpu)
> > > +{
> > > +       return READ_ONCE(per_cpu(em_data, cpu));
> > > +}
> > > +EXPORT_SYMBOL_GPL(em_cpu_get);
> > > 
> > > But your read side doesn't take, not is required to take em_pd_mutex.
> > > 
> > > At that point, the mutex_unlock() doesn't guarantee anything.
> > > 
> > > A CPU observing the em_data store, doesn't need to observe the store
> > > that filled the data structure it points to.
> > 
> > Right but even if I add the smp_store_release(), I can still have a
> > CPU observing em_data while another is in the process of updating it.
> > So, if smp_store_release() doesn't guarantee that readers will see a
> > complete update, do I actually get something interesting from it ?
> > (That's not a rhetorical question, I'm actually wondering :-)
> 
> I thought the update would fail if em_data was already set.
> 
> That is, you can only set this thing up _once_ and then you'll have to
> forever live with it.
> 
> Or did I read that wrong?

No no, that's correct. em_data is populated once and kept as-is
forever.

What I was trying to say is, when em_data is being populated for the
first time, nothing prevents a reader from using em_cpu_get()
concurrently. And in this case, it doesn't matter if you use
smp_store_release() or not, the reader might see the table half-updated.

So, basically, smp_store_release() doesn't guarantee that readers won't
see a half-baked em_data. That's the point I'm trying to make at least :-)
