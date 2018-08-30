Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFF1C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0225E2073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0225E2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbeH3SGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:06:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:38520 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728962AbeH3SGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:06:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C38BDAE05;
        Thu, 30 Aug 2018 14:04:34 +0000 (UTC)
Date:   Thu, 30 Aug 2018 16:04:34 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH v4] console: Add console=spcr option
Message-ID: <20180830140434.k7nfdwerv72jlwyi@pathway.suse.cz>
References: <20180829155618.32359-1-prarit@redhat.com>
 <20180830123849.26163-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830123849.26163-1-prarit@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-08-30 08:38:49, Prarit Bhargava wrote:
> ACPI may contain an SPCR table that defines a default system console.
> On ARM if the table is present then the SPCR console is enabled by default.
> On x86 the SPCR console is used if 'earlycon' (no parameters) is
> specified as a kernel parameter and is used only as the early console.
> To use the SPCR data as a console a user must boot with 'earlycon',
> grep logs & specify a console= kernel parameter, and then reboot again.
> 
> Add 'console=spcr' that enables a firmware or hardware console, and on
> x86 enable the SPCR console if 'console=spcr' is specified.

> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 3b20607d581b..a43a34734f02 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -1771,3 +1771,17 @@ void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
>  	e820__range_add(addr, size, E820_TYPE_ACPI);
>  	e820__update_table_print();
>  }
> +
> +int __init arch_console_setup(char *str)
> +{
> +	int ret;
> +
> +	if (strcmp("spcr", str))
> +		return 1;
> +
> +	ret = acpi_parse_spcr(false, true);
> +	if (ret)
> +		pr_err(PREFIX "ERROR: SPCR console is not enabled (%d)\n", ret);
> +
> +	return 0;
> +}
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 924e37fb1620..ceee021a37ec 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2107,6 +2112,9 @@ static int __init console_setup(char *str)
>  	char *s, *options, *brl_options = NULL;
>  	int idx;
>  
> +	if (!arch_console_setup(str))
> +		return 1;
> +
>  	if (_braille_console_setup(&str, &brl_options))
>  		return 1;

Sigh, I am still a bit confused by the error handling. Especially
I am not sure why console_setup() always returns 1.

It looks like it means an error when called from do_early_param().
But it means that the option was proceed when called from
obsolete_checksetup(). Do I get this correctly, please?

If this is true, we should change the logic in arch_console_setup().
It should return 1 when "spcr" is handled and it should return 0
otherwise. Also it should be commented.

It looks like a historic mess. This is why I do not ask you to do
any bigger clean up. But the new patch should not make it even
more confusing by an inverted 0/1 logic.

Best Regards,
Petr
