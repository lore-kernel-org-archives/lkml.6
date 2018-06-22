Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2710C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0692414D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dx5TPQsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0692414D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751526AbeFVLha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 07:37:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43438 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbeFVLh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 07:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gb7kFF3/sDr3QKwAoQRwO7tzB2YpY7pn3SNDrL3WYuc=; b=dx5TPQsRIjiRS0gRgM7SNKcHA
        FovMfhzFOJiRMK/9lmU6k5yePETJJrNatd1KyKOGJdtFdLvjUo/jVBS4ksBS4U1yIZLFVlFSQxVux
        x24xChjrDOb5HheViH4tewH7J/EWjhFQiCWnXom4io5wzfxUMSZ1ZM3G5g62vlE71ht3EZCfcF6v6
        0u0TVKhAbtq4VwkrppnsMVXF0h51C7cLX03W6p0lRDHdVNjzz8G5p5CXva9bMUJAeKvEvektZ30En
        Wm37KbX5uZiisTEF+qN3DskM4l1xQLOyxDQ//T+6uounaFT1kgjdTdORhVMWklCnpSAg0nI0ijZi3
        i+cJaDuXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWKNQ-0006nT-7j; Fri, 22 Jun 2018 11:37:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 772292029FA0A; Fri, 22 Jun 2018 13:37:13 +0200 (CEST)
Date:   Fri, 22 Jun 2018 13:37:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, patrick.bellasi@arm.com,
        joel@joelfernandes.org, daniel.lezcano@linaro.org,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v6 04/11] cpufreq/schedutil: use rt utilization tracking
Message-ID: <20180622113713.GJ2494@hirez.programming.kicks-ass.net>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-5-git-send-email-vincent.guittot@linaro.org>
 <20180621184524.GB27616@hirez.programming.kicks-ass.net>
 <20180622075853.GC23168@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622075853.GC23168@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 08:58:53AM +0100, Quentin Perret wrote:
> Say we have 50% of the capacity stolen by RT, and a 25% CFS task
> running. If we re-scale, we'll end up with a 50% request for CFS
> (util==512 for your code above). But if we want to see a little bit
> of idle time in the system, we should really request an OPP for 75%+ of
> capacity no ? Or am I missing something ?

That is true.. So we could limit the scaling to the case where there is
no idle time, something like:

	util = sg_cpu->util_cfs;

	cap_cfs = (1024 - (sg_cpu->util_rt + ...));
	if (util == cap_cfs)
		util = sg_cpu->max;

That specifically handles the '0% idle -> 100% freq' case, but I don't
realy like edge behaviour like that. If for some reason it all doesn't
quite align you're left with bits.

And the linear scaling is the next simplest thing that avoids the hard
boundary case.

I suppose we can make it more complicated, something like:

             u           u
  f := u + (--- - u) * (---)^n
            1-r         1-r

Where: u := cfs util
       r := \Sum !cfs util
       f := frequency request

That would still satisfy all criteria I think:

  r = 0      -> f := u
  u = (1-r)  -> f := 1

and in particular:

  u << (1-r) -> f ~= u

which casuses less inflation than the linear thing where there is idle
time.

In your specific example that ends up with:

             .25           .25
  f = .25 + (--- - .25) * (---)^n = .25 + .0625 (for n=2)
             .5            .5     = .25 + .125  (for n=1)

But is that needed complexity?
