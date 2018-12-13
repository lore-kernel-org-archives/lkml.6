Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260ADC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D0C20645
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="QdUxhUmY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D0C20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbeLMMvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:51:09 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43378 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729092AbeLMMvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:51:08 -0500
Received: from zn.tnic (p200300EC2BCC68008920808B02BC4AF6.dip0.t-ipconnect.de [IPv6:2003:ec:2bcc:6800:8920:808b:2bc:4af6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9C19B1EC0B45;
        Thu, 13 Dec 2018 13:51:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544705466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gKO6VU1dxD75d9efMbu/3VB1jtNTeNij38oKwPdVfDQ=;
        b=QdUxhUmYR6awguXheRFGZ27Lvt5Mw650Y2d5020aYCgIXxoI1NNzoiCRw0DVS/YfhleZiT
        1tnKNxWnPphitvaNUKeQwbe0u33Ola+pNlXMxzCMlwfgDaJQWrOxHyzw0KPYoX45F2kGOF
        lxzMGmcr6k52ncKJkp2cdmgQRnZvUi0=
Date:   Thu, 13 Dec 2018 13:50:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, keescook@chromium.org,
        bhe@redhat.com, msys.mizuma@gmail.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v13 1/6] x86/boot: Introduce kstrtoull() to boot
 directory instead of simple_strtoull()
Message-ID: <20181213125059.GC25287@zn.tnic>
References: <20181212031053.1815-1-fanc.fnst@cn.fujitsu.com>
 <20181212031053.1815-2-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181212031053.1815-2-fanc.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 11:10:48AM +0800, Chao Fan wrote:
> Introduce kstrtoull() from lib/kstrtox.c to boot directory so that code
> in boot/ can use kstrtoull() and the old simple_strtoull() can be
> replaced.
> 
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/boot/string.c | 137 +++++++++++++++++++++++++++++++++++++++++
>  arch/x86/boot/string.h |   2 +
>  2 files changed, 139 insertions(+)
> 
> diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
> index c4428a176973..e02405f20f98 100644
> --- a/arch/x86/boot/string.c
> +++ b/arch/x86/boot/string.c
> @@ -12,7 +12,10 @@
>   * Very basic string functions
>   */
>  
> +#define _LINUX_CTYPE_H
>  #include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
>  #include <asm/asm.h>
>  #include "ctype.h"
>  #include "string.h"
> @@ -187,3 +190,137 @@ char *strchr(const char *s, int c)
>  			return NULL;
>  	return (char *)s;
>  }
> +
> +static inline u64 div_u64_rem(u64 dividend, u32 divisor, u32 *remainder)
> +{
> +	union {
> +		u64 v64;
> +		u32 v32[2];
> +	} d = { dividend };
> +	u32 upper;
> +
> +	upper = d.v32[1];
> +	d.v32[1] = 0;
> +	if (upper >= divisor) {
> +		d.v32[1] = upper / divisor;
> +		upper %= divisor;
> +	}
> +	asm ("divl %2" : "=a" (d.v32[0]), "=d" (*remainder) :
> +		"rm" (divisor), "0" (d.v32[0]), "1" (upper));
> +	return d.v64;
> +}

Why aren't you using the simple one from include/linux/math64.h ?

Rest looks ok.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
