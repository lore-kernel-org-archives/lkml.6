Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbeBHJm7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 04:42:59 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:46381 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752210AbeBHJm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 04:42:56 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: lenb@kernel.org, andy.shevchenko@gmail.com, erik.schmauss@intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: Re: [PATCH v4] ACPI: Parse entire table as a term_list for Dell XPS 9570 and Precision M5530
Date: Thu, 08 Feb 2018 10:41:12 +0100
Message-ID: <2007331.yMPN9LMbQs@aspire.rjw.lan>
In-Reply-To: <20180205051924.10186-1-kai.heng.feng@canonical.com>
References: <20180205051924.10186-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, February 5, 2018 6:19:24 AM CET Kai-Heng Feng wrote:
> The i2c touchpad on Dell XPS 9570 and Precision M5530 doesn't work out
> of box.
> 
> The touchpad relies on its _INI method to update its _HID value from
> XXXX0000 to SYNA2393.
> Also, the _STA relies on value of I2CN to report correct status.
> 
> Set acpi_gbl_parse_table_as_term_list so the value of I2CN can be
> correctly set up, and _INI can get run. The ACPI table in this machine
> is designed to get parsed this way.
> 
> Also, change the quirk table to a more generic name.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=198515
> Cc: Mario Limonciello <mario.limonciello@dell.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v4: Remove unnecessary message for user.
> 
> v3: Put the function under right #ifdef, comment adjustment
> 
> v2: Andy's suggestion, merge to a single quirk table.
>  drivers/acpi/bus.c | 38 +++++++++++++++++++++++++++++++-------
>  1 file changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index f87ed3be779a..11c6dda233d6 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -66,10 +66,37 @@ static int set_copy_dsdt(const struct dmi_system_id *id)
>  	return 0;
>  }
>  #endif
> +static int set_gbl_term_list(const struct dmi_system_id *id)
> +{
> +	acpi_gbl_parse_table_as_term_list = 1;
> +	return 0;
> +}
>  
> -static const struct dmi_system_id dsdt_dmi_table[] __initconst = {
> +static const struct dmi_system_id acpi_quirks_dmi_table[] __initconst = {
> +	/*
> +	 * Touchpad on Dell XPS 9570/Precision M5530 doesn't work under I2C
> +	 * mode.
> +	 * https://bugzilla.kernel.org/show_bug.cgi?id=198515
> +	 */
> +	{
> +		.callback = set_gbl_term_list,
> +		.ident = "Dell Precision M5530",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Precision M5530"),
> +		},
> +	},
> +	{
> +		.callback = set_gbl_term_list,
> +		.ident = "Dell XPS 15 9570",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "XPS 15 9570"),
> +		},
> +	},
>  	/*
>  	 * Invoke DSDT corruption work-around on all Toshiba Satellite.
> +	 * DSDT will be copied to memory.
>  	 * https://bugzilla.kernel.org/show_bug.cgi?id=14679
>  	 */
>  	{
> @@ -83,7 +110,7 @@ static const struct dmi_system_id dsdt_dmi_table[] __initconst = {
>  	{}
>  };
>  #else
> -static const struct dmi_system_id dsdt_dmi_table[] __initconst = {
> +static const struct dmi_system_id acpi_quirks_dmi_table[] __initconst = {
>  	{}
>  };
>  #endif
> @@ -1019,11 +1046,8 @@ void __init acpi_early_init(void)
>  
>  	acpi_permanent_mmap = true;
>  
> -	/*
> -	 * If the machine falls into the DMI check table,
> -	 * DSDT will be copied to memory
> -	 */
> -	dmi_check_system(dsdt_dmi_table);
> +	/* Check machine-specific quirks */
> +	dmi_check_system(acpi_quirks_dmi_table);
>  
>  	status = acpi_reallocate_root_table();
>  	if (ACPI_FAILURE(status)) {
> 

Applied, thanks!
