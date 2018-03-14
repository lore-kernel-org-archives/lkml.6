Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753518AbeCNIt7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 04:49:59 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35874 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751873AbeCNIt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 04:49:56 -0400
X-Google-Smtp-Source: AG47ELsN6PCVb0JfJug/1831lePc75uU+n1XTUn4Zxb9q8TpALAnlbxmbXoLpTtbe/xp8+j37ke9GbhCcurASPhD374=
MIME-Version: 1.0
In-Reply-To: <20180313230155.GC23414@mithrandir>
References: <20180313210015.3344380-1-arnd@arndb.de> <20180313230155.GC23414@mithrandir>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Mar 2018 09:49:54 +0100
X-Google-Sender-Auth: 8ZrICIB4zZ2sjezLesMiZZ__c04
Message-ID: <CAK8P3a3A37_q0PEXFqi2iLR_bJxW=trB3tksZqyjG5MYwaMuXA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: rm68200: add backlight dependency
To: Thierry Reding <thierry.reding@gmail.com>
Cc: David Airlie <airlied@linux.ie>,
        Philippe CORNU <philippe.cornu@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 12:01 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Tue, Mar 13, 2018 at 09:59:54PM +0100, Arnd Bergmann wrote:
>> Like many other panel drivers, this one fails to build
>> when backlight support is disabled:
>>
>> drivers/gpu/drm/panel/panel-raydium-rm68200.o: In function `rm68200_probe':
>> panel-raydium-rm68200.c:(.text+0x14a): undefined reference to `devm_of_find_backlight'
>>
>> This adds the appropriate dependency.
>>
>> Fixes: 2b7ed18bed1a ("drm/panel: Add support for Raydium RM68200 panel driver")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/gpu/drm/panel/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>
> This shouldn't be necessary. include/linux/backlight.h defines a stub if
> the backlight class is not enabled.
>
> What tree are you seeing this on?

This is on linux-next.

It must be with BACKLIGHT_CLASS_DEVICE=m and
DRM_PANEL_RAYDIUM_RM68200=y, meaning that it should
be sufficient to do

    depends on BACKLIGHT_CLASS_DEVICE || BACKLIGHT_CLASS_DEVICE=n

to force DRM_PANEL_RAYDIUM_RM68200 to be a loadable module
whenever BACKLIGHT_CLASS_DEVICE=m. For the patch, I looked at
what the other drivers in the same directory do and followed their
example.

I see three options here:

1. update my patch changelog with the explanation I wrote here but leave it
    untouched
2. use the more elaborate dependency (after testing) but not change the
    others
3. change all panel drivers with a backlight dependency the same way,
    possibly with a helper symbol like

config BACKLIGHT_CLASS_DEVICE_OPTIONAL
         tristate
         default m if BACKLIGHT_CLASS_DEVICE=m
         default y

      Arnd
