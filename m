Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752643AbeEUDdf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 23:33:35 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42485 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751524AbeEUDdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 23:33:33 -0400
X-Google-Smtp-Source: AB8JxZqMmrDwCnOl0SN9dkMcFXDZF4bUakWkAde0PwkusaRtRPR5wudRd6872eObmxn4RUWKAAkDMt1X0mPprpSokDU=
MIME-Version: 1.0
In-Reply-To: <4a4b12fc-ab54-20c4-7aa7-a83c4faecf25@infradead.org>
References: <CAFkk2KRTnRpi5thUGTM2+LZMyitggdJtiOBO7E0pTn93fz6-SQ@mail.gmail.com>
 <d4c3b2ab-385d-fe7a-bdb1-2d497d620de5@infradead.org> <CAFkk2KRozscmd4kQSJKwKmY3WpTody7S5XZZObf8SKLF62k6+w@mail.gmail.com>
 <CAFkk2KRkEt3+786QvyjzPPAm+3HDe2+ydzZJpshfdKyUDQVfuw@mail.gmail.com>
 <CAFkk2KRvSxu+x-nb045=3L63KEk5h9URr5QYLPoYp6rqqTR4qA@mail.gmail.com>
 <3d9be2f2-3fbe-411b-8529-0e0847f01346@infradead.org> <CAFkk2KRWon_S--dxYw82cDyGXKTFA6jxrrQwstzLvHPs=6-dqQ@mail.gmail.com>
 <c4ec710f-b2bd-b9f0-c33a-159aa53ca73c@infradead.org> <1378afb3-2b0e-da7a-5721-a8fa727e4382@infradead.org>
 <CAFkk2KS=bYn3t-764CEy+sq9E8FUbWH=L-yQbDhAYQpnrgmsiQ@mail.gmail.com> <4a4b12fc-ab54-20c4-7aa7-a83c4faecf25@infradead.org>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Mon, 21 May 2018 05:33:31 +0200
Message-ID: <CAFkk2KTrC7DEe7dU4Jq13YBNWGDSa8KmMm0mpFvxokrKeMzCFg@mail.gmail.com>
Subject: Re: [ANNOUNCE] Kconfiglib menuconfig implementation
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 4:45 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 05/19/2018 09:47 PM, Ulf Magnusson wrote:
>> On Sun, May 20, 2018 at 6:03 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
>>> On 05/19/2018 08:45 PM, Randy Dunlap wrote:
>>>> On 05/08/2018 09:59 AM, Ulf Magnusson wrote:
>>>>> Hello,
>>>>>
>>>>> I've added incremental search for jumping directly to a symbol now.
>>>>> Regular expressions are supported as well.
>>>>>
>>>>> Some screenshots below:
>>>>>
>>>>> https://raw.githubusercontent.com/ulfalizer/Kconfiglib/screenshots/screenshots/ss10.png
>>>>> https://raw.githubusercontent.com/ulfalizer/Kconfiglib/screenshots/screenshots/ss11.png
>>>>> https://raw.githubusercontent.com/ulfalizer/Kconfiglib/screenshots/screenshots/ss13.png
>>>>>
>>>>> The last screenshot shows how things might look after you jump to a
>>>>> symbol. The jumped-to symbol wasn't visible in this case, so show-all
>>>>> mode was turned on automatically.
>>>>
>>>> Hi Ulf,
>>>>
>>>>
>>>>
>>>> Hm, OK, I used the trick that you supplied a few weeks ago and I have the UI now.
>>>>
>>>>     ARCH=x86 SRCARCH=x86 KERNELVERSION=`make kernelversion` \
>>>>         Kconfiglib/menuconfig.py
>>>>
>>>> so yes, a real Makefile target would be nice. :)
>>>
>>> I want to see all kconfig symbols that end with "_DEBUG" (so excluding
>>> _DEBUGFS).  Using:
>>>
>>> /.*_DEBUG$
>>>
>>> shows me 6 symbols:
>>> ATH9K_COMMON_DEBUG
>>> DVB_B2C2_FLEXCOP_DEBUG
>>> HAVE_DMA_API_DEBUG
>>> IP_DCCP_TFRC_DEBUG
>>> NFS_DEBUG
>>> PM_SLEEP_DEBUG
>>>
>>> so where are the other (approx.) 176?
>>> see:
>>> $ find . -name Kconfig\* | xargs grep "config.*_DEBUG$" | grep -v \.orig | wc
>>>     182     364    9179
>>>
>>>
>>> Anyway, something for you to look at. :)
>>>
>>> --
>>> ~Randy
>>
>> It's related to how the search is done. Searching for "DEBUG\b" (word
>> boundary) instead will find all of them.
>>
>> A string is generated for each symbol. For symbols with prompts, this
>> string includes the prompt as well, so you get e.g.
>>
>>     AB8500_DEBUG "Enable debug info via debugfs"
>>
>> Those strings are then searched/displayed.
>>
>> What you got with your search was all symbols whose names end in
>> "_DEBUG" that don't have a prompt.
>>
>> The nice thing about searching both the name and the prompt is that
>> e.g. "debugfs ab8500" will find the symbol above. I'm also planning to
>> add menus to the search, by generating 'menu: "menu title"' strings
>> for them.
>>
>> It's a bit awkward/unintuitive that what you tried doesn't work
>> though. Maybe the symbol name could be searched separately from the
>> prompt, though I'd be a bit sad to abandon the super simple
>> single-string-per-entry implementation approach. :)
>
> Hi Ulf,
>
> What else are you planning to do with /(search)?

Here's the stuff I've thought of so far:

  - Display invisible symbols in red (to match show-all mode)

  - Search prompts of menus and comments as well

  - Have [F1] show the help display without canceling the search,
    so you can quickly scan through a bunch of symbols

Maybe you could get fancy with stuff like finding symbols that are
related to other symbols in particular ways too...

> /syscall lists 20 or so symbols. It would be nice if each one of those
> showed its current setting [y,n,maybe^Wm].

Nice idea. I added it:
https://github.com/ulfalizer/Kconfiglib/commit/3161affaa5bb8350a39bfd305c56171a25b02151

Works for strings/int/hex too.

> I like Toggle show-all mode.  When I use xconfig, I usually turn on most
> of its options, including one like that.

IIRC, xconfig doesn't make it very clear which symbols are invisible
in show-all mode. That's why I made them red.

>
> --
> ~Randy

Cheers,
Ulf
