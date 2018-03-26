Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752213AbeCZWAR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:00:17 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40543 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeCZWAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:00:16 -0400
X-Google-Smtp-Source: AG47ELvO6DylWzfeMB/deE/MeGdeQu6gU8SNcJQ7kljVzqs2nmoBqsHd7Q4LrNTw6rcV7SlUmpEapg==
Subject: Re: [PATCH] aspeed: watchdog: Add status function
To: Eddie James <eajames@linux.vnet.ibm.com>,
        linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, wim@linux-watchdog.org, joel@jms.id.au,
        openbmc@lists.ozlabs.org
References: <1522099028-20347-1-git-send-email-eajames@linux.vnet.ibm.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <eeaa2de8-937d-4371-1b32-931b3221f6ce@roeck-us.net>
Date: Mon, 26 Mar 2018 15:00:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1522099028-20347-1-git-send-email-eajames@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/26/2018 02:17 PM, Eddie James wrote:
> Populate the status watchdog operation to return the "timeout status"
> register of the ASPEED watchdog.
> 
> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
> ---
>   drivers/watchdog/aspeed_wdt.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index a5b8eb2..d6dd5c9 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -55,6 +55,7 @@ struct aspeed_wdt_config {
>   #define   WDT_CTRL_WDT_INTR		BIT(2)
>   #define   WDT_CTRL_RESET_SYSTEM		BIT(1)
>   #define   WDT_CTRL_ENABLE		BIT(0)
> +#define WDT_TIMEOUT_STATUS	0x10
>   
>   /*
>    * WDT_RESET_WIDTH controls the characteristics of the external pulse (if
> @@ -138,6 +139,13 @@ static int aspeed_wdt_ping(struct watchdog_device *wdd)
>   	return 0;
>   }
>   
> +static unsigned int aspeed_wdt_status(struct watchdog_device *wdd)
> +{
> +	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
> +
> +	return readl(wdt->base + WDT_TIMEOUT_STATUS);
> +}

Does the register report WDIOF_* status flags/bits as defined in the API ?
This seems more than unlikely.

Guenter

> +
>   static int aspeed_wdt_set_timeout(struct watchdog_device *wdd,
>   				  unsigned int timeout)
>   {
> @@ -171,6 +179,7 @@ static int aspeed_wdt_restart(struct watchdog_device *wdd,
>   	.start		= aspeed_wdt_start,
>   	.stop		= aspeed_wdt_stop,
>   	.ping		= aspeed_wdt_ping,
> +	.status		= aspeed_wdt_status,
>   	.set_timeout	= aspeed_wdt_set_timeout,
>   	.restart	= aspeed_wdt_restart,
>   	.owner		= THIS_MODULE,
> 
