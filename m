Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB6EC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7453F240B1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7453F240B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754079AbeGEPJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:09:18 -0400
Received: from foss.arm.com ([217.140.101.70]:51600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753990AbeGEPJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:09:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61A5618A;
        Thu,  5 Jul 2018 08:09:14 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D7D03F5BA;
        Thu,  5 Jul 2018 08:09:10 -0700 (PDT)
Date:   Thu, 5 Jul 2018 16:09:08 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v4 03/12] PM: Introduce an Energy Model management
 framework
Message-ID: <20180705150908.GF32579@e108498-lin.cambridge.arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-4-quentin.perret@arm.com>
 <20180705143901.GO2458@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705143901.GO2458@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 Jul 2018 at 16:39:01 (+0200), Peter Zijlstra wrote:
> On Thu, Jun 28, 2018 at 12:40:34PM +0100, Quentin Perret wrote:
> > +/**
> > + * em_fd_nr_cap_states() - Get the number of capacity states of a freq. domain
> > + * @fd		: frequency domain for which want to do this
> > + *
> > + * Return: the number of capacity state in the frequency domain table
> > + */
> > +static inline int em_fd_nr_cap_states(struct em_freq_domain *fd)
> > +{
> > +	struct em_cs_table *table;
> > +	int nr_states;
> > +
> > +	rcu_read_lock();
> > +	table = rcu_dereference(fd->cs_table);
> > +	nr_states = table->nr_cap_states;
> > +	rcu_read_unlock();
> 
> So right here, we can continue to free @table...
> 
> > +
> > +	return nr_states;
> > +}
> 
> and then what does the value we return mean?

Hmm that's a good point. In practice the number of entries in the table
never changes, so that makes no sense to keep that value in the
RCU-protected struct. I can just move nr_cap_states in struct
freq_domain directly and access it without RCU protection, it is simply
not needed.

I'll change that for the next version.

Thanks,
Quentin
