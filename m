Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932462AbeCLUwH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 16:52:07 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:56036 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932302AbeCLUwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 16:52:03 -0400
X-Google-Smtp-Source: AG47ELtIcP6cpOB5ygljT0DV3HZIK4145wure0cPjGp7f5u98cR5+zVYmc6rY3bg/pSHgMOwuxAWsQ==
Date: Mon, 12 Mar 2018 21:51:58 +0100
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: =?iso-8859-1?Q?Cl=E9ment?= VUCHENER <clement.vuchener@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Cameron Gutman <aicommander@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Subject: Re: [PATCH v5 0/4] new driver for Valve Steam Controller
Message-ID: <20180312205158.GB21621@casa>
References: <20180311195842.5551-1-rodrigorivascosta@gmail.com>
 <CAM4jgCq5UT0SBKA1DMfsAKd8R+yn0ViPr0U-iE8-tWjgA9hTTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM4jgCq5UT0SBKA1DMfsAKd8R+yn0ViPr0U-iE8-tWjgA9hTTQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 03:30:43PM +0100, Clément VUCHENER wrote:
> 2018-03-11 20:58 GMT+01:00 Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>:
> > This patchset implements a driver for Valve Steam Controller, based on a
> > reverse analysis by myself.
> >
> > Sorry, I've been out of town for a few weeks and couldn't keep up with this...
> >
> > @Pierre-Loup and @Clément, could you please have another look at this and
> > check if it is worthy? Benjamin will not commit it without an express ACK from
> > Valve. Of course he is right to be cautious, but I checked this driver with
> > the Steam Client and all seems to go just fine. I think that there is a lot of
> > Linux out of the desktop that could use this driver and cannot use the Steam
> > Client. Worst case scenario, this driver can now be blacklisted, but I hope
> > that will not be needed.
> 
> I tested the driver with my 4.15 fedora kernel (I only built the
> module not the whole kernel) and I got double inputs (your driver
> input device + steam uinput device) when testing Shovel Knight with
> Steam Big Picture. It seems to work fine when the inputs are the same,
> but after changing the controller configuration in Steam, the issue
> became apparent.

I assumed that when several joysticks are available, games would listen
to one one of them. It looks like I'm wrong, and some (many?) games will
listen to all available joysticks at the same time. Thus having two
logical joysticks that represent the same physical one is not good.

An easy solution would be that Steam Client grabs this driver
(ioctl(EVIOCGRAB)) when creating the uinput device. Another solution
would be that Steam Client blacklists this driver, of course.

> And without Steam and your external tool, you get double inputs too. I
> tried RetroArch and it was unusable because of the keyboard inputs
> from the lizard mode (e.g. pressing B also presses Esc and quits
> RetroArch). Having to download and compile an external tool to make
> the driver work properly may be too difficult for the user. Your goal
> was to provide an alternative to user space drivers but now you
> actually depend on (a very simple) one.

Yes, I noticed that. TBH, this driver without Steam Client or the
user-space tool is not very nice, precisely because you'll get constant
Escape and Enter presses, and most games react to those.

Frankly speaking, I'm not sure how to proceed. I can think of the
following options:
 1.Steam Client installation could add a file to blacklist
   hid-steam, just as it adds a few udev rules.
 2.The default CONFIG_HID_STEAM can be changed to "n". Maybe only
   on the architectures for which there is a Steam Client available.
   This way DIY projects will still be able to use it.
 3.This driver could be abandoned :-(. Just use Steam Client if possible or
   any of the user-mode drivers available.

If we decide for 1 or 2, then the lizard mode could be disabled without
ill effects. We could even enable the gyro and all the other gadgets
without worring about current compatibility.

At the end of the day, I think that it is up to Valve what to do.
Best Regards.
Rodrigo.

> Also the button and axis codes do not match the gamepad API doc
> (https://www.kernel.org/doc/Documentation/input/gamepad.txt).
> 
> >
> > For full reference, I'm adding a full changelog of this patchset.
> >
> > Changes in v5:
> >  * Fix license SPDX to GPL-2.0+.
> >  * Minor stylistic changes (BIT(3) instead 0x08 and so on).
> >
> > Changes in v4:
> >  * Add command to check the wireless connection status on probe, without
> >    waiting for a message (thanks to Clément Vuchener for the tip).
> >  * Removed the error code on redundant connection/disconnection messages. That
> >    was harmless but polluted dmesg.
> >  * Added buttons for touching the left-pad and right-pad.
> >  * Fixed a misplaced #include from 2/4 to 1/4.
> >
> > Changes in v3:
> >  * Use RCU to do the dynamic connec/disconnect of wireless devices.
> >  * Remove entries in hid-quirks.c as they are no longer needed. This allows
> >    this module to be blacklisted without side effects.
> >  * Do not bypass the virtual keyboard/mouse HID devices to avoid breaking
> >    existing use cases (lizard mode). A user-space tool to do that is
> >    linked.
> >  * Fully separated axes for joystick and left-pad. As it happens.
> >  * Add fuzz values for left/right pad axes, they are a little wiggly.
> >
> > Changes in v2:
> >  * Remove references to USB. Now the interesting interfaces are selected by
> >    looking for the ones with feature reports.
> >  * Feature reports buffers are allocated with hid_alloc_report_buf().
> >  * Feature report length is checked, to avoid overflows in case of
> >    corrupt/malicius USB devices.
> >  * Resolution added to the ABS axes.
> >  * A lot of minor cleanups.
> >
> > Rodrigo Rivas Costa (4):
> >   HID: add driver for Valve Steam Controller
> >   HID: steam: add serial number information.
> >   HID: steam: command to check wireless connection
> >   HID: steam: add battery device.
> >
> >  drivers/hid/Kconfig     |   8 +
> >  drivers/hid/Makefile    |   1 +
> >  drivers/hid/hid-ids.h   |   4 +
> >  drivers/hid/hid-steam.c | 794 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 807 insertions(+)
> >  create mode 100644 drivers/hid/hid-steam.c
> >
> > --
> > 2.16.2
> >
