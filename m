Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeCOK7b (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 06:59:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:23461 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751617AbeCOK73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 06:59:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,310,1517904000";
   d="scan'208";a="211549849"
Subject: Re: [PATCH v3 05/11] mmc: sdhci: Disable HS200 mode if controller
 can't support 1.8v
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180307132020.30951-1-kishon@ti.com>
 <20180307132020.30951-6-kishon@ti.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <fc379441-ed8e-47b4-f34b-d4137d158ec6@intel.com>
Date: Thu, 15 Mar 2018 12:58:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307132020.30951-6-kishon@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/18 15:20, Kishon Vijay Abraham I wrote:
> Though MMC controller can indicate HS200 mode capability (by
> using "mmc-hs200-1_8v" dt property), if the IO lines in the board
> is connected to 3.3v supply, HS200 mode cannot be supported.
> Such boards have "no-1-8-v" property in their dts file. Disable HS200
> mode for boards which have "no-1-8-v" set.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/mmc/host/sdhci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 2ededa7f43df..aa8b5ca0d1b0 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3672,6 +3672,7 @@ int sdhci_setup_host(struct sdhci_host *host)
>  	if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V) {
>  		host->caps1 &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
>  				 SDHCI_SUPPORT_DDR50);
> +		mmc->caps2 &= ~MMC_CAP2_HS200;

Pedantically, shouldn't that be:

	~(MMC_CAP2_HS200_1_8V_SDR | MMC_CAP2_HS400_1_8V)

We have MMC_CAP2_HSX00_1_2V so maybe we should add:

	#define MMC_CAP2_HSX00_1_8V	(MMC_CAP2_HS200_1_8V_SDR | MMC_CAP2_HS400_1_8V)

And then

		mmc->caps2 &= ~MMC_CAP2_HSX00_1_8V;

>  	}
>  
>  	/* Any UHS-I mode in caps implies SDR12 and SDR25 support. */
> 
