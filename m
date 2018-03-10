Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932857AbeCJEEQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 23:04:16 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42411 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932299AbeCJEEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 23:04:14 -0500
X-Google-Smtp-Source: AG47ELvwxwabvudk0nmReiZ0sdMFSPM4HjfRMxav6P3O0ul0iBVBlhthIuOzQc3XbKUtGrHY5huYyw==
Subject: Re: [PATCH v2 1/2] watchdog: dw: RMW the control register
To: Brian Norris <briannorris@chromium.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-rockchip@lists.infradead.org
References: <20180310034607.254884-1-briannorris@chromium.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <4be661fc-033d-7be6-cda6-8e90510f1738@roeck-us.net>
Date: Fri, 9 Mar 2018 20:04:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180310034607.254884-1-briannorris@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2018 07:46 PM, Brian Norris wrote:
> RK3399 has rst_pulse_length in CONTROL_REG[4:2], determining the length
> of pulse to issue for system reset. We shouldn't clobber this value,
> because that might make the system reset ineffective. On RK3399, we're
> seeing that a value of 000b (meaning 2 cycles) yields an unreliable
> (partial?) reset, and so we only fully reset after the watchdog fires a
> second time. If we retain the system default (010b, or 8 clock cycles),
> then the watchdog reset is much more reliable.
> 
> Read-modify-write retains the system value and improves reset
> reliability.
> 
> It seems we were intentionally clobbering the response mode previously,
> to ensure we performed a system reset (we don't support an interrupt
> notification), so retain that explicitly.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v2:
>   * factor out helper
>   * handle both start() and restart() cases
>   * note the RESP_MODE handling in commit message
> ---
>   drivers/watchdog/dw_wdt.c | 23 +++++++++++++++--------
>   1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index c2f4ff516230..918357bccf5e 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -34,6 +34,7 @@
>   
>   #define WDOG_CONTROL_REG_OFFSET		    0x00
>   #define WDOG_CONTROL_REG_WDT_EN_MASK	    0x01
> +#define WDOG_CONTROL_REG_RESP_MODE_MASK	    0x02
>   #define WDOG_TIMEOUT_RANGE_REG_OFFSET	    0x04
>   #define WDOG_TIMEOUT_RANGE_TOPINIT_SHIFT    4
>   #define WDOG_CURRENT_COUNT_REG_OFFSET	    0x08
> @@ -121,14 +122,23 @@ static int dw_wdt_set_timeout(struct watchdog_device *wdd, unsigned int top_s)
>   	return 0;
>   }
>   
> +static void dw_wdt_arm_system_reset(struct dw_wdt *dw_wdt)
> +{
> +	u32 val = readl(dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
> +
> +	/* Disable interrupt mode; always perform system reset. */
> +	val &= ~WDOG_CONTROL_REG_RESP_MODE_MASK;
> +	/* Enable watchdog. */
> +	val |= WDOG_CONTROL_REG_WDT_EN_MASK;
> +	writel(val, dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
> +}
> +
>   static int dw_wdt_start(struct watchdog_device *wdd)
>   {
>   	struct dw_wdt *dw_wdt = to_dw_wdt(wdd);
>   
>   	dw_wdt_set_timeout(wdd, wdd->timeout);
> -
> -	writel(WDOG_CONTROL_REG_WDT_EN_MASK,
> -	       dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
> +	dw_wdt_arm_system_reset(dw_wdt);
>   
>   	return 0;
>   }
> @@ -152,16 +162,13 @@ static int dw_wdt_restart(struct watchdog_device *wdd,
>   			  unsigned long action, void *data)
>   {
>   	struct dw_wdt *dw_wdt = to_dw_wdt(wdd);
> -	u32 val;
>   
>   	writel(0, dw_wdt->regs + WDOG_TIMEOUT_RANGE_REG_OFFSET);
> -	val = readl(dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
> -	if (val & WDOG_CONTROL_REG_WDT_EN_MASK)
> +	if (dw_wdt_is_enabled(dw_wdt))
>   		writel(WDOG_COUNTER_RESTART_KICK_VALUE,
>   		       dw_wdt->regs + WDOG_COUNTER_RESTART_REG_OFFSET);
>   	else
> -		writel(WDOG_CONTROL_REG_WDT_EN_MASK,
> -		       dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
> +		dw_wdt_arm_system_reset(dw_wdt);
>   
>   	/* wait for reset to assert... */
>   	mdelay(500);
> 
