Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751239AbeECU2M (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 16:28:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57656 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbeECU2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 16:28:10 -0400
Subject: Re: [ANNOUNCE] Kconfiglib menuconfig implementation
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAFkk2KRTnRpi5thUGTM2+LZMyitggdJtiOBO7E0pTn93fz6-SQ@mail.gmail.com>
 <d4c3b2ab-385d-fe7a-bdb1-2d497d620de5@infradead.org>
 <CAFkk2KRozscmd4kQSJKwKmY3WpTody7S5XZZObf8SKLF62k6+w@mail.gmail.com>
 <CAFkk2KRkEt3+786QvyjzPPAm+3HDe2+ydzZJpshfdKyUDQVfuw@mail.gmail.com>
 <CAFkk2KRvSxu+x-nb045=3L63KEk5h9URr5QYLPoYp6rqqTR4qA@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3d9be2f2-3fbe-411b-8529-0e0847f01346@infradead.org>
Date: Thu, 3 May 2018 13:28:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAFkk2KRvSxu+x-nb045=3L63KEk5h9URr5QYLPoYp6rqqTR4qA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2018 02:07 PM, Ulf Magnusson wrote:
> On Tue, May 1, 2018 at 9:47 PM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
>> On Tue, May 1, 2018 at 9:12 PM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
>>> On Tue, May 1, 2018 at 7:56 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
>>>> On 04/30/2018 05:57 PM, Ulf Magnusson wrote:
>>>>> Hello,
>>>>>
>>>>> Kconfiglib (https://github.com/ulfalizer/Kconfiglib) now has a
>>>>> terminal menuconfig implementation, implemented in plain curses
>>>>> (which is in the Python standard library).
>>>>>
>>>>> The interface should feel familiar to people used to mconf. It has
>>>>> some features that mconf lacks:
>>>>>
>>>>>   - Seamless resizing
>>>>>
>>>>>   - Unicode support
>>>>>
>>>>>   - Runs on Windows (via 'pip install windows-curses', which uses
>>>>>     PDCurses)
>>>>>
>>>>>   - Improved information displays:
>>>>>
>>>>>     * All expressions are split into readable chunks
>>>>>
>>>>>     * Menus and comments have information displays
>>>>>
>>>>>   - Relatively easy-to-read and easy-to-tweak code.
>>>>>
>>>>>     Kconfiglib automatically invalidates symbols as needed, and
>>>>>     values can never get stale, which helps.
>>>>>
>>>>> Some upcoming features are mouse support and a search feature that
>>>>> can jump directly to the definition of a symbol. The jump-to feature
>>>>> will use a "show-all" mode in case the symbol isn't visible.
>>>>>
>>>>> See the Kconfiglib GitHub page for screenshots. The menuconfig
>>>>> implementation is at
>>>>> https://github.com/ulfalizer/Kconfiglib/blob/master/menuconfig.py.
>>>>> The docstring at the top has some more information.
>>>>
>>>> Hi,
>>>>
>>>> I'm probably missing some python additive (I hope it's that easy), but
>>>> menuconfig.py is not liking the "degree" symbol in drivers/net/can/peak_canfd/Kconfig:
>>>>
>>>> config CAN_PEAK_PCIEFD
>>>>         depends on PCI
>>>>         tristate "PEAK-System PCAN-PCIe FD cards"
>>>>         ---help---
>>>>           This driver adds support for the PEAK-System PCI Express FD
>>>>           CAN-FD cards family.
>>>>           These 1x or 2x CAN-FD channels cards offer CAN 2.0 a/b as well as
>>>>           CAN-FD access to the CAN bus. Besides the nominal bitrate of up to
>>>>           1 Mbit/s, the data bytes of CAN-FD frames can be transmitted with
>>>>           up to 12 Mbit/s. A galvanic isolation of the CAN ports protects the
>>>>           electronics of the card and the respective computer against
>>>>           disturbances of up to 500 Volts. The PCAN-PCI Express FD can be
>>>>           operated with ambient temperatures in a range of -40 to +85 °C.
>>>>
>>>>
>>>> kconfiglib.KconfigSyntaxError:
>>>> Malformed ascii in drivers/net/can/peak_canfd/Kconfig
>>>> Context: b't temperatures in a range of -40 to +85 \xc2\xb0C.\n'
>>>> Problematic data: b'\xc2'
>>>> Reason: ordinal not in range(128)
>>>>
>>>>
>>>> thanks,
>>>> --
>>>> ~Randy
>>>
>>> Thanks for trying it out!
>>>
>>> You're probably running in the C locale, which implies an ASCII
>>> encoding. That has caused enough trouble that the Python devs decided
>>> to automatically convert it to UTF-8 in Python 3.7:
>>> https://www.python.org/dev/peps/pep-0538/. LC_CTYPE=C.UTF-8 should fix
>>> it.
>>>
>>> It's a bit silly to have it crash for something like that though. I
>>> could force UTF-8 instead of respecting the locale (though it feels
>>> neater to respect settings), or tell Python to ignore decoding errors.
>>> Should probably do something at least...
>>>
>>> Cheers,
>>> Ulf
>>
>> Leaning towards just forcing UTF-8. It's what you want in 99% of
>> cases, and ignoring decoding errors would be unsafe for Unicode string
>> values.
>>
>> Could make the forcing optional, and default to on...
>>
>> Cheers,
>> Ulf
> 
> Went with a more general solution:
> https://github.com/ulfalizer/Kconfiglib/commit/da40c014398f329b324a2eb9de062344e773dc74
> 
> You can now specify any encoding (or None, to use the encoding
> specified in the environment), with "utf-8" as the default. That
> default probably saves a bunch of pain in practice.

Hi,

(with new kconfiglib.py and menuconfig.py)

Thanks for the fixes.

If I use "LC_CTYPE=C.UTF-8" then I get the down arrows in the bottom colored
bar.  Without that, I get an upside-down T (that is 193, 0xc1, line drawing
character in the IBM extended character set).

Hm. With LC_CTYPE=C.UTF-8, the upper colored bar prints up arrows.
Without that, it prints ^^^^^^^^^^^^^^.
That's nice that it can do either.

Being a vim user, I do like the optional navigation keys.

-- 
~Randy
