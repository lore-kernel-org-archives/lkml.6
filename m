Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC32C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940F121534
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W+LiJ16g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940F121534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbeHTNax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 09:30:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60338 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbeHTNar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 09:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HlgGqQd8rrRih2iUPbPr8OfpjSF3Nn4X8SPt6QHuUIk=; b=W+LiJ16gUT1x3rCXQLAaCKq2Y
        KecSZTPw+yq6MzkPxCxQInwXlqjjYqA2anfF5TYGHLZvGajT3xNf5UpKoL/4xs+/ZxkSQhR74nnXg
        5cbWjcfHKgj+a/d2zuI0XaVpsHN4ZKClyNWvl1bpjX07LuDjTeIbUY2ZAf4S+VKX4/FFp6GO+GR6B
        6Ayg710zk7AlP0QjgRr+HBJpjyXIyvNHmVj4zavDOK4h47oF/AQDhSJ7iSFnEtSsiPDuwAo5DXIl+
        EYRpLiSafMSY5cRJV9FXjY5xQK1kz9Glze/3eUAbww0tuH2V2guHjJz9Bjx++bSYMGRQAvQUKgByS
        UqmTAuyjA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1frhDr-0008R2-Hj; Mon, 20 Aug 2018 10:15:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AD2AE20267B13; Mon, 20 Aug 2018 12:15:41 +0200 (CEST)
Date:   Mon, 20 Aug 2018 12:15:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     leo.yan@linaro.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] cpuidle: menu: Handle stopped tick more aggressively
Message-ID: <20180820101541.GW2494@hirez.programming.kicks-ass.net>
References: <1951009.1jlQfyrxio@aspire.rjw.lan>
 <3174357.2tBMdxG3bF@aspire.rjw.lan>
 <1754612.IcCR94pSYR@aspire.rjw.lan>
 <20180812145515.GB28966@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180812145515.GB28966@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 12, 2018 at 10:55:15PM +0800, leo.yan@linaro.org wrote:
> The first one issue is caused by timer cancel, I wrote one case for
> CPU_0 starting a hrtimer with pinned mode with short expire time and
> when the CPU_0 goes to sleep this short timeout timer can let idle
> governor selects a shallow state; at the meantime another CPU_1 will
> be used to try to cancel the timer, my purpose is to cheat CPU_0 so can
> see the CPU_0 staying in shallow state for long time;  it has low
> percentage to cancel the timer successfully, but I do see seldomly the
> timer can be canceled successfully so CPU_0 will stay in idle for long
> time (I cannot explain why the timer cannot be canceled successfully
> for every time, this might be another issue?).  This case is tricky,
> but it's possible happen in drivers with timer cancel.

So this is really difficuly to make hapen I think; you first need the
CPU to go deep idle, such that it disabled the tick. Then you have to
start the hrtimer there (using an IPI I suppose) which will then force
the governor to pick a shallow idle state, and then you have to cancel
the timer before it gets triggered.

And then, if the CPU stays perfectly idle, it will be stuck in that
shallow state... forever more.

_However_ IIRC when we (remotely) cancel an hrtimer, we do not in fact
reprogram the timer hardware. So the timer _will_ trigger.
hrtimer_interrupt() will observe nothing to do and reprogram the
hardware for the next timer (if there is one).

This should be enough to cycle through the idle loop and re-select an
idle state and avoid this whole problem.

If that is not happening, then something is busted and we need to figure
out what.
