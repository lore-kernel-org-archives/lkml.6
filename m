Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753886AbeC1SO6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 14:14:58 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:35956 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752831AbeC1SOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 14:14:54 -0400
X-Google-Smtp-Source: AIpwx4/ynSInu8w9KaEbZ6leFDpPpXjJb0xxuNy6gJ2F1xyCm0gG0dsypeAdzMv4VRExY8IGGl8a6A==
Date: Wed, 28 Mar 2018 20:14:48 +0200
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        =?iso-8859-1?Q?Cl=E9ment?= VUCHENER <clement.vuchener@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, Cameron Gutman <aicommander@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Subject: Re: [PATCH v7 0/2] hid-steam driver with user mode client dection
Message-ID: <20180328181448.GA1674@casa>
References: <20180325160703.15997-1-rodrigorivascosta@gmail.com>
 <CAO-hwJ+XxB9QnZSAALPZTWmAMDsrzq-dhjtMDOvdXHWtDv=H7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO-hwJ+XxB9QnZSAALPZTWmAMDsrzq-dhjtMDOvdXHWtDv=H7g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 10:12:19AM +0200, Benjamin Tissoires wrote:
> Hi Rodrigo,
> 
> On Sun, Mar 25, 2018 at 6:07 PM, Rodrigo Rivas Costa
> <rodrigorivascosta@gmail.com> wrote:
> > This is a reroll of the Steam Controller driver.
> >
> > This time the client usage is detected by using exposing a custom hidraw
> > device (hid_ll_driver) to userland and forwarding that to the real one.
> 
> That is actually more clever than what I had in mind.
> This way you reliably know if the hidraw node has been opened without
> touching hid-core.c or hidraw.c, well played :)

8-)

> > About how the lizard-mode/hidraw-client issue is handled, I have added a
> > module parameter (I don't know if that is the best option, but it helps me
> > illustrate different approaches to the problem):
> >
> > Independently of the lizard_mode parameter value:
> 
> I find the values of the lizard_mode parameter hard to understand. And
> honestly, I do not think there is much a difference between 0 and 1.
> AFAICT, the difference between these two values is that in the first
> case you are disabling the lizard mode whether or not the joystick is
> in used, and in the latter, you disable it only when the joystick is
> in use. Does that gives any benefits to users?

Well, the rules I'm trying to apply are, in order of priority:
1. Never send a lizard command when hidraw is in use.
2. Disable the lizard mode when the input node is in use.

Now, the freedom is in what to do when the input node and hidraw are
both unused, hence the parameters. The two easy options are:
 * lizard_mode=1: lizard mode is on, same experience as without
   hid-steam, so it is the default.
 * lizard_mode=0: lizard mode is off. I always use a mouse and
   keyboard together with the controller, so I like this one.

But that leaves a marginal use case uncovered. What if I want to manage
the lizard mode using a user mode tool, such as my steamctrl from
github? This tool opens hidraw and sends a lizard_mode command (enable
or disable), but it does not matter, because as soon as hidraw is closed
hid-steam will reset the lizard mode to the value of the lizard_mode
parameter.
That is why I added lizard_mode=2: it instructs hid-steam not to send
any lizard mode command at all. You do not get any magic (I even break
rule 2 above) but you can use steamctrl freely.

Summing up:
 * lizard_mode = 0: disabled.
 * lizard_mode = 1: enabled (except when input is in use).
 * lizard_mode = 2: no magic (use a user mode tool or expect weirdness).

I don't think anybody is actually using a user-mode tool for that so
maybe mode 2 can be discarded.

Note that Steam disables the lizard_mode when it starts and restores it
when it closes, unconditionally, so default option lizard_mode=1 will be
indistinguishable from hid-generic for the average user... except if
Steam crashes, then you will have lizard mode reenabled automatically,
which is nice.

The other two lizard_mode={0,1} I think they are quite useful, and I'd
like to keep them.

> I would think having a boolean "let the kernel handle the lizard mode
> with some magic inside" would be simpler to understand. You do not
> really want to support too many configurations and I think it would be
> wiser to say either disable the new mode or just enable it.

