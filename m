Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABBEC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94D1214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i9dsZapQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A94D1214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbeISOyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:54:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40754 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbeISOyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yjs+vEYNUzWymhgp9p5owv/BCDePyj1k02b3o7j27QU=; b=i9dsZapQayGpJjgZ51fcR0Hlt
        U9KemDx+T200Z/46qdNJbi0yRdfat/tf7D5nLrVWnduOw6bXNKm8TtW1XDzXFkzELMuI6DtP/vAjc
        f1/OCXBb/HVHc1dmwFsrFP9uWYqUA+KOfjHTOKEoFUvv6X1jP88FjRIrGZxhPrSQuKQdrRH29LImC
        6rgGAUHE9rFGQPuBBfZCNGVKZtgS83XBzOH/lph8e/450lzD49gKE/SzCMVW4wrqUWo6T3VKa/kno
        uO1CfWKYVxPZqrqv2iaSGCM1fxRTQa2jjD14fYk27UDVUb/FZxVT0BVvw9+UtPWJcF4SvSr9t3Y9A
        vfnSRv1vg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2Yc4-0005PE-ND; Wed, 19 Sep 2018 09:17:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 994C8202C1A33; Wed, 19 Sep 2018 11:17:31 +0200 (CEST)
Date:   Wed, 19 Sep 2018 11:17:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Waiman Long <longman@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2] clocksource: Warn if too many missing ticks are
 detected
Message-ID: <20180919091731.GY24124@hirez.programming.kicks-ass.net>
References: <1537319979-6139-1-git-send-email-longman@redhat.com>
 <alpine.DEB.2.21.1809190948470.1468@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809190948470.1468@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 09:53:47AM +0200, Thomas Gleixner wrote:
> On Tue, 18 Sep 2018, Waiman Long wrote:
> 
> > The clocksource watchdog, when running, is scheduled on all the CPUs in
> > the system sequentially on a round-robin fashion with a period of 0.5s.
> > A bug in the 4.18 kernel is causing missing ticks when nohz_full
> > is specified. Under some circumstances, this causes the watchdog to
> > incorrectly state that the TSC is unstable because of counter overflow
> > in the hpet watchdog clock source after a few minutes delay.
> > 
> > That particular bug is fixed by the 4.19 commit 7059b36636beab ("sched:
> > idle: Avoid retaining the tick when it has been stopped"). To make it
> > easier to catch this kind of bug in the future, a check is added to see
> > if there is too much delay in the invocation of the watchdog callback
> > and print a warning once if it happens.
> 
> Second thoughts on this. Putting the check into the clocksource watchdog is
> the wrong place as it's just checking at a place where the symptom
> shows. What about putting it right to the source, i.e. in the timer wheel
> as it does not depend on the clocksource watchdog being active. The
> clocksource watchdog triggering is just one of the symptoms, but in general
> timers being massively late is not a good thing.

Just make sure to think of the virt case; virt can cause all kind of
'fun' lateness.
