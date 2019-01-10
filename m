Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66924C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3543D20685
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="eC1oJJPM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbfAJRBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:01:14 -0500
Received: from mail.skyhub.de ([5.9.137.197]:58856 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbfAJRBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:01:13 -0500
Received: from zn.tnic (p200300EC2BC5CF00F8565421A8111C7E.dip0.t-ipconnect.de [IPv6:2003:ec:2bc5:cf00:f856:5421:a811:1c7e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EE3A41EC035B;
        Thu, 10 Jan 2019 18:01:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547139671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uTSCpUvBGNcb7la2cAU6MajSH8aykN1VCQ1VTxp1XVE=;
        b=eC1oJJPMLuPZWyjYhBywAXwcCJU8TeoQuA8UK98PP/G4cdYZO1ysag4vhiO5OKi0ZXYPGx
        HHfRsKdvst2jiC/VkydxX86lHni2h9H7K+tqg5JWnF83zJd44PUQef9W6NI+kB1uPI+PaL
        45UN79Ia6Nd1y53aw4XTHf3nI9gQBRo=
Date:   Thu, 10 Jan 2019 18:01:03 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, keescook@chromium.org,
        bhe@redhat.com, msys.mizuma@gmail.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v15 2/6] x86/boot: Introduce get_acpi_rsdp() to parse
 RSDP in cmdline from KEXEC
Message-ID: <20190110170103.GF17621@zn.tnic>
References: <20190107032243.25324-1-fanc.fnst@cn.fujitsu.com>
 <20190107032243.25324-3-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190107032243.25324-3-fanc.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 11:22:39AM +0800, Chao Fan wrote:
> KASLR may randomly choose some positions which are located in movable
> memory regions. This will make the movable memory chosen by KASLR
> can't be removed.
> 
> Memory information in SRAT is necessary to fix the conflict between
> KASLR and memory-hotremove.
> 
> ACPI SRAT (System/Static Resource Affinity Table) shows the details
> about memory ranges, including ranges of memory provided by hot-added
> memory devices. SRAT is introduced by Root System Description
> Pointer(RSDP). So RSDP should be found firstly.
> 
> When booting form KEXEC/EFI/BIOS, the methods to find RSDP
> are different. When booting from KEXEC, 'acpi_rsdp=' may have been
> added to cmdline, so parse cmdline to find RSDP.
> 
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/boot/compressed/acpi.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 arch/x86/boot/compressed/acpi.c
> 
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> new file mode 100644
> index 000000000000..7ca5001d7639
> --- /dev/null
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define BOOT_CTYPE_H
> +#include "misc.h"
> +#include "error.h"
> +#include "../string.h"
> +
> +#include <linux/acpi.h>

Ok, I corrected it to this, please replace in your version:

/*
 * Max length of 64-bit hex address string is 19, prefix "0x" + 16 hex
 * digits, and '\0' for termination.
 */
#define MAX_ADDR_LEN 19

static acpi_physical_address get_acpi_rsdp(void)
{
	acpi_physical_address addr = 0;

#ifdef CONFIG_KEXEC
	char val[MAX_ADDR_LEN] = { };
	int ret;

	ret = cmdline_find_option("acpi_rsdp", val, MAX_ADDR_LEN);
	if (ret < 0)
		return 0;

	if (kstrtoull(val, 16, &addr))
		return 0;
#endif
	return addr;
}


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
