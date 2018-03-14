Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752252AbeCNQja convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:39:30 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:34752 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbeCNQj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:39:27 -0400
X-Google-Smtp-Source: AG47ELujOSHlvXCT1RjSWeXbg0Dg3wlkshsOUcMd6GnckLbocHDtCYAmfRDhpJGZfPUQkwuNCsjm6wSALkz9Nh2E+GY=
MIME-Version: 1.0
In-Reply-To: <20180312205158.GB21621@casa>
References: <20180311195842.5551-1-rodrigorivascosta@gmail.com>
 <CAM4jgCq5UT0SBKA1DMfsAKd8R+yn0ViPr0U-iE8-tWjgA9hTTQ@mail.gmail.com> <20180312205158.GB21621@casa>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Wed, 14 Mar 2018 17:39:25 +0100
Message-ID: <CAO-hwJJqDM5Y7t-hpZ_s7EzjVki00ME7fd_7iUWcgaTZ9o906g@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] new driver for Valve Steam Controller
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Cc: =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Cameron Gutman <aicommander@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 9:51 PM, Rodrigo Rivas Costa
<rodrigorivascosta@gmail.com> wrote:
> On Mon, Mar 12, 2018 at 03:30:43PM +0100, Clément VUCHENER wrote:
>> 2018-03-11 20:58 GMT+01:00 Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>:
>> > This patchset implements a driver for Valve Steam Controller, based on a
>> > reverse analysis by myself.
>> >
>> > Sorry, I've been out of town for a few weeks and couldn't keep up with this...
>> >
>> > @Pierre-Loup and @Clément, could you please have another look at this and
>> > check if it is worthy? Benjamin will not commit it without an express ACK from
>> > Valve. Of course he is right to be cautious, but I checked this driver with
>> > the Steam Client and all seems to go just fine. I think that there is a lot of
>> > Linux out of the desktop that could use this driver and cannot use the Steam
>> > Client. Worst case scenario, this driver can now be blacklisted, but I hope
>> > that will not be needed.
>>
>> I tested the driver with my 4.15 fedora kernel (I only built the
>> module not the whole kernel) and I got double inputs (your driver
>> input device + steam uinput device) when testing Shovel Knight with
>> Steam Big Picture. It seems to work fine when the inputs are the same,
>> but after changing the controller configuration in Steam, the issue
>> became apparent.
>
> I assumed that when several joysticks are available, games would listen
> to one one of them. It looks like I'm wrong, and some (many?) games will
> listen to all available joysticks at the same time. Thus having two
> logical joysticks that represent the same physical one is not good.

Yeah, the general rule of thumb is "think of the worst thing that can
happen, someone will do something worst".

>
> An easy solution would be that Steam Client grabs this driver
> (ioctl(EVIOCGRAB)) when creating the uinput device. Another solution
> would be that Steam Client blacklists this driver, of course.

This is 2 solutions that rely on a userspace change, and this is not
acceptable in its current form. What if people do not upgrade Steam
client but upgrade their kernel? Well, Steam might be able to force
people to always run the latest shiny available version, but for other
games, you can't expect people to have a compatible version of the
userspace stack.

Also, "blacklisting the driver" from Steam client is something the OS
can do, but not the client when you run on a different distribution.
You need root for that, and I don't want to give root permissions to
Steam (or to any user space client that shouldn't have root privileges
for what it matters).

>
>> And without Steam and your external tool, you get double inputs too. I
>> tried RetroArch and it was unusable because of the keyboard inputs
>> from the lizard mode (e.g. pressing B also presses Esc and quits
>> RetroArch). Having to download and compile an external tool to make
>> the driver work properly may be too difficult for the user. Your goal
>> was to provide an alternative to user space drivers but now you
>> actually depend on (a very simple) one.
>
> Yes, I noticed that. TBH, this driver without Steam Client or the
> user-space tool is not very nice, precisely because you'll get constant
> Escape and Enter presses, and most games react to those.
>
> Frankly speaking, I'm not sure how to proceed. I can think of the
> following options:
>  1.Steam Client installation could add a file to blacklist
>    hid-steam, just as it adds a few udev rules.

But what about RetroArch? And what if you install Steam but want to
play SDL games that could benefit from your driver?

