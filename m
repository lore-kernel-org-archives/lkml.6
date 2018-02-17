Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751116AbeBQQOp (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 11:14:45 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:32979 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751035AbeBQQOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 11:14:43 -0500
X-Google-Smtp-Source: AH8x2258RVSou3hV1l3uebYRtWMzyq8kakXAmLZoAyDnx5LkxCxoc+ngeqgTkO/IQBiqc2fErnsUhA==
Date: Sat, 17 Feb 2018 08:14:41 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, rwright@hpe.com,
        maurice.a.saldivar@hpe.com, mingo@kernel.org,
        marcus.folkesson@gmail.com
Subject: Re: [v3,03/11] watchdog/hpwdt: Update nmi_panic message.
Message-ID: <20180217161441.GA22055@roeck-us.net>
References: <20180215234400.5022-4-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215234400.5022-4-jerry.hoemann@hpe.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 04:43:52PM -0700, Jerry Hoemann wrote:
> Include the nmistat in the nmi_panic message to give support
> an indication why the NMI was called (e.g. a timeout or generate
> nmi button.)
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> ---
>  drivers/watchdog/hpwdt.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 20a13c5d0285..07810caabf74 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -113,19 +113,23 @@ static int hpwdt_my_nmi(void)
>   */
>  static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
>  {
> -	if ((ulReason == NMI_UNKNOWN) && !hpwdt_my_nmi())
> +	unsigned int mynmi = hpwdt_my_nmi();
> +	static char panic_msg[] =
> +		"00: An NMI occurred. Depending on your system the reason "
> +		"for the NMI is logged in any one of the following resources:\n"
> +		"1. Integrated Management Log (IML)\n"
> +		"2. OA Syslog\n"
> +		"3. OA Forward Progress Log\n"
> +		"4. iLO Event Log";
> +
> +	if ((ulReason == NMI_UNKNOWN) && !mynmi)

As mentioned before, I won't accept patches with unnecessary ( ).
Deferring to Wim.

Guenter

>  		return NMI_DONE;
>  
>  	if (allow_kdump)
>  		hpwdt_stop();
>  
> -	nmi_panic(regs, "An NMI occurred. Depending on your system the reason "
> -		"for the NMI is logged in any one of the following "
> -		"resources:\n"
> -		"1. Integrated Management Log (IML)\n"
> -		"2. OA Syslog\n"
> -		"3. OA Forward Progress Log\n"
> -		"4. iLO Event Log");
> +	hex_byte_pack(panic_msg, mynmi);
> +	nmi_panic(regs, panic_msg);
>  
>  	return NMI_HANDLED;
>  }
