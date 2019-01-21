Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB669C2F441
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A0B20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfAURBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:01:21 -0500
Received: from muru.com ([72.249.23.125]:34396 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfAURBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:01:21 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A90E180C0;
        Mon, 21 Jan 2019 17:01:26 +0000 (UTC)
Date:   Mon, 21 Jan 2019 09:01:16 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@llwyncelyn.cymru>,
        Jiri Slaby <jslaby@suse.cz>, Pavel Machek <pavel@ucw.cz>,
        Peter Hurley <peter@hurleysoftware.com>,
        Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-serial@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/3] serdev support for n_gsm
Message-ID: <20190121170116.GA5544@atomide.com>
References: <20190114012528.2367-1-tony@atomide.com>
 <20190118115958.GA5532@kroah.com>
 <20190121105735.GI3691@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121105735.GI3691@localhost>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Johan Hovold <johan@kernel.org> [190121 10:57]:
> Adding Marcel on CC.
> 
> On Fri, Jan 18, 2019 at 12:59:58PM +0100, Greg Kroah-Hartman wrote:
> > On Sun, Jan 13, 2019 at 05:25:25PM -0800, Tony Lindgren wrote:
> > > Hi all,
> > > 
> > > Here's a series of patches to add initial serdev support to n_gsm
> > > TS 27.010 line discipline.
> > > 
> > > This allows handling vendor specific protocols on top of TS 27.010 and
> > > allows creating simple serdev drivers where it makes sense. So far I've
> > > tested it with droid 4 for it's modem to provide char devices for AT
> > > ports, modem PM support, and serdev drivers for GNSS and Alsa ASoC.
> > > 
> > > I'll be posting the related MFD, GNSS and Alsa ASoC drivers separately.
> > > For reference, the MFD driver is at [0], the GNSS driver at [1], and
> > > the Alsa ASoC driver at [2] below.
> > 
> > I have applied the first two patches to my tree, as those are nice
> > cleanups.
> > 
> > The last one I want some feedback from the serdev developers to verify
> > all is set up properly, and Johan, to see if this ends up conflicting
> > with the gnss code, as that would not be good.
> 
> I think we need to have a discussion about how to model modems generally
> before getting into implementation details.
> 
> Modems are currently managed by user space (e.g. through ofono) and
> I'm not sure that moving only parts of its responsibilities into the
> kernel is necessarily the right thing to do. You still need coordination
> between the various components for things like power management.

At least now we do have the option of doing kernel drivers or user
space apps whichever way we want to :)

And we can now do the user space apps without having to implement
any of the Motorola custom packet numbering layer on top of TS 27.010
for each app.

For some user space examples, I have posted scripts to send and receive
SMS at [3], and Pavel has ofono patches [4] below. Seems like we can
also add support to ModemManager along the similar lines. And for the
serdev drivers, those implement standard Linux interfaces for apps
to use.

For PM, about a year ago I tried making things work with a user space
solution and it sucked big time[5]. The power management makes sense
to do in the kernel driver at least in this case as there are shared
GPIO pins between the USB PHY and TS 27.010 UART. The shared GPIOs
are handled by the phy-mapphone-mdm6600 driver.

With the serdev n_gsm MFD driver, the only thing that needs to be done
to idle the modem is to enable autosuspend for the OHCI interface. So
no spefific coordination between various components is needed for PM
beyond that. Things idle just fine using PM runtime.

> TS 27.010 may make it seem like we can move everything into the kernel,
> but Tony's to-be-posted Motorola MFD driver is still exposing character
> devices for most of the muxed ports. If I understand things correctly,
> there also still needs to be some coordination with USB over which some
> channels are handled (e.g. IP over USB, gnss over muxed UART).

Hmm yes now we can do either user space daemons or kernel serdev
drivers.

For USB, the modem data connection already works with USB OHCI over
QMI. So it's is already handled and separated out of this. The USB
PHY and TS 27.010 UART have shared GPIO pins handled by the USB PHY
driver. The USB PHY is integrated into the modem with the shared
GPIO pins controlling the PHY and the TS 27.010 UART PM..
But it's working for PM and like I mentioned modem PM works as long
as OHCI is set to autosuspend. Well the modem also wants to see
TS 27.010 connected before idling.

> Instead of adding these extra layers, only to export most ports to user
> space again, it may be better to hook into the various kernel subsystems
> through dedicated user-space-implementation interfaces such as the
> suggested ugnss interface, which means that user space feeds gnss data
> into the kernel which in turn makes it available through a standard
> interface.

Sure that's doable. But notice that we actually need to kick the
serdev GNSS interface to get more data. It's not a passive GNSS
data feed in this case. So it's not going to be just a case of
cat /dev/motmdm4 > /dev/ugnss. Without the serdev GNSS driver,
it would be some-custom-app -i /dev/motmdm4 -o /dev/ugnss.

And without the n_gsm serdev support, it's a mess of some app
similar to [5] initializing n_gsm, trying to deal with the USB
PHY PM, dealing with Motorola custom packet numbering, kicking
GNSS device, feeding data to /dev/ugnss. Hmm I think I've already
been there just to be able to type AT commands to the modem and
it did not work :)

Anyways, for the serdev kernel drivers, the criteria I've tried
to follow is: "Can this serdev device driver make user space
apps use standard Linux interfaces for the hardware?"

So for the serdev Alsa ASoC driver, user space can use the standard
Alsa interface for setting voice call volume. And for the serdev
GNSS driver, user space can use /dev/gnss0.

I don't think it makes sense to do the GNSS driver in user space
in this case because of the kicking needed. But at least it
certainly is doable with /dev/ugnss.

> This would also allow things to work for other transports such as USB
> CDC for which the mux protocol isn't used.

Yeah I agree it would be nice to have GNSS framework have ugnss
device similar to drivers/input/misc/uinput.c. Anyways, having
a serdev GNSS driver in this case does not prevent a USB driver
from feeding data to the /dev/ugnss interface. In this case
doing GNSS driver over UART is preferred for smaller power
consumption.

Regards,

Tony


[0] https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/tree/drivers/mfd/motorola-mdm.c?h=droid4-pending-mdm-v4.20
[1] https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/tree/drivers/gnss/motmdm.c?h=droid4-pending-mdm-v4.20
[2] https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/tree/sound/soc/codecs/motmdm.c?h=droid4-pending-mdm-v4.20
[3] https://github.com/tmlind/droid4-sms-tools
[4] https://github.com/pavelmachek/ofono
[5] https://github.com/tmlind/droid4-ngsm
