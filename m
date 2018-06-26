Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C62C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E131025D0A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E131025D0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964970AbeFZK3e (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:29:34 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:43525 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934634AbeFZK32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:29:28 -0400
Received: by mail-vk0-f66.google.com with SMTP id d74-v6so9686577vke.10;
        Tue, 26 Jun 2018 03:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i2hLIlgvKme6H1UR/dw3XZsn733zYMkEhILBxZJH/sk=;
        b=Om6ECu7yUaSy7tBr9EUqsTk6avCCiSKVwmSRQWOj05MWCZI5wNvDvRHdgcjGmHQZCW
         ZovVB2CFEfOabgpstbGGGuBpiO9Td/RYqMdecD8+cZXDEyMhNPCcRQZv7F8lHbr4Hw1T
         i19/mTLZJAcup+GTekpuKWfiiu72T6M4FUAO/amp/cETJUXqgfGjOWvUjmIXEODbouhY
         Yxz5UOxklUMTfswT2491WfucBc4Iqn7KFx2sIPjx6RnTgiLVizUoYCIrR2alGRHz6HCp
         lWoLH6WLuu5Z2byzgCsi2oizDDrb1Q3neJv/upyd2mC0HlMwB/xVbC8gU7F7L7L/na9Y
         zk5w==
X-Gm-Message-State: APt69E2zsn1rTFc5JCrIzOcvAjCzeEAKF5neOPu9b3iTx76L7fUHMdIs
        7+Imj4AcF5QvvPzxew2Wt6+HPdNXZN614caunTg=
X-Google-Smtp-Source: AAOMgpdMUlsytNLp8ccVkNPW0jAzs7IUZO7Z1t3LypULeXQMGAMoprbsISz2fhaK9hjJzUZLiXcHr+Di6r+zBFyRm+k=
X-Received: by 2002:a1f:1e10:: with SMTP id e16-v6mr512608vke.176.1530008967687;
 Tue, 26 Jun 2018 03:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180619135518.8990-1-geert+renesas@glider.be>
 <20180620132507.GE6242@sirena.org.uk> <CAMuHMdXYL+=mBOofUqQ06Ld4zUF7BWqt+S2dFTw6AEAPuDsZPQ@mail.gmail.com>
 <1705903.rOAenNWc8f@aspire.rjw.lan>
In-Reply-To: <1705903.rOAenNWc8f@aspire.rjw.lan>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 26 Jun 2018 12:29:16 +0200
Message-ID: <CAMuHMdUYtao4fgQUwBArZG1y+yfbwHE0SHuM6v2NGnhY7GSjkA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PM / wakeup: Add callback for wake-up change notification
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Tue, Jun 26, 2018 at 12:17 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, June 26, 2018 12:06:16 PM CEST Geert Uytterhoeven wrote:
> > On Wed, Jun 20, 2018 at 3:25 PM Mark Brown <broonie@kernel.org> wrote:
> > > On Wed, Jun 20, 2018 at 02:15:38PM +0200, Rafael J. Wysocki wrote:
> > > > On Wed, Jun 20, 2018 at 12:35 PM, Mark Brown <broonie@kernel.org> wrote:
> > >
> > > > > The flip side of that is that either suspend and resume or poweroff are
> > > > > broken for userspace unless they know about this magic sysfs file which
> > > > > isn't great either.
> > >
> > > > But to me that isn't that much different from an RTC wake alarm, say.
> > >
> > > > Enabling it to wake up the system in general isn't sufficient, you
> > > > also need to actually set the alarm using a different interface.
> >
> > The RTC wake alarm time is indeed different, as it is not a simple boolean flag.
> > It is also more natural for the user, who expects to need to find some way to
> > configure the wake-up time.
>
> OK, take Ethernet.  You need to configure WoL on that to wake up the system
> in addition to setting power/wakeup for it.
>
> Take WiFi: You need to set up WoW on that.
>
> And so on.

I always found it strange that you have both "ethtool wol" and and a
"wakeup" file
in sysfs (does "ethtool wol" predate the wakeup file in sysfs?)

I believe originally WoL supported MagicPacket only (many systems still
support only that), so originally it was boolean.

> > > It seems more like hardware breakage we're trying to fix than a feature
> > > - it's not like it's adding something we didn't have already (like
> > > setting a time in an alarm where the alarm is an additional thing), more
> > > just trying to execute on an existing user interface successfully.  I
> > > can see that there's a case that it doesn't map very well onto the
> > > standard interfaces so perhaps we have to add something on the side as
> > > the hardware is just too horrible to fit in with the standard interfaces
> > > and we have to do that.
> >
> > My main worry is usability: with a separate sysfs file, we need to document the
> > file, and the user needs to be aware of it.
>
> That's right, but it will be very hard to convince me that changing the
> meaning of the "wakeup" attribute just in order to work around this issue
> (which arguably is a consequence of "unfortunate" hardware design) is a
> good idea. :-)

OK.

Next question: where to document device-specific sysfs files for regulators?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
