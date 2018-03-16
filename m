Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752392AbeCPFSy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 01:18:54 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35831 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbeCPFSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 01:18:52 -0400
X-Google-Smtp-Source: AG47ELtDnR42L0wkU16LpKqN+0GlSf6ZDFJoLR6TSe2jzToHTpQ/4rQSftREGph0+oou9k4vCJODkwrZcb4Vgs92Te8=
MIME-Version: 1.0
In-Reply-To: <1521129726-15490-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1521129726-15490-1-git-send-email-eajames@linux.vnet.ibm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 16 Mar 2018 15:48:31 +1030
X-Google-Sender-Auth: a4SwiW8TpmOysxL9ieSAUuKiRGA
Message-ID: <CACPK8XfR+FpRMDrMSmdq8wWA830BPcZCQYuPj6tMU71wfQWjWg@mail.gmail.com>
Subject: Re: [PATCH v2] watchdog: aspeed: Allow configuring for alternate boot
To: Eddie James <eajames@linux.vnet.ibm.com>
Cc: LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Milton Miller <miltonm@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 2:32 AM, Eddie James <eajames@linux.vnet.ibm.com> wrote:
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

That will do.

Reviewed-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel

> ---
> Changes since v1:
>  * Disable secondary boot before the restart operation.
>
>  drivers/watchdog/aspeed_wdt.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index d1987d6..a5b8eb2 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -46,6 +46,7 @@ struct aspeed_wdt_config {
>  #define WDT_RELOAD_VALUE       0x04
>  #define WDT_RESTART            0x08
>  #define WDT_CTRL               0x0C
> +#define   WDT_CTRL_BOOT_SECONDARY      BIT(7)
>  #define   WDT_CTRL_RESET_MODE_SOC      (0x00 << 5)
>  #define   WDT_CTRL_RESET_MODE_FULL_CHIP        (0x01 << 5)
>  #define   WDT_CTRL_RESET_MODE_ARM_CPU  (0x10 << 5)
> @@ -158,6 +159,7 @@ static int aspeed_wdt_restart(struct watchdog_device *wdd,
>  {
>         struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
>
> +       wdt->ctrl &= ~WDT_CTRL_BOOT_SECONDARY;
>         aspeed_wdt_enable(wdt, 128 * WDT_RATE_1MHZ / 1000);
>
>         mdelay(1000);
> @@ -245,6 +247,8 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>         }
>         if (of_property_read_bool(np, "aspeed,external-signal"))
>                 wdt->ctrl |= WDT_CTRL_WDT_EXT;
> +       if (of_property_read_bool(np, "aspeed,alt-boot"))
> +               wdt->ctrl |= WDT_CTRL_BOOT_SECONDARY;
>
>         if (readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE)  {
>                 /*
> --
> 1.8.3.1
>
