Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754683AbeDWJ2o (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 05:28:44 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:41237 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754401AbeDWJ2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 05:28:39 -0400
X-Google-Smtp-Source: AB8JxZrOC/pj0ZkiZp14T5vgOjWSuDUcg/B49wo9IzhPKH4n8QY+To4f//8GBCvmnGqxsZq/o1S2zP1TBa7o1EJPpoo=
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVQea-tQ4vQF=SrkCCqaRCRyo=aBiAuyv7p0z0FEi3r2g@mail.gmail.com>
References: <0ca46228311ec615947e199def9fed62d70c1f07.1524118799.git.baolin.wang@linaro.org>
 <CAK8P3a15stj5Yurd7rM7278cYPtM6kufs=QL2GihCOxRUCHRSQ@mail.gmail.com> <CAMuHMdVQea-tQ4vQF=SrkCCqaRCRyo=aBiAuyv7p0z0FEi3r2g@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 23 Apr 2018 11:28:38 +0200
X-Google-Sender-Auth: V1lZrzUxIWLHK-TECC4-UKLpQK0
Message-ID: <CAK8P3a2FNU2k=nzE=FCt=2GL2x=-UdhkFGUJQqFe-h8FfMZRdw@mail.gmail.com>
Subject: Re: [PATCH] m68k: Remove read_persistent_clock()
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Baolin Wang <baolin.wang@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Finn Thain <fthain@telegraphics.com.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 11:07 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Arnd,
>
> On Fri, Apr 20, 2018 at 5:22 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Thu, Apr 19, 2018 at 8:22 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>>> The read_persistent_clock() uses a timespec, which is not year 2038 safe
>>> on 32bit systems. Moreover on m68k architecture, we have implemented generic
>>> RTC drivers that can be used to compensate the system suspend time. So
>>> we can remove the obsolete read_persistent_clock().
>>>
>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>>
>> I'm not sure about this one: it's still possible to turn off
>> CONFIG_RTC_DRV_GENERIC
>> on M68KCLASSIC, and in that case we still need a read_persistent_clock64()
>> implementation. Or we use your patch but make CONFIG_RTC_DRV_GENERIC
>> mandatory.
>
> Typically (in the defconfigs) CONFIG_RTC_DRV_GENERIC is either "m",
> or not set.
>
> And in both cases, a platform-specific RTC class driver may or may not be
> builtin or loaded. We have them for some Amigas (RTC_DRV_MSM6242 or
> RTC_DRV_RP5C01).
>
> I've never been an expert of timekeeping code...

Some extra background on this:

read_persistent_clock64/read_persistent_clock is primarily needed when you
have a real time source that is better than the one exposed in the RTC class
driver.  For platforms doing suspend/resume, the timekeeping code will
first try calling read_persistent_clock64() but fall back to the RTC
if that fails.
On only a few architectures like m68k, read_persistent_clock64() falls
back to reading the RTC hardware, which means it will still work even if
the RTC_DRV_GENERIC driver is not loaded. Removing that code will
still work correctly as long as the generic RTC driver does get loaded
before suspend. On platforms without suspend/resume, none of this matters.

The other user of read_persistent_clock() is to set the initial time at boot.
This again can be done by the RTC subsystem if the correct RTC driver
is built-in and CONFIG_RTC_HCTOSYS is set. Alexandre is planning
to remove that option and instead force early user space to load the
RTC driver and then sync it manually using the sysfs knob for it.

If you have ancient user space that doesn't do this, you might still
rely on read_persistent_clock() to set the boot time.

> Should we get rid of ARCH_USES_GETTIMEOFFSET?
> it seems m68k and two ARM platforms are the last users.
> What needs to be done?

This is entirely unrelated, but generally speaking it would be
great to convert m68k away from ARCH_USES_GETTIMEOFFSET,
yes.

The first step would be to get rid of all the dummy gettimeoffset() functions
that return a constant (like dn_gettimeoffset()).

The larger part of that effort would be to turn each clock implementation
in m68k into a real clocksource driver. This is probably straightforward,
but I don't know the details (adding LinusW to Cc, he's done this on
some ARM hardware in the past).

>> See below for a version I did a while ago (but never submitted as I got
>> distracted).
>
> Thanks, I can apply it, if it is deemed correct ;-)

Please apply Finn's bugfix for the month-off bug first, that one is more
urgent. I've rebased my patch on top of his and resent that one.

       Arnd
