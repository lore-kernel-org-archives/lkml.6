Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E768C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D07524242
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D07524242
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753941AbeFVMym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:54:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34808 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751198AbeFVMyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:54:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D6987A9;
        Fri, 22 Jun 2018 05:54:41 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2682B3F246;
        Fri, 22 Jun 2018 05:54:39 -0700 (PDT)
Date:   Fri, 22 Jun 2018 13:54:34 +0100
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
Message-ID: <20180622125433.GA26461@e108498-lin.cambridge.arm.com>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-5-git-send-email-vincent.guittot@linaro.org>
 <20180621184524.GB27616@hirez.programming.kicks-ass.net>
 <20180622075853.GC23168@e108498-lin.cambridge.arm.com>
 <20180622113713.GJ2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622113713.GJ2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 Jun 2018 at 13:37:13 (+0200), Peter Zijlstra wrote:
> That is true.. So we could limit the scaling to the case where there is
> no idle time, something like:
> 
> 	util = sg_cpu->util_cfs;
> 
> 	cap_cfs = (1024 - (sg_cpu->util_rt + ...));
> 	if (util == cap_cfs)
> 		util = sg_cpu->max;
> 
> That specifically handles the '0% idle -> 100% freq' case, but I don't
> realy like edge behaviour like that. If for some reason it all doesn't
> quite align you're left with bits.
> 
> And the linear scaling is the next simplest thing that avoids the hard
> boundary case.

Right, so maybe we'll get something smoother by just summing the signals
as Vincent is proposing ? You will still request max freq for the
(util == cap_cfs) case you described. By definition, you will have
(util_cfs + util_rt + ...) == 1024 in this case.

cap_cfs is the delta between RT+DL+... and 1024, and the only case where
util_cfs can be equal to cap_cfs is if util_cfs fills that delta
entirely.

I hope that makes sense

Thanks,
Quentin
