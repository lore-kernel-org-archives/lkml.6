Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D60C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8318E208B1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8318E208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754574AbeFTIag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:30:36 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61035 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752930AbeFTIad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:30:33 -0400
Received: from 79.184.254.22.ipv4.supernova.orange.pl (79.184.254.22) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 4d34ff52ab8a1549; Wed, 20 Jun 2018 10:03:51 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] PM / wakeup: Add callback for wake-up change notification
Date:   Wed, 20 Jun 2018 10:02:41 +0200
Message-ID: <2523505.Jaak4fIuPm@aspire.rjw.lan>
In-Reply-To: <CAMuHMdWgdsSS7qcfPmHnvL-XmXzyoS=bMGgc6q0urcvO5upWvQ@mail.gmail.com>
References: <20180619135518.8990-1-geert+renesas@glider.be> <CAJZ5v0gGuTDCf8Bsefyj5R6mF=SXZDrt7JacNU5vBZOf84QsvA@mail.gmail.com> <CAMuHMdWgdsSS7qcfPmHnvL-XmXzyoS=bMGgc6q0urcvO5upWvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, June 19, 2018 5:22:06 PM CEST Geert Uytterhoeven wrote:
> Hi Rafael,
> 
> On Tue, Jun 19, 2018 at 4:48 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Tue, Jun 19, 2018 at 3:55 PM, Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
> > > Add a callback to inform a device that its wake-up setting has been
> > > changed.  This allows a device to synchronize device configuration with
> > > an external user action.
> > >
> > > E.g. on systems using a Rohm BD9571MWV PMIC and a toggle accessory power
> > > switch, the system suspend/resume procedure is:
> > >   1. Configure PMIC for DDR backup mode (by software), which changes the
> > >      role of the accessory power switch from a power to a wake-up
> > >      switch,
> > >   2. Switch accessory power switch off (manually), to prepare for system
> > >      suspend,
> > >   3. Suspend system (by software),
> > >   4. Switch accessory power switch on (manually), to wake up the system.
> > >
> > > As step 2 involves a manual operation, step 1 cannot be combined
> > > with step 3 and performed in the PMIC's suspend callback (unlike on
> > > systems with a momentary power switch).
> > >
> > > Adding the new callback allows to move step 1 to the new callback, to be
> > > performed in response to the user writing "enabled" to the PMIC's
> > > "wakeup" virtual file in sysfs.
> >
> > I still don't quite understand this TBH.
> >
> > In particular, why do you want a write to "wakeup" trigger this
> > instead of having a special sysfs attr for that exposed by your PMIC
> > driver?
> 
> In v1 (https://patchwork.kernel.org/patch/9996567/), I had a
> driver-specific "backup_mode" sysfs file.
> In v2 and later of the driver series (https://lkml.org/lkml/2018/4/18/345),
> I changed that to use the standard "wakeup" file in sysfs, in response to
> a comment from Mark Brown.

Well, I'm not convinced that this is the right approach, though.

> > Writing "enabled" to "wakeup" for the PMIC should enable the PMIC
> > itself to wake up the system, which isn't quite the case, or is it?
> 
> Actually the PMIC cannot wake up the system if backup mode is not enabled.

That doesn't really matter.  "enabled" in "wakeup" only means that user space
allows the device to wake up the system from sleep, but it still may not be
able to do that for certain reasons (like in this case).  By adding this
callback you're changing the meaning of the attribute.

> When suspending the system (PSCI suspend) without enabling backup mode
> first, the system will just crash (which cannot be distinguished from being
> suspended, as PSCI doesn't support any other wake-up sources anyway[*] ;-)
> So in that sense writing "enabled" to the "wakeup" file does enable the
> PMIC to wake up the system.
> 
> Do you still prefer a driver-specific sysfs file?

Yes, I do.

Thanks,
Rafael

