Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752903AbeC2WIy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 18:08:54 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37936 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752880AbeC2WIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 18:08:51 -0400
X-Google-Smtp-Source: AIpwx49564Opt+k3ByLfHhmwcac/Q7QDUjFW4we8lC29f9Y/j2vtccSOVoDfqGTi/lpt8bmuaBmL7g==
MIME-Version: 1.0
In-Reply-To: <CAFqH_51czaGUzaWpAo1+E0JeNh3o-vA4CucXQT1DKnwhZLML5A@mail.gmail.com>
References: <20170927213527.31416-1-shawnn@chromium.org> <20171129121123.7zg63mjy7pufokg5@dell>
 <CAFqH_51zqxXZeEXDSry9aBwwj4Z7SRzxfKw5Ffzh-2A1UQG2Pw@mail.gmail.com>
 <CAHNYxRyDDJRuoU67bjJ+Osvx9GauSPkwCsRZbknwVOY=rb6SEA@mail.gmail.com> <CAFqH_51czaGUzaWpAo1+E0JeNh3o-vA4CucXQT1DKnwhZLML5A@mail.gmail.com>
From: Alexandru M Stan <amstan@chromium.org>
Date: Thu, 29 Mar 2018 15:08:27 -0700
X-Gmail-Original-Message-ID: <CAHNYxRz9tBv_AEQ6DiyxuN2hR_2ACiNr0Afx_tj-uepwBYXp+w@mail.gmail.com>
Message-ID: <CAHNYxRz9tBv_AEQ6DiyxuN2hR_2ACiNr0Afx_tj-uepwBYXp+w@mail.gmail.com>
Subject: Re: [PATCH] mfd: cros ec: spi: Fix "in progress" error signaling
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>,
        Shawn Nematbakhsh <shawnn@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, jonathanh@nvidia.com,
        Brian Norris <briannorris@chromium.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 3:49 AM, Enric Balletbo Serra
<eballetbo@gmail.com> wrote:
> I think that accessing to the ec console should give the same result, right?

Yep, even better.

>
> In such case here is:
>
> Veyron Minnie ( ASUS Chromebook Flip C100PA )
> -------------------------------------------------------------------
> Chip:    stm stm32f07x
> Board:   0
> RO:      minnie_v1.1.2697-faafaa5
> RW:      minnie_v1.1.2712-242f6bd
> Build: minnie_v1.1.2712-242f6bd 2016-11-03 00:34:41 @build196-m2
>
> Veyron Jaq (  Haier Mighty MP )
> --------------------------------------------------------------------
> Chip:    stm stm32f07x
> Board:   0
> RO:      mighty_v1.1.2680-6727e1d
> RW:      mighty_v1.1.2712-242f6bd
> Build: mighty_v1.1.2680-6727e1d 2015-03-24 01:12:48 @build290-m2

Looks like your mighty is running the RO firmware, whereas your minnie
runs RW. Is it possible you have the 0x200 bit in the gbb flags set on
mighty? That would prevent the RO->RW transition, and give you an
older firmware.

6727e1d..242f6bd is quite the change. I see some spi changes too,
though i believe it's mostly at power state transitions
(suspend/resume). Other changes include battery settings (yeah.. you
should really avoid running that RO if you can avoid it) and a ton of
accelerometer stuff for minnie.

If it's not the gbb flags, and we can't figure it out why you're stuck
in RO, you can also use "sysjump RW" to force the RW copy on mighty.
See if there's any behavior changes in what you care about.

>
> We're running the RW firmware and I just discovered that our jaq is a
> mighty (but I guess it's the same?)

They're essentially the same, but they're running slightly different
firmware. In practice the only difference is that mighty's firmware
reads an extra gpio for the battery presence.

Feel free to diff the board/{jaq,mighty} ec folders for yourself for
more details/assurances.

>
> Thanks,
>   Enric

All in all I'm not sure that the version differences are enough to
explain the spi errors you see in the kernel.

My bet is back to the accelerometer stuff:
Are you running chromeos ui on this device (is there a chromeos-chrome
process constantly polling the accelerometer, so asking the cros-ec
driver for transfers)?
Another thing to make sure accelerometer is disabled is to run
"accelrate 0 0" on the minnie EC.
If none of that accelerometer stuff is enabled, minnie should
essentially act like a mighty/jaq.
