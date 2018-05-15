Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752916AbeEOMjm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 08:39:42 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:37984 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752307AbeEOMjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 08:39:40 -0400
X-Google-Smtp-Source: AB8JxZqzCsQbwN473C0DK9qG4TEdwe+usr3W72ySrq/xdLtlVikx/pr3hj1OrVbpVfFc+TZv15hlxtuZ9KQj9hY2jeQ=
MIME-Version: 1.0
In-Reply-To: <0ea1d2bf-fa0f-4b3d-556a-5dca5afbf2a9@ti.com>
References: <0ea1d2bf-fa0f-4b3d-556a-5dca5afbf2a9@ti.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 15 May 2018 14:39:39 +0200
Message-ID: <CACRpkdaZ5G=gBHNwf7YMLEBOqC2UrO+YLrz09H4h8HWYN=av4w@mail.gmail.com>
Subject: Re: MMC performance degradation due to too many requests
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 1:30 PM, Faiz Abbas <faiz_abbas@ti.com> wrote:

> Also, I see many times the number of interrupts for mmc1 in 4.14.
(...)
> I also printed out the size of the DMA transfers in the omap_hsmmc
> driver during the dd command. I see that the maximum size of the dma
> transfer has decreased from 1 MB to 256kB between 4.13 and 4.14.

This seems like my fault for removing the bounce buffer.
(The name bounce buffer is misleading, I suspect the right
term for what is was doing was "merge buffer" or something,
coalescing physically consecutive requests.)

commit de3ee99b097dd51938276e3af388cd4ad0f2750a
"mmc: Delete bounce buffer handling"
should be the culprit.

The bounce buffer only makes any performance impact if the
host DMA controller is unable to handle scatter-gather lists
so the number of segments is set down to 1.

Can you verifty that:
- mmc->max_segs == 1
- You were previously enabling CONFIG_MMC_BLOCK_BOUNCE

I am a bit confused since omap_hsmmc sets max_segs
to 64, indicating that it can do scatter-gather, and the bounce buffer
code will only every kick in if max_segs == 1.

The solution we created for SDHCI is:
commit bd9b902798ab14d19ca116b10bde581ddff8f905
"mmc: sdhci: Implement an SDHCI-specific bounce buffer"
i.e. we push this bouncing down to the driver and does not try
to do it in the MMC core.

I'd be happy to come up with something OMAP-specific as well
if you can only help me to figure out the code path leading to
max_segs == 1.

Yours,
Linus Walleij
