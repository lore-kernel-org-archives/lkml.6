Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbeECCr2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 22:47:28 -0400
Received: from mail-ot0-f180.google.com ([74.125.82.180]:46347 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751929AbeECCrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 22:47:25 -0400
X-Google-Smtp-Source: AB8JxZoCrmR8kktQ1eB1Aab94cTDZkk+ETD6d1knXrfeW94vmB+B5g3JHH1XPxFxh5iXS2kykKjysmHgt+1Yi0zrBhY=
MIME-Version: 1.0
In-Reply-To: <ac506aa3-e5f6-9bfa-a18b-441e04b21d97@infradead.org>
References: <CAFkk2KRTnRpi5thUGTM2+LZMyitggdJtiOBO7E0pTn93fz6-SQ@mail.gmail.com>
 <d4c3b2ab-385d-fe7a-bdb1-2d497d620de5@infradead.org> <25f6b309-9346-7e28-beeb-a37e69a91ce8@infradead.org>
 <ac506aa3-e5f6-9bfa-a18b-441e04b21d97@infradead.org>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Thu, 3 May 2018 04:47:24 +0200
Message-ID: <CAFkk2KTE+h+UY83vvbFDgG9zcyNy4jZYg+-O3p1yOBmLH-K9Xw@mail.gmail.com>
Subject: Re: [ANNOUNCE] Kconfiglib menuconfig implementation
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w432lZLF015280

On Tue, May 1, 2018 at 8:52 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 05/01/2018 11:13 AM, Randy Dunlap wrote:
>> On 05/01/2018 10:56 AM, Randy Dunlap wrote:
>>> On 04/30/2018 05:57 PM, Ulf Magnusson wrote:
>>>> Hello,
>>>>
>>>> Kconfiglib (https://github.com/ulfalizer/Kconfiglib) now has a
>>>> terminal menuconfig implementation, implemented in plain curses
>>>> (which is in the Python standard library).
>>>>
>>>> The interface should feel familiar to people used to mconf. It has
>>>> some features that mconf lacks:
>>>>
>>>>   - Seamless resizing
>>>>
>>>>   - Unicode support
>>>>
>>>>   - Runs on Windows (via 'pip install windows-curses', which uses
>>>>     PDCurses)
>>>>
>>>>   - Improved information displays:
>>>>
>>>>     * All expressions are split into readable chunks
>>>>
>>>>     * Menus and comments have information displays
>>>>
>>>>   - Relatively easy-to-read and easy-to-tweak code.
>>>>
>>>>     Kconfiglib automatically invalidates symbols as needed, and
>>>>     values can never get stale, which helps.
>>>>
>>>> Some upcoming features are mouse support and a search feature that
>>>> can jump directly to the definition of a symbol. The jump-to feature
>>>> will use a "show-all" mode in case the symbol isn't visible.
>>>>
>>>> See the Kconfiglib GitHub page for screenshots. The menuconfig
>>>> implementation is at
>>>> https://github.com/ulfalizer/Kconfiglib/blob/master/menuconfig.py.
>>>> The docstring at the top has some more information.
>>>
>>> Hi,
>>>
>>> I'm probably missing some python additive (I hope it's that easy), but
>>> menuconfig.py is not liking the "degree" symbol in drivers/net/can/peak_canfd/Kconfig:
>>>
>>> config CAN_PEAK_PCIEFD
>>>      depends on PCI
>>>      tristate "PEAK-System PCAN-PCIe FD cards"
>>>      ---help---
>>>        This driver adds support for the PEAK-System PCI Express FD
>>>        CAN-FD cards family.
>>>        These 1x or 2x CAN-FD channels cards offer CAN 2.0 a/b as well as
>>>        CAN-FD access to the CAN bus. Besides the nominal bitrate of up to
>>>        1 Mbit/s, the data bytes of CAN-FD frames can be transmitted with
>>>        up to 12 Mbit/s. A galvanic isolation of the CAN ports protects the
>>>        electronics of the card and the respective computer against
>>>        disturbances of up to 500 Volts. The PCAN-PCI Express FD can be
>>>        operated with ambient temperatures in a range of -40 to +85 °C.
>>>
>>>
>>> kconfiglib.KconfigSyntaxError:
>>> Malformed ascii in drivers/net/can/peak_canfd/Kconfig
>>> Context: b't temperatures in a range of -40 to +85 \xc2\xb0C.\n'
>>> Problematic data: b'\xc2'
>>> Reason: ordinal not in range(128)
>>
>> BTW, after modifying 4 other instances of this "error," I have it running.
>> Now looking/testing. :)
>
> Hi Ulf,
>
> Here are a few comments for you FWIW.
>
> menuconfig.py uses the terminal window space better than menuconfig:
> fewer margins, less Help text so more usable lines.
>
> ESC/q is nicer than in ESC+ESC in menuconfig.
>
> What is the lower colored line for? I don't see it being used.

It might show "Show-all mode enabled" now too. ;)

>
> On Quit, don't need to prompt for Save when the file is already saved
> or has not been modified.

Fixed.

>
> When menuconfig displays the Kconfig menu tree and it is over term-width
> characters, it truncates on the left so that the user can see all of
> the current menu name. menuconfig.py truncates on the right so that
> the current menu name may be partially lost or totally lost.

Fixed. The menu path now scrolls to the right as needed. Maybe "..."
could be displayed as well, though I'm not sure if it's helpful in
practice.

>
> To enable=y a tristate symbol, cannot enter Y, must do Space Space to cycle
> from N to M to Y.

Fixed.

>
> No / symbol search. I use that a lot, but I don't claim to be a
> typical user.

Coming soon. I have added a "show-all" mode in preparation for it, as
you might want to jump to invisible symbols.

Screenshot: https://raw.githubusercontent.com/ulfalizer/Kconfiglib/screenshots/screenshots/ss9.png

>
>
> Thanks.
> --
> ~Randy

Thanks for the feedback! Tell me if you spot anything else.

Cheers,
Ulf
