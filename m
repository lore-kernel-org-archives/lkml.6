Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D444C00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D93213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXZZ81se"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbfB0XHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 18:07:12 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34588 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729918AbfB0XHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 18:07:11 -0500
Received: by mail-pg1-f193.google.com with SMTP id i130so8702729pgd.1;
        Wed, 27 Feb 2019 15:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/eLaTVx1AZOl3KcGQIVZAHVbQYVMEUTyhL5QFT3s1tg=;
        b=KXZZ81seSb2qMsiOaOeDPZVdRKw0VjmP8z5PHvZ+NWUhGqCSH4FuLLD75865HJl/UE
         IPIEwuMpKKuPbjvVaDlT/kYwluqvk1+kl02UUHCdPAdCtTqkuHqwd9vAzeeNHnuWp0vX
         3VaAHzYFsprfYWFtCw7txCa02OELn6W63JLJh0QTMbSnjSDmehvLcaIhLyMDfMfy2UrN
         s8gl/o7Rr9kgN7kmQYvJ/fcx/0aGv2+8pgwYA8UYN9V9nJ+Ax74NXqgX+pcwdNTXvV9M
         wFpWY2hHk9vO0m1xOyJvSaAGHwKw3zcS4q1indoymxwubDPI0sfqcrYRbzY6UiOgUK51
         +7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/eLaTVx1AZOl3KcGQIVZAHVbQYVMEUTyhL5QFT3s1tg=;
        b=fXPqPiUqTSYyw/hhmT9swSqd5mgKoCaAKJ8KDkWu1ZggQ+e0WSXnQWFrfvggtNibhc
         jwpz6lJIyiW5pVVPj73Ka1LO9fbwNELBBSeWKUstFVh73Kw1koyhQDfyCbc5sRgMuuuv
         BXn0kviFmiDJ5VTcAx4DatqAWewvu9t+N9JZlY0xn9NShZPWfSNGsfvN+3rslm9dQ6ge
         XPu30/rNety04FQ8SwuBo5x3qSnNo5dEaBal4wvXKUR3Gq2pMOMe2MRtZ+tGZ1pb2Lw2
         FNzHxEXdzLqsxUTU+yJg4L2vgTBdy4BHaPL2jYFowOZIn+UNPhBtAqZBpYOkyCFXvrQV
         uFGA==
X-Gm-Message-State: AHQUAuYKIylgl/uF7xvqgjeHv5Dhie4meMPbnVW07iFAVULKs96a1979
        WqNj3pqmPup7xXnt1iJJiXioeiuj
X-Google-Smtp-Source: AHgI3IbHiE5GTh1KGSaMiiLzPAoeHfXp2sb7pMyZtsJ/fYvTB8oK22CvBA4KcAl1+AWToKmnApmNWw==
X-Received: by 2002:a63:f648:: with SMTP id u8mr5258946pgj.91.1551308830253;
        Wed, 27 Feb 2019 15:07:10 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n23sm4720388pgv.86.2019.02.27.15.07.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 15:07:08 -0800 (PST)
Date:   Wed, 27 Feb 2019 15:07:07 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "wim@iguana.be" <wim@iguana.be>,
        "gregory.clement@free-electrons.com" 
        <gregory.clement@free-electrons.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] watchdog: orion: don't enable rstout if an interrupt
 is configured
Message-ID: <20190227230707.GA28635@roeck-us.net>
References: <20171011022958.31268-1-chris.packham@alliedtelesis.co.nz>
 <20171011022958.31268-3-chris.packham@alliedtelesis.co.nz>
 <227eed69-c4c8-01a1-3c6b-6cf95e84a9cd@roeck-us.net>
 <4f82b24c3b244d3eba0f8de8cb25049f@svr-chch-ex1.atlnz.lc>
 <636717314b294a5f9a4ed1ffa44625c4@svr-chch-ex1.atlnz.lc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <636717314b294a5f9a4ed1ffa44625c4@svr-chch-ex1.atlnz.lc>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 08:59:07PM +0000, Chris Packham wrote:
> Hijacking an old thread,
> 
> On 11/10/17 5:30 PM, Chris Packham wrote:
> > On 11/10/17 16:42, Guenter Roeck wrote:
> >> On 10/10/2017 07:29 PM, Chris Packham wrote:
> >>> The orion_wdt_irq invokes panic() so we are going to reset the CPU
> >>> regardless.  By not setting this bit we get a chance to gather debug
> >>> from the panic output before the system is reset.
> >>>
> >>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> >>
> >> Unless I am missing something, this assumes that the interrupt is
> >> handled, ie that the system is not stuck with interrupts disabled.
> >> This makes the watchdog less reliable. This added verbosity comes
> >> at a significant cost. I'd like to get input from others if this
> >> is acceptable.
> >>
> >> That would be different if there was a means to configure a pretimeout,
> >> ie a means to tell the system to generate an irq first, followed by a
> >> hard reset if the interrupt is not served. that does not seem to be
> >> the case here, though.
> >>
> > 
> > As far as I can tell there is no pretimeout capability in the orion
> > /armada WDT. I have got a work-in-progress patch that enables the RSTOUT
> > in the interrupt handler which some-what mitigates your concern but
> > still requires the interrupt to be handled at least once.
> > 
> > Another option would be to use one of the spare global timers to provide
> > the interrupt-driven aspect.
> 
> So as Guenter rightly pointed out my original patch meant that we'd hang 
> if we got stuck in a loop with interrupts disabled. Shortly after that 
> that's exactly what happened on my test setup.
> 
> I've now been able to follow-up on the idea of using one of the spare 
> global timers as a pretimeout indication and it's looking pretty 
> promising. The patch is below (beware MUA wrapping). I'll submit it 
> properly but I'm wondering if I should add the timer1 based watchdog as 
> a separate watchdog device or like I have below roll it into the 
> existing watchdog device.
> 

Why not use a pretimeout ? Isn't this exactly what you are doing,
with a fixed pretimeout of timeout / 2 ?

Guenter
