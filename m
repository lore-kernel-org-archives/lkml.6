Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965453AbeBMSUq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 13:20:46 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:47045 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965286AbeBMSUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 13:20:44 -0500
X-Google-Smtp-Source: AH8x226ZsNbsqALQKHNwgMVYBXS+KC5+UBv7HA8GteqbNeBoYTUuv+sRrGoN0yAsvJQzCHTTFXXZ3Q==
Date: Tue, 13 Feb 2018 10:20:42 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, rwright@hpe.com,
        maurice.a.saldivar@hpe.com
Subject: Re: [PATCH v2 10/11] watchdog/hpwdt: remove allow_kdump module
 parameter.
Message-ID: <20180213182042.GA26558@roeck-us.net>
References: <20180212052111.12010-1-jerry.hoemann@hpe.com>
 <20180212052111.12010-11-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212052111.12010-11-jerry.hoemann@hpe.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 10:21:10PM -0700, Jerry Hoemann wrote:
> The intent of this parameter is unclear and it sets up a
> race between the reset of the system by ASR and crashdump.
> 
> The length of time between receipt of the pretimeout NMI
> and the ASR reset of the system is fixed by hardware.
> 
> Turning the parameter off doesn't necessairly prevent a crash dump.
> Also, having the ASR reset occur while the system is crash dumping
> doesn't imply that the dump was hung given the short duration
> between the NMI and the reset.
> 
> This parameter is not a substitute for having a architected watchdog
> crashdump hang detection paridigm.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> ---
>  drivers/watchdog/hpwdt.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index e9e54fe20804..bb0dcc8709b8 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -33,7 +33,6 @@
>  static unsigned int soft_margin = DEFAULT_MARGIN;	/* in seconds */
>  static bool nowayout = WATCHDOG_NOWAYOUT;
>  #ifdef CONFIG_HPWDT_NMI_DECODING
> -static unsigned int allow_kdump = 1;

At the end of hpwdt_init_nmi_decoding(), there used to be a log message
showing the value of allow_kdump. Maybe that was removed in another patch,
but it really belongs to this patch, or am I missing something ?

Guenter

>  static bool pretimeout = 1;
>  #else
>  static bool pretimeout;
> @@ -149,8 +148,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
>  	if (iLO5 && (ulReason == NMI_UNKNOWN) && !mynmi)
>  		return NMI_DONE;
>  
> -	if (allow_kdump)
> -		hpwdt_stop(&hpwdt_dev);
> +	hpwdt_stop(&hpwdt_dev);
>  
>  	panic_msg[0] = hexdigit((mynmi>>4)&0xf);
>  	panic_msg[1] = hexdigit(mynmi&0xf);
> @@ -351,9 +349,6 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
>  		__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>  
>  #ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
> -module_param(allow_kdump, int, 0444);
> -MODULE_PARM_DESC(allow_kdump, "Start a kernel dump after NMI occurs");
> -
>  module_param(pretimeout, bool, 0444);
>  MODULE_PARM_DESC(pretimeout, "Watchdog pretimeout enabled");
>  #endif					/* } */
> -- 
> 2.13.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
