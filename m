Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40821C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0B423CD9
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0B423CD9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933079AbeGFNkK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:40:10 -0400
Received: from foss.arm.com ([217.140.101.70]:37014 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753533AbeGFNkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:40:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B9EAED1;
        Fri,  6 Jul 2018 06:40:09 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38BD13F5AD;
        Fri,  6 Jul 2018 06:40:05 -0700 (PDT)
Date:   Fri, 6 Jul 2018 14:40:03 +0100
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
Subject: Re: [RFC PATCH v4 08/12] sched: Add over-utilization/tipping point
 indicator
Message-ID: <20180706134003.GB17577@e108498-lin.cambridge.arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-9-quentin.perret@arm.com>
 <20180706113208.GS2458@hirez.programming.kicks-ass.net>
 <20180706132056.GA17577@e108498-lin.cambridge.arm.com>
 <20180706132428.GY2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706132428.GY2476@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 Jul 2018 at 15:24:28 (+0200), Peter Zijlstra wrote:
> On Fri, Jul 06, 2018 at 02:20:57PM +0100, Quentin Perret wrote:
> > So, what we try to do here is to _not_ set the overutilized flag based
> > on the utilization of a new task, because its utilization is 'wrong'.
> > That should help avoiding spurious transitions above the overutilized
> > threshold.
> 
> That most certainly deserves a comment,

Ok, will do.

> also didn't util_est fix some of that wrong-ness?

When a new task is enqueued, we don't have util_est samples yet, so the
task's util_est is equal to its util_avg. So util_est won't help here,
unfortunately.

But it does help in the wake-up path to predict what OPP will be
selected (see cpu_util_next() in patch 09/12).

Thanks,
Quentin
