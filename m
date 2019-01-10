Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A57AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0552220657
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="BEedg4qt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfAJVPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 16:15:33 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38948 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfAJVPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 16:15:32 -0500
Received: from zn.tnic (p200300EC2BC5CF00CD9D2FB5DCB47746.dip0.t-ipconnect.de [IPv6:2003:ec:2bc5:cf00:cd9d:2fb5:dcb4:7746])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 395B91EC08EA;
        Thu, 10 Jan 2019 22:15:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547154931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wIoi8pczJERT7x9PNmm27meszqDlWs6BJCu2jPvHxX4=;
        b=BEedg4qtQMmw3erjh/8ZHwGe1dyTnbdt8uDgxuBqRSHzN/uTadQG/W7EL+/bf54qSkRyOV
        po7juCdIWZWl58iHPIYvU1K/2kmtDt9aFcexJKL97LDlNIDmeAqUOBAEQrjQs1ygsmZwZX
        fTkBDhNQZiWw7glG2UcZS145+lc94nY=
Date:   Thu, 10 Jan 2019 22:15:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, keescook@chromium.org,
        bhe@redhat.com, msys.mizuma@gmail.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v15 3/6] x86/boot: Introduce efi_get_rsdp_addr() to find
 RSDP from EFI table
Message-ID: <20190110211523.GG17621@zn.tnic>
References: <20190107032243.25324-1-fanc.fnst@cn.fujitsu.com>
 <20190107032243.25324-4-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190107032243.25324-4-fanc.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 11:22:40AM +0800, Chao Fan wrote:
> Memory information in SRAT is necessary to fix the conflict between
> KASLR and memory-hotremove. So RSDP and SRAT should be parsed.
> 
> When booting form KEXEC/EFI/BIOS, the methods to compute RSDP
> are different. When booting from EFI, EFI table points to RSDP.
> So parse the EFI table and find the RSDP.
> 
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/boot/compressed/acpi.c | 83 +++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> index 7ca5001d7639..f74c5d033d79 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -5,6 +5,8 @@
>  #include "../string.h"
>  
>  #include <linux/acpi.h>
> +#include <linux/efi.h>
> +#include <asm/efi.h>
>  
>  /*
>   * Max length of 64-bit hex address string is 19, prefix "0x" + 16 hex
> @@ -28,3 +30,84 @@ static acpi_physical_address get_acpi_rsdp(void)
>  #endif
>  	return 0;
>  }
> +
> +/* Search EFI table for RSDP. */
> +static acpi_physical_address efi_get_rsdp_addr(void)
> +{
> +	acpi_physical_address rsdp_addr = 0;


<---- newline here.

> +#ifdef CONFIG_EFI
> +	efi_system_table_t *systab;
> +	struct efi_info *ei;
> +	bool efi_64;
> +	char *sig;
> +	int size;
> +	int i;
> +
> +	ei = &boot_params->efi_info;
> +	sig = (char *)&ei->efi_loader_signature;
> +
> +	if (!strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
> +		efi_64 = true;
> +	} else if (!strncmp(sig, EFI32_LOADER_SIGNATURE, 4)) {
> +		efi_64 = false;
> +	} else {
> +		debug_putstr("Wrong EFI loader signature.\n");
> +		return 0;
> +	}
> +
> +	/* Get systab from boot params. Based on efi_init(). */
> +#ifdef CONFIG_X86_64
> +	systab = (efi_system_table_t *)(ei->efi_systab | ((__u64)ei->efi_systab_hi<<32));
> +#else
> +	if (ei->efi_systab_hi || ei->efi_memmap_hi) {
> +		debug_putstr("Error getting RSDP address: EFI system table located above 4GB.\n");
> +		return 0;
> +	}
> +	systab = (efi_system_table_t *)ei->efi_systab;
> +#endif
> +
> +	if (!systab)
> +		error("EFI system table is not found.");

s/is//

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
> +			u64 table64;
> +
> +			tmp_table = config_tables;
> +			guid = tmp_table->guid;
> +			table64 = tmp_table->table;
> +			table = table64;

That table64 looks superfluous.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
