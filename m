Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbeENSMY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:12:24 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:38377 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbeENSMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:12:23 -0400
X-Google-Smtp-Source: AB8JxZpbYBBPXp8D/d4XNOoaXyAf9l3PyImAJu431g3uv5CvlyhZ/FWE6+dAZa0Qq5ozIZCIbNUYWW580Or0j0eZZbM=
MIME-Version: 1.0
In-Reply-To: <20180514165844.GD27984@xo-6d-61-c0.localdomain>
References: <CAFkk2KRTnRpi5thUGTM2+LZMyitggdJtiOBO7E0pTn93fz6-SQ@mail.gmail.com>
 <d4c3b2ab-385d-fe7a-bdb1-2d497d620de5@infradead.org> <CAFkk2KRozscmd4kQSJKwKmY3WpTody7S5XZZObf8SKLF62k6+w@mail.gmail.com>
 <20180514165844.GD27984@xo-6d-61-c0.localdomain>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Mon, 14 May 2018 20:12:21 +0200
Message-ID: <CAFkk2KQX=j5_VCSRR1fm31x=yC3zse47fnpJaqpLGOLw-v5QkA@mail.gmail.com>
Subject: Re: [ANNOUNCE] Kconfiglib menuconfig implementation
To: Pavel Machek <pavel@ucw.cz>
Cc: Randy Dunlap <rdunlap@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4EICV5u031414

On Mon, May 14, 2018 at 6:58 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> > config CAN_PEAK_PCIEFD
>> >         depends on PCI
>> >         tristate "PEAK-System PCAN-PCIe FD cards"
>> >         ---help---
>> >           This driver adds support for the PEAK-System PCI Express FD
>> >           CAN-FD cards family.
>> >           These 1x or 2x CAN-FD channels cards offer CAN 2.0 a/b as well as
>> >           CAN-FD access to the CAN bus. Besides the nominal bitrate of up to
>> >           1 Mbit/s, the data bytes of CAN-FD frames can be transmitted with
>> >           up to 12 Mbit/s. A galvanic isolation of the CAN ports protects the
>> >           electronics of the card and the respective computer against
>> >           disturbances of up to 500 Volts. The PCAN-PCI Express FD can be
>> >           operated with ambient temperatures in a range of -40 to +85 °C.
>> >
>> >
>> > kconfiglib.KconfigSyntaxError:
>> > Malformed ascii in drivers/net/can/peak_canfd/Kconfig
>> > Context: b't temperatures in a range of -40 to +85 \xc2\xb0C.\n'
>> > Problematic data: b'\xc2'
>> > Reason: ordinal not in range(128)
>> >
>> >
>> > thanks,
>> > --
>> > ~Randy
>>
>> Thanks for trying it out!
>>
>> You're probably running in the C locale, which implies an ASCII
>> encoding. That has caused enough trouble that the Python devs decided
>> to automatically convert it to UTF-8 in Python 3.7:
>> https://www.python.org/dev/peps/pep-0538/. LC_CTYPE=C.UTF-8 should fix
>> it.
>>
>> It's a bit silly to have it crash for something like that though. I
>> could force UTF-8 instead of respecting the locale (though it feels
>> neater to respect settings), or tell Python to ignore decoding errors.
>> Should probably do something at least...
>
> Well, Kconfig files are utf-8, as is the rest of kernel.

Yeah, it's the only sane assumption anyway.

>
> So yes, you should respect $LC_CTYPE for display etc, but you should always
> assume Kconfig files are utf-8... and that does not need to be optional.

Already made it optional, with UTF-8 as the default (via
Kconfig.__init__(..., encoding="utf-8")).

I did a similar thing to what PEP 538 does for the menuconfig:
https://github.com/ulfalizer/Kconfiglib/blob/master/menuconfig.py#L2271.
The C locale is converted to a UTF-8 locale for LC_CTYPE if possible.
Other locales are respected. That'll be the default behavior in Python
3.7, and prevents issues with get_wch().

>
>                                                                         Pavel

Cheers,
Ulf
