Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752703AbeBFLHL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 06:07:11 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33911 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752183AbeBFLHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 06:07:01 -0500
X-Google-Smtp-Source: AH8x224tZohAYxYOap9bT7wTKg7Qpj+QdHgV5fPWtPEwGhhEN7bJcMWaa4uyCkQVD2rUm8QN2qvQDvDlPPaInx3fMo0=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2bQzn39cFSspJKP6HoUuV7cxSw4AZpVRVvD=FMAYfp5Q@mail.gmail.com>
References: <CGME20180115161439epcas3p1006f02c4e49f58c30c4aec1b0b11b0a7@epcas3p1.samsung.com>
 <20180115161431.803248-1-arnd@arndb.de> <1737876.npfVsP8Sog@amdc3058>
 <faff816c-d9d6-cb75-fe24-ba19fa92bd7e@infradead.org> <CAK8P3a2bQzn39cFSspJKP6HoUuV7cxSw4AZpVRVvD=FMAYfp5Q@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 6 Feb 2018 12:07:00 +0100
X-Google-Sender-Auth: Wh-uzbUSTPvhkL9-s1HTfzvTDCk
Message-ID: <CAMuHMdUdagXOG=v-xsLBoTb=rjS0HgAxZJE92NZsyqFzG=CVaQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fbdev: don't select I2C directly
To: Arnd Bergmann <arnd@arndb.de>
Cc: Randy Dunlap <rdunlap@infradead.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Rob Clark <robdclark@gmail.com>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 2, 2018 at 12:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Feb 2, 2018 at 1:21 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
>> b. DRM configuration is a mess. You shouldn't want to follow their model. :)
>
> Right, that should also be fixed, so DRM no longer includes I2C ;-)
>
> At the moment, DRM is the most common cause for circular dependencies
> because it has a number of 'select' statements for symbols that otherwise
> are used with 'depends on'. We should probably address the 'select I2C'
> portion in there, but also some of the others like:
>
> drivers/gpu/drm/Kconfig:        select POWER_SUPPLY
> drivers/gpu/drm/Kconfig:        select HWMON
> drivers/gpu/drm/Kconfig:        select FB
> drivers/gpu/drm/udl/Kconfig: select USB

USB? Seriously?

> drivers/gpu/drm/sti/Kconfig: select OF
> drivers/gpu/drm/sti/Kconfig: select RESET_CONTROLLER
> drivers/gpu/drm/etnaviv/Kconfig:        select CMA if HAVE_DMA_CONTIGUOUS
> drivers/gpu/drm/etnaviv/Kconfig:        select TMPFS
> drivers/gpu/drm/i915/Kconfig.debug:        select DEBUG_FS
> drivers/gpu/drm/i915/Kconfig.debug:        select PREEMPT_COUNT
> drivers/gpu/drm/i915/Kconfig.debug:     select TRACING
> drivers/gpu/drm/i915/Kconfig.debug:     select FAULT_INJECTION
> drivers/gpu/drm/mediatek/Kconfig:       select MEMORY
> drivers/gpu/drm/mediatek/Kconfig:       select GENERIC_PHY
> drivers/gpu/drm/msm/Kconfig:    select REGULATOR
>
>> c. If I2C is not enabled in the FB menu, someone could just add something like this:
>>
>> comment "Enable I2C to see more driver choices"
>>         depends on !I2C
>
> I don't think that would address the issue of 'defconfig' builds losing
> I2C support when it's no longer automatically selection. On x86, this
> is not an issue, as X86 always enables I2C. For the rest, we could
> do a hack like this:
>
> --- a/drivers/i2c/Kconfig
> +++ b/drivers/i2c/Kconfig
> @@ -8,6 +8,7 @@ config I2C
>         tristate "I2C support"
>         select RT_MUTEXES
>         select IRQ_DOMAIN
> +       default DRM || FB
>         ---help---
>           I2C (pronounce: I-squared-C) is a slow serial bus protocol used in
>           many micro controller applications and developed by Philips.  SMBus,
>
> which would let all 'defconfig' versions keep working. It's a bit ugly, but
> at least wouldn't cause other circular dependencies.

And then we'll have to refresh all defconfigs for machines with FB and
without I2C?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
