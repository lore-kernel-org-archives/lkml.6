Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753568AbeBPHSa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 02:18:30 -0500
Received: from fllnx210.ext.ti.com ([198.47.19.17]:53993 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753545AbeBPHS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 02:18:27 -0500
Subject: Re: [PATCH v2 11/16] mmc: sdhci: Program a relatively accurate SW
 timeout value
To: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20180205125029.21570-1-kishon@ti.com>
 <20180205125029.21570-12-kishon@ti.com>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <aa30bb13-7271-a426-f606-59f21961806f@ti.com>
Date: Fri, 16 Feb 2018 12:47:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20180205125029.21570-12-kishon@ti.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday 05 February 2018 06:20 PM, Kishon Vijay Abraham I wrote:
> sdhci has a 10 second timeout to catch devices that stop responding.
> Instead of programming 10 second arbitrary value, calculate the total time
> it would take for the entire transfer to happen and program the timeout
> value accordingly.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/mmc/host/sdhci.c | 46 +++++++++++++++++++++++++++++++++++++++-------
>  drivers/mmc/host/sdhci.h | 10 ++++++++++
>  2 files changed, 49 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 0489572d1892..d52f9e7eabe2 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -673,6 +673,37 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
>  	}
>  }
>  
> +static void sdhci_calc_sw_timeout(struct sdhci_host *host,
> +				  struct mmc_command *cmd,
> +				  unsigned int target_timeout)
> +{
> +	struct mmc_data *data = cmd->data;
> +	struct mmc_host *mmc = host->mmc;
> +	unsigned long long transfer_time;
> +	struct mmc_ios *ios = &mmc->ios;
> +	unsigned char bus_width = ios->bus_width;

This should have been 1 << ios->bus_width.

-Kishon
