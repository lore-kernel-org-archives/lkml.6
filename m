Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752845AbeCPF2D (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 01:28:03 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39455 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbeCPF2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 01:28:01 -0400
X-Google-Smtp-Source: AG47ELt1ky+EyBtUOo0FIO07OJ9v7hhMpYQ5xnQYUr83UmEKUNdoCRt07vQeBFppDwa4VXvYqUSxZQ==
Subject: Re: [PATCH v2] watchdog: aspeed: Allow configuring for alternate boot
To: Eddie James <eajames@linux.vnet.ibm.com>,
        linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, joel@jms.id.au, wim@linux-watchdog.org,
        Milton Miller <miltonm@us.ibm.com>
References: <1521129726-15490-1-git-send-email-eajames@linux.vnet.ibm.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <4be330f2-455c-46d5-b98a-8319b07cffcc@roeck-us.net>
Date: Thu, 15 Mar 2018 22:27:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521129726-15490-1-git-send-email-eajames@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15/2018 09:02 AM, Eddie James wrote:
> From: Milton Miller <miltonm@us.ibm.com>
> 
> Allow the device tree to specify a watchdog to fallover to
> the alternate boot source.
> 
> The aspeeed watchdog can set a latch directing flash chip select 0 to
> chip select 1, allowing boot from an alternate media if the watchdog
> is not reset in time.  On the ast2400 bank 1 also goes to flash bank 1,
> while on the ast2500 the chip selects are swapped.
> 
> Also clear the secondary boot bit during the machine restart operation.
> Otherwise, the system will switch to the alternate boot after every
> reboot, which is not desired.
> 
> Signed-off-by: Milton Miller <miltonm@us.ibm.com>
> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes since v1:
>   * Disable secondary boot before the restart operation.
> 
>   drivers/watchdog/aspeed_wdt.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index d1987d6..a5b8eb2 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -46,6 +46,7 @@ struct aspeed_wdt_config {
>   #define WDT_RELOAD_VALUE	0x04
>   #define WDT_RESTART		0x08
>   #define WDT_CTRL		0x0C
> +#define   WDT_CTRL_BOOT_SECONDARY	BIT(7)
>   #define   WDT_CTRL_RESET_MODE_SOC	(0x00 << 5)
>   #define   WDT_CTRL_RESET_MODE_FULL_CHIP	(0x01 << 5)
>   #define   WDT_CTRL_RESET_MODE_ARM_CPU	(0x10 << 5)
> @@ -158,6 +159,7 @@ static int aspeed_wdt_restart(struct watchdog_device *wdd,
>   {
>   	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
>   
> +	wdt->ctrl &= ~WDT_CTRL_BOOT_SECONDARY;
>   	aspeed_wdt_enable(wdt, 128 * WDT_RATE_1MHZ / 1000);
>   
>   	mdelay(1000);
> @@ -245,6 +247,8 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>   	}
>   	if (of_property_read_bool(np, "aspeed,external-signal"))
>   		wdt->ctrl |= WDT_CTRL_WDT_EXT;
> +	if (of_property_read_bool(np, "aspeed,alt-boot"))
> +		wdt->ctrl |= WDT_CTRL_BOOT_SECONDARY;
>   
>   	if (readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE)  {
>   		/*
> 
