Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034669AbeEXWFU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 18:05:20 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38108 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966031AbeEXWFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 18:05:18 -0400
X-Google-Smtp-Source: AB8JxZp0ZNmh+tNmfac9S+kNSAcqhN8E/txwO1kG3Fz5s25JSFYqwgUs6Fo8hzfBnfFondZuthXfiAnMrGLp8agDyuU=
MIME-Version: 1.0
In-Reply-To: <20180524162157.GA26662@kroah.com>
References: <20180523021656.122455-1-drinkcat@chromium.org>
 <Pine.LNX.4.44L0.1805230958590.1481-100000@iolanthe.rowland.org>
 <20180523163936.GE12456@kroah.com> <CANMq1KD8SpPQ7UTy2wN0J84dsA86Skmbb5q0OjkG+-BZShiv-A@mail.gmail.com>
 <20180524162157.GA26662@kroah.com>
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Fri, 25 May 2018 06:05:16 +0800
Message-ID: <CANMq1KBmE9i=Th46q06+3bY34LuLwd=U-otTxj5D9M0H2Kcaqw@mail.gmail.com>
Subject: Re: [PATCH] usb: hub: Per-port setting to use old enumeration scheme
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Eugene Korenevsky <ekorenevsky@gmail.com>,
        Peter Chen <peter.chen@nxp.com>, Daniel Drake <drake@endlessm.com>,
        Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>,
        Richard Leitner <richard.leitner@skidata.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 12:21 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, May 24, 2018 at 07:42:00AM +0800, Nicolas Boichat wrote:
>> On Thu, May 24, 2018 at 12:39 AM, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>> > On Wed, May 23, 2018 at 10:03:55AM -0400, Alan Stern wrote:
>> >> On Wed, 23 May 2018, Nicolas Boichat wrote:
>> >>
>> >> > The "old" enumeration scheme is considerably faster (it takes
>> >> > ~294ms instead of ~439ms to get the descriptor).
>> >> >
>> >> > It is currently only possible to use the old scheme globally
>> >> > (/sys/module/usbcore/parameters/old_scheme_first), which is not
>> >> > desirable as the new scheme was introduced to increase compatibility
>> >> > with more devices.
>> >> >
>> >> > However, in our case, we care about time-to-active for a specific
>> >> > USB device (which we make the firmware for), on a specific port
>> >> > (that is pogo-pin based: not a standard USB port). This new
>> >> > sysfs option makes it possible to use the old scheme on a single
>> >> > port only.
>> >> >
>> >> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
>> >> > ---
>> >> >
>> >> > There are other "quirks" that we could add to reduce further
>> >> > enumeration time (e.g. reduce USB debounce time, reduce TRSTRCY
>> >> > to 10ms instead of 50ms as used currently), but the logic is quite
>> >> > similar, so it'd be good to have this reviewed first.
>> >>
>> >> I'm not opposed to the idea in principle, although I don't like your
>> >> implementation because it breaks the original old_scheme_first
>> >> parameter.
>>
>> I don't think it breaks the original parameter? I mean,
>> /sys/module/usbcore/parameters/old_scheme_first is still a global
>> default, while bit 0 of /sys/bus/usb/devices/x/y/z/quirks becomes a
>> port-specific override.
>>
>> >> Let's see what some other people think.
>> >>
>> >> Yours is a rather special case, because you know exactly what device
>> >> will be attached to a specific port.  Still, I can see that sort of
>> >> thing happening in constrained and special-purpose settings.
>> >>
>> >> How do you arrange to set the new quirk before the device is
>> >> discovered?
>> >
>> > Yeah, this last question is what I had when looking at this.  Or does it
>> > not matter at first boot and only matters for wake-up?
>>
>> It does not matter on boot, we have plenty of time to enumerate the
>> device. We use USB (auto-)suspend and remote wake, so no
>> re-enumeration there either. It only matters on unplug/replug where
>> the device needs to be re-enumerated.
>
> How does this device get unplugged/replugged if it is connected directly
> to the device?

It is external. Essentially, this is a tablet with a detachable
keyboard/touchpad. The interface between tablet and base is USB, over
pogo pins. The port is non-standard (pogo, not normal USB), and we
fully control the firmware on the base side as well, which allows us
to take shortcuts like this: we know exactly what device will be
connected on that port.

>> Somewhere in an init script, we would do this (we know in advance that
>> usb1 port2 is the bus/port where we have our pogo-pin USB interface,
>> so we can hard-code the path):
>> echo 1 > /sys/bus/usb/devices/usb1/1-0:1.0/usb1-port2/quirks
>>
>> We could try to add ACPI support (just like connect_type), but we
>> don't strictly need it for our application.
>
> Isn't there an "internal" ACPI flag for USB ports, or is that
> what connect_type is?  Why wouldn't that work here instead?

What we may need here is something like "external but non-standard, so
we can ignore compatibility constraints when enumerating"...

Thanks,
