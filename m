Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D20C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC302250F
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC302250F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731181AbeKNIdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 03:33:35 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:40340 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeKNIdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 03:33:35 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 6611329EE8;
        Tue, 13 Nov 2018 17:33:15 -0500 (EST)
Date:   Wed, 14 Nov 2018 09:33:42 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 13/13] m68k: mvme16x: Convert to clocksource APIy
In-Reply-To: <alpine.DEB.2.21.1811131407120.2697@nanos.tec.linutronix.de>
Message-ID: <alpine.LNX.2.21.1811140925270.371@nippy.intranet>
References: <cover.1541995959.git.fthain@telegraphics.com.au> <2f4015ba435f6f06b874295d2a47319875474c7f.1541995959.git.fthain@telegraphics.com.au> <alpine.DEB.2.21.1811121001140.14703@nanos.tec.linutronix.de> <alpine.LNX.2.21.1811130826260.356@nippy.intranet>
 <alpine.LNX.2.21.1811132137180.371@nippy.intranet> <alpine.DEB.2.21.1811131407120.2697@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018, Thomas Gleixner wrote:

> On Wed, 14 Nov 2018, Finn Thain wrote:
> > 
> > What I mean by that is, the interrupt level (IPL) prevents interrupt 
> > handlers from being re-entered. But a handler can still get 
> > interrupted by a higher priority interrupt request. In the past I've 
> > had to add defensive locking because of this.
> > 
> > In these patches I've assumed it was possible for some higher priority 
> > interrupt handler to perform a clocksource read after the timer 
> > handler started executing. Hence the use of local_irq_save/restore.
> > 
> > To be sure, I've just run a quick test and confirmed that the timer 
> > handler can indeed get interrupted by the ethernet interrupt handler.
> 
> Urgh. Then you have more serious trouble. If the interrupting handler 
> calls any of the time accessor functions then you can actually live lock 
> when the interrupt happens in the middle of the write locked section of 
> the core timekeeping update.

Does this apply to arch_gettimeoffset also? If so, that would mean another 
bug fix patch for -stable...

> So you really want to disable interrupts across the whole timer 
> interrupt function or make sure that the timer interrupt is the highest 
> priority one on the system.
> 

The timer interrupt priority isn't always what one would hope. 

But I can certainly disable interrupts for timer_interrupt() execution 
(that is, xtime_update() etc.)

-- 

> Thanks,
> 
> 	tglx
> 
