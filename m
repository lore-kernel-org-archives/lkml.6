Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHDril2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 50BF7601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932242AbeFFHPG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 03:15:06 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:46157 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932131AbeFFHPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 03:15:03 -0400
X-Google-Smtp-Source: ADUXVKK0KKdjvHMQ5hqSEh+47uMqLODNdVNHj1hYEpXpjEoRUlP34/AUGzV30eKCEZaFeT9H6+4KMyJpUJewNXs6n3o=
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1806061619240.8@nippy.intranet>
References: <cover.1527909627.git.fthain@telegraphics.com.au>
 <f32f4e3a0fd736152f768b7a00bfc731daba1629.1527909627.git.fthain@telegraphics.com.au>
 <7ce9a8c3996506ae6f9ab16b3cf73c287e205a89.1527909627.git.fthain@telegraphics.com.au>
 <8597ac466215f573d8bea40e74fdec2bf72fabbb.1527909627.git.fthain@telegraphics.com.au>
 <878b389293851359e53de186bf302ce52d95ad95.1527909627.git.fthain@telegraphics.com.au>
 <adba0545c06cd6c67e26c433990d036b0d7e968c.1527909627.git.fthain@telegraphics.com.au>
 <166b4c3a7347fe27f12bda86d50533cd01ee11b9.1527909627.git.fthain@telegraphics.com.au>
 <73507a3e9444da17c222cf74df41842ce30d15ee.1527909627.git.fthain@telegraphics.com.au>
 <de8edb03dbd2fd25b53d0bdf9c6d65adf9aa0aa3.1527909627.git.fthain@telegraphics.com.au>
 <CAMuHMdVheowFa8bx0fg-_Dvx+TMZhPbvouTs82Y3tq1gtSpRMQ@mail.gmail.com> <alpine.LNX.2.21.1806061619240.8@nippy.intranet>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 6 Jun 2018 09:15:01 +0200
X-Google-Sender-Auth: XaqbryJ1SeEhcvaTWVLLxyB7koY
Message-ID: <CAMuHMdWQsHLGoxf4_2xtSi4fVc+Lxxa3KXP9VntFYu85YVC0tQ@mail.gmail.com>
Subject: Re: [PATCH 08/11] macintosh/via-pmu: Replace via-pmu68k driver with
 via-pmu driver
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Wed, Jun 6, 2018 at 8:57 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> On Mon, 4 Jun 2018, Geert Uytterhoeven wrote:
>> > Don't call pmu_shutdown() or pmu_restart() on early PowerBooks: the
>> > PMU device found in these PowerBooks isn't supported.
>>
>> Shouldn't that be a separate patch?
>>
>> > --- a/arch/m68k/mac/misc.c
>> > +++ b/arch/m68k/mac/misc.c
>>
>> > @@ -477,9 +445,8 @@ void mac_poweroff(void)
>> >                    macintosh_config->adb_type == MAC_ADB_CUDA) {
>> >                 cuda_shutdown();
>> >  #endif
>> > -#ifdef CONFIG_ADB_PMU68K
>> > -       } else if (macintosh_config->adb_type == MAC_ADB_PB1
>> > -               || macintosh_config->adb_type == MAC_ADB_PB2) {
>> > +#ifdef CONFIG_ADB_PMU
>> > +       } else if (macintosh_config->adb_type == MAC_ADB_PB2) {
>> >                 pmu_shutdown();
>> >  #endif
>> >         }
>> > @@ -519,9 +486,8 @@ void mac_reset(void)
>> >                    macintosh_config->adb_type == MAC_ADB_CUDA) {
>> >                 cuda_restart();
>> >  #endif
>> > -#ifdef CONFIG_ADB_PMU68K
>> > -       } else if (macintosh_config->adb_type == MAC_ADB_PB1
>> > -               || macintosh_config->adb_type == MAC_ADB_PB2) {
>> > +#ifdef CONFIG_ADB_PMU
>> > +       } else if (macintosh_config->adb_type == MAC_ADB_PB2) {
>> >                 pmu_restart();
>> >  #endif
>> >         } else if (CPU_IS_030) {
>>
>
> The stability problem here is bigger than just pmu_restart() and
> pmu_shutdown(), so those hunks are insufficient. You need to prevent the
> via-pmu68k driver from loading in the first place and to drop all the
> PMU_68K_V1 cases.
>
> But splitting this patch in that way creates potential merge conflicts,
> which is a hassle. E.g. this hunk:
>
> -       ....
> -       switch (macintosh_config->adb_type) {
> -       case MAC_ADB_PB1:
> -               pmu_kind = PMU_68K_V1;
> -               break;
> -       case MAC_ADB_PB2:
> -               pmu_kind = PMU_68K_V2;
> -               break;
> -       default:
> -               pmu_kind = PMU_UNKNOWN;
> -               return -ENODEV;
> -       }
> -       ...
>
> would get split over two patches.
>
> The way I see it, having no PMU driver for PMU_68K_V1 machines is a bug.
> And loading any of the existing PMU drivers on that hardware is also a
> bug. These bugs are equivalent in that either one means you can't use the
> keyboard, trackpad etc. So there's no value in cherry-picking the other
> bug.
>
> If you are using v4.17 on a PMU_68K_V1 machine, you probably already have
> CONFIG_ADB_PMU68K=n. With that config, here's nothing to be gained from
> bisecting these changes.
>
> Does that make sense? Did I overlook other possible reason(s) to split up
> this patch?

So 4.17 mac_defconfig won't work on PMU_68K_V1 machines?
Perhaps that should be fixed first.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
