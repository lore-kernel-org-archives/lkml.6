Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753945AbeBZOiL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 09:38:11 -0500
Received: from mail-wr0-f173.google.com ([209.85.128.173]:42582 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753333AbeBZOiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 09:38:09 -0500
X-Google-Smtp-Source: AG47ELvrGhVYbs7hQ/9EcnMmXlAsoDKvI9zQwwweeaIt6V10dfWEHcObEVUYQkD0NE8gnFrz+a9Bxw==
Date: Mon, 26 Feb 2018 15:38:04 +0100
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: =?iso-8859-1?Q?Cl=E9ment?= VUCHENER <clement.vuchener@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Cameron Gutman <aicommander@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] new driver for Valve Steam Controller
Message-ID: <20180226143804.GA6007@casa>
References: <20180225185250.10759-1-rodrigorivascosta@gmail.com>
 <CAO-hwJ+PDkR4v5r93KJBCqxfm3FTCkrzaOd-K=HxLMwhoAomXQ@mail.gmail.com>
 <CAM4jgCpX1OOBqCEvqtyx=ftvnuk3zg_jMsFkxFZXxEfZD-ak5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM4jgCpX1OOBqCEvqtyx=ftvnuk3zg_jMsFkxFZXxEfZD-ak5Q@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 12:24:21PM +0100, Clément VUCHENER wrote:
> 2018-02-26 10:50 GMT+01:00 Benjamin Tissoires <benjamin.tissoires@redhat.com>:
> > Hi Rodrigo,
> >
> > On Sun, Feb 25, 2018 at 7:52 PM, Rodrigo Rivas Costa
> > <rodrigorivascosta@gmail.com> wrote:
> >> This patchset implements a driver for Valve Steam Controller, based on a
> >> reverse analysis by myself.
> >
> > To me, the code looks OK now. I haven't got the time to do a better
> > review, so giving my:
> > Acked-by: Bnejamin Tissoires <benjamin.tissoires@redhat.com>
> >
> > However, before we include it, I'd like to have the ACK from
> > Pierre-Loup and Clément. They should be more qualified than me to say
> > if this will interfere with the official Steam client (I think we are
> > good now, but that's just my opinion).
> 
> I am not qualified to speak about the steam client, it has been a long
> time since I have a look at how it uses the controller and I think it
> changed a lot.
> 
> I checked the code and I think you are not handling wireless
> connection correctly. If a wireless controller is already connected
> when the driver is loaded, you will not receive a connection event and
> forget to register the controller. You can send a 0xb4 request with
> empty parameters (0xb4, 0x00, ... ) to force the receiver to send its
> connection status (as the type 3 event you are already parsing). Since
> user-space program may also send this request, you should make sure
> the driver works if it receives a (dis)connected event when it is
> already (dis)connected.

You are partially right. If a wireless controller is already connected
when the driver is loaded, it will not create the input device. But
eventually it will receive a input or battery report. Then it will know
that it is not yet registered and it will do it. Since the wireless
device sends one battery status per second, that is not a big deal. That
is in patch 3/3, though, without that you will have to touch a button to
get the connection.

The redundant disconnection is handled properly, I think. It will just
call steam_unregister() several times, but that will do nothing if the
input device/battery is not created.

Anyway, I agree that the 0xb4 request is a much better solution, I
didn't know about that command. I'll add it to the driver and check it
from user-land to see if it breaks anything.

Thanks for the tip!
Rodrigo

> 
> >
> > Cheers,
> > Benjamin
> >
> >>
> >> This is reroll v3, codenamed "lazy lizard". Changes from v2:
> >>  * Use RCU to do the dynamic connec/disconnect of wireless devices. Please,
> >>    to anybody that knows their way around RCU, review.
> >>  * Remove entries in hid-quirks.c as they are no longer needed. This allows
> >>    this module to be blacklisted without side effects.
> >>  * Do not bypass the virtual keyboard/mouse HID devices to avoid breaking
> >>    existing use cases (lizard mode). A user-space tool to do that is
> >>    linked.
> >>  * Fully separated axes for joystick and left-pad. As it happens, there are
> >>    people with too many fingers.
> >>  * Add fuzz values for left/right pad axes, they are a little wiggly.
> >>
> >> Notable changes from patchset v1:
> >>  * Remove references to USB. Now the interesting interfaces are selected by
> >>    looking for the ones with feature reports.
> >>  * Feature reports buffers are allocated with hid_alloc_report_buf().
> >>  * Feature report length is checked, to avoid overflows in case of
> >>    corrupt/malicius USB devices.
> >>  * Resolution added to the ABS axes.
> >>  * A lot of minor cleanups.
> >>
> >> Rodrigo Rivas Costa (3):
> >>   HID: add driver for Valve Steam Controller
> >>   HID: steam: add serial number information.
> >>   HID: steam: add battery device.
> >>
> >>  drivers/hid/Kconfig     |   8 +
> >>  drivers/hid/Makefile    |   1 +
> >>  drivers/hid/hid-ids.h   |   4 +
> >>  drivers/hid/hid-steam.c | 777 ++++++++++++++++++++++++++++++++++++++++++++++++
> >>  4 files changed, 790 insertions(+)
> >>  create mode 100644 drivers/hid/hid-steam.c
> >>
> >> --
> >> 2.16.2
> >>
