Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59741C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EAE020020
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EAE020020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966998AbeFSRNY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:13:24 -0400
Received: from foss.arm.com ([217.140.101.70]:54076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966772AbeFSRNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:13:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FEAD1596;
        Tue, 19 Jun 2018 10:13:22 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A97953F246;
        Tue, 19 Jun 2018 10:13:18 -0700 (PDT)
Date:   Tue, 19 Jun 2018 18:13:17 +0100
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
Message-ID: <20180619171316.GB29374@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-6-quentin.perret@arm.com>
 <20180619122632.GS2458@hirez.programming.kicks-ass.net>
 <20180619132449.GA17720@e108498-lin.cambridge.arm.com>
 <20180619162042.GT2458@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619162042.GT2458@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 Jun 2018 at 18:20:42 (+0200), Peter Zijlstra wrote:
> Right, so I would not do that many things at once. Also be more explicit
> about what data structure, and why.

OK, I can probably split that patch in two smaller patches. One that
introduces and enables the static_key (or something else to replace it,
see my reply below); and another one to create the list of frequency
domains.

> That said, I think the whole for_each_freq_domain() thing as done is
> broken. You've completely ignored the arguments to
> partition_sched_domains(). What happens if you create partitions right
> along the frequency domains?
> 
> So you really want an argument to for_each_freq_domain() to indicate
> who's frequency domains you want to iterate. And then I think it's
> easiest if you hook into build_sched_domains() instead, because you
> really want a list per root_domain I suspect

Hmm right, the current implementation is broken with multiple root
domains... We rarely use that in mobile but the code should work
regardless I suppose.

I agree having one list per root_domain should be better. I'll change that
in v4. But I also think the idea of a global static_key is broken then.
We need a per root_domain thing as well. The SD_ASYM_CPUCAPACITY flag
might be set on one hierarchy and not the other for ex. Not sure if
attaching a static_key to each root_domain really makes sense though ...

Would replacing the static_key by a flag attached to the root_domain be
reasonable ? The CONFIG_ENERGY_MODEL config option could help us make
sure there is no performance impact when EAS can't be used with something
like this:

	static bool sched_energy_enabled(struct root_domain *rd)
	{
	#ifdef CONFIG_ENERGY_MODEL
		return rd->eas_enabled;
	#else
		return false;
	#endif
	}

Or maybe a sched_feat instead of that ifdefery ?

> (and an empty list if there is but one entry on).

Sorry but I didn't understand that ...

Thanks,
Quentin
