Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbeCLHfZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 03:35:25 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39190 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbeCLHfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 03:35:22 -0400
X-Google-Smtp-Source: AG47ELsxGIObYI1h34GgdhZhmtJ9XKuiu3dg4os7uCRYW5iUxXdZ5oRp2CWcV4oUh7mLXxs5Az1kMA==
Date: Mon, 12 Mar 2018 08:35:18 +0100
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Cc: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Cameron Gutman <aicommander@gmail.com>,
        =?iso-8859-1?Q?Cl=E9ment?= VUCHENER <clement.vuchener@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v5 0/4] new driver for Valve Steam Controller
Message-ID: <20180312073518.GA21621@casa>
References: <20180311195842.5551-1-rodrigorivascosta@gmail.com>
 <99cb195e-589c-b3fc-1237-e1c8f557c51e@valvesoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99cb195e-589c-b3fc-1237-e1c8f557c51e@valvesoftware.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 11, 2018 at 04:12:41PM -0700, Pierre-Loup A. Griffais wrote:
> 
> 
> On 03/11/2018 12:58 PM, Rodrigo Rivas Costa wrote:
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
> Hi Rodrigo,
> 
> I think the approach you outlined earlier of only sending configuration
> commands to the device when something is actively using the driver is sane.
> I won't have the cycles to thoroughly check all the possible interactions
> with the client in the near future, so in the interest of not blocking
> development I'd say go for it. I'll try to get someone to take the patchset
> for a spin soon.

First of all, thank you very much for your attention.

Note that this driver does not send any configuration command at all. It
only sends commands get_serial (ae 15 01) and get_comm_status (b4), and
those just on probe time. That should be quite safe IMO.

Sending a configuration command, such as enable/disable_gyro on
input->open() is probably not so safe, so I'm leaving that for an
eventual future patch. Many games (and even X) enumerate the input
devices by opening and closing them. That could cause trouble...


Best regards.
Rodrigo

> 
> Thanks,
>  - Pierre-Loup
> 
> > 
> > For full reference, I'm adding a full changelog of this patchset.
> > 
> > Changes in v5:
> >   * Fix license SPDX to GPL-2.0+.
> >   * Minor stylistic changes (BIT(3) instead 0x08 and so on).
> > 
> > Changes in v4:
> >   * Add command to check the wireless connection status on probe, without
> >     waiting for a message (thanks to Clément Vuchener for the tip).
> >   * Removed the error code on redundant connection/disconnection messages. That
> >     was harmless but polluted dmesg.
> >   * Added buttons for touching the left-pad and right-pad.
> >   * Fixed a misplaced #include from 2/4 to 1/4.
> > 
> > Changes in v3:
> >   * Use RCU to do the dynamic connec/disconnect of wireless devices.
> >   * Remove entries in hid-quirks.c as they are no longer needed. This allows
> >     this module to be blacklisted without side effects.
> >   * Do not bypass the virtual keyboard/mouse HID devices to avoid breaking
> >     existing use cases (lizard mode). A user-space tool to do that is
> >     linked.
> >   * Fully separated axes for joystick and left-pad. As it happens.
> >   * Add fuzz values for left/right pad axes, they are a little wiggly.
> > 
> > Changes in v2:
> >   * Remove references to USB. Now the interesting interfaces are selected by
> >     looking for the ones with feature reports.
> >   * Feature reports buffers are allocated with hid_alloc_report_buf().
> >   * Feature report length is checked, to avoid overflows in case of
> >     corrupt/malicius USB devices.
> >   * Resolution added to the ABS axes.
> >   * A lot of minor cleanups.
> > 
> > Rodrigo Rivas Costa (4):
> >    HID: add driver for Valve Steam Controller
> >    HID: steam: add serial number information.
> >    HID: steam: command to check wireless connection
> >    HID: steam: add battery device.
> > 
> >   drivers/hid/Kconfig     |   8 +
> >   drivers/hid/Makefile    |   1 +
> >   drivers/hid/hid-ids.h   |   4 +
> >   drivers/hid/hid-steam.c | 794 ++++++++++++++++++++++++++++++++++++++++++++++++
> >   4 files changed, 807 insertions(+)
> >   create mode 100644 drivers/hid/hid-steam.c
> > 
> 
