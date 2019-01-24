Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33D4C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947762184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r91mEtCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfAXPQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:16:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60378 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfAXPQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:16:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0Eg55sX6khG6Sdx8oyYbmL9ccbeDiqSqeWVq+D8pRJI=; b=r91mEtCOv2ltYMRwRGdSliw54
        iBs8RkJ6aIoWnHiSo7g8Dwt+PgKYK6X8pJNjr3GuAPxrdYNUiN2qqBX6EkOfTEgGXHhlNFmfKEpV6
        TBV4nTdNNRWdrK/EeRmx8fQE4pRdU6wemec4BcdqcSa7UVWvwrrylt/HjKjwNG1m6BhrY+GkDmde4
        IqcFs6+pchokP7rq7cufhTUHObjaP7gZ7iQYoFBqgPrdiprcMxUND3olwD4nYF0tnruk/lvD0muO0
        iFPfoRGd+ba/groHs8b9QNAElIsghMJp9JIWWTUEIy1UcUejhhHXBya2DwCTlNQLf6dVrlkEZMNft
        eHb3btg+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gmgjY-0004iR-Oh; Thu, 24 Jan 2019 15:16:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0CFB0238BB05C; Thu, 24 Jan 2019 16:15:59 +0100 (CET)
Date:   Thu, 24 Jan 2019 16:15:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v6 09/16] sched/cpufreq: uclamp: Add utilization clamping
 for RT tasks
Message-ID: <20190124151559.GP13777@hirez.programming.kicks-ass.net>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-10-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115101513.2822-10-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 10:15:06AM +0000, Patrick Bellasi wrote:
> Add uclamp_default_perf, a special set of clamp values to be used
> for tasks requiring maximum performance, i.e. by default all the non
> clamped RT tasks.

Urgh... why though?
