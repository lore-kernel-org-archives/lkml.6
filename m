Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D053ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1649920854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1649920854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388105AbeGWMpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 08:45:13 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61576 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387922AbeGWMpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 08:45:12 -0400
Received: from 79.184.255.17.ipv4.supernova.orange.pl (79.184.255.17) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 6053d99af2727ef5; Mon, 23 Jul 2018 13:44:22 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Erik Schmauss <erik.schmauss@intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: Re: [PATCH] Revert "ACPI / bus: Parse tables as term_list for Dell XPS 9570 and Precision M5530"
Date:   Mon, 23 Jul 2018 13:42:37 +0200
Message-ID: <5241523.N3ikpBZNhp@aspire.rjw.lan>
In-Reply-To: <20180719110030.9483-1-kai.heng.feng@canonical.com>
References: <20180719110030.9483-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 19, 2018 1:00:30 PM CEST Kai-Heng Feng wrote:
> This reverts commit 36904703aeeeb6cd31993f1353c8325006229f9a.
> 
> Since commit 5a8361f7ecce ("ACPICA: Integrate package handling with
> module-level code"), acpi_gbl_execute_tables_as_methods is always true,
> so we can remove the quirk for XPS 9570/Precision M5530.
> 
> Cc: Erik Schmauss <erik.schmauss@intel.com>
> Cc: Mario Limonciello <mario.limonciello@dell.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/acpi/bus.c | 38 +++++++-------------------------------
>  1 file changed, 7 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 84b4a62018eb..f61f8927d843 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -66,37 +66,10 @@ static int set_copy_dsdt(const struct dmi_system_id *id)
>  	return 0;
>  }
>  #endif
> -static int set_gbl_term_list(const struct dmi_system_id *id)
> -{
> -	acpi_gbl_execute_tables_as_methods = 1;
> -	return 0;
> -}
>  
> -static const struct dmi_system_id acpi_quirks_dmi_table[] __initconst = {
> -	/*
> -	 * Touchpad on Dell XPS 9570/Precision M5530 doesn't work under I2C
> -	 * mode.
> -	 * https://bugzilla.kernel.org/show_bug.cgi?id=198515
> -	 */
> -	{
> -		.callback = set_gbl_term_list,
> -		.ident = "Dell Precision M5530",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Precision M5530"),
> -		},
> -	},
> -	{
> -		.callback = set_gbl_term_list,
> -		.ident = "Dell XPS 15 9570",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "XPS 15 9570"),
> -		},
> -	},
> +static const struct dmi_system_id dsdt_dmi_table[] __initconst = {
>  	/*
>  	 * Invoke DSDT corruption work-around on all Toshiba Satellite.
> -	 * DSDT will be copied to memory.
>  	 * https://bugzilla.kernel.org/show_bug.cgi?id=14679
>  	 */
>  	{
> @@ -110,7 +83,7 @@ static const struct dmi_system_id acpi_quirks_dmi_table[] __initconst = {
>  	{}
>  };
>  #else
> -static const struct dmi_system_id acpi_quirks_dmi_table[] __initconst = {
> +static const struct dmi_system_id dsdt_dmi_table[] __initconst = {
>  	{}
>  };
>  #endif
> @@ -1060,8 +1033,11 @@ void __init acpi_early_init(void)
>  
>  	acpi_permanent_mmap = true;
>  
> -	/* Check machine-specific quirks */
> -	dmi_check_system(acpi_quirks_dmi_table);
> +	/*
> +	 * If the machine falls into the DMI check table,
> +	 * DSDT will be copied to memory
> +	 */
> +	dmi_check_system(dsdt_dmi_table);
>  
>  	status = acpi_reallocate_root_table();
>  	if (ACPI_FAILURE(status)) {
> 

Applied, thanks!


