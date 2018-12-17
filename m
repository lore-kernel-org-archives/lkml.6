Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A19C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F63204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732302AbeLQLjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:39:00 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:59318 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731901AbeLQLjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:39:00 -0500
Received: from 79.184.255.25.ipv4.supernova.orange.pl (79.184.255.25) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 3de697eb0eb99179; Mon, 17 Dec 2018 12:38:57 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
Cc:     robert.moore@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ACPI / tables: add DSDT AmlCode new declaration name support
Date:   Mon, 17 Dec 2018 12:38:34 +0100
Message-ID: <7887454.AELDQZ8aft@aspire.rjw.lan>
In-Reply-To: <254f789dee7773b938db7a204ca8800db10e4588.1542105349.git.dongsheng.wang@hxt-semitech.com>
References: <254f789dee7773b938db7a204ca8800db10e4588.1542105349.git.dongsheng.wang@hxt-semitech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, November 13, 2018 11:46:23 AM CET Wang Dongsheng wrote:
> The new naming rule is added in acpica version 20180427.
> So the dsdt aml code name changes from "AmlCode" to "dsdt_aml_code".
> 
> The patch that introduces naming rules is:
> https://github.com/acpica/acpica/commit/f9a88a4c1cd020b6a5475d63b29626852a0b5f37
> 
> Tested:
> ACPICA release version 20180427+.
> ARM64: QCOM QDF2400
> GCC: 4.8.5 20150623
> 
> Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
> ---
>  drivers/acpi/Kconfig  |  2 +-
>  drivers/acpi/tables.c | 10 ++++++++--
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 9705fc986da9..15ab53a52fdc 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -336,7 +336,7 @@ config ACPI_CUSTOM_DSDT_FILE
>  	  See Documentation/acpi/dsdt-override.txt
>  
>  	  Enter the full path name to the file which includes the AmlCode
> -	  declaration.
> +	  or dsdt_aml_code declaration.
>  
>  	  If unsure, don't enter a file name.
>  
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index a3d012b08fc5..297020bbaade 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -713,6 +713,9 @@ acpi_os_physical_table_override(struct acpi_table_header *existing_table,
>  					  table_length);
>  }
>  
> +static void *amlcode __attribute__ ((weakref("AmlCode")));
> +static void *dsdt_amlcode __attribute__ ((weakref("dsdt_aml_code")));
> +
>  acpi_status
>  acpi_os_table_override(struct acpi_table_header *existing_table,
>  		       struct acpi_table_header **new_table)
> @@ -723,8 +726,11 @@ acpi_os_table_override(struct acpi_table_header *existing_table,
>  	*new_table = NULL;
>  
>  #ifdef CONFIG_ACPI_CUSTOM_DSDT
> -	if (strncmp(existing_table->signature, "DSDT", 4) == 0)
> -		*new_table = (struct acpi_table_header *)AmlCode;
> +	if (!strncmp(existing_table->signature, "DSDT", 4)) {
> +		*new_table = (struct acpi_table_header *)&amlcode;
> +		if (!(*new_table))
> +			*new_table = (struct acpi_table_header *)&dsdt_amlcode;
> +	}
>  #endif
>  	if (*new_table != NULL)
>  		acpi_table_taint(existing_table);
> 

Applied with some changelog modifications, thanks!

