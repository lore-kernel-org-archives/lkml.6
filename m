Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751080AbeEATdz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 15:33:55 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:41761 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750755AbeEATdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 15:33:53 -0400
X-Google-Smtp-Source: AB8JxZowsPdrwV7W3UZTzUnKB/YpsWOMRhuUye/Gff0hSST5Oug/j67+7JNvBFTxJSAZtCJbXDaiozJDsspNm5VDjaw=
MIME-Version: 1.0
In-Reply-To: <ac506aa3-e5f6-9bfa-a18b-441e04b21d97@infradead.org>
References: <CAFkk2KRTnRpi5thUGTM2+LZMyitggdJtiOBO7E0pTn93fz6-SQ@mail.gmail.com>
 <d4c3b2ab-385d-fe7a-bdb1-2d497d620de5@infradead.org> <25f6b309-9346-7e28-beeb-a37e69a91ce8@infradead.org>
 <ac506aa3-e5f6-9bfa-a18b-441e04b21d97@infradead.org>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Tue, 1 May 2018 21:33:52 +0200
Message-ID: <CAFkk2KRcx4c-pzNVfxpvom4kq1QTyrP_gEyNg+NtdXoq3RzoFg@mail.gmail.com>
Subject: Re: [ANNOUNCE] Kconfiglib menuconfig implementation
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w41JY0jY030397

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

It's just a separator above the help text with the keys. Also has
arrows pointing down when the window is scrolled up.

Maybe the help text could appear directly at the bottom with a
different background color instead. Not sure if it'd get uglier.

>
> On Quit, don't need to prompt for Save when the file is already saved
> or has not been modified.

Will fix. I had gotten the idea that mconf always prompted, so I got
lazy for the initial version. :)

>
> When menuconfig displays the Kconfig menu tree and it is over term-width
> characters, it truncates on the left so that the user can see all of
> the current menu name. menuconfig.py truncates on the right so that
> the current menu name may be partially lost or totally lost.

You mean the menu path at the top? Will fix that.

>
> To enable=y a tristate symbol, cannot enter Y, must do Space Space to cycle
> from N to M to Y.

Had never noticed that feature in mconf. I'll add it.

>
> No / symbol search. I use that a lot, but I don't claim to be a
> typical user.

It's planned. It will also support jumping directly to a symbol in the
menu tree, which is a feature I've always missed in mconf.

A "show all" mode will be added at the same time, that shows invisible
symbols. Jumping to an invisible symbol can then turn it in
automatically.

>
>
> Thanks.
> --
> ~Randy

Cheers,
Ulf
