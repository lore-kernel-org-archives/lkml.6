Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7802DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6F7208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gZMcbWBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6F7208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934155AbeFLRfY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:35:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43154 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933076AbeFLRfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 13:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FG3ng/wIdluKsRmtbpvycaAup8uVOve30OfjFvdX5aM=; b=gZMcbWBWd2SgTb2Ukn+h92Lle
        bqH6WeAJkVU4OOyYcB30x6uByLzBz6kkhKqsKhi/3GPTjtcXlR4DTq7/ZhiKNiUme1/egS1Hwyf6i
        /t1RyWEa+rU7u9FOo+zLrqchtsAFZyuB1MkvsbX+kF+070QZIWJ4USONMEtiT1SC0axGtDnyAOKs1
        itcHJZ/EYb/Hsjqa+DK1dC8Xj7VV663FFq5uOrgeXDofYIbEOM3pFKNrgqY1JuCddSPlH+tzk7EFh
        qkSNXoeSHfMPM/t7ybgd+hVQqrezTsAfpazBU0BTS4/AmkqWACyu2Dd/s7T+h1sMYF8Yd5cY0bHzF
        q0ATYDdBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSnCO-00011t-AJ; Tue, 12 Jun 2018 17:35:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1645D201EA7A3; Tue, 12 Jun 2018 19:35:14 +0200 (CEST)
Date:   Tue, 12 Jun 2018 19:35:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     viresh.kumar@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH V6] powercap/drivers/idle_injection: Add an idle
 injection framework
Message-ID: <20180612173514.GV12217@hirez.programming.kicks-ass.net>
References: <1528804816-32636-1-git-send-email-daniel.lezcano@linaro.org>
 <20180612123036.GJ12180@hirez.programming.kicks-ass.net>
 <16d5649d-863c-10c7-9287-202568e713e6@linaro.org>
 <20180612125247.GO12217@hirez.programming.kicks-ass.net>
 <16770447-afe3-0fd7-19f9-1bd52c4c8ced@linaro.org>
 <20180612140654.GQ12217@hirez.programming.kicks-ass.net>
 <cce05d92-d51a-ab4f-83f2-37dcdee0cd6a@linaro.org>
 <20180612155841.GT12217@hirez.programming.kicks-ass.net>
 <7190a58e-05f2-216c-8b36-70692fa722bf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7190a58e-05f2-216c-8b36-70692fa722bf@linaro.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 07:02:57PM +0200, Daniel Lezcano wrote:
> Mmh, it is unclear for me if the park() vs wakeup() can happen at the
> same time.
> 
> If the park() function is called, that means the hotplug is allowed.

No, it means we're inside hot-un-plug, but that doesn't stop the hrtimer
from firing.

> If the hotplug is allowed, we can modify the online mask.
> 
> What happens with the online mask when we are processing it in an
> interrupt context ?

RCU-like, if you observe a CPU in the online mask, it will stay
available, but the bit might get cleared.

> > Maybe avoid the issue entire by having a
> > {period,idle} tuple, where your old run := period - idle.
> 
> Can you elaborate ? I don't get it.

Have a period parameter that specifies the interval in which you have
one injected idle, and specify for how long you want to inject idle;
then obviously idle < period.

> >>> Furthermore, should you not be using hrtimer_forward(&timer,
> >>> idle_duration + run_duration) instead? AFAICT the current scheme is
> >>> prone to drifting.
> >>
> >> (I assume you meant setting the timer in the wakeup task function).
> >>
> >> Yes, drifting is not an issue if that happens. This scheme is simpler
> >> and safer than setting the timer ahead before waking up the tasks with
> >> the risk it expires before all the tasks ended their idle cycles.
> > 
> > sloppy though..
> 
> Ok, do you prefer to see the timer set in the wakeup function and thus
> having a periodic tick for the idle injection ?

I think having a HRTIMER_RESTART handler that does hrtimer_forward() is
the most sensible. You will end up having to deal with threads not being
ready, but I think that's not a real problem.


