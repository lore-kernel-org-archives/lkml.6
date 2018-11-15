Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC0DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB83221582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB83221582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388489AbeKPDaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:30:46 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35524 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbeKPDaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 22:30:46 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JWx1X2FJZJU9; Thu, 15 Nov 2018 18:22:03 +0100 (CET)
Received: from zn.tnic (p200300EC2BD00900D5714500C00E26FD.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:900:d571:4500:c00e:26fd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A24EF1EC0322;
        Thu, 15 Nov 2018 18:22:03 +0100 (CET)
Date:   Thu, 15 Nov 2018 18:21:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpu: Avoid endless loop to get the number of cache
 leaves
Message-ID: <20181115172155.GB25056@zn.tnic>
References: <1541422425-5855-1-git-send-email-puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1541422425-5855-1-git-send-email-puwen@hygon.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 08:53:45PM +0800, Pu Wen wrote:
> To get the number of cache leaves on AMD or Hygon platform, it should
> get the value of cpuid leaf 0x8000001d. But on certain broken platform
> such as a not fullly implemented virtual platform(Xen, for example),
> the value of the cpuid leaf will nerver be CTYPE_NULL, so the kernel
> will run into an endless loop.
> 
> To fix this problem, add a new enum type CTYPE_MAX to limit the maximum
> cpuid accessing.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  arch/x86/kernel/cpu/cacheinfo.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
> index dc1b934..7bd167f 100644
> --- a/arch/x86/kernel/cpu/cacheinfo.c
> +++ b/arch/x86/kernel/cpu/cacheinfo.c
> @@ -121,7 +121,8 @@ enum _cache_type {
>  	CTYPE_NULL = 0,
>  	CTYPE_DATA = 1,
>  	CTYPE_INST = 2,
> -	CTYPE_UNIFIED = 3
> +	CTYPE_UNIFIED = 3,
> +	CTYPE_MAX = 4
>  };
>  
>  union _cpuid4_leaf_eax {
> @@ -640,7 +641,7 @@ static int find_num_cache_leaves(struct cpuinfo_x86 *c)
>  		/* Do cpuid(op) loop to find out num_cache_leaves */
>  		cpuid_count(op, i, &eax, &ebx, &ecx, &edx);
>  		cache_eax.full = eax;
> -	} while (cache_eax.split.type != CTYPE_NULL);
> +	} while (cache_eax.split.type != CTYPE_NULL && i != CTYPE_MAX);

i is an int and CTYPE_MAX is enum _cache_type. Huh?

This works by chance because CTYPE_MAX is 4 and the termination CPUID
leaf is the 4th too.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
