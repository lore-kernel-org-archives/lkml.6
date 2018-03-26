Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751866AbeCZIMW convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:12:22 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:38389 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750940AbeCZIMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:12:20 -0400
X-Google-Smtp-Source: AG47ELujbEvtW36lAVmN9SWVKzXPYZCrRiHks1OB7+GKMbJU6cg8aGTaPbNTgcV3SDSRDcibjz0Iw+6EChtkC7VhZ6c=
MIME-Version: 1.0
In-Reply-To: <20180325160703.15997-1-rodrigorivascosta@gmail.com>
References: <20180325160703.15997-1-rodrigorivascosta@gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Mon, 26 Mar 2018 10:12:19 +0200
Message-ID: <CAO-hwJ+XxB9QnZSAALPZTWmAMDsrzq-dhjtMDOvdXHWtDv=H7g@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] hid-steam driver with user mode client dection
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Cc: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, Cameron Gutman <aicommander@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rodrigo,

On Sun, Mar 25, 2018 at 6:07 PM, Rodrigo Rivas Costa
<rodrigorivascosta@gmail.com> wrote:
> This is a reroll of the Steam Controller driver.
>
> This time the client usage is detected by using exposing a custom hidraw
> device (hid_ll_driver) to userland and forwarding that to the real one.

That is actually more clever than what I had in mind.
This way you reliably know if the hidraw node has been opened without
touching hid-core.c or hidraw.c, well played :)

>
> About how the lizard-mode/hidraw-client issue is handled, I have added a
> module parameter (I don't know if that is the best option, but it helps me
> illustrate different approaches to the problem):
>
> Independently of the lizard_mode parameter value:

I find the values of the lizard_mode parameter hard to understand. And
honestly, I do not think there is much a difference between 0 and 1.
AFAICT, the difference between these two values is that in the first
case you are disabling the lizard mode whether or not the joystick is
in used, and in the latter, you disable it only when the joystick is
in use. Does that gives any benefits to users?

I would think having a boolean "let the kernel handle the lizard mode
with some magic inside" would be simpler to understand. You do not
really want to support too many configurations and I think it would be
wiser to say either disable the new mode or just enable it.

Also, I think there will be races if a user changes the value of the
parameter while running the system. You might want to add an
additional patch that would trigger the mode change on module
parameter change.

As far as I can tell, I am happy with such hack. There are a few
points I'd like to raise in the patch 1, but I'll inline my comments
there.

Cheers,
Benjamin

>
>  1. When a hidraw client is running:
>    a. I will not send any lizard-mode command to the device, so the client is
>       in full control.
>    b. The input device will not send any input message. However it will not
>       dissappear nor return any error message. Maybe it could return ENODEV if
>       they try to open the input device when hidraw client is running?
>
> If lizard_mode == 0 ('disabled'):
>  2.0. When a hidraw client is not running, lizard_mode is disabled.
>
> If lizard_mode == 1, ('auto', the default):
>  2.1. When a hidraw client is not running:
>    a. When the input device is not in use, lizard mode is enabled.
>    b. When the input device is in use, lizard mode is disabled.
>
> If lizard_mode == 2 ('usermode'):
>  2.2. This driver does not send any lizard_mode-related command. So it is up
>       to user mode to configure it, with steamctrl or whatever.
>
> Note that when Steam Client opens it always disables lizard-mode (it creates
> keyboard/mouse XTest inputs with the same function, though). And when it closed
> (but not when it crashes, I think) it always re-enables the lizard mode.
>
> About the input buttons/axes mapping, as per Clément suggestion, I tried to
> conform to Documentation/gamepad.rst, but with a few caveats and doubts:
>  * BTN_NORTH/BTN_WEST are alias of BTN_X/BTN_Y, but those buttons in this
>    controller have the labels changed (BTN_NORTH is actually Y). I don't know
>    the best option, so for now I'm mapping 'Y' to BTN_Y and 'X' to BTN_X.
>  * I'm mapping the lpad clicks to BTN_DPAD_{UP,RIGHT,DOWN,LEFT} but I'm not
>    sure if that is such a good idea: it cannot do diagonals, for example.
>    Maybe we could fake the whole dpad from the touch position?
>  * I'm mapping pressing the joystick to BTN_THUMBL and clicking the rpad to
>    BTN_THUMBR. Clicking the lpad is unmapped because that is used for the
>    dpad, depending on where it is clicked.
>  * Currently I'm mapping the lpad-touch to BTN_THUMB and rpad-touch to
>    BTN_THUMB2, but I don't know if that is so useful. lpad-touch will overlap
>    with any use of the dpad. And rpad-touch will overlap with rpad-click...
>
> Changes in v7:
>  * All the automatic lizard_mode stuff.
>  * Added the lizard_mode parameter.
>  * The patchset is reduced to 2 commits. The separation of the
>    steam_get_serial command no longer makes sense, since I need the
>    steam_send_cmd in the first commit to implement the lizard mode.
>  * Change the input mapping to conform to Documentation/gamepad.rst.
>
> (v6 was a RFC, it does not count).
>
> Changes in v5:
>  * Fix license SPDX to GPL-2.0+.
>  * Minor stylistic changes (BIT(3) instead 0x08 and so on).
>
> Changes in v4:
>  * Add command to check the wireless connection status on probe, without
>    waiting for a message (thanks to Clément Vuchener for the tip).
>  * Removed the error code on redundant connection/disconnection messages. That
>    was harmless but polluted dmesg.
>  * Added buttons for touching the left-pad and right-pad.
>  * Fixed a misplaced #include from 2/4 to 1/4.
>
> Changes in v3:
>  * Use RCU to do the dynamic connec/disconnect of wireless devices.
>  * Remove entries in hid-quirks.c as they are no longer needed. This allows
>    this module to be blacklisted without side effects.
>  * Do not bypass the virtual keyboard/mouse HID devices to avoid breaking
>    existing use cases (lizard mode). A user-space tool to do that is
>    linked.
>  * Fully separated axes for joystick and left-pad. As it happens.
>  * Add fuzz values for left/right pad axes, they are a little wiggly.
>
> Changes in v2:
>  * Remove references to USB. Now the interesting interfaces are selected by
>    looking for the ones with feature reports.
>  * Feature reports buffers are allocated with hid_alloc_report_buf().
>  * Feature report length is checked, to avoid overflows in case of
>    corrupt/malicius USB devices.
>  * Resolution added to the ABS axes.
>  * A lot of minor cleanups.
>
> Rodrigo Rivas Costa (2):
>   HID: add driver for Valve Steam Controller
>   HID: steam: add battery device.
>
>  drivers/hid/Kconfig     |   8 +
>  drivers/hid/Makefile    |   1 +
>  drivers/hid/hid-ids.h   |   4 +
>  drivers/hid/hid-steam.c | 978 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/hid.h     |   1 +
>  5 files changed, 992 insertions(+)
>  create mode 100644 drivers/hid/hid-steam.c
>
> --
> 2.16.2
>
