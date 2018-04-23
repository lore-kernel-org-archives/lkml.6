Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753119AbeDWGEX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 02:04:23 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:47278 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752971AbeDWGES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 02:04:18 -0400
Subject: Re: [PATCH] mmc: disable card sleep via device-tree
To: Lukasz Majewski <lukma@denx.de>,
        Stanislav Meduna <stanislav.meduna@nxtcontrol.com>
References: <20180422213126.32756-1-lukma@denx.de>
CC: Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Chanho Min <chanho.min@lge.com>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <f4b6291f-2756-38ff-31e0-0ba290f64e48@mentor.com>
Date: Mon, 23 Apr 2018 09:04:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180422213126.32756-1-lukma@denx.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [137.202.0.87]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On 04/23/2018 12:31 AM, Lukasz Majewski wrote:
> From: Stanislav Meduna <stanislav.meduna@nxtcontrol.com>
> 
> On a TQMa53 module the mmc_sleep leaves the eMMC card in a state
> that the imx53 rom boot code is unable to probe, resulting in
> reboot hanging. Add a device tree property to disable sleeping
> on suspend.
> 
> For TQMa53 modules the exact commit to cause hang after reboot
> (v3.10 -> v3.11):
> commit 486fdbbc1483 ("mmc: core: Add shutdown callback for (e)MMC bus_ops")
> 
> [The exact discussion can be found here:
> https://patchwork.kernel.org/patch/8881401/
> "i.MX53 restart via watchdog does not work"
> 
> Signed-off-by: Stanislav Meduna <stanislav.meduna@nxtcontrol.com>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  Documentation/devicetree/bindings/mmc/mmc-card.txt | 4 ++++
>  drivers/mmc/core/mmc.c                             | 7 +++++--
>  include/linux/mmc/card.h                           | 2 +-
>  3 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.txt b/Documentation/devicetree/bindings/mmc/mmc-card.txt
> index 8d2d71758907..c3ee151edd7c 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-card.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc-card.txt
> @@ -12,6 +12,9 @@ Required properties:
>  Optional properties:
>  -broken-hpi : Use this to indicate that the mmc-card has a broken hpi
>                implementation, and that hpi should not be used
> +-no-sleep-on-suspend : Do not put the card to sleep when suspending.
> +              There are boards with bootloaders that are unable
> +              to probe such card when rebooting.

I would recommend to examine an option to reuse the existing host
controller property 'keep-power-in-suspend', note that a particular
host controller driver may ignore it.

In general the problem sounds like a PCB hardware bug, and if it is
eMMC card specific, please provide more information about that eMMC
rather than about the host.

--
With best wishes,
Vladimir
