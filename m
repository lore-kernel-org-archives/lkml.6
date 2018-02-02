Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751710AbeBBMAB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 07:00:01 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:35668 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751561AbeBBL7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 06:59:53 -0500
X-Google-Smtp-Source: AH8x226dk2TtMw9NHXqsuFmOcDz34ezsgsYB6EvojrIBmo/l62wy5Go4DbKF3jLRWuiaI9eyHQHrTZW0EQqO0VqrTvc=
MIME-Version: 1.0
In-Reply-To: <faff816c-d9d6-cb75-fe24-ba19fa92bd7e@infradead.org>
References: <CGME20180115161439epcas3p1006f02c4e49f58c30c4aec1b0b11b0a7@epcas3p1.samsung.com>
 <20180115161431.803248-1-arnd@arndb.de> <1737876.npfVsP8Sog@amdc3058> <faff816c-d9d6-cb75-fe24-ba19fa92bd7e@infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 2 Feb 2018 12:59:52 +0100
X-Google-Sender-Auth: erm8z8sBdEawmd6KL90r8TYrX8k
Message-ID: <CAK8P3a2bQzn39cFSspJKP6HoUuV7cxSw4AZpVRVvD=FMAYfp5Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] fbdev: don't select I2C directly
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Rob Clark <robdclark@gmail.com>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 2, 2018 at 1:21 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 02/01/2018 08:14 AM, Bartlomiej Zolnierkiewicz wrote:
>> On Monday, January 15, 2018 05:14:04 PM Arnd Bergmann wrote:
>>> Using a Kconfig 'select' statement for a user-visible symbol that other
>>> drivers depend on often causes circular dependencies. A new one showed
>>> up when I wanted to add an NVMEM dependency to the DRM_MSM driver:
>>>
>>> drivers/i2c/Kconfig:7:error: recursive dependency detected!
>>> drivers/i2c/Kconfig:7:       symbol I2C is selected by FB_DDC
>>> drivers/video/fbdev/Kconfig:63:      symbol FB_DDC is selected by FB_CYBER2000_DDC
>>> drivers/video/fbdev/Kconfig:390:     symbol FB_CYBER2000_DDC depends on FB_CYBER2000
>>> drivers/video/fbdev/Kconfig:378:     symbol FB_CYBER2000 depends on FB
>>> drivers/video/fbdev/Kconfig:5:       symbol FB is selected by DRM_KMS_FB_HELPER
>>> drivers/gpu/drm/Kconfig:77:  symbol DRM_KMS_FB_HELPER depends on DRM_KMS_HELPER
>>> drivers/gpu/drm/Kconfig:71:  symbol DRM_KMS_HELPER is selected by DRM_MSM
>>> drivers/gpu/drm/msm/Kconfig:2:       symbol DRM_MSM depends on NVMEM
>>> drivers/nvmem/Kconfig:1:     symbol NVMEM is selected by EEPROM_AT24
>>> drivers/misc/eeprom/Kconfig:3:       symbol EEPROM_AT24 depends on I2C
>>>
>>> Here, the problem is that many fbdev drivers have an i2c based interface
>>> and just 'select i2c' for that, while we also select the framebuffer
>>> subsystem indirectly from a DRM driver that now depends on i2c.
>>>
>>> This does away with the 'select' statement and instead uses 'depends on',
>>> like almost all I2C users.
>>
>> I worry that this change may cause various driver options to no longer
>> be visible to people configuring their kernels and not having I2C already
>> selected.
>>
>> DRM somehow manages to select I2C and I would prefer to be it the same
>> way for fbdev (also looking at the current next tree there are still
>> some drivers that 'select I2C')..
>
> a. Linus has stated that a driver should not enable an entire subsystem,
>    so depends on would be better than select.
>    If I had the email/patch, I would be glad to Ack it.
>
> b. DRM configuration is a mess. You shouldn't want to follow their model. :)

Right, that should also be fixed, so DRM no longer includes I2C ;-)

At the moment, DRM is the most common cause for circular dependencies
because it has a number of 'select' statements for symbols that otherwise
are used with 'depends on'. We should probably address the 'select I2C'
portion in there, but also some of the others like:

drivers/gpu/drm/Kconfig:        select POWER_SUPPLY
drivers/gpu/drm/Kconfig:        select HWMON
drivers/gpu/drm/Kconfig:        select FB
drivers/gpu/drm/udl/Kconfig: select USB
drivers/gpu/drm/sti/Kconfig: select OF
drivers/gpu/drm/sti/Kconfig: select RESET_CONTROLLER
drivers/gpu/drm/etnaviv/Kconfig:        select CMA if HAVE_DMA_CONTIGUOUS
drivers/gpu/drm/etnaviv/Kconfig:        select TMPFS
drivers/gpu/drm/i915/Kconfig.debug:        select DEBUG_FS
drivers/gpu/drm/i915/Kconfig.debug:        select PREEMPT_COUNT
drivers/gpu/drm/i915/Kconfig.debug:     select TRACING
drivers/gpu/drm/i915/Kconfig.debug:     select FAULT_INJECTION
drivers/gpu/drm/mediatek/Kconfig:       select MEMORY
drivers/gpu/drm/mediatek/Kconfig:       select GENERIC_PHY
drivers/gpu/drm/msm/Kconfig:    select REGULATOR

> c. If I2C is not enabled in the FB menu, someone could just add something like this:
>
> comment "Enable I2C to see more driver choices"
>         depends on !I2C

I don't think that would address the issue of 'defconfig' builds losing
I2C support when it's no longer automatically selection. On x86, this
is not an issue, as X86 always enables I2C. For the rest, we could
do a hack like this:

--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -8,6 +8,7 @@ config I2C
        tristate "I2C support"
        select RT_MUTEXES
        select IRQ_DOMAIN
+       default DRM || FB
        ---help---
          I2C (pronounce: I-squared-C) is a slow serial bus protocol used in
          many micro controller applications and developed by Philips.  SMBus,

which would let all 'defconfig' versions keep working. It's a bit ugly, but
at least wouldn't cause other circular dependencies.

     Arnd
