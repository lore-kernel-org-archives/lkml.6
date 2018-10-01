Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AF7C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2215C213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2215C213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbeJAWaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:30:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36470 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbeJAWaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:30:55 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4B70520717; Mon,  1 Oct 2018 17:52:26 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1D1782073D;
        Mon,  1 Oct 2018 17:52:16 +0200 (CEST)
Date:   Mon, 1 Oct 2018 17:52:17 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Romain Izard <romain.izard.pro@gmail.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-watchdog@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] watchdog: sama5d4: write the mode register in two
 steps
Message-ID: <20181001155217.GE2967@piout.net>
References: <20180914101339.7382-1-romain.izard.pro@gmail.com>
 <20180914101339.7382-3-romain.izard.pro@gmail.com>
 <20180914102732.GP14988@piout.net>
 <CAGkQfmPydsn6cH2pHQ9HQeGQo0J4qJ9vXjkQD+_W5iyz---KEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGkQfmPydsn6cH2pHQ9HQeGQo0J4qJ9vXjkQD+_W5iyz---KEA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/2018 15:58:45+0200, Romain Izard wrote:
> 2018-09-14 12:27 GMT+02:00 Alexandre Belloni <alexandre.belloni@bootlin.com>:
> > On 14/09/2018 12:13:39+0200, Romain Izard wrote:
> >> The specification for SAMA5D2 and SAMA5D4 chips, that use this IP for
> >> their watchdog timer, has the following advice regarding the Mode Register:
> >>
> >> "When setting the WDDIS bit, and while it is set, the fields WDV and WDD
> >> must not be modified."
> >>
> >> I have observed on a board based on a SAMA5D2 chip that using any other
> >> timeout duration than the default 16s in the device tree will reset the
> >> board when the watchdog device is opened; this is probably due to ignoring
> >> the aforementioned constraint.
> >>
> >> To fix this, read the content of the Mode Register before writing it,
> >> and split the access into two parts if WDV or WDD need to be changed.
> >>
> >
> > Hum, that is really weird because when I developed
> > 015b528644a84b0018d3286ecd6ea5f82dce0180, I tested with a program doing:
> >
> >         flags = WDIOS_DISABLECARD;
> >         ioctl(fd, WDIOC_SETOPTIONS, &flags);
> >         for (i = 16; i > 2; i--) {
> >                 ioctl(fd, WDIOC_SETTIMEOUT, &i);
> >         }
> >
> >         ioctl(fd, WDIOC_KEEPALIVE, &dummy);
> >
> >         flags = WDIOS_ENABLECARD;
> >         ioctl(fd, WDIOC_SETOPTIONS, &flags);
> >
> >         for (i = 16; i > 2; i--) {
> >                 ioctl(fd, WDIOC_SETTIMEOUT, &i);
> >         }
> >
> > This would immediately reproduce the reset when changing WDV/WDD with
> > WDDIS set.
> >
> > I'll test again.
> >
> 
> The issue is visible when setting a custom value for the timeout on startup.
> In the past it was only possible to do so with a module parameter, and the
> previous patch in the series makes it possible to do with the device tree.
> 
> When using the Linux4SAM 5.7 release, it is sufficient to set the timeout on
> the command line to reproduce the issue:
> 
> In the bootloader:
> # setenv bootargs $bootargs sama5d4_wdt.wdt_timeout=10
> 
> To trigger an immediate reset (with some code that should work):
> # (echo 1; while sleep 3; do echo 1; done) > /dev/watchdog
> 

Ok, I've tested and seen the issue. I agree with Guenter that it is
probably worth having a function to update MR that takes the timeout
value and whether the watchdog needs to be enabled. It would probably
make caching mr unnecessary.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
