Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC13C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FAB218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfAXUxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:53:42 -0500
Received: from muru.com ([72.249.23.125]:35280 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbfAXUxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:53:41 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 188CC8181;
        Thu, 24 Jan 2019 20:53:46 +0000 (UTC)
Date:   Thu, 24 Jan 2019 12:53:36 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@llwyncelyn.cymru>,
        Jiri Slaby <jslaby@suse.cz>, Pavel Machek <pavel@ucw.cz>,
        Peter Hurley <peter@hurleysoftware.com>,
        Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-serial@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] serdev support for n_gsm
Message-ID: <20190124205335.GV5720@atomide.com>
References: <20190114012528.2367-1-tony@atomide.com>
 <20190118115958.GA5532@kroah.com>
 <20190121105735.GI3691@localhost>
 <20190121170116.GA5544@atomide.com>
 <20190124163932.GZ3691@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124163932.GZ3691@localhost>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Johan Hovold <johan@kernel.org> [190124 16:39]:
> This series adds a new interface (gsm_serdev) but no users, which is not
> something we normally accept. I think you need to post the lot, at least
> as an RFC in order for the full picture to be visible.

Sure I can post them all as RFC series maybe this coming
weekend when I get a chance.

> Similarly, including an example device tree would also help with the
> overall picture. I've been able to derive the following (from your code
> and already merged phy driver binding doc):
> 
>    	mdm6600_phy: usb-phy {
> 		compatible = "motorola,mapphone-mdm6600";
> 		enable-gpios = <&gpio3 31 GPIO_ACTIVE_LOW>;
> 		power-gpios = <&gpio2 22 GPIO_ACTIVE_HIGH>;
> 		reset-gpios = <&gpio2 17 GPIO_ACTIVE_HIGH>;
> 		motorola,mode-gpios = <&gpio5 20 GPIO_ACTIVE_HIGH>,
> 				      <&gpio5 21 GPIO_ACTIVE_HIGH>;
> 		motorola,cmd-gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>,
> 				     <&gpio4 8 GPIO_ACTIVE_HIGH>,
> 				     <&gpio5 14 GPIO_ACTIVE_HIGH>;
> 		motorola,status-gpios = <&gpio2 20 GPIO_ACTIVE_HIGH>,
> 					<&gpio2 21 GPIO_ACTIVE_HIGH>,
> 					<&gpio2 23 GPIO_ACTIVE_HIGH>;
> 		#phy-cells = <0>;
> 	};
> 
> 	&uart {
> 		gsm-mux? {
> 			compatible = "motorola,mapphone-mdm6600-serdev";
> 			phy = <&mdm6600_phy>;
> 
> 			gnss {
> 				compatible = "motorola,mapphone-mdm6600-gnss";
> 			};
> 
> 			audio-codec {
> 
> 			};
> 		};
> 	};
> 
> 	&ohci {
> 		phys = <&mdm6600_phy>;
> 	};
> 
> Which brings us back to the question of how to model modems. You've
> already added a phy-driver for something which really is some sort of
> modem representation.

That is not a "modem representation".

It's just doing what's typically done for drivers with firmware
like let's say WLAN pwrseq driver on SDIO bus. So start device,
enable clocks for the PHY so Linux won't oops when loading
ohci-platform device driver. It does not have much anything to
do beyond enabling communication over Linux standard buses like
TS 27.010 and USB. For more info, please see commit 5d1ebbda0318
("phy: mapphone-mdm6600: Add USB PHY driver for MDM6600 on
Droid 4").

It's too bad the USB PHY for the Linux SoC OHCI is on the modem
and clocked from the modem instead of what is usually done
where it would be clocked by the Linux running SoC. And too bad
some of the GPIO pins are shared with the TS 27.010 port. But hey,
it's just bad hardware design and not much we can do about it.
And it can be all isolated in the USB PHY driver.

> > And without the n_gsm serdev support, it's a mess of some app
> > similar to [5] initializing n_gsm, trying to deal with the USB
> > PHY PM, dealing with Motorola custom packet numbering, kicking
> > GNSS device, feeding data to /dev/ugnss. Hmm I think I've already
> > been there just to be able to type AT commands to the modem and
> > it did not work :)
> 
> It's a mess indeed, but I'd rather see user-space dealing with until we
> figure out how best to do it in the kernel. ;)

Well we really do not have user space dealing with it. And I'm
not planning on working on the user space approach any longer
for n_gsm, Motorola custom packet layer, and shared GPIO pins
for PM. That was proven to be a dead end alread and not worth
continuing.

For kicking the GNSS, that can be certainly done with a kernel
serdev driver or some custom user space app. With the $subject
patch we now have both options available unlike earlier.

> > Anyways, for the serdev kernel drivers, the criteria I've tried
> > to follow is: "Can this serdev device driver make user space
> > apps use standard Linux interfaces for the hardware?"
> > 
> > So for the serdev Alsa ASoC driver, user space can use the standard
> > Alsa interface for setting voice call volume. And for the serdev
> > GNSS driver, user space can use /dev/gnss0.
> 
> I understand. Both drivers appears to be using AT commands for control.
> It would be interesting to hear what Mark has to say about the codec
> driver too. Moving AT handling into the kernel scares me a bit. If we
> already have a telephony stack to deal with it in user-space, my
> inclination is to let it continue to handle it.

Right, too bad it's AT commands instead of let's say just
register offsets to a mem region on the modem. Or even some
enumerated commands. And yes it's the firmware doing all
kinds of things, just like with a let's say a WLAN driver.

And no, we don't really have a telephony stack to deal with it
in the user-space. But with the $subject patch it becomes doable
for the parts it makes sense to do, for ofono, ModemManager and
my phone scripts too.

For the Alsa driver, we need to configure the i2s channel
on the PMIC for time division multiplexing with set_tdm_slot()
for voice calls as the PMIC is the clock master.

> Modem-managed GNSS is also different from receivers connected directly
> to the host. It's really the modem that drives the GNSS receiver, and
> offers a higher-level interface to the host, for example, by buffering
> output which the host can later request. It may or may not be the
> kernel's job to periodically poll the modem to recreate an NMEA feed so
> to speak.

This is very similar to what we're doing with any driver that needs
firmware loaded, let's say again WLAN on SDIO. Or Bluetooth on SDIO.
Or a USB device with firmware :)

> But the end-result of having it accessible through a standard interface
> is of course appealing.

Yes I agree. That's the best way to make things work in a
standard way for Linux distros.

Based on my experience with trying to make embedded devices usable
with standard Linux distros, the irattach/ldattach/hciattach
route never worked well from user point of view.

If we can make things usable out of the box with simple channel
specific device drivers or user space apps it's a big improvment
for users. If we can also get rid of some duplicate copies of the
same code implementing the same thing in favor of using Linux
generic interfaces then even better :)

Then maybe later on if it turns out we have three or more
modems from various vendors needing similar feature it might
make sense to attempt to move some of the handling to a generic
framework like you did for GNSS. But currently I do not see
a need for that and for QMI based modems things are handled
in a different way anyways.

> I have some more comments on the gsm_serdev interface and motorola mfd,
> but let's start with the above.

Sure thanks, I'll post the RFC series of the pending patches.

Regards,

Tony
