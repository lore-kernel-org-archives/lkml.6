Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151A4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0592086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB0592086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbeJKAAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:00:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50876 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbeJKAAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:00:34 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IvppudFY23jU; Wed, 10 Oct 2018 18:37:37 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCA7500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:7500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 06EB81EC0104;
        Wed, 10 Oct 2018 18:37:36 +0200 (CEST)
Date:   Wed, 10 Oct 2018 18:37:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     peterz@infradead.org, x86@kernel.org, eranian@google.com,
        kan.liang@intel.com, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 1/2] x86/cpufeature: Add facility to match microcode
 revisions
Message-ID: <20181010163730.GA6125@zn.tnic>
References: <20181010162608.23899-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181010162608.23899-1-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lemme paste some of tglx's review comments from last time.

On Wed, Oct 10, 2018 at 09:26:07AM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> For bug workarounds or checks it is useful to check for specific
> microcode versions. Add a new table format to check for steppings

s/versions/revisions/

> with min microcode revisions.
> 
> This does not change the existing x86_cpu_id because it's an ABI
> shared with modutils, and also has quite difference requirements,

s/difference/different/

> as in no wildcards, but everything has to be matched exactly.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
> v2:
> Remove all CPU match, only check boot cpu
> Move INTEL_MIN_UCODE macro to header.
> Minor cleanups.
> Remove max ucode and driver data
> ---
>  arch/x86/include/asm/cpu_device_id.h | 26 ++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/match.c          | 21 +++++++++++++++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
> index baeba0567126..1b90bd1d0b95 100644
> --- a/arch/x86/include/asm/cpu_device_id.h
> +++ b/arch/x86/include/asm/cpu_device_id.h
> @@ -11,4 +11,30 @@
>  
>  extern const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match);
>  
> +/*
> + * Match specific microcodes

"What means microcodes or steppings? If you mean microcode revisions then
please spell it out and use it all over the place. steppings is confusing
at best as its associated to the CPU stepping."

> + *
> + * vendor/family/model/stepping must be all set.
> + * min_ucode is optional and can be 0.
> + */
> +
> +struct x86_ucode_id {
> +	u8 vendor;
> +	u8 family;
> +	u16 model;
> +	u16 stepping;

"Why u16? The corresponding members in cpuinfo_x86 are 8bit wide so why
wasting memory for these tables?"

> +	u32 min_ucode;
> +};
> +
> +#define INTEL_MIN_UCODE(mod, step, rev) {			\
> +	.vendor = X86_VENDOR_INTEL,				\
> +	.family = 6,						\
> +	.model = mod,						\
> +	.stepping = step,					\
> +	.min_ucode = rev,					\
> +}
> +
> +extern const struct x86_ucode_id *
> +x86_match_ucode(const struct x86_ucode_id *match);
> +
>  #endif
> diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
> index 3fed38812eea..ec8ee31699cd 100644
> --- a/arch/x86/kernel/cpu/match.c
> +++ b/arch/x86/kernel/cpu/match.c
> @@ -48,3 +48,24 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
>  	return NULL;
>  }
>  EXPORT_SYMBOL(x86_match_cpu);
> +
> +const struct x86_ucode_id *x86_match_ucode(const struct x86_ucode_id *match)

s/ucode/microcode/

> +{
> +	struct cpuinfo_x86 *c = &boot_cpu_data;
> +	const struct x86_ucode_id *m;
> +
> +	for (m = match; m->vendor | m->family | m->model; m++) {
> +		if (c->x86_vendor != m->vendor)
> +			continue;
> +		if (c->x86 != m->family)
> +			continue;
> +		if (c->x86_model != m->model)
> +			continue;
> +		if (c->x86_stepping != m->stepping)
> +			continue;
> +		if (c->microcode < m->min_ucode)
> +			continue;
> +		return m;
> +	}
> +	return NULL;
> +}
> -- 
> 2.17.1
> 

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
