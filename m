Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965379AbeBMRlj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:41:39 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41128 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965023AbeBMRlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:41:37 -0500
X-Google-Smtp-Source: AH8x225LrJL1njOFQtoyAIQrCM8rK+wfdL7a4KJINvN8ck1W5XAfxTvLeVQgwPN5Pjz8BDBKHWFh8g==
Date: Tue, 13 Feb 2018 09:41:35 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, rwright@hpe.com,
        maurice.a.saldivar@hpe.com
Subject: Re: [PATCH v2 03/11] watchdog/hpwdt: Update nmi_panic message.
Message-ID: <20180213174135.GA22401@roeck-us.net>
References: <20180212052111.12010-1-jerry.hoemann@hpe.com>
 <20180212052111.12010-4-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212052111.12010-4-jerry.hoemann@hpe.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 10:21:03PM -0700, Jerry Hoemann wrote:
> Include the nmistat in the nmi_panic message to give support
> an indication why the NMI was called (e.g. a timeout or generate
> nmi button.)
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> ---
>  drivers/watchdog/hpwdt.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 20a13c5d0285..6f7949ef9a23 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -108,24 +108,35 @@ static int hpwdt_my_nmi(void)
>  	return ioread8(hpwdt_nmistat) & 0x6;
>  }
>  
> +static inline int hexdigit(int v)
> +{
> +	return (v > 9) ? (v-9+'A') : (v+'0');
> +}
> +
>  /*
>   *	NMI Handler
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
> +	panic_msg[0] = hexdigit((mynmi>>4)&0xf);
> +	panic_msg[1] = hexdigit(mynmi&0xf);

No need to reinvent the wheel.

	panic_msg[0] = hex_asc_hi(mynmi);
	panic_msg[1] = hex_asc_lo(mynmi);

or even better
	hex_byte_pack(panic_msg, mynmi);

There are matching _upper functions if you prefer A..F instead of a..f.

Guenter
