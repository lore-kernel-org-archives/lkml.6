Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752809AbeBFLI5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 06:08:57 -0500
Received: from fllnx209.ext.ti.com ([198.47.19.16]:20702 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbeBFLIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 06:08:49 -0500
Subject: Re: [PATCH] ARM: dts: da850-evm: add clock properties to the nand
 node
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180205155222.22189-1-brgl@bgdev.pl>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <3f171f6a-bcea-65ec-d56d-f6ae24660f34@ti.com>
Date: Tue, 6 Feb 2018 16:37:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180205155222.22189-1-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 February 2018 09:22 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Make nand work with the common clock framework by specifying which
> clock should be used and what name to look up.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/boot/dts/da850-evm.dts | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
> index a86a8a1816f2..2602ad8e99ee 100644
> --- a/arch/arm/boot/dts/da850-evm.dts
> +++ b/arch/arm/boot/dts/da850-evm.dts
> @@ -296,6 +296,9 @@
>  			reg = <0 0x02000000 0x02000000
>  			       1 0x00000000 0x00008000>;
>  
> +			clocks = <&psc0 3>;
> +			clock-names = "aemif";

Looks like this is being added only to satisfy the devm_clk_get() call
in nand_davinci_probe() which I think is superfluous since we also
enable the same clock in aemif_probe().

Perhaps the better solution is to drip the clk code in
drivers/mtd/nand/davinci_nand.c and shift legacy code to start using
drivers/memory/aemif.c as well? This way we can also drop
arch/arm/mach-davinci/aemif.c

Thanks,
Sekhar
