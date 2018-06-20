Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268B1C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8318208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8318208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754730AbeFTIge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:36:34 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33244 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753906AbeFTIgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:36:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA93F80D;
        Wed, 20 Jun 2018 00:58:18 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D72F63F246;
        Wed, 20 Jun 2018 00:58:14 -0700 (PDT)
Date:   Wed, 20 Jun 2018 08:58:09 +0100
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
Message-ID: <20180620075809.GA23168@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-6-quentin.perret@arm.com>
 <20180619122632.GS2458@hirez.programming.kicks-ass.net>
 <20180619132449.GA17720@e108498-lin.cambridge.arm.com>
 <20180619162042.GT2458@hirez.programming.kicks-ass.net>
 <20180619171316.GB29374@e108498-lin.cambridge.arm.com>
 <20180619184250.GF2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619184250.GF2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 Jun 2018 at 20:42:50 (+0200), Peter Zijlstra wrote:
> On Tue, Jun 19, 2018 at 06:13:17PM +0100, Quentin Perret wrote:
> > Would replacing the static_key by a flag attached to the root_domain be
> > reasonable ? 
> 
> Keep the static key as is, enable if any root domain needs it.

OK. So basically the semantics of the static key becomes: it is set if
at least one root domain has a non-empty list of freq domains. And a
root_domain has a non-empty list of frequency domains if it meets all
conditions for EAS (SD_ASYM_CPUCAPACITY flag set, low complexity for
the "portion" of the EM covering it, ...)

And then, checking the status of the list (empty or not) for a specific
root domain can replace my flag I guess. I'll need to check that somewhere
around select_task_rq_fair() in addition to the check on the static key to
decide if a task can go in find_energy_efficient_cpu().

> > Sorry but I didn't understand that ...
> 
> If you have only a single freq-domain, there is nothing to do, right?

Ah, right. Since we already agreed that all CPUs in a freq domain must
have the same micro-arch, that's correct. Checking the presence of the
SD_ASYM_CPUCAPACITY flag should cover this case I guess.

Thanks,
Quentin
