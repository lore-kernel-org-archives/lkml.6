Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935563AbeB1Wte (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 17:49:34 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45427 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935461AbeB1Wtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 17:49:32 -0500
X-Google-Smtp-Source: AH8x227csLoeoEwGppagMxAwNXfpzpCk+tYVwQcTCkxQrwATZJhz5sYn/t5BvIHHK/5KQ6MyHiKUlA==
Date: Wed, 28 Feb 2018 23:49:26 +0100
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Cameron Gutman <aicommander@gmail.com>,
        =?iso-8859-1?Q?Cl=E9ment?= VUCHENER <clement.vuchener@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Subject: Re: [PATCH v4 1/4] HID: add driver for Valve Steam Controller
Message-ID: <20180228224926.GA7009@casa>
References: <20180228184322.29636-1-rodrigorivascosta@gmail.com>
 <20180228184322.29636-2-rodrigorivascosta@gmail.com>
 <CAHp75VfPK=yAx9TLEX-W0SrK8xXQzrP4wAuFWS3zEjHGoPJRsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfPK=yAx9TLEX-W0SrK8xXQzrP4wAuFWS3zEjHGoPJRsw@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 09:21:15PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 28, 2018 at 8:43 PM, Rodrigo Rivas Costa
> <rodrigorivascosta@gmail.com> wrote:
> > There are two ways to connect the Steam Controller: directly to the USB
> > or with the USB wireless adapter.  Both methods are similar, but the
> > wireless adapter can connect up to 4 devices at the same time.
> >
> > The wired device will appear as 3 interfaces: a virtual mouse, a virtual
> > keyboard and a custom HID device.
> >
> > The wireless device will appear as 5 interfaces: a virtual keyboard and
> > 4 custom HID devices, that will remain silent until a device is actually
> > connected.
> >
> > The custom HID device has a report descriptor with all vendor specific
> > usages, so the hid-generic is not very useful. In a PC/SteamBox Valve
> > Steam Client provices a software translation by using direct USB access
> > and a creates a uinput virtual gamepad.
> >
> > This driver was reverse engineered to provide direct kernel support in
> > case you cannot, or do not want to, use Valve Steam Client. It disables
> > the virtual keyboard and mouse, as they are not so useful when you have
> > a working gamepad.
> 
> 
> > +// SPDX-License-Identifier: GPL-2.0
> 
> > +MODULE_LICENSE("GPL");
> 
> Not the same.

Hmmm... I copied from usb-skeleton.c, IIRC...
I'll change to GPL-2.0+, that would be correct, I think.

> 
> > +static void steam_unregister(struct steam_device *steam)
> > +{
> > +       struct input_dev *input;
> > +
> > +       rcu_read_lock();
> > +       input = rcu_dereference(steam->input);
> > +       rcu_read_unlock();
> > +
> 
> > +       if (input) {
> 
> if (!input)
>  return;
> 
> ?
That was because of symmetry, because further patches add more objects.
Then
if (input)
	free(input);
if (battery)
	free(battery);
/* in the future *(
if (input_gyro)
	free(input_gyro);

Sure, the last one can do an early return, but you break symmetry.

> 
> > +               RCU_INIT_POINTER(steam->input, NULL);
> > +               synchronize_rcu();
> > +               hid_info(steam->hdev, "Steam Controller disconnected");
> > +               input_unregister_device(input);
> > +       }
> > +}
> 
> > +static bool steam_is_valve_interface(struct hid_device *hdev)
> > +{
> > +       struct hid_report_enum *rep_enum;
> > +       struct hid_report *hreport;
> > +
> > +       /*
> > +        * The wired device creates 3 interfaces:
> > +        *  0: emulated mouse.
> > +        *  1: emulated keyboard.
> > +        *  2: the real game pad.
> > +        * The wireless device creates 5 interfaces:
> > +        *  0: emulated keyboard.
> > +        *  1-4: slots where up to 4 real game pads will be connected to.
> > +        * We know which one is the real gamepad interface because they are the
> > +        * only ones with a feature report.
> > +        */
> > +       rep_enum = &hdev->report_enum[HID_FEATURE_REPORT];
> 
> > +       list_for_each_entry(hreport, &rep_enum->report_list, list) {
> > +               /* should we check hreport->id == 0? */
> > +               return true;
> > +       }
> > +       return false;
> 
> So, for now it's just an equivalent of
> 
> return !list_empty();
> 
> ?

I was expecting to add a few more checks in the middle, but those
weren't needed at the end.
I'll change that.

> 
> > +}
> 
> > +       /*
> > +        * From this point on, if anything fails return 0 and ignores
> > +        * the error, so that the default HID devices are still bound.
> > +        */
> > +       steam = devm_kzalloc(&hdev->dev,
> > +                       sizeof(struct steam_device), GFP_KERNEL);
> 
> sizeof(*steam) saves a line.

Right, changed.

> 
> > +       if (!steam) {
> > +               ret = -ENOMEM;
> > +               goto mem_fail;
> > +       }
> 
> > +static void steam_remove(struct hid_device *hdev)
> > +{
> > +       struct steam_device *steam = hid_get_drvdata(hdev);
> > +
> > +       if (steam && (steam->quirks & STEAM_QUIRK_WIRELESS)) {
> > +               hid_info(hdev, "Steam wireless receiver disconnected");
> > +               hid_hw_close(hdev);
> > +       }
> > +
> > +       hid_hw_stop(hdev);
> > +
> > +       if (steam) {
> > +               cancel_work_sync(&steam->work_connect);
> > +               steam_unregister(steam);
> 
> > +               hid_set_drvdata(hdev, NULL);
> 
> Hmm.. Doesn't HID do this?

Do you mean the hid_set_drvdata(hdev, NULL)? I'm not sure, I didn't see
that on hid-core.c or hid-generic.c. And a call like this is done in
many modules... so I did the same, just to be sure.
> 
> > +       }
> 
> if (steam) {
> ...
>        hid_hw_stop(hdev);
> ...
> } else {
>        hid_hw_stop(hdev);
> }
> 
> ?

I have no real preference. Your version has two 'if', mine has two 'if'.
What about:

static void steam_remove(struct hid_device *hdev)
{
	struct steam_device *steam = hid_get_drvdata(hdev);

	if (!steam) {
		hid_hw_stop(hdev);
		return;
	}

	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
		hid_info(hdev, "Steam wireless receiver disconnected");
		hid_hw_close(hdev);
	}
	hid_hw_stop(hdev);
	cancel_work_sync(&steam->work_connect);
	steam_unregister(steam);
	hid_set_drvdata(hdev, NULL);
}


> 
> > +}
> 
> > +static void steam_do_input_event(struct steam_device *steam,
> > +               struct input_dev *input, u8 *data)
> > +{
> > +       /* 24 bits of buttons */
> > +       u8 b8, b9, b10;
> > +       bool lpad_touched, lpad_and_joy;
> > +
> > +       b8 = data[8];
> > +       b9 = data[9];
> > +       b10 = data[10];
> > +
> > +       input_report_abs(input, ABS_Z, data[11]);
> > +       input_report_abs(input, ABS_RZ, data[12]);
> > +
> > +       /*
> > +        * These two bits tells how to interpret the values X and Y.
> > +        * lpad_and_joy tells that the joystick and the lpad are used at the
> > +        * same time.
> > +        * lpad_touched tells whether X/Y are to be read as lpad coord or
> > +        * joystick values.
> > +        * (lpad_touched || lpad_and_joy) tells if the lpad is really touched.
> > +        */
> 
> > +       lpad_touched = b10 & 0x08;
> 
> BIT(3) ?
> 
> > +       lpad_and_joy = b10 & 0x80;
> 
> BIT(7) ?
> 
> > +       input_event(input, EV_KEY, BTN_TR2, !!(b8 & 0x01));
> > +       input_event(input, EV_KEY, BTN_TL2, !!(b8 & 0x02));
> > +       input_event(input, EV_KEY, BTN_TR, !!(b8 & 0x04));
> > +       input_event(input, EV_KEY, BTN_TL, !!(b8 & 0x08));
> > +       input_event(input, EV_KEY, BTN_Y, !!(b8 & 0x10));
> > +       input_event(input, EV_KEY, BTN_B, !!(b8 & 0x20));
> > +       input_event(input, EV_KEY, BTN_X, !!(b8 & 0x40));
> > +       input_event(input, EV_KEY, BTN_A, !!(b8 & 0x80));
> > +       input_event(input, EV_KEY, BTN_SELECT, !!(b9 & 0x10));
> > +       input_event(input, EV_KEY, BTN_MODE, !!(b9 & 0x20));
> > +       input_event(input, EV_KEY, BTN_START, !!(b9 & 0x40));
> > +       input_event(input, EV_KEY, BTN_GEAR_DOWN, !!(b9 & 0x80));
> > +       input_event(input, EV_KEY, BTN_GEAR_UP, !!(b10 & 0x01));
> > +       input_event(input, EV_KEY, BTN_THUMBR, !!(b10 & 0x04));
> > +       input_event(input, EV_KEY, BTN_THUMBL, !!(b10 & 0x40));
> > +       input_event(input, EV_KEY, BTN_THUMB, lpad_touched || lpad_and_joy);
> > +       input_event(input, EV_KEY, BTN_THUMB2, !!(b10 & 0x10));
> 
> BIT(x) ?
> 
> > +
> > +       input_report_abs(input, ABS_HAT0X,
> > +                       !!(b9 & 0x02) - !!(b9 & 0x04));
> > +       input_report_abs(input, ABS_HAT0Y,
> > +                       !!(b9 & 0x08) - !!(b9 & 0x01));
> 
> BIT(x) ?

That's certainly nicer. Changed.
> 
> > +}
> 
> > +static int steam_raw_event(struct hid_device *hdev,
> > +                       struct hid_report *report, u8 *data,
> > +                       int size)
> > +{
> > +       struct steam_device *steam = hid_get_drvdata(hdev);
> > +       struct input_dev *input;
> > +
> 
> > +       if (!steam)
> > +               return 0;
> 
> When it's possible?

That's because how the new automatic unbinding/rebinding of hid-generic
works. This driver binds all the interfaces of the device, including the
virtual mouse and keyboard (!steam_is_valve_interface()).  Those
hid_devices do not have a steam_device, but they still generate
raw_events.
> 
> > +       return 0;
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko

Regards.
Rodrigo.
