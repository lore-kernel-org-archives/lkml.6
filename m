Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CFEC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B52C624110
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B52C624110
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753779AbeGEPc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:32:58 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51978 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753642AbeGEPcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:32:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B81197A9;
        Thu,  5 Jul 2018 08:32:54 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C47863F5BA;
        Thu,  5 Jul 2018 08:32:50 -0700 (PDT)
Date:   Thu, 5 Jul 2018 16:32:49 +0100
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
Message-ID: <20180705153249.GH32579@e108498-lin.cambridge.arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-4-quentin.perret@arm.com>
 <20180705150629.GP2458@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705150629.GP2458@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 Jul 2018 at 17:06:29 (+0200), Peter Zijlstra wrote:
> On Thu, Jun 28, 2018 at 12:40:34PM +0100, Quentin Perret wrote:
> > +/* fd_update_cs_table() - Computes the capacity values of a cs_table
> > + *
> > + * This assumes a linear relation between capacity and frequency. As such,
> > + * the capacity of a CPU at the n^th capacity state is computed as:
> > + *           capactity(n) = max_capacity * freq(n) / freq_max
> > + */
> 
> Broken comment style
> 
> > +static void fd_update_cs_table(struct em_cs_table *cs_table, int cpu)
> > +{
> > +	unsigned long cmax = arch_scale_cpu_capacity(NULL, cpu);
> > +	int max_cap_state = cs_table->nr_cap_states - 1;
> > +	unsigned long fmax = cs_table->state[max_cap_state].frequency;
> > +	int i;
> > +
> > +	for (i = 0; i < cs_table->nr_cap_states; i++) {
> > +		u64 cap = (u64)cmax * cs_table->state[i].frequency;
> > +		do_div(cap, fmax);
> > +		cs_table->state[i].capacity = (unsigned long)cap;
> 
> I prefer div64_*() over do_div(), the calling convention the latter
> always confuses the heck out of me.
> 
> So this then becomes something like:
> 
> 		cs_table->state[i].capacity =
> 			div64_u64(cmax * cs_table->state[i].frequency, fmax);

Ok, I'll change both.

Thanks,
Quentin
