Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbeB1Ofq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:35:46 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38552 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752157AbeB1Ofo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:35:44 -0500
X-Google-Smtp-Source: AH8x2250eOjMv2ItX5KoeOkKRIcGz25mi2o1GVI2Twm2XzKMl6Te3knGK9JMbtRs/XclX9YKYSKQ3g==
Subject: Re: [PATCH] watchdog: sbsa: use 32-bit read for WCV
To: Jayachandran C <jnair@caviumnetworks.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org
Cc: Fu Wei <fu.wei@linaro.org>, linux-kernel@vger.kernel.org
References: <1519815140-5336-1-git-send-email-jnair@caviumnetworks.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <265c171f-8a08-2799-53b5-c6e3a5bf44b5@roeck-us.net>
Date: Wed, 28 Feb 2018 06:35:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519815140-5336-1-git-send-email-jnair@caviumnetworks.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28/2018 02:52 AM, Jayachandran C wrote:
> According to SBSA spec v3.1 section 5.3:
>    All registers are 32 bits in size and should be accessed using
>    32-bit reads and writes. If an access size other than 32 bits
>    is used then the results are IMPLEMENTATION DEFINED.
>    [...]
>    The Generic Watchdog is little-endian
> 
> The current code uses readq to read the watchdog compare register
> which does a 64-bit access. This fails on ThunderX2 which does not
> implement 64-bit access to this register.
> 
> Fix this by using lo_hi_readq() that does two 32-bit reads.
> 
> Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/sbsa_gwdt.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
> index 316c2eb..e8bd988 100644
> --- a/drivers/watchdog/sbsa_gwdt.c
> +++ b/drivers/watchdog/sbsa_gwdt.c
> @@ -50,6 +50,7 @@
>    */
>   
>   #include <linux/io.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
>   #include <linux/interrupt.h>
>   #include <linux/module.h>
>   #include <linux/moduleparam.h>
> @@ -159,7 +160,7 @@ static unsigned int sbsa_gwdt_get_timeleft(struct watchdog_device *wdd)
>   	    !(readl(gwdt->control_base + SBSA_GWDT_WCS) & SBSA_GWDT_WCS_WS0))
>   		timeleft += readl(gwdt->control_base + SBSA_GWDT_WOR);
>   
> -	timeleft += readq(gwdt->control_base + SBSA_GWDT_WCV) -
> +	timeleft += lo_hi_readq(gwdt->control_base + SBSA_GWDT_WCV) -
>   		    arch_counter_get_cntvct();
>   
>   	do_div(timeleft, gwdt->clk);
> 
