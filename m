Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753194AbeA3Pb2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 10:31:28 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41933 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753165AbeA3Pb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 10:31:26 -0500
X-Google-Smtp-Source: AH8x2242ODzQsoxCc/N64YLuDPTfJRI8LIwL+eg8j6xHjua60RQ275r6efB98UCa3/2uqI/6RULJ7cvoLDQ9uhKyL50=
MIME-Version: 1.0
In-Reply-To: <20180130150337.GC10525@sirena.org.uk>
References: <1517318506-14664-1-git-send-email-geert@linux-m68k.org> <20180130150337.GC10525@sirena.org.uk>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jan 2018 16:31:24 +0100
X-Google-Sender-Auth: ZwqaKmeJWC_hn5jRSVXPMvr_BTM
Message-ID: <CAMuHMdWhADAPSnj_34R04Oh_H_puyc0vzx--tpihAaUM4NDMQg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: STM32_DFSDM_ADC should depend on HAS_DMA
To: Mark Brown <broonie@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>, linux-iio@vger.kernel.org,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, Jan 30, 2018 at 4:03 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jan 30, 2018 at 02:21:46PM +0100, Geert Uytterhoeven wrote:
>> If NO_DMA=y:
>>
>>     ERROR: "bad_dma_ops" [drivers/iio/adc/stm32-dfsdm-adc.ko] undefined!
>>
>> Add a dependency on HAS_DMA to fix this.
>
> Once again I have to ask why we're doing this per driver and not having
> the few architectures that have this issue set something up.

Because doing so would lead us to

    depends on COMPILE_TEST || HAS_DMA

in many places. Is that any better?

I agree we could indeed use DMA dummies in cases where a driver uses:

   depends on ARCH_FOO || ARCH_BAR || COMPILE_TEST
   depends on HAS_DMA

But we also have generic options like:

    config ATA_BMDMA
            bool "ATA BMDMA support"
            depends on HAS_DMA

And even architecture-specific drivers for SoCs that may or not have DMA:

config HASH_DEV_STM32
        tristate "Support for STM32 hash accelerators"
        depends on ARCH_STM32
        depends on HAS_DMA

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
