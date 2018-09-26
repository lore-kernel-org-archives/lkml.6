Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB38C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608F5214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y6TA1E99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 608F5214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbeIZTaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:30:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48564 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeIZTaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+QpZr3jLndJIAU82gK4SkmFYKmBqJyzqdlfEiHRWmyA=; b=Y6TA1E99Vcj5bhhmI3/iZ1aP4
        ssYIGkR6ZFVd4i2LHuGqx6pH74k+fClsjOzDfyrRjor1Vp6gUFQv77vE27vV+7lYqY45kEWI/585j
        AUsFfGpwrK07C9b3dxyqnl5JqOM85uRSAAd2jMk1UWqPf2yZxpoxzd2l9yyTnmlBEsPY1/cLRCwn2
        wpFwOY94JNmbyV720sU2JPJPfyeaFbaqy+aDdszyOXo3yD1oy239mXF/yz7oDmhAqCqIggeUED7zp
        0TkMj/3JQSPBEyKL3mvbmjWuDHRfOeKMFBKaRih45cQMCpyeW6tqZT3biIIYAExMiXRTH82S3dgLH
        Wj+NNuWRQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g59h6-00086z-7v; Wed, 26 Sep 2018 13:17:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6CFDB206F1806; Wed, 26 Sep 2018 15:17:24 +0200 (CEST)
Date:   Wed, 26 Sep 2018 15:17:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>
Subject: Re: [PATCH] sched/fair: Don't increase sd->balance_interval on
 newidle balance
Message-ID: <20180926131724.GB2512@hirez.programming.kicks-ass.net>
References: <1537896922-8508-1-git-send-email-valentin.schneider@arm.com>
 <CAKfTPtB-UiXx39XZeJ0FNeYOU-pLFbY1u7vgbo584MNHSnpr=w@mail.gmail.com>
 <9209a9ec-72b4-17d7-6596-71b55767a9aa@arm.com>
 <CAKfTPtAUUcwPThggDMfQ1k7z4kguTwrLVEFKnkMqszs9nTri=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAUUcwPThggDMfQ1k7z4kguTwrLVEFKnkMqszs9nTri=g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 12:33:25PM +0200, Vincent Guittot wrote:
> On Wed, 26 Sep 2018 at 11:35, Valentin Schneider

> > library I use) has some phase where it spawns at lot of tasks at once to do
> > some setup (busybox, shutils, bash...). Some of those tasks are pinned to a
> > particular CPU, and that can lead to failed load_balance() - and to make things
> > worse, there's a lot of idle_balance() in there.
> >
> > Eventually when I start running my actual workload a few ~100ms later, it's
> > impacted by that balance_interval increase.
> >
> > Admittedly that's a specific use-case, but I don't think this quick increase
> > is something that was intended.
> 
> Yes, this really sounds like a specific use-case. Unluckily you find a
> way to reach max interval quite easily/every time with your test
> set-up but keep in mind that this can also happen in real system life
> and without using the newly idle path.
> So if it's a problem to have a interval at max value for your unitary
> test, it probably means that it's a problem for the system and the max
> value is too high
> 
> Taking advantage of all load_balance event to update the interval
> makes sense to me. It seems that you care about a short and regular
> balance interval more that minimizing overhead of load balancing.
> At the opposite, i'm sure that you don't complain if newly idle load
> balance resets the interval to min value and overwrite what the
> periodic load balance set up previously :-)

Well, we've excluded newidle balance from updating such stats before. So
in that respect the patch proposed by Valentin isn't weird.

Consider for example:

  58b26c4c0257 ("sched: Increment cache_nice_tries only on periodic lb")

In general I think it makes perfect sense to exclude newidle balance
from such stats; you get much more stable results from the regular
balance.
