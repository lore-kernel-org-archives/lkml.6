Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754524AbeDWJLt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 05:11:49 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45957 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754347AbeDWJLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 05:11:44 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, broonie@kernel.org,
        lorenzo.pieralisi@arm.com, bill.fletcher@linaro.org,
        linux-arm-kernel@lists.infradead.org, graeme.gregory@linaro.org
Subject: Re: [PATCH] ACPI / button: make module loadable when booted in non-ACPI mode
Date: Mon, 23 Apr 2018 11:11:36 +0200
Message-ID: <19815719.fbhg0N8B6c@aspire.rjw.lan>
In-Reply-To: <20180423082834.24617-1-ard.biesheuvel@linaro.org>
References: <20180423082834.24617-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 23, 2018 10:28:34 AM CEST Ard Biesheuvel wrote:
> Modules such as nouveau.ko and i915.ko have a link time dependency on
> acpi_lid_open(), and due to its use of acpi_bus_register_driver(),
> the button.ko module that provides it is only loadable when booted in
> ACPI mode. However, the ACPI button driver can be built into the core
> kernel as well, in which case the dependency can always be satisfied,
> and the dependent modules can be loaded regardless of whether the
> system was booted in ACPI mode or not.
> 
> So let's fix this asymmetry by making the ACPI button driver loadable
> as a module even if not booted in ACPI mode, so it can provide the
> acpi_lid_open() symbol in the same way as when built into the kernel.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> Could we perhaps get this into -stable as well? It is not a classic
> regression, but it completely breaks, e.g., Fedora when booting in
> DT mode on an ARM system.
> 
>  drivers/acpi/button.c | 23 +++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index e1eee7a60fad..0506ca56c615 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -635,4 +635,25 @@ module_param_call(lid_init_state,
>  		  NULL, 0644);
>  MODULE_PARM_DESC(lid_init_state, "Behavior for reporting LID initial state");
>  
> -module_acpi_driver(acpi_button_driver);
> +/*
> + * Modules such as nouveau.ko and i915.ko have a link time dependency on
> + * acpi_lid_open(), and would therefore not be loadable on ACPI capable kernels
> + * booted in non-ACPI mode if we use the ordinary acpi_bus_[un]register_driver
> + * routines here (which only work when booted in ACPI mode) and build this
> + * driver as a module. So provide our own versions instead.
> + */
> +static int __acpi_bus_register_driver(struct acpi_driver *driver)
> +{
> +	if (!acpi_disabled)
> +		return acpi_bus_register_driver(driver);
> +	return 0;
> +}

I would write this as:

    if (acpi_disabled)
            return 0;

    return acpi_bus_register_driver(driver);

and the comment can go above the (acpi_disabled) check then (bacause that's
what makes the difference when ACPI is disabled).

> +
> +static void __acpi_bus_unregister_driver(struct acpi_driver *driver)
> +{
> +	if (!acpi_disabled)
> +		acpi_bus_unregister_driver(driver);
> +}
> +
> +module_driver(acpi_button_driver, __acpi_bus_register_driver,
> +	      __acpi_bus_unregister_driver);
> 
