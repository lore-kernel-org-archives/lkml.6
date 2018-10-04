Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DC4C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E4621473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E4621473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeJDSvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 14:51:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35310 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbeJDSvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 14:51:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E43AE7A9;
        Thu,  4 Oct 2018 04:58:46 -0700 (PDT)
Received: from queper01-lin (queper01-lin.Emea.Arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C73793F5A0;
        Thu,  4 Oct 2018 04:58:42 -0700 (PDT)
Date:   Thu, 4 Oct 2018 12:58:41 +0100
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
Subject: Re: [PATCH v7 13/14] sched/topology: Make Energy Aware Scheduling
 depend on schedutil
Message-ID: <20181004115839.c5g2fsehszbvwoqq@queper01-lin>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-14-quentin.perret@arm.com>
 <20181004105023.GE19252@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004105023.GE19252@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 Oct 2018 at 12:50:23 (+0200), Peter Zijlstra wrote:
> On Wed, Sep 12, 2018 at 10:13:08AM +0100, Quentin Perret wrote:
> > Energy Aware Scheduling (EAS) is designed with the assumption that
> > frequencies of CPUs follow their utilization value. When using a CPUFreq
> > governor other than schedutil, the chances of this assumption being true
> > are small, if any. When schedutil is being used, EAS' predictions are at
> > least consistent with the frequency requests. Although those requests
> > have no guarantees to be honored by the hardware, they should at least
> > guide DVFS in the right direction and provide some hope in regards to the
> > EAS model being accurate.
> > 
> > To make sure EAS is only used in a sane configuration, create a strong
> > dependency on schedutil being used. Since having sugov compiled-in does
> > not provide that guarantee, make CPUFreq call a scheduler function on
> > on governor changes hence letting it rebuild the scheduling domains,
> > check the governors of the online CPUs, and enable/disable EAS
> > accordingly.
> 
> So this patch disables EAS when we change cpufreq gov. How about we
> force select schedutil and disallow changing it when EAS is enabled?
> 
> Instead of silently disabling EAS when we frob the governor?

By doing it this way I think we have a better integration with things
like that exclusive cpusets. In the end, EAS is enabled in a
per-root_domain basis. So, say you have two root domains, A and B. EAS
is enabled on A and disabled on B (because it doesn't have
SD_ASYM_CPUCAPACITY or something). Should you be forced to use sugov on
the CPUs of B to run EAS on A ? If there is a cpufreq policy covering
only the CPUs of B, I'd say probably no.

Now I get the argument that this is happening silently as-is, so we can
do better. How about we put a message in dmesg we EAS gets disabled in
case of governor changes ?

Also, I'm currently working on a doc patch for EAS ATM (to be posted
soon), so I can (and will) make it very clear there that you _must_
use sugov to use EAS.

Would that work ?

Thanks,
Quentin
