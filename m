Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751210AbeBPUer (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 15:34:47 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38069 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750801AbeBPUem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 15:34:42 -0500
X-Google-Smtp-Source: AH8x224trVTbqqsNYYwAsWUirkIhBqEHd/nHUPU1W/ubs98aIrtxUOSJo6MTbA26JgEHAdOSmiSZIQ==
Date: Fri, 16 Feb 2018 12:34:40 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, rwright@hpe.com,
        maurice.a.saldivar@hpe.com, mingo@kernel.org,
        marcus.folkesson@gmail.com
Subject: Re: [PATCH v3 08/11] watchdog/hpwdt: Programable Pretimeout NMI
Message-ID: <20180216203440.GA31849@roeck-us.net>
References: <20180215234400.5022-1-jerry.hoemann@hpe.com>
 <20180215234400.5022-9-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215234400.5022-9-jerry.hoemann@hpe.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 04:43:57PM -0700, Jerry Hoemann wrote:
> Make whether or not the hpwdt watchdog delivers a pretimeout NMI
> programable by the user.
> 
> The underlying iLO hardware is programmable as to whether or not
> a pre-timeout NMI is delivered to the system before the iLO resets
> the system.  However, the iLO does not allow for programming the
> length of time that NMI is delivered before the system is reset.
> 
> Hence, in hpwdt_set_pretimeout, val == 0 disables the NMI. Any
> non-zero value sets the pretimeout length to what the hardware
> supports.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> ---
>  drivers/watchdog/hpwdt.c | 42 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index da9a04101814..dc0ad20738ed 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -28,12 +28,15 @@
>  #define TICKS_TO_SECS(ticks)		((ticks) * 128 / 1000)
>  #define HPWDT_MAX_TIMER			TICKS_TO_SECS(65535)
>  #define DEFAULT_MARGIN			30
> +#define PRETIMEOUT_SEC			9
>  
>  static unsigned int soft_margin = DEFAULT_MARGIN;	/* in seconds */
> -static unsigned int reload;			/* the computed soft_margin */
>  static bool nowayout = WATCHDOG_NOWAYOUT;
>  #ifdef CONFIG_HPWDT_NMI_DECODING
>  static unsigned int allow_kdump = 1;
> +static bool pretimeout = 1;
> +#else
> +static bool pretimeout;
>  #endif
>  
static bool pretimeout = IS_ENABLED(CONFIG_HPWDT_NMI_DECODING);

>  static void __iomem *pci_mem_addr;		/* the PCI-memory address */
> @@ -55,10 +58,12 @@ static struct watchdog_device hpwdt_dev;
>   */
>  static int hpwdt_start(struct watchdog_device *dev)
>  {
> -	reload = SECS_TO_TICKS(dev->timeout);
> +	int control = 0x81 | (pretimeout ? 0x4 : 0);
> +	int reload = SECS_TO_TICKS(dev->timeout);
>  
> +	dev_dbg(dev->parent, "start watchdog 0x%08x:0x%02x\n", reload, control);
>  	iowrite16(reload, hpwdt_timer_reg);
> -	iowrite8(0x85, hpwdt_timer_con);
> +	iowrite8(control, hpwdt_timer_con);
>  
>  	return 0;
>  }
> @@ -67,6 +72,8 @@ static int hpwdt_stop(struct watchdog_device *dev)
>  {
>  	unsigned long data;
>  
> +	dev_dbg(dev->parent, "stop  watchdog\n");
> +
Unrelated.

>  	data = ioread8(hpwdt_timer_con);
>  	data &= 0xFE;
>  	iowrite8(data, hpwdt_timer_con);
> @@ -75,8 +82,9 @@ static int hpwdt_stop(struct watchdog_device *dev)
>  
>  static int hpwdt_ping(struct watchdog_device *dev)
>  {
> -	reload = SECS_TO_TICKS(dev->timeout);
> +	int reload = SECS_TO_TICKS(dev->timeout);
>  
> +	dev_dbg(dev->parent, "ping  watchdog 0x%08x\n", reload);

Unrelated. If you want to add debug messages, please do it
in a separate patch.

>  	iowrite16(reload, hpwdt_timer_reg);
>  
>  	return 0;
> @@ -98,12 +106,21 @@ static int hpwdt_settimeout(struct watchdog_device *dev, unsigned int val)
>  }
>  
>  #ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
> +static int hpwdt_set_pretimeout(struct watchdog_device *dev, unsigned int val)
> +{
> +	if (val && (val != PRETIMEOUT_SEC)) {

Unnecessary ( )

The actual timeout can be a value smaller than 9 seconds.
Minimum is 1 second. What happens if the user configures
a timeout of less than 9 seconds as well as a pretimeout ?
Will it fire immediately ? 

> +		dev_info(dev->parent, "Setting pretimeout to %d\n", PRETIMEOUT_SEC);

Please no ongoing logging noise. This can easily be abused to clog
the kernel log.

> +		val = PRETIMEOUT_SEC;
> +	}
> +	dev->pretimeout = val;
> +	pretimeout = val ? 1 : 0;

	pretimeout = !!val;

> +	return 0;
> +}
>  
>  static unsigned int hpwdt_my_nmi(void)
>  {
>  	return ioread8(hpwdt_nmistat) & 0x6;
>  }
> -
>  /*
>   *	NMI Handler
>   */
> @@ -123,6 +140,9 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
>  
>  	pr_debug("nmi: ulReason=%d, mynmi=0x%0x\n", ulReason, mynmi);
>  
> +	if (!pretimeout)
> +		return NMI_DONE;
> +
>  	if (allow_kdump)
>  		hpwdt_stop(&hpwdt_dev);
>  
> @@ -137,7 +157,8 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
>  static const struct watchdog_info hpwdt_info = {
>  	.options	= WDIOF_SETTIMEOUT    |
>  			  WDIOF_KEEPALIVEPING |
> -			  WDIOF_MAGICCLOSE,
> +			  WDIOF_MAGICCLOSE    |
> +			  WDIOF_PRETIMEOUT,
>  	.identity	= "HPE iLO2+ HW Watchdog Timer",
>  };
>  
> @@ -291,6 +312,9 @@ static const struct watchdog_ops hpwdt_ops = {
>  	.ping		= hpwdt_ping,
>  	.set_timeout	= hpwdt_settimeout,
>  	.get_timeleft	= hpwdt_gettimeleft,
> +#ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
> +	.set_pretimeout	= hpwdt_set_pretimeout,
> +#endif					/* } */
>  };
>  
>  static struct watchdog_device hpwdt_dev = {
> @@ -299,6 +323,9 @@ static struct watchdog_device hpwdt_dev = {
>  	.min_timeout	= 1,
>  	.max_timeout	= HPWDT_MAX_TIMER,
>  	.timeout	= DEFAULT_MARGIN,
> +#ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
> +	.pretimeout	= PRETIMEOUT_SEC,
> +#endif					/* } */
>  };
>  
>  
> @@ -317,6 +344,9 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
>  #ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
>  module_param(allow_kdump, int, 0);
>  MODULE_PARM_DESC(allow_kdump, "Start a kernel dump after NMI occurs");
> +
> +module_param(pretimeout, bool, 0);
> +MODULE_PARM_DESC(pretimeout, "Watchdog pretimeout enabled");
>  #endif					/* } */
>  
>  module_pci_driver(hpwdt_driver);
> -- 
> 2.13.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
