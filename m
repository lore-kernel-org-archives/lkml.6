Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69C5C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F604242B9
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jYgD8EKM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F604242B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753272AbeFVNaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 09:30:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55284 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751326AbeFVNaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 09:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LT7ImzVWiBZpgym+tQ+mOnSxLR2LXR8uiW+BKlQtmtk=; b=jYgD8EKMUlBcg1ToI6foZFrdl
        PUzkTomfrFrlFdfBHWWateCDmOj8uxog8AiKRIcTq1KYFE0qoLhJgsPlTRsDKlc5pwlW0YsTRcsa0
        0q2/BPBVZIdQXb8vKBTMwLD9moTQ5i5jNl5oRYnqQNDesbSgVnAlna+xSkGtKFIEkvQP3zlSU04+g
        gCSsD0KgdFewNVTsGNhqLdwlJrNNJ3qY6BJ2z5322fMNMA8ffleJ6V6AbqQeXhdKAtgDzpm55SVQR
        ownrTl3wyXGG+lYAN0XlxaFBEc6FrRE4gtClPw8Us0a4XrhA4bh4KQb5R9lLvOhQMgGgdruIIbW9T
        QMjA9xOsw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWM8R-0005nZ-2d; Fri, 22 Jun 2018 13:29:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9219E2029F1D7; Fri, 22 Jun 2018 15:29:53 +0200 (CEST)
Date:   Fri, 22 Jun 2018 15:29:53 +0200
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
Message-ID: <20180622132953.GM2494@hirez.programming.kicks-ass.net>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-5-git-send-email-vincent.guittot@linaro.org>
 <20180621184524.GB27616@hirez.programming.kicks-ass.net>
 <20180622075853.GC23168@e108498-lin.cambridge.arm.com>
 <20180622113713.GJ2494@hirez.programming.kicks-ass.net>
 <20180622125433.GA26461@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622125433.GA26461@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 01:54:34PM +0100, Quentin Perret wrote:
> On Friday 22 Jun 2018 at 13:37:13 (+0200), Peter Zijlstra wrote:
> > That is true.. So we could limit the scaling to the case where there is
> > no idle time, something like:
> > 
> > 	util = sg_cpu->util_cfs;
> > 
> > 	cap_cfs = (1024 - (sg_cpu->util_rt + ...));
> > 	if (util == cap_cfs)
> > 		util = sg_cpu->max;
> > 
> > That specifically handles the '0% idle -> 100% freq' case, but I don't
> > realy like edge behaviour like that. If for some reason it all doesn't
> > quite align you're left with bits.
> > 
> > And the linear scaling is the next simplest thing that avoids the hard
> > boundary case.
> 
> Right, so maybe we'll get something smoother by just summing the signals
> as Vincent is proposing ? 

Sure, but see my previous mail just now, that has the problem of
u_{rt,dl} distoting f_{rt,dl} even when there is no u_cfs.

