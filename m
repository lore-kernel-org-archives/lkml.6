Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86973C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59193218AF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BDYgeDLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388303AbfAKTYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:24:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47840 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfAKTYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:24:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VVHl2OHEU8GiPDuesfQLBCYJU4vhigiBNrQGC1KfSPQ=; b=BDYgeDLzvJIV+MC5/6Ss7yn4U
        s7SJfZWy9BOwQ0b/mud9dw3g56hUKU8w7D7HmwoFezivnnCGlNJz8zOZQHRL4GEed7YU1Pg1v7L7j
        6H8BySzoMiJTpegkZ/wwNUoDoma3jchENr1EqjMXvG4zT/C+tQVG9rvUWkmQ39VGhNm4LQrK52bS1
        O3AxhC84iBCK0RPWEPCkthsGL+CtauVRC5dAUuBdy8h+JCKAXuLxqO87rxwt9jrKAevxxQupGFGyv
        ZyHMaVQoeSLqQEJavLSJqMg8kB9/LB9W01Ebjp0hpKcx+zkY0zkqD9p9tkz/wH9UXraLdXX95xKFV
        atHGh9fsw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gi2PO-0003Mo-H5; Fri, 11 Jan 2019 19:23:58 +0000
Date:   Fri, 11 Jan 2019 11:23:58 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 4/4] /proc/stat: Call kstat_irqs_usr() only for active
 IRQs
Message-ID: <20190111192357.GK6310@bombadil.infradead.org>
References: <1547061648-16080-1-git-send-email-longman@redhat.com>
 <1547061648-16080-5-git-send-email-longman@redhat.com>
 <alpine.DEB.2.21.1901111750280.4957@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901112017000.1661@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1901112017000.1661@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 08:19:33PM +0100, Thomas Gleixner wrote:
> On Fri, 11 Jan 2019, Thomas Gleixner wrote:
> > --- a/kernel/irq/internals.h
> > +++ b/kernel/irq/internals.h
> > @@ -246,6 +246,7 @@ static inline void kstat_incr_irqs_this_
> >  {
> >  	__this_cpu_inc(*desc->kstat_irqs);
> >  	__this_cpu_inc(kstat.irqs_sum);
> > +	desc->tot_count++;
> 
> There is one issue here. True percpu interrupts, like the timer interrupts
> on ARM(64), will access that in parallel. But that's not rocket science to
> fix.

I was wondering about that from an efficiency point of view.  Since
interrupts are generally targetted to a single CPU, there's no cacheline
bouncing to speak of, except for interrupts like TLB shootdown on x86.
It might make sense for the percpu interrupts to still sum them at read
time, and not sum them at interrupt time.
