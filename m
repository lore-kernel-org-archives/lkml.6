Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A37C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0ACC20851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="UglCcAHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0ACC20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbeLMUXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:23:31 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35386 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbeLMUXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 15:23:30 -0500
Received: from zn.tnic (p200300EC2BCC680084911476902B5E84.dip0.t-ipconnect.de [IPv6:2003:ec:2bcc:6800:8491:1476:902b:5e84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C680C1EC08EA;
        Thu, 13 Dec 2018 21:23:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544732609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8blBEzpgaCgxxxZX/oLptrY8jAWxvolU5XO+o2vTI1s=;
        b=UglCcAHgg+HyXJC+5Wuj4NgdqPJqxkE6xZlwR6nEYKHBoEX+sg4MWjHO7XQX+miXpbBUjD
        aIYqbmCrI4qhj0nkqirb0/6Akd8UnzJAHPZojaxVwKHUeyTNP59f3igUFJZVeNxPkNtbY4
        aYayImfPF1S/6a9Ea/xrpleF3LBQvpk=
Date:   Thu, 13 Dec 2018 21:23:04 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, keescook@chromium.org,
        bhe@redhat.com, msys.mizuma@gmail.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v13 3/6] x86/boot: Introduce efi_get_rsdp_addr() to find
 RSDP from EFI table
Message-ID: <20181213202304.GG25287@zn.tnic>
References: <20181212031053.1815-1-fanc.fnst@cn.fujitsu.com>
 <20181212031053.1815-4-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181212031053.1815-4-fanc.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 11:10:50AM +0800, Chao Fan wrote:
> Memory information in SRAT is necessary to fix the conflict between
> KASLR and memory-hotremove. So RSDP and SRAT should be parsed.
> 
> When booting form KEXEC/EFI/BIOS, the methods to compute RSDP
> are different. When booting from EFI, EFI table points to RSDP.
> So parse the EFI table and find the RSDP.
> 
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/boot/compressed/acpi.c | 79 +++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> index cad15686f82c..c96008712ec9 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -28,3 +28,82 @@ static acpi_physical_address get_acpi_rsdp(void)
>  	return 0;
>  #endif
>  }
> +
> +/* Search EFI table for RSDP. */
> +static acpi_physical_address efi_get_rsdp_addr(void)
> +{
> +#ifdef CONFIG_EFI
> +	acpi_physical_address rsdp_addr = 0;
> +	efi_system_table_t *systab;
> +	struct efi_info *e;
> +	bool efi_64;
> +	char *sig;
> +	int size;
> +	int i;
> +
> +	e = &boot_params->efi_info;
> +	sig = (char *)&e->efi_loader_signature;
> +
> +	if (!strncmp(sig, EFI64_LOADER_SIGNATURE, 4))
> +		efi_64 = true;
> +	else if (!strncmp(sig, EFI32_LOADER_SIGNATURE, 4))
> +		efi_64 = false;
> +	else {
> +		debug_putstr("Wrong EFI loader signature.\n");
> +		return 0;
> +	}

Use curly braces for all three branches above.

> +
> +	/* Get systab from boot params. Based on efi_init(). */
> +#ifdef CONFIG_X86_64
> +	systab = (efi_system_table_t *)(e->efi_systab | ((__u64)e->efi_systab_hi<<32));
> +#else
> +	if (e->efi_systab_hi || e->efi_memmap_hi) {
> +		debug_putstr("Error getting RSDP address: EFI system table located above 4GB.\n");
> +		return 0;
> +	}
> +	systab = (efi_system_table_t *)e->efi_systab;
> +#endif
> +
> +	if (!systab)
> +		return 0;
> +
> +	/*
> +	 * Get EFI tables from systab. Based on efi_config_init() and
> +	 * efi_config_parse_tables().
> +	 */
> +	size = efi_64 ? sizeof(efi_config_table_64_t) :
> +			sizeof(efi_config_table_32_t);
> +
> +	for (i = 0; i < systab->nr_tables; i++) {
> +		void *config_tables;
> +		unsigned long table;
> +		efi_guid_t guid;
> +
> +		config_tables = (void *)(systab->tables + size * i);
> +		if (efi_64) {
> +			efi_config_table_64_t *tmp_table;
> +
> +			tmp_table = (efi_config_table_64_t *)config_tables;
> +			guid = tmp_table->guid;
> +			table = tmp_table->table;
> +
> +			if (!IS_ENABLED(CONFIG_X86_64) && table >> 32) {
> +				debug_putstr("Error getting RSDP address: EFI system table located above 4GB.\n");

Do s/system/config/ here so that this error message is different from
the one above.

> +				return 0;
> +			}
> +		} else {
> +			efi_config_table_32_t *tmp_table;
> +
> +			tmp_table = (efi_config_table_32_t *)config_tables;
> +			guid = tmp_table->guid;
> +			table = tmp_table->table;
> +		}
> +
> +		if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
> +			rsdp_addr = (acpi_physical_address)table;
> +		else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
> +			return (acpi_physical_address)table;
> +	}
> +	return rsdp_addr;
> +#endif

	}
#endif
	return rsdp_addr;
}

IOW, you have:

static acpi_physical_address efi_get_rsdp_addr(void)
{
        acpi_physical_address rsdp_addr = 0;
#ifdef CONFIG_EFI
	...
#endif
	return rsdp_addr;
}

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
