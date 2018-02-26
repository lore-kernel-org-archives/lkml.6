Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751967AbeBZAla (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 19:41:30 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37862 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751904AbeBZAl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 19:41:26 -0500
X-Google-Smtp-Source: AH8x225+w8CibARGSV37Z3hPgajUznf/5oFk1UIrCP1BL0+s9u/MH7Ae0lFsLI47i4kjHZ0Qt6c9+g==
Date: Sun, 25 Feb 2018 16:41:23 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, rwright@hpe.com,
        maurice.a.saldivar@hpe.com, mingo@kernel.org,
        marcus.folkesson@gmail.com
Subject: Re: [v4, 06/10] watchdog/hpwdt: condition early return of NMI
 handler on iLO5
Message-ID: <20180226004123.GA13491@roeck-us.net>
References: <20180225213259.2861-7-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180225213259.2861-7-jerry.hoemann@hpe.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25, 2018 at 02:32:55PM -0700, Jerry Hoemann wrote:
> Modify prior change to not claim an NMI unless originated
> from iLO to apply only to iLO5 and later going forward.
> This restores hpwdt traditional behavior of calling panic
> if the NMI is NMI_IO_CHECK, NMI_SERR, or NMI_UNKNOWN for
> legacy hardware.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> ---
>  drivers/watchdog/hpwdt.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 1a18326bc99d..e60c689ebdb2 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -32,6 +32,7 @@
>  #define HPWDT_MAX_TIMER			TICKS_TO_SECS(65535)
>  #define DEFAULT_MARGIN			30
>  
> +static bool iLO5;

Another nitpick: CamelCase is still not preferred for variable names.

Guenter

>  static unsigned int soft_margin = DEFAULT_MARGIN;	/* in seconds */
>  static unsigned int reload;			/* the computed soft_margin */
>  static bool nowayout = WATCHDOG_NOWAYOUT;
> @@ -121,7 +122,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
>  		"3. OA Forward Progress Log\n"
>  		"4. iLO Event Log";
>  
> -	if ((ulReason == NMI_UNKNOWN) && mynmi)
> +	if (iLO5 && ulReason == NMI_UNKNOWN && mynmi)
>  		return NMI_DONE;
>  
>  	if (allow_kdump)
> @@ -279,6 +280,9 @@ static int hpwdt_init_one(struct pci_dev *dev,
>  			", timer margin: %d seconds (nowayout=%d).\n",
>  			HPWDT_VERSION, hpwdt_dev.timeout, nowayout);
>  
> +	if (dev->subsystem_vendor == PCI_VENDOR_ID_HP_3PAR)
> +		iLO5 = 1;
> +
>  	return 0;
>  
>  error_wd_register:
