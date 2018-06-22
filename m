Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CEBC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AF924305
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LQY0CrwC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0AF924305
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753025AbeFVNwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 09:52:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46922 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751325AbeFVNwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 09:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=v+fo7KDGTBf0rg9mX3Qpo2v7hoYSkOCJi6OzfARcnVE=; b=LQY0CrwCvuI8duoD2Nq250aNn
        AsIM8xr8yTWLiPEZ2akUmZMr4flpQWEimGTWjSMHJncU3+Plpx2Eh5sfYkMGpJ6CCf+vV/kHRE7eX
        Z6U7eGC9a2lxKAxwW6fJyw7t01ftM3JXHGsnvJQD4/cIrmH8+Yp4avAWxI7bhs/xLifi5wx9ynyXh
        u61oPOfhnkWw/xMHpNZoisuQvwYOSK2TxgXVU+PUv//0/IkyxB2ZMMv0rt/2f9iqsQxsW/CDJGrAE
        C+xLzn3mQxcMvA3mUGDqlbiJnc6/JMKKsUzz9Z6ve2d5iRznNjISRJvmlsCiLvirJW+6hKT8lTDU3
        Hpjr3u7JA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWMTs-0000U1-CT; Fri, 22 Jun 2018 13:52:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C07B12029F1DB; Fri, 22 Jun 2018 15:52:02 +0200 (CEST)
Date:   Fri, 22 Jun 2018 15:52:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Quentin Perret <quentin.perret@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v6 04/11] cpufreq/schedutil: use rt utilization tracking
Message-ID: <20180622135202.GD2512@hirez.programming.kicks-ass.net>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-5-git-send-email-vincent.guittot@linaro.org>
 <20180621184524.GB27616@hirez.programming.kicks-ass.net>
 <20180622075853.GC23168@e108498-lin.cambridge.arm.com>
 <20180622113713.GJ2494@hirez.programming.kicks-ass.net>
 <CAKfTPtC5HLD=3W-w0XgwMrzhLfgE8onE4RmGTXyCWx6F=-uVhw@mail.gmail.com>
 <20180622132624.GL2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622132624.GL2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 03:26:24PM +0200, Peter Zijlstra wrote:
> > But this also means that we will start to inflate the utilization to
> > get higher OPP even if there is idle time and lost the interest of
> > using dl bw
> 
> You get _some_ inflation, but only if there is actual cfs utilization to
> begin with.

Note that at high idle time, the inflation really is minimal:

f(.2,.2,2)
.20312500000000000000

