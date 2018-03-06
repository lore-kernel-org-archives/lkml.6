Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933209AbeCGA21 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 19:28:27 -0500
Received: from 7.mo1.mail-out.ovh.net ([87.98.158.110]:35524 "EHLO
        7.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932905AbeCGA20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 19:28:26 -0500
Message-ID: <1520377868.31705.25.camel@florentflament.com>
Subject: Re: [PATCH v2 1/1] HID: Logitech K290: Add driver for the Logitech
 K290 USB keyboard
From: Florent Flament <contact@florentflament.com>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: andy.shevchenko@gmail.com, Jiri Kosina <jikos@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Date: Wed, 07 Mar 2018 00:11:08 +0100
In-Reply-To: <1520292697.14077.14.camel@florentflament.com>
References: <20180304170004.26553-1-contact@florentflament.com>
         <20180304221425.28611-1-contact@florentflament.com>
         <20180304221425.28611-2-contact@florentflament.com>
         <CAE7qMrpF4dGCUrtnXbxb4MLFPZ0Wf13mrQEPypwPbEHaB9e44A@mail.gmail.com>
         <CAO-hwJK=LVZXU5M1CxRvm43TzL7qVqNNepwT2qrriMnCS3akeA@mail.gmail.com>
         <1520292697.14077.14.camel@florentflament.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 2311191038012062236
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtfedrkedtgddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin, Nestor,

On Tue, 2018-03-06 at 00:31 +0100, Florent Flament wrote:
> On Mon, 2018-03-05 at 18:26 +0100, Benjamin Tissoires wrote:
> > Hi Florent,
> 
> Hi Benjamin,
> 
> > 
> > On Mon, Mar 5, 2018 at 10:31 AM, Nestor Lopez Casado
> > <nlopezcasad@logitech.com> wrote:
> > > Hello Florent,
> > > 
> > > In my view, this driver may not be a good idea. The default
> > > behaviour
> > > of K290 is 'send multimedia keycodes' with the user given the
> > > choice
> > > to change that behaviour via vendor commands. Putting a driver
> > > that
> > > will unconditionally change that behaviour without the user's
> > > consent
> > > might bother other users that prefer the multimedia keycodes by
> > > default.
> > > 
> > > Besides, I'd argue that instead of a kernel module this would be
> > > best
> > > achieved from a user space application. Something in the lines of
> > > Solaar (github pwr/solaar) or libratbag (there's an issue open to
> > > support keyboards) or even a specific application built for the
> > > purpose. Anyways, please collect the input from Benjamin and Jiri
> > > as
> > > they as they best placed to advise than myself.
> > 
> > On top of what Nestor said, this type of functionality, if we want
> > to
> > have them in the kernel should probably be integrated in
> > hid-logitech-hidpp, in order not having some magic reports to send.
> > 
> > Things like reconnect of the device would be handled far more
> > easily
> > in hid-logitech-hidpp while you would be reinventing the wheel
> > here.
> > 
> > One other thing I do not like in this submission of the driver is
> > the
> > direct use of USB while we have a full transport agnostic layer
> > called
> > HID.
> 
> Fair enough, I didn't have a look at how hid-logitech-hidpp is
> working
> yet. I'll dig into that to see if this driver can me implemented more
> elegantly.

I had a closer look at how the HID layer is interacting with the USB
layer. And as far as I understand, the only way to send a message to
the USB control endpoint from the HID layer is through the
hid_submit_ctrl function in drivers/hid/usbhid/hid-core.c, which does
this:

usbhid->cr->bRequestType = USB_TYPE_CLASS | USB_RECIP_INTERFACE | dir;
usbhid->cr->bRequest = (dir == USB_DIR_OUT) ? HID_REQ_SET_REPORT :
					      HID_REQ_GET_REPORT;
usbhid->cr->wValue = cpu_to_le16(((report->type + 1) << 8) |
				 report->id);
usbhid->cr->wIndex = cpu_to_le16(usbhid->ifnum);
usbhid->cr->wLength = cpu_to_le16(len);

dbg_hid("submitting ctrl urb: %s wValue=0x%04x wIndex=0x%04x
wLength=%u\n",
	usbhid->cr->bRequest == HID_REQ_SET_REPORT ? "Set_Report" :
						     "Get_Report",
	usbhid->cr->wValue, usbhid->cr->wIndex, usbhid->cr->wLength);

r = usb_submit_urb(usbhid->urbctrl, GFP_ATOMIC);


While this is probably fine for most HID devices, some devices (like
the Logitech K290) need to receive a vendor specific request directly
adressed to the device (i.e bRequestType = USB_TYPE_VENDOR |
USB_RECIPE_DEVICE). While in the hid_submit_ctrl function, the
bRequestType is hardcoded to USB_TYPE_CLASS | USB_RECIP_INTERFACE.

So it looks like the mechanism used by Logitech to allow switching its
K290 keyboard behavior is not HID compliant and requires to forge a
custom USB request.

Apparently this keyboard is not the only device that requires the same
kind of custom USB requests. If we look at the hid-elo driver, the
same usb_control_msg calls are performed in elo_smartset_send_get:

return usb_control_msg(dev, pipe, command,
		dir | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
		0, 0, data, ELO_SMARTSET_PACKET_SIZE,
		ELO_SMARTSET_CMD_TIMEOUT);

and in elo_flush_smartset_responses:

return usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
		ELO_FLUSH_SMARTSET_RESPONSES,
		USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
		0, 0, NULL, 0, USB_CTRL_SET_TIMEOUT);


So far, I don't think that it's feasible to send the control message
required to toggle the keyboard behavior from the HID layer, though I'd
be glad to have your thoughts.

Regards,
Florent Flament