That would be the lizard_mode={0,1} I talked about? Both of them have
magic. The magicless option was the 2.

> Also, I think there will be races if a user changes the value of the
> parameter while running the system. You might want to add an
> additional patch that would trigger the mode change on module
> parameter change.

True, but the races should be easy to remove, with a simple local
variable.  About the trigger, I've never seen a trigger on module
parameter change. Can you give me a hint or example of how to do that.

> As far as I can tell, I am happy with such hack. There are a few
> points I'd like to raise in the patch 1, but I'll inline my comments
> there.

I'll address them promptly.

Thanks.
Rodrigo

> Cheers,
> Benjamin
> 
> >
> >  1. When a hidraw client is running:
> >    a. I will not send any lizard-mode command to the device, so the client is
> >       in full control.
> >    b. The input device will not send any input message. However it will not
> >       dissappear nor return any error message. Maybe it could return ENODEV if
> >       they try to open the input device when hidraw client is running?
> >
> > If lizard_mode == 0 ('disabled'):
> >  2.0. When a hidraw client is not running, lizard_mode is disabled.
> >
> > If lizard_mode == 1, ('auto', the default):
> >  2.1. When a hidraw client is not running:
> >    a. When the input device is not in use, lizard mode is enabled.
> >    b. When the input device is in use, lizard mode is disabled.
> >
> > If lizard_mode == 2 ('usermode'):
> >  2.2. This driver does not send any lizard_mode-related command. So it is up
> >       to user mode to configure it, with steamctrl or whatever.
> >
> > Note that when Steam Client opens it always disables lizard-mode (it creates
> > keyboard/mouse XTest inputs with the same function, though). And when it closed
> > (but not when it crashes, I think) it always re-enables the lizard mode.
> >
> > About the input buttons/axes mapping, as per Clément suggestion, I tried to
> > conform to Documentation/gamepad.rst, but with a few caveats and doubts:
> >  * BTN_NORTH/BTN_WEST are alias of BTN_X/BTN_Y, but those buttons in this
> >    controller have the labels changed (BTN_NORTH is actually Y). I don't know
> >    the best option, so for now I'm mapping 'Y' to BTN_Y and 'X' to BTN_X.
> >  * I'm mapping the lpad clicks to BTN_DPAD_{UP,RIGHT,DOWN,LEFT} but I'm not
> >    sure if that is such a good idea: it cannot do diagonals, for example.
> >    Maybe we could fake the whole dpad from the touch position?
> >  * I'm mapping pressing the joystick to BTN_THUMBL and clicking the rpad to
> >    BTN_THUMBR. Clicking the lpad is unmapped because that is used for the
> >    dpad, depending on where it is clicked.
> >  * Currently I'm mapping the lpad-touch to BTN_THUMB and rpad-touch to
> >    BTN_THUMB2, but I don't know if that is so useful. lpad-touch will overlap
> >    with any use of the dpad. And rpad-touch will overlap with rpad-click...
> >
> > Changes in v7:
> >  * All the automatic lizard_mode stuff.
> >  * Added the lizard_mode parameter.
> >  * The patchset is reduced to 2 commits. The separation of the
> >    steam_get_serial command no longer makes sense, since I need the
> >    steam_send_cmd in the first commit to implement the lizard mode.
> >  * Change the input mapping to conform to Documentation/gamepad.rst.
> >
> > (v6 was a RFC, it does not count).
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
> > Rodrigo Rivas Costa (2):
> >   HID: add driver for Valve Steam Controller
> >   HID: steam: add battery device.
> >
> >  drivers/hid/Kconfig     |   8 +
> >  drivers/hid/Makefile    |   1 +
> >  drivers/hid/hid-ids.h   |   4 +
> >  drivers/hid/hid-steam.c | 978 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/hid.h     |   1 +
> >  5 files changed, 992 insertions(+)
> >  create mode 100644 drivers/hid/hid-steam.c
> >
> > --
> > 2.16.2
> >
