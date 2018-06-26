Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0890C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6419A268C5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6419A268C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934393AbeFZKRe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:17:34 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44454 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933509AbeFZKRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:17:32 -0400
Received: from 79.184.255.183.ipv4.supernova.orange.pl (79.184.255.183) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 7a808c3c24cc8a62; Tue, 26 Jun 2018 12:17:30 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] PM / wakeup: Add callback for wake-up change notification
Date:   Tue, 26 Jun 2018 12:16:14 +0200
Message-ID: <1705903.rOAenNWc8f@aspire.rjw.lan>
In-Reply-To: <CAMuHMdXYL+=mBOofUqQ06Ld4zUF7BWqt+S2dFTw6AEAPuDsZPQ@mail.gmail.com>
References: <20180619135518.8990-1-geert+renesas@glider.be> <20180620132507.GE6242@sirena.org.uk> <CAMuHMdXYL+=mBOofUqQ06Ld4zUF7BWqt+S2dFTw6AEAPuDsZPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, June 26, 2018 12:06:16 PM CEST Geert Uytterhoeven wrote:
> On Wed, Jun 20, 2018 at 3:25 PM Mark Brown <broonie@kernel.org> wrote:
> > On Wed, Jun 20, 2018 at 02:15:38PM +0200, Rafael J. Wysocki wrote:
> > > On Wed, Jun 20, 2018 at 12:35 PM, Mark Brown <broonie@kernel.org> wrote:
> >
> > > > The flip side of that is that either suspend and resume or poweroff are
> > > > broken for userspace unless they know about this magic sysfs file which
> > > > isn't great either.
> >
> > > But to me that isn't that much different from an RTC wake alarm, say.
> >
> > > Enabling it to wake up the system in general isn't sufficient, you
> > > also need to actually set the alarm using a different interface.
> 
> The RTC wake alarm time is indeed different, as it is not a simple boolean flag.
> It is also more natural for the user, who expects to need to find some way to
> configure the wake-up time.

OK, take Ethernet.  You need to configure WoL on that to wake up the system
in addition to setting power/wakeup for it.

Take WiFi: You need to set up WoW on that.

And so on.

> > It seems more like hardware breakage we're trying to fix than a feature
> > - it's not like it's adding something we didn't have already (like
> > setting a time in an alarm where the alarm is an additional thing), more
> > just trying to execute on an existing user interface successfully.  I
> > can see that there's a case that it doesn't map very well onto the
> > standard interfaces so perhaps we have to add something on the side as
> > the hardware is just too horrible to fit in with the standard interfaces
> > and we have to do that.
> 
> My main worry is usability: with a separate sysfs file, we need to document the
> file, and the user needs to be aware of it.

That's right, but it will be very hard to convince me that changing the
meaning of the "wakeup" attribute just in order to work around this issue
(which arguably is a consequence of "unfortunate" hardware design) is a
good idea. :-)

