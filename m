Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935333AbeBPLIr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:08:47 -0500
Received: from server.atrad.com.au ([150.101.241.2]:36852 "EHLO
        server.atrad.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935119AbeBPLIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:08:46 -0500
Date: Fri, 16 Feb 2018 21:20:14 +1030
From: Jonathan Woithe <jwoithe@just42.net>
To: Micha?? K??pie?? <kernel@kempniu.pl>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] platform/x86: fujitsu-laptop: Define constants for
 backlight power control
Message-ID: <20180216105014.GB25974@marvin.atrad.com.au>
References: <20180211210727.12130-1-kernel@kempniu.pl>
 <20180211210727.12130-7-kernel@kempniu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180211210727.12130-7-kernel@kempniu.pl>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-MIMEDefang-action: accept
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 10:07:26PM +0100, Micha?? K??pie?? wrote:
> Use named constants instead of integers in call_fext_func() invocations
> related to backlight power control in order to more clearly convey the
> intent of each call.
> 
> Signed-off-by: Micha?? K??pie?? <kernel@kempniu.pl>
> ---
[cut]
> +/* FUNC interface - backlight power control */
> +#define BACKLIGHT_POWER	0x4
> +#define BACKLIGHT_OFF	0x3
> +#define BACKLIGHT_ON	0x0

A minor detail: BACKLIGHT_OFF and BACKLIGHT_ON are potential parameter
values while BACKLIGHT_POWER is essentially a parameter selector.  Should
the name of BACKLIGHT_POWER reflect this difference?  It could be difficult
to do without making the resulting identifier a little long.  The best I can
come up with is BACKLIGHT_PARAM_POWER or (if a saving of one character is
desired) BACKLIGHT_PARM_POWER.

[cut]
> @@ -818,7 +825,8 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
>  	/* Sync backlight power status */
>  	if (fujitsu_bl && fujitsu_bl->bl_device &&
>  	    acpi_video_get_backlight_type() == acpi_backlight_vendor) {
> -		if (call_fext_func(fext, FUNC_BACKLIGHT, 0x2, 0x4, 0x0) == 3)
> +		if (call_fext_func(fext, FUNC_BACKLIGHT, 0x2, BACKLIGHT_POWER,
> +				   0x0) == 3)
>  			fujitsu_bl->bl_device->props.power = FB_BLANK_POWERDOWN;
>  		else
>  			fujitsu_bl->bl_device->props.power = FB_BLANK_UNBLANK;

I'm curious: this fext function call is, I think, returning the current
backlight power value.  If that's the case, is the value of 3 used in the
test of the return function conceptually BACKLIGHT_OFF, and if so, should we
use BACKLIGHT_OFF instead of the numeric constant?  It seems likely given
that it results in the backlight power property being set to
FB_BLANK_POWERDOWN.

Regards
  jonathan
