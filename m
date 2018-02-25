Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbeBYXtF (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 18:49:05 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45284 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751770AbeBYXtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 18:49:02 -0500
X-Google-Smtp-Source: AG47ELut+8d9lP0B+gFaob6ANbFQjL1gEColL6lROLxw5OgLPbpyCCu9+JK54IXJtle7Fa/4pu9dWA==
Subject: Re: [PATCH v4 06/10] watchdog/hpwdt: condition early return of NMI
 handler on iLO5
To: Jerry Hoemann <jerry.hoemann@hpe.com>, wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, maurice.a.saldivar@hpe.com, mingo@kernel.org,
        marcus.folkesson@gmail.com
References: <20180225213259.2861-1-jerry.hoemann@hpe.com>
 <20180225213259.2861-7-jerry.hoemann@hpe.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <13cbc00b-59a2-b6bb-88c1-bd66c3bc5c21@roeck-us.net>
Date: Sun, 25 Feb 2018 15:48:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180225213259.2861-7-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/25/2018 01:32 PM, Jerry Hoemann wrote:
> Modify prior change to not claim an NMI unless originated
> from iLO to apply only to iLO5 and later going forward.
> This restores hpwdt traditional behavior of calling panic
> if the NMI is NMI_IO_CHECK, NMI_SERR, or NMI_UNKNOWN for
> legacy hardware.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> ---
>   drivers/watchdog/hpwdt.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 1a18326bc99d..e60c689ebdb2 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -32,6 +32,7 @@
>   #define HPWDT_MAX_TIMER			TICKS_TO_SECS(65535)
>   #define DEFAULT_MARGIN			30
>   
> +static bool iLO5;
>   static unsigned int soft_margin = DEFAULT_MARGIN;	/* in seconds */
>   static unsigned int reload;			/* the computed soft_margin */
>   static bool nowayout = WATCHDOG_NOWAYOUT;
> @@ -121,7 +122,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
>   		"3. OA Forward Progress Log\n"
>   		"4. iLO Event Log";
>   
> -	if ((ulReason == NMI_UNKNOWN) && mynmi)
> +	if (iLO5 && ulReason == NMI_UNKNOWN && mynmi)
>   		return NMI_DONE;
>   
>   	if (allow_kdump)
> @@ -279,6 +280,9 @@ static int hpwdt_init_one(struct pci_dev *dev,
>   			", timer margin: %d seconds (nowayout=%d).\n",
>   			HPWDT_VERSION, hpwdt_dev.timeout, nowayout);
>   
> +	if (dev->subsystem_vendor == PCI_VENDOR_ID_HP_3PAR)
> +		iLO5 = 1;

Hyper-nitpick:
		iLO5 = true;

I have seen 0day warnings because of that, so it is useful to avoid bool/int
mixups.

Thanks,
Guenter

> +
>   	return 0;
>   
>   error_wd_register:
> 
