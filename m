Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C19C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15B82087F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="BYxEYC9N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15B82087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbeLEO6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:58:24 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48290 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbeLEO6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:58:24 -0500
Received: from zn.tnic (p200300EC2BC09900E0912853F26C5B9C.dip0.t-ipconnect.de [IPv6:2003:ec:2bc0:9900:e091:2853:f26c:5b9c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 396CC1EC027B;
        Wed,  5 Dec 2018 15:58:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544021902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yKJK8SNzH08YnQbWv5nO2JLTb6E7gcqSfzMvBrFvI8M=;
        b=BYxEYC9NABNRdIepiYNFKkuBdeqDiogR4ZxSpj6zLs9v+Bd7Ng2zyK5sj9uJodMvUdJbsr
        gwYvTngCHmmYPHIaEXzQ0AxjQz7vzxgbzrcsVx5VXC5cYiMu9KXp12lDA57lWHzxqyEo6q
        BWSA6cRZr5KnQeN9EkQa9KGS02b7w78=
Date:   Wed, 5 Dec 2018 15:58:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, keescook@chromium.org,
        bhe@redhat.com, msys.mizuma@gmail.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v12 1/5] x86/boot: Add get_acpi_rsdp() to parse RSDP in
 cmdline from KEXEC
Message-ID: <20181205145814.GJ29510@zn.tnic>
References: <20181129081631.11139-1-fanc.fnst@cn.fujitsu.com>
 <20181129081631.11139-2-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181129081631.11139-2-fanc.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 04:16:27PM +0800, Chao Fan wrote:
> To fix the conflict between KASLR and memory-hotremove, memory
> information in SRAT table is necessary.
> 
> ACPI SRAT (System/Static Resource Affinity Table) can show the details
> about memory ranges, including ranges of memory provided by hot-added
> memory devices. SRAT table must be introduced by RSDP pointer (Root
> System Description Pointer). So RSDP should be found firstly.
> 
> When booting form KEXEC/EFI/BIOS, the methods to find RSDP pointer
> are different. When booting from KEXEC, 'acpi_rsdp' may have been
> added to cmdline, so parse the cmdline and find the RSDP pointer.
> 
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/boot/compressed/acpitb.c | 33 +++++++++++++++++++++++++++++++
>  arch/x86/boot/compressed/misc.c   |  5 +++++
>  arch/x86/boot/compressed/misc.h   |  4 ++++
>  lib/kstrtox.c                     |  5 +++++
>  4 files changed, 47 insertions(+)
>  create mode 100644 arch/x86/boot/compressed/acpitb.c
> 
> diff --git a/arch/x86/boot/compressed/acpitb.c b/arch/x86/boot/compressed/acpitb.c
> new file mode 100644
> index 000000000000..614c45655cff
> --- /dev/null
> +++ b/arch/x86/boot/compressed/acpitb.c

Also, I guess calling that file simply "acpi.c" is good enough.

> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define BOOT_CTYPE_H
> +#include "misc.h"
> +#include "error.h"
> +
> +#include <linux/efi.h>
> +#include <asm/efi.h>

asm/ headers come after linux/ header.

...

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
