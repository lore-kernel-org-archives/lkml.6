Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F8DC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3088720652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3088720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937879AbeFSNY5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:24:57 -0400
Received: from foss.arm.com ([217.140.101.70]:50154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937149AbeFSNYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:24:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09E9480D;
        Tue, 19 Jun 2018 06:24:55 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 122DC3F25D;
        Tue, 19 Jun 2018 06:24:50 -0700 (PDT)
Date:   Tue, 19 Jun 2018 14:24:49 +0100
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
Subject: Re: [RFC PATCH v3 05/10] sched/topology: Reference the Energy Model
 of CPUs when available
Message-ID: <20180619132449.GA17720@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-6-quentin.perret@arm.com>
 <20180619122632.GS2458@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619122632.GS2458@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 Jun 2018 at 14:26:32 (+0200), Peter Zijlstra wrote:
> On Mon, May 21, 2018 at 03:25:00PM +0100, Quentin Perret wrote:
> > In order to use EAS, the task scheduler has to know about the Energy
> > Model (EM) of the platform. This commit extends the scheduler topology
> > code to take references on the frequency domains objects of the EM
> > framework for all online CPUs. Hence, the availability of the EM for
> > those CPUs is guaranteed to the scheduler at runtime without further
> > checks in latency sensitive code paths (i.e. task wake-up).
> 
> I'm confused by this patch,... what does it do? Why is em_cpu_get()
> (after you fix it) not sufficient?

Hmm, so maybe the confusing part is that this patch does two things:
1. it checks all conditions for starting EAS are met
  (SD_ASYM_CPUCAPACITY is set, the EM covers all online CPUs, the EM
  isn't too complex to be used during wakeup);
2. it builds a list of frequency domains for the private use of the
   scheduler in latency sensitive code paths, and sets the static key

So I guess your question is more about 2. It is nice to have a list of
frequency domains because that makes iteration over frequency domains
in the wake-up path very easy, and efficient (for_each_freq_domain() is
used in find_energy_efficient_cpu() and compute_energy(), patches 07 and
09/10).
And also, by making the scheduler maintain that list, we can be more
hotplug-aware. If you hotplug out all CPUs of a freq domain, the scheduler
can remove it from its list and have one less element to iterate against.
The idea was tp remove the unused things on hotplug, just like for
sched domains.

I think that not having that list would mean to play with cpumasks in
find_energy_efficient_cpu() and in compute_energy() to keep track of the
CPUs we have visited and stuff like that. That's doable but probably more
complex, and not more efficient, I think.

Is the overall idea any clearer ?

Thanks,
Quentin