>  2.The default CONFIG_HID_STEAM can be changed to "n". Maybe only
>    on the architectures for which there is a Steam Client available.
>    This way DIY projects will still be able to use it.

But this will make the decision to include or not the driver in
distributions harder. And if no distribution uses it, you won't have
free tests, and you will be alone to maintain it. So that's not ideal
either

>  3.This driver could be abandoned :-(. Just use Steam Client if possible or
>    any of the user-mode drivers available.

This would be a waste for everybody as it's always better when we share.

>
> If we decide for 1 or 2, then the lizard mode could be disabled without
> ill effects. We could even enable the gyro and all the other gadgets
> without worring about current compatibility.

To me, 1 is out of the question. The kernel can't expect a user space
change especially if you are knowingly introducing a bug for the end
user.

2 is still on the table IMO, and 3 would be a shame.

I know we already discussed about sysfs and module parameters, but if
the driver will conflict with a userspace stack, the only way would be
to have a (dynamic) parameter "enhanced_mode" or
"kernel_awesome_support" or whatever which would be a boolean, that
defaults to false that Steam can eventually lookup if they want so in
the future we can default it to true. When this parameter is set, the
driver will create the inputs and toggle the various modes, while when
it's toggled off, it'll clean up itself and keep the device as if it
were connected to hid-generic. Bonus point, this removes the need for
the simple user space tool that enables the mode.

>
> At the end of the day, I think that it is up to Valve what to do.

Again, Valve is a big player here, but do not underestimate other
projects (like RetroArch mentioned above) because if you break their
workflow, they will have the right to request a revert of the commit
because it breaks some random user playing games in the far end of
Antarctica (yes, penguins do love to play games :-P )

Cheers,
Benjamin

> Best Regards.
> Rodrigo.
>
>> Also the button and axis codes do not match the gamepad API doc
>> (https://www.kernel.org/doc/Documentation/input/gamepad.txt).
>>
>> >
>> > For full reference, I'm adding a full changelog of this patchset.
>> >
>> > Changes in v5:
>> >  * Fix license SPDX to GPL-2.0+.
>> >  * Minor stylistic changes (BIT(3) instead 0x08 and so on).
>> >
>> > Changes in v4:
>> >  * Add command to check the wireless connection status on probe, without
>> >    waiting for a message (thanks to Clément Vuchener for the tip).
>> >  * Removed the error code on redundant connection/disconnection messages. That
>> >    was harmless but polluted dmesg.
>> >  * Added buttons for touching the left-pad and right-pad.
>> >  * Fixed a misplaced #include from 2/4 to 1/4.
>> >
>> > Changes in v3:
>> >  * Use RCU to do the dynamic connec/disconnect of wireless devices.
>> >  * Remove entries in hid-quirks.c as they are no longer needed. This allows
>> >    this module to be blacklisted without side effects.
>> >  * Do not bypass the virtual keyboard/mouse HID devices to avoid breaking
>> >    existing use cases (lizard mode). A user-space tool to do that is
>> >    linked.
>> >  * Fully separated axes for joystick and left-pad. As it happens.
>> >  * Add fuzz values for left/right pad axes, they are a little wiggly.
>> >
>> > Changes in v2:
>> >  * Remove references to USB. Now the interesting interfaces are selected by
>> >    looking for the ones with feature reports.
>> >  * Feature reports buffers are allocated with hid_alloc_report_buf().
>> >  * Feature report length is checked, to avoid overflows in case of
>> >    corrupt/malicius USB devices.
>> >  * Resolution added to the ABS axes.
>> >  * A lot of minor cleanups.
>> >
>> > Rodrigo Rivas Costa (4):
>> >   HID: add driver for Valve Steam Controller
>> >   HID: steam: add serial number information.
>> >   HID: steam: command to check wireless connection
>> >   HID: steam: add battery device.
>> >
>> >  drivers/hid/Kconfig     |   8 +
>> >  drivers/hid/Makefile    |   1 +
>> >  drivers/hid/hid-ids.h   |   4 +
>> >  drivers/hid/hid-steam.c | 794 ++++++++++++++++++++++++++++++++++++++++++++++++
>> >  4 files changed, 807 insertions(+)
>> >  create mode 100644 drivers/hid/hid-steam.c
>> >
>> > --
>> > 2.16.2
>> >
