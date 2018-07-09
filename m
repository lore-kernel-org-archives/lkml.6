Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408B4C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08842089B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08842089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933510AbeGIP2h (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:28:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33006 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933271AbeGIP2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:28:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59F7BED1;
        Mon,  9 Jul 2018 08:28:35 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6662E3F589;
        Mon,  9 Jul 2018 08:28:31 -0700 (PDT)
Date:   Mon, 9 Jul 2018 16:28:26 +0100
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
Subject: Re: [RFC PATCH v4 09/12] sched/fair: Introduce an energy estimation
 helper function
Message-ID: <20180709152825.GA17598@e108498-lin.cambridge.arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-10-quentin.perret@arm.com>
 <20180706131243.GV2458@hirez.programming.kicks-ass.net>
 <20180706151212.GD17577@e108498-lin.cambridge.arm.com>
 <20180706154949.GO2494@hirez.programming.kicks-ass.net>
 <20180706170443.GE17577@e108498-lin.cambridge.arm.com>
 <20180709120138.GQ2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709120138.GQ2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 Jul 2018 at 14:01:38 (+0200), Peter Zijlstra wrote:
> On Fri, Jul 06, 2018 at 06:04:44PM +0100, Quentin Perret wrote:
> > 'max_util' is basically the util we use to request an OPP. 'sum_util' is
> > how long the CPUs will be running.
> 
> A indeed. But yes bit of a mess, but it wants doing I think.

OK, understood.

> Perhaps a little something like the below... The alternative is two
> separate but closely related functions, not sure which is better.
> 
> 
> enum schedutil_type {
> 	frequency_util,
> 	energy_util,
> };

Hmm, this should work ... Should we also try to avoid the code
duplication in scale_rt_capacity() ? This doesn't want dependencies on
schedutil I assume so a little bit of extra work is required.

What about moving schedutil_freq_util() to sched.h and give it a more
generic name (total_cpu_util() ?) with no dependencies on
CONFIG_CPU_FREQ_GOV_SCHEDUTIL ? Also, 'energy_util' would have to be
renamed I guess (busy_time_util ?).

Then scale_rt_capacity() can be turned into something like (totally
untested):

static unsigned long scale_rt_capacity(int cpu)
{
	unsigned long util = total_cpu_util(cpu, 0, busy_time_util);

	return arch_scale_cpu_capacity(NULL, cpu) - util;
}

Thoughts ?

Thanks,
Quentin
