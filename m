Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A576CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2ED218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389213AbeLULRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 06:17:17 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:43756 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732325AbeLULRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 06:17:17 -0500
Received: from 79.184.255.25.ipv4.supernova.orange.pl (79.184.255.25) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id a6977d9430bbe637; Fri, 21 Dec 2018 12:17:14 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI / tables: Add an ifdef around amlcode and dsdt_amlcode
Date:   Fri, 21 Dec 2018 12:16:46 +0100
Message-ID: <1712098.V69yOz7Vcp@aspire.rjw.lan>
In-Reply-To: <20181220193856.7833-1-natechancellor@gmail.com>
References: <20181220193856.7833-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, December 20, 2018 8:38:56 PM CET Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/acpi/tables.c:715:14: warning: unused variable 'amlcode'
> [-Wunused-variable]
> static void *amlcode __attribute__ ((weakref("AmlCode")));
>              ^
> drivers/acpi/tables.c:716:14: warning: unused variable 'dsdt_amlcode'
> [-Wunused-variable]
> static void *dsdt_amlcode __attribute__ ((weakref("dsdt_aml_code")));
>              ^
> 2 warnings generated.
> 
> The only uses of these variables are hiddem behind CONFIG_ACPI_CUSTOM_DSDT
> so do the same thing here.
> 
> Fixes: 82e4eb4e9653 ("ACPI / tables: add DSDT AmlCode new declaration name support")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/acpi/tables.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index ccb90eff00e5..48eabb6c2d4f 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -712,8 +712,10 @@ acpi_os_physical_table_override(struct acpi_table_header *existing_table,
>  					  table_length);
>  }
>  
> +#ifdef CONFIG_ACPI_CUSTOM_DSDT
>  static void *amlcode __attribute__ ((weakref("AmlCode")));
>  static void *dsdt_amlcode __attribute__ ((weakref("dsdt_aml_code")));
> +#endif
>  
>  acpi_status
>  acpi_os_table_override(struct acpi_table_header *existing_table,
> 

Applied, thanks!


