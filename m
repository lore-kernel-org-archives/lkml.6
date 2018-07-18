Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89796ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5432084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5432084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbeGRJTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 05:19:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57434 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbeGRJTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 05:19:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A214D7A9;
        Wed, 18 Jul 2018 01:42:23 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.210.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4E0F3F589;
        Wed, 18 Jul 2018 01:42:20 -0700 (PDT)
Date:   Wed, 18 Jul 2018 09:42:18 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v2 01/12] sched/core: uclamp: extend sched_setattr to
 support utilization clamping
Message-ID: <20180718084218.GI32302@e110439-lin>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-2-patrick.bellasi@arm.com>
 <20180717175025.GA150378@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717175025.GA150378@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-Jul 10:50, Joel Fernandes wrote:
> On Mon, Jul 16, 2018 at 09:28:55AM +0100, Patrick Bellasi wrote:

[...]

> > diff --git a/init/Kconfig b/init/Kconfig
> > index 041f3a022122..1d45a6877d6f 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -583,6 +583,25 @@ config HAVE_UNSTABLE_SCHED_CLOCK
> >  config GENERIC_SCHED_CLOCK
> >  	bool
> >  
> > +menu "Scheduler features"
> > +
> > +config UCLAMP_TASK
> > +	bool "Enable utilization clamping for RT/FAIR tasks"
> > +	depends on CPU_FREQ_GOV_SCHEDUTIL
> 
> Does it make sense to depend on this? One could turn off schedutil and then
> uclamp can't be used for any other purpose (big.LITTLE task placement etc)?

You right, utilization clamping is _going_ to target tasks placement.
But, the support currently posted in this series is just for OPP
biasing. Thus, it would not make sense to enabled it when schedutil
is not available.

My idea was to keep this dependency while we finalize these bits.
Once we move on to the tasks placement biasing, we will remove this
dependency too.

Does that makes sense?

> thanks,
> 
> - Joel

-- 
#include <best/regards.h>

Patrick Bellasi
