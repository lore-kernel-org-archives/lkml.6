Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755216AbeDZI4c (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 04:56:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:65508 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754785AbeDZI40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 04:56:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,330,1520924400";
   d="scan'208";a="194529438"
Subject: Re: [PATCH v4 05/12] mmc: sdhci: Disable HS200/HS400 mode if
 controller can't support 1.8v
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>
References: <20180425120937.29867-1-kishon@ti.com>
 <20180425120937.29867-6-kishon@ti.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <6bdf4feb-bc12-3779-3de6-e08af1d4f518@intel.com>
Date: Thu, 26 Apr 2018 11:55:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425120937.29867-6-kishon@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/18 15:09, Kishon Vijay Abraham I wrote:
> Though MMC controller can indicate HS200/HS400 mode capability (by
> using "mmc-hs200-1_8v"/"mmc-hs400-1_8v" dt property), if the IO lines
> in the board is connected to 3.3v supply, HS200/HS400 mode cannot be
> supported. Such boards have "no-1-8-v" property in their dts file.
> Disable HS200/HS400 mode for boards which have "no-1-8-v" set.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/mmc/host/sdhci.c | 1 +
>  include/linux/mmc/host.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 2ededa7f43df..b5f047b5f3ae 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3672,6 +3672,7 @@ int sdhci_setup_host(struct sdhci_host *host)
>  	if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V) {
>  		host->caps1 &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
>  				 SDHCI_SUPPORT_DDR50);
> +		mmc->caps2 &= ~MMC_CAP2_HSX00_1_8V;

Seems weird for sdhci to clear flags it never set.  Also couldn't we
reasonably expect dt properties to be consistent?  Is this really about
setting SDHCI_QUIRK2_NO_1_8_V in your driver and expecting it to override
other dt properties?  Although that still begs the question why anyone would
set dt properties that the hardware doesn't support?  I guess you should
also clear MMC_CAP2_HS400_ES.

>  	}
>  
>  	/* Any UHS-I mode in caps implies SDR12 and SDR25 support. */
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 7c6eaf63f5ce..58832451767b 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -345,6 +345,7 @@ struct mmc_host {
>  #define MMC_CAP2_HS400_1_2V	(1 << 16)	/* Can support HS400 1.2V */
>  #define MMC_CAP2_HS400		(MMC_CAP2_HS400_1_8V | \
>  				 MMC_CAP2_HS400_1_2V)
> +#define MMC_CAP2_HSX00_1_8V	(MMC_CAP2_HS200_1_8V_SDR | MMC_CAP2_HS400_1_8V)
>  #define MMC_CAP2_HSX00_1_2V	(MMC_CAP2_HS200_1_2V_SDR | MMC_CAP2_HS400_1_2V)
>  #define MMC_CAP2_SDIO_IRQ_NOTHREAD (1 << 17)
>  #define MMC_CAP2_NO_WRITE_PROTECT (1 << 18)	/* No physical write protect pin, assume that card is always read-write */
> 
