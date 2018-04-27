Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932373AbeD0Mav (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 08:30:51 -0400
Received: from mout01.posteo.de ([185.67.36.141]:40106 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757846AbeD0Mas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 08:30:48 -0400
From: Marc Dietrich <marvin24@gmx.de>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marcel Ziswiler <marcel@ziswiler.com>, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/4] Restore ULPI USB on Tegra20
Date: Fri, 27 Apr 2018 14:30:41 +0200
Message-ID: <4032338.O1BXeabcRj@ax5200p>
In-Reply-To: <20180426235818.10018-1-digetx@gmail.com>
References: <20180426235818.10018-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Am Freitag, 27. April 2018, 01:58:14 CEST schrieb Dmitry Osipenko:
> Hello,
> 
> This series of patches fixes ULPI USB on Tegra20. The original problem
> was reported by Marcel Ziswiler, he found that "ulpi-link" clock was
> incorrectly set to CDEV2 instead of PLL_P_OUT4. Marcel made a patch
> that changed the "ulpi-link" clock to PLL_P_OUT4 and that fixed issue
> with the USB for the devices that have CDEV2 being enabled by bootloader.
> The patch got into the kernel and later Marc Dietrich found that USB
> stopped working on the "paz00" Tegra20 board. After a bit of discussion
> was revealed that PLL_P_OUT4 is the parent clock of the CDEV2 and clock
> driver was setting CDEV2's parent incorrectly. The parent clock is actually
> determined by the pinmuxing config of CDEV2 pingroup. This patchset fixes
> the parent of CDEV2 clock by making Tegra's pinctrl driver a clock provider,
> providing CDEV1/2 clock muxes (thanks to Peter De Schrijver for the
> suggestion), and then setting these clock muxes as parents for the CDEV1/2
> clocks. In the end Marcel's CDEV2->PLL_P_OUT4 change is reverted since
> CDEV2 (aka MCLK2) is the actual clock source for "ulpi-link".
> 
> Dmitry Osipenko (4):
>   clk: tegra20: Add DEV1/DEV2 OSC dividers
>   pinctrl: tegra20: Provide CDEV1/2 clock muxes
>   clk: tegra20: Set correct parents for CDEV1/2 clocks
>   ARM: dts: tegra20: Revert "Fix ULPI regression on Tegra20"
> 
>  arch/arm/boot/dts/tegra20.dtsi          |  2 +-
>  drivers/clk/tegra/clk-tegra20.c         | 18 +++++++++++----
>  drivers/pinctrl/tegra/pinctrl-tegra.c   | 11 ---------
>  drivers/pinctrl/tegra/pinctrl-tegra.h   | 11 +++++++++
>  drivers/pinctrl/tegra/pinctrl-tegra20.c | 30 ++++++++++++++++++++++++-
>  5 files changed, 55 insertions(+), 17 deletions(-)

Thanks for taking a look at this!

Series is:

Tested-by: Marc Dietrich <marvin24@gmx.de>

Marc
