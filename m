Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9A6C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E33244D0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E33244D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933849AbeFVPaZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:30:25 -0400
Received: from foss.arm.com ([217.140.101.70]:36946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933304AbeFVPaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:30:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DE6780D;
        Fri, 22 Jun 2018 08:30:24 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1432F3F557;
        Fri, 22 Jun 2018 08:30:21 -0700 (PDT)
Date:   Fri, 22 Jun 2018 16:30:17 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, patrick.bellasi@arm.com,
        joel@joelfernandes.org, daniel.lezcano@linaro.org,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v6 04/11] cpufreq/schedutil: use rt utilization tracking
Message-ID: <20180622153016.GA29031@e108498-lin.cambridge.arm.com>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-5-git-send-email-vincent.guittot@linaro.org>
 <20180621184524.GB27616@hirez.programming.kicks-ass.net>
 <20180622075853.GC23168@e108498-lin.cambridge.arm.com>
 <20180622113713.GJ2494@hirez.programming.kicks-ass.net>
 <20180622152258.GF2512@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622152258.GF2512@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 Jun 2018 at 17:22:58 (+0200), Peter Zijlstra wrote:
> On Fri, Jun 22, 2018 at 01:37:13PM +0200, Peter Zijlstra wrote:
> > That is true.. So we could limit the scaling to the case where there is
> > no idle time, something like:
> > 
> > 	util = sg_cpu->util_cfs;
> > 
> > 	cap_cfs = (1024 - (sg_cpu->util_rt + ...));
> > 	if (util == cap_cfs)
> > 		util = sg_cpu->max;
> > 
> 
> OK, it appears this is more or less what the patches do. And I think
> there's a small risk/hole with this where util ~= cap_cfs but very close
> due to some unaccounted time.

So Vincent suggested at some point to add a margin to avoid that issue
IIRC. FWIW, this is what the overutilized flag of EAS does. It basically
says, if there isn't enough idle time in the system (cfs_util is too close
to cap_cfs), don't bother looking at the util signals because they'll be
kinda wrong.

So what about something like, go to max freq if overutilized ? Or
something similar on a per cpufreq policy basis ?

Thanks,
Quentin
