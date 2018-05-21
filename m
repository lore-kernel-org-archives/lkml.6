Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754200AbeEUWBZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 18:01:25 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35160 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753663AbeEUVVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 17:21:22 -0400
X-Google-Smtp-Source: AB8JxZq6WZjbhU49bgc0leFbVJQnxv/6ZiZ0F5s5rYacqd3oESva+Vpg4pfcEBLOeM/iR17wMZVdGA==
Date: Mon, 21 May 2018 14:21:18 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Vittorio Gambaletta (VittGam)" <linuxbugs@vittgam.net>
Cc: linux-kernel@vger.kernel.org, bleung@chromium.org, bleung@google.com,
        olof@lixom.net, Salvatore Bellizzi <lkml@seppia.net>,
        groeck@chromium.org, groeck@google.com
Subject: Re: [PATCH RESEND] platform/chrome: cros_ec_lpc: Add support for
 newer Google devices using custom coreboot firmware or stock SeaBIOS.
Message-ID: <20180521212118.GD74396@dtor-ws>
References: <201805210544.w4L5iZ9B083096@mail.vittgam.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201805210544.w4L5iZ9B083096@mail.vittgam.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vittorio,

On Mon, May 21, 2018 at 07:44:35AM +0200, Vittorio Gambaletta (VittGam) wrote:
> Custom coreboot firmware does not contain "Google_*" as BIOS
> version string; also, booting through stock SeaBIOS will present
> an empty BIOS version string to Linux. So the generic match at
> the top would not work.
> 
> A previous patch added the "GOOGLE" match for DMI system vendor,
> but newer machines such as Skylake-based Caroline use "Google"
> instead.
> 
> Also amend the previous comment adding a note that this is needed
> for stock SeaBIOS too.

I think this driver is incorrectly structured and adding new DMI
signatures should not be needed. The newer hardware has the device
GOOG0004 in their ACPI tables, we should not need additional DMI checks.
DMI checks should only be needed for much older hardware, such as
Link/Peppy that did not have EC described in DSDT.

Let me see if I can fix it up.

> 
> Signed-off-by: Vittorio Gambaletta <linuxbugs@vittgam.net>
> Signed-off-by: Salvatore Bellizzi <lkml@seppia.net>
> 
> ---
> 
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -347,7 +347,8 @@
>  	},
>  	{
>  		/*
> -		 * If the box is running custom coreboot firmware then the
> +		 * If the box is running custom coreboot firmware,
> +		 * or is booting Linux through stock SeaBIOS, then the
>  		 * DMI BIOS version string will not be matched by "Google_",
>  		 * but the system vendor string will still be matched by
>  		 * "GOOGLE".
> @@ -358,6 +359,16 @@
>  		},
>  	},
>  	{
> +		/*
> +		 * Newer machines use "Google" instead of "GOOGLE" as
> +		 * DMI system vendor string.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
> +		},
> +	},
> +	{
>  		/* x86-link, the Chromebook Pixel. */
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),

Thanks.

-- 
Dmitry
