Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeBSIE3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 03:04:29 -0500
Received: from mga04.intel.com ([192.55.52.120]:63816 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751904AbeBSIE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 03:04:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,534,1511856000";
   d="scan'208";a="28247768"
Subject: Re: [PATCH v2 10/16] mmc: sdhci: Fix to use data_timer only for data
 line commands
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180205125029.21570-1-kishon@ti.com>
 <20180205125029.21570-11-kishon@ti.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <192a7c1e-9180-e473-8000-4a4aa806df91@intel.com>
Date: Mon, 19 Feb 2018 10:03:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180205125029.21570-11-kishon@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/18 14:50, Kishon Vijay Abraham I wrote:
> commit d7422fb489eee5587d3eec ("mmc: sdhci: Separate timer timeout for
> command and data requests") while separating timer timeout for
> command and data requests, passed cmd->mrq to sdhci_mod_timer (cmd is an
> argument to sdhci_send_command) and in sdhci_mod_timer used mrq->cmd
> to check if it is a data line command. This results in using
> data timer for commands like MMC_SET_BLOCK_COUNT (CMD23) though it is
> not a data line command. Fix it here.

I am not sure why you need this change, but it is not right actually.  There
are 2 timers because there can be 2 mrqs and we need to delete the correct
timer in sdhci_request_done() so it is better to make the selection based on
the mrq not the last command.

> 
> Fixes: commit d7422fb489eee5587d3eec ("mmc: sdhci: Separate timer timeout for
> command and data requests")
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/mmc/host/sdhci.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 1aa74b4682f3..0489572d1892 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1073,10 +1073,10 @@ static void sdhci_finish_data(struct sdhci_host *host)
>  	}
>  }
>  
> -static void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,
> +static void sdhci_mod_timer(struct sdhci_host *host, struct mmc_command *cmd,
>  			    unsigned long timeout)
>  {
> -	if (sdhci_data_line_cmd(mrq->cmd))
> +	if (sdhci_data_line_cmd(cmd))
>  		mod_timer(&host->data_timer, timeout);
>  	else
>  		mod_timer(&host->timer, timeout);
> @@ -1135,7 +1135,7 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  		timeout += DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;
>  	else
>  		timeout += 10 * HZ;
> -	sdhci_mod_timer(host, cmd->mrq, timeout);
> +	sdhci_mod_timer(host, cmd, timeout);
>  
>  	host->cmd = cmd;
>  	if (sdhci_data_line_cmd(cmd)) {
> 
