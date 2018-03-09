Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932612AbeCIWED (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 17:04:03 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:33586 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932104AbeCIWEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 17:04:01 -0500
X-Google-Smtp-Source: AG47ELskiK4oCQvm0MnS4eBpKWpKh51SXt4HAseTBmDCpXRIZ/uNx0heMt3rADzO/Pxv0yQNIqhV9A==
Date: Fri, 9 Mar 2018 14:03:59 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Eddie James <eajames@linux.vnet.ibm.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@jms.id.au, wim@linux-watchdog.org,
        Milton Miller <miltonm@us.ibm.com>
Subject: Re: [PATCH 1/2] watchdog: aspeed: Fix translation of reset mode to
 ctrl register
Message-ID: <20180309220359.GA32606@roeck-us.net>
References: <1520632700-25800-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1520632700-25800-2-git-send-email-eajames@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520632700-25800-2-git-send-email-eajames@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 03:58:19PM -0600, Eddie James wrote:
> From: Milton Miller <miltonm@us.ibm.com>
> 
> Assert RESET_SYSTEM bit for any reset and set MODE field from reset
> type.
> 
> The watchdog control register has a RESET_SYSTEM bit that is really
> closer to activate a reset, and RESET_SYSTEM_MODE field that chooses
> how much to reset.
> 
> Before this patch, a node without these optional property would do a
> SOC reset, but a node with properties requesting a cpu or SOC reset
> would do nothing and a node requesting a system reset would do a
> SOC reset.
> 
> Fixes: b7f0b8ad25f3 ("drivers/watchdog: ASPEED reference dev tree properties for config")
> Signed-off-by: Milton Miller <miltonm@us.ibm.com>
> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/aspeed_wdt.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index ca5b91e..d1987d6 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -232,11 +232,14 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>  		wdt->ctrl |= WDT_CTRL_RESET_MODE_SOC | WDT_CTRL_RESET_SYSTEM;
>  	} else {
>  		if (!strcmp(reset_type, "cpu"))
> -			wdt->ctrl |= WDT_CTRL_RESET_MODE_ARM_CPU;
> +			wdt->ctrl |= WDT_CTRL_RESET_MODE_ARM_CPU |
> +				     WDT_CTRL_RESET_SYSTEM;
>  		else if (!strcmp(reset_type, "soc"))
> -			wdt->ctrl |= WDT_CTRL_RESET_MODE_SOC;
> +			wdt->ctrl |= WDT_CTRL_RESET_MODE_SOC |
> +				     WDT_CTRL_RESET_SYSTEM;
>  		else if (!strcmp(reset_type, "system"))
> -			wdt->ctrl |= WDT_CTRL_RESET_SYSTEM;
> +			wdt->ctrl |= WDT_CTRL_RESET_MODE_FULL_CHIP |
> +				     WDT_CTRL_RESET_SYSTEM;
>  		else if (strcmp(reset_type, "none"))
>  			return -EINVAL;
>  	}
> -- 
> 1.8.3.1
> 
