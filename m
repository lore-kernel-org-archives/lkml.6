Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F0FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D52A223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D52A223C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732166AbeKNDvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:51:05 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51336 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731537AbeKNDvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:51:05 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QuGm4pXO3Lbq; Tue, 13 Nov 2018 18:51:55 +0100 (CET)
Received: from zn.tnic (p200300EC2BE56F00D5714500C00E26FD.dip0.t-ipconnect.de [IPv6:2003:ec:2be5:6f00:d571:4500:c00e:26fd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4F0671EC00EB;
        Tue, 13 Nov 2018 18:51:55 +0100 (CET)
Date:   Tue, 13 Nov 2018 18:51:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, bhe@redhat.com, msys.mizuma@gmail.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v11 3/5] x86/boot: Add get_acpi_rsdp() to parse RSDP in
 cmdlien from kexec
Message-ID: <20181113175150.GK10502@zn.tnic>
References: <20181112094645.4879-1-fanc.fnst@cn.fujitsu.com>
 <20181112094645.4879-4-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181112094645.4879-4-fanc.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 05:46:43PM +0800, Chao Fan wrote:
> Imitate setup_acpi_rsdp() for the early_param of 'acpi_rsdp'.
> KEXEC writes the RSDP pointer to cmdline for EFI booting.
> So if 'acpi_rsdp' found in cmdline, use it directely.
> 
> Since function kstrtoull() is needed, include it in
> arch/x86/boot/string.h. To solve the definition conflict
> problem, set BOOT_STRING tag to expose only kstrtoull() and
> functions used by it. Other functions in lib/kstrtox.c will
> be covered.
> 
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/boot/compressed/acpitb.c | 26 ++++++++++++++++++++++++++
>  arch/x86/boot/string.h            |  4 ++++
>  lib/kstrtox.c                     |  4 ++++
>  3 files changed, 34 insertions(+)
> 
> diff --git a/arch/x86/boot/compressed/acpitb.c b/arch/x86/boot/compressed/acpitb.c
> index 50fa65cf824d..5cfb4efa5a19 100644
> --- a/arch/x86/boot/compressed/acpitb.c
> +++ b/arch/x86/boot/compressed/acpitb.c
> @@ -8,6 +8,12 @@
>  #include <linux/numa.h>
>  #include <linux/acpi.h>
>  
> +#define STATIC
> +#include <linux/decompress/mm.h>
> +
> +#define BOOT_STRING
> +#include "../string.h"
> +
>  /* Search EFI table for RSDP table. */
>  static void efi_get_rsdp_addr(acpi_physical_address *rsdp_addr)
>  {
> @@ -200,3 +206,23 @@ static void bios_get_rsdp_addr(acpi_physical_address *rsdp_addr)
>  		*rsdp_addr = (acpi_physical_address)address;
>  	}
>  }
> +
> +static void get_acpi_rsdp(acpi_physical_address *rsdp_addr)
> +{
> +#ifdef CONFIG_KEXEC

Ok, why is that CONFIG_KEXEC dependency needed now too?

Ok, let's recap: so far, for your use case you need:

CONFIG_MEMORY_HOTREMOVE
CONFIG_RANDOMIZE_BASE
and now
CONFIG_KEXEC

So, you can clean up all that ifdeffery by defining a new config item
CONFIG_EARLY_PARSE_RSDP or so which depends on all those three items and
then you can do

vmlinux-objs-$(CONFIG_EARLY_PARSE_RSDP) += $(obj)/acpitb.o

and get rid of the most of the ifdeffery.

Yes?

> +	unsigned long long res;
> +	int len = 0;
> +	char *val;
> +
> +	val = malloc(19);
> +	len = cmdline_find_option("acpi_rsdp", val, 19);
> +

^ Superfluous newline.

> +	if (len == -1)
> +		return;

That check is not needed since you do > 0 below.

> +
> +	if (len > 0) {
> +		val[len] = 0;
> +		*rsdp_addr = (acpi_physical_address)kstrtoull(val, 16, &res);
> +	}
> +#endif
> +}
> diff --git a/arch/x86/boot/string.h b/arch/x86/boot/string.h
> index 3d78e27077f4..0ff3edb888e4 100644
> --- a/arch/x86/boot/string.h
> +++ b/arch/x86/boot/string.h
> @@ -30,3 +30,7 @@ extern unsigned long long simple_strtoull(const char *cp, char **endp,
>  					  unsigned int base);
>  
>  #endif /* BOOT_STRING_H */
> +
> +#ifdef BOOT_STRING
> +#include "../../../lib/kstrtox.c"
> +#endif
> diff --git a/lib/kstrtox.c b/lib/kstrtox.c
> index 1006bf70bf74..3804db9eed56 100644
> --- a/lib/kstrtox.c
> +++ b/lib/kstrtox.c
> @@ -126,6 +126,8 @@ int kstrtoull(const char *s, unsigned int base, unsigned long long *res)
>  }
>  EXPORT_SYMBOL(kstrtoull);

This needs a comment to explain what is that guard used for.

> +#ifndef BOOT_STRING
> +
>  /**
>   * kstrtoll - convert a string to a long long
>   * @s: The start of the string. The string must be null-terminated, and may also
> @@ -408,3 +410,5 @@ kstrto_from_user(kstrtou16_from_user,	kstrtou16,	u16);
>  kstrto_from_user(kstrtos16_from_user,	kstrtos16,	s16);
>  kstrto_from_user(kstrtou8_from_user,	kstrtou8,	u8);
>  kstrto_from_user(kstrtos8_from_user,	kstrtos8,	s8);
> +
> +#endif

#endif /* BOOT_STRING */

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
