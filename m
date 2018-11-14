Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C06EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA67A22419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="K2fX5J/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA67A22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732504AbeKOEQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 23:16:12 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:46752 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732174AbeKOEQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 23:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dkb/D3nsMkqgWOsV5xGiPB0z8f8Jz/J47vJk6oP1P4c=; b=K2fX5J/36d/olS2mhAQYOvAhx
        GlnW2DxBhwpR805jdk3LdrqQVYkHzB77PtPAcq1BMmoAJ7EJUQnnJ5zwvHy+P3eBT9eej73r5P+tZ
        RgrTm8/OS4OvErqJCCO+eM9EqJ657o5cm2ZiTbGgKUTLJAMoymlQFIGRAG93ojs12Hxms=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:33918)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gMzdd-0006if-9a; Wed, 14 Nov 2018 18:11:41 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gMzdZ-0001d6-PG; Wed, 14 Nov 2018 18:11:37 +0000
Date:   Wed, 14 Nov 2018 18:11:35 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Theodore Tso <tytso@mit.edu>
Subject: Re: [RFC PATCH 01/13] arm: Fix mutual exclusion in arch_gettimeoffset
Message-ID: <20181114181135.GU30658@n2100.armlinux.org.uk>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
 <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au>
 <20181112083422.GA19695@infradead.org>
 <alpine.LNX.2.21.1811131420150.362@nippy.intranet>
 <20181113092012.GI30658@n2100.armlinux.org.uk>
 <alpine.LNX.2.21.1811140854280.371@nippy.intranet>
 <20181113234336.GP30658@n2100.armlinux.org.uk>
 <alpine.LNX.2.21.1811141142490.8@nippy.intranet>
 <20181114141632.GT30658@n2100.armlinux.org.uk>
 <CAMuHMdWwknYYEYpU4ogVAbpWtrF9aG=4vrh505dM2Btp8KjKMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWwknYYEYpU4ogVAbpWtrF9aG=4vrh505dM2Btp8KjKMg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 03:58:36PM +0100, Geert Uytterhoeven wrote:
> Hi Russell,
> 
> On Wed, Nov 14, 2018 at 3:16 PM Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > On Wed, Nov 14, 2018 at 02:17:09PM +1100, Finn Thain wrote:
> > > So, even assuming that you're right about the limitations of single-timer
> > > platforms in general, removal of arch_gettimeoffset wouldn't require the
> > > removal of any platforms, AFAICT.
> >
> > I haven't proposed removing platforms.
> >
> > I'm just objecting to the idea of removing arch_gettimeoffset(),
> > thereby causing a regression by changing the resolution of
> > gettimeofday() without any sign of equivalent functionality.
> >
> > However, I now see (having searched mailing lists) what you are
> > trying to do - you have _not_ copied me or the mailing lists I'm
> > on with your cover message, so I'm *totally* lacking in the context
> > of your patch series, particularly where you are converting m68k
> > to use clocksources without needing the gettimeoffset() stuff.
> >
> > You have failed to explain that in this thread - probably assuming
> > that I've read your cover message.  I haven't until now, because
> > you never sent it to me or the linux-arm-kernel mailing list.
> >
> > I have found this thread _very_ frustrating, and frankly a waste of
> > my time discussing the finer points because of this lack of context.
> > Please ensure that if you're going to be sending a patch series,
> > that the cover message at least finds its way to the intended
> > audience of your patches, so that everyone has the context they
> > need when looking at (eg) the single patch they may receive.
> >
> > Alternatively, if someone raises a problem with the patch, and you
> > _know_ you haven't done that, then please consider informing them
> > where they can get more context, eg, by providing a link to your
> > archived cover message.  It would help avoid misunderstandings.
> 
> Sorry for the lack of context.
> The real trigger was also not explained in the cover message, and was a
> the threat to remove platforms not using modern timekeeping APIs, cfr.
>  "Removing support for old hardware from the kernel"
> (https://lwn.net/Articles/769468/).

And naturally, because kernel developers are oh so great at
communication, that decision has been communicated to those
affected by it. *NOT*.

Clearly there is a need for much better communication.  We're
better at it when dealing with patches, but not when it comes to
physical meetings.

Maybe when some decision like "we're going to kill stuff still
using the old gettimeoffset API" then _someone_ needs to identify
which platforms are using that and make sure that those maintainers
know about that decision, much the same way that if a patch were
to touch the gettimeoffset API, we'd make damn sure that such a
patch went to those affected by the change.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
