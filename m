Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D554EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7D620657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="kCAugDlV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391942AbfAPMUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:20:34 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59354 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389150AbfAPMUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:20:33 -0500
Received: from zn.tnic (p200300EC2BC98A0074F02E32486DBF81.dip0.t-ipconnect.de [IPv6:2003:ec:2bc9:8a00:74f0:2e32:486d:bf81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 37C9C1EC0ABA;
        Wed, 16 Jan 2019 13:20:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547641232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cRNn1EsAJFtFq0jPgg6N6KWD9+QTcEv6hbSx8sVhXkc=;
        b=kCAugDlVs4imY6BEWURybBltHcofX7bNEx/Ud6/mnCAN+Gkrjmk1PrZctXskG1X5pVeGWw
        1FsPtojO31aH8Uml1J14wR74y8YfZ94oH8XTCobxkVs87dsP//ldilr7Nrm/7XfzBXV5b8
        /fiYROCrMYYnLi8qhpdC4qPq/BEiSCM=
Date:   Wed, 16 Jan 2019 13:20:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     kan.liang@linux.intel.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, mingo@redhat.com, ak@linux.intel.com,
        eranian@google.com
Subject: Re: [PATCH V5 1/4] x86/cpufeature: Add facility to check for min
 microcode revisions
Message-ID: <20190116122026.GF15409@zn.tnic>
References: <1546900465-5121-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1546900465-5121-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 02:34:22PM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> For bug workarounds or checks it is useful to check for specific
> microcode revisions.
> 
> Add a new generic function to match the CPU with stepping.
> Add the other function to check the min microcode revisions for
> the matched CPU.
> A new table format is introduced to facilitate the quirk to
> fill the related information.
> 
> This does not change the existing x86_cpu_id because it's an ABI
> shared with modules, and also has quite different requirements,
> as in no wildcards, but everything has to be matched exactly.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Based-on-code-from: Andi Kleen <ak@linux.intel.com>

The proper tag is: Originally-by

> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
> 
> Changes since V4:
> - Rename to x86_cpu_check and INTEL_CHECK_UCODE
> - Split x86_min_microcode() into two functions. One is a generic
>   CPU match function with stepping. The other is to check the min
>   microcode revisions.
> 
> The previous discussion can be found here.
> https://lkml.org/lkml/2018/10/10/740
> 
>  arch/x86/include/asm/cpu_device_id.h | 28 ++++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/match.c          | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
> index baeba05..43f19af 100644
> --- a/arch/x86/include/asm/cpu_device_id.h
> +++ b/arch/x86/include/asm/cpu_device_id.h
> @@ -11,4 +11,32 @@
>  
>  extern const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match);
>  
> +/*
> + * Match specific microcode revisions.
> + *
> + * vendor/family/model/stepping must be all set.
> + *
> + * only checks against the boot cpu.  When mixed-stepping configs are

s/cpu/CPU/g

> + * valid for a CPU model, add a quirk for every valid stepping and
> + * do the fine-tuning in the quirk handler.
> + */
> +
> +struct x86_cpu_check {

That's not a "check". If anything, it is a descriptor of sorts. I.e.,
x86_cpu_desc or so.

> +	u8	vendor;
> +	u8	family;
> +	u8	model;
> +	u8	stepping;
> +	u32	microcode_rev;

Name those the same way as the corresponding members in struct
cpuinfo_x86 are named, so that there's no confusion about what is what.

> +};
> +
> +#define INTEL_CHECK_UCODE(mod, step, rev) {			\

INTEL_CPU_DESC

or so.

> +	.vendor = X86_VENDOR_INTEL,				\
> +	.family = 6,						\
> +	.model = mod,						\
> +	.stepping = step,					\
> +	.microcode_rev = rev,					\
> +}
> +
> +extern bool x86_cpu_has_min_microcode_rev(const struct x86_cpu_check *table);
> +
>  #endif
> diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
> index 3fed388..408bed37 100644
> --- a/arch/x86/kernel/cpu/match.c
> +++ b/arch/x86/kernel/cpu/match.c
> @@ -48,3 +48,34 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
>  	return NULL;
>  }
>  EXPORT_SYMBOL(x86_match_cpu);
> +
> +static const struct x86_cpu_check *
> +x86_match_cpu_with_stepping(const struct x86_cpu_check *match)
> +{
> +	struct cpuinfo_x86 *c = &boot_cpu_data;
> +	const struct x86_cpu_check *m;
> +
> +	for (m = match; m->family | m->model; m++) {
> +		if (c->x86_vendor != m->vendor)
> +			continue;
> +		if (c->x86 != m->family)
> +			continue;
> +		if (c->x86_model != m->model)
> +			continue;
> +		if (c->x86_stepping != m->stepping)
> +			continue;
> +		return m;
> +	}
> +	return NULL;
> +}
> +
> +bool x86_cpu_has_min_microcode_rev(const struct x86_cpu_check *table)
> +{
> +	const struct x86_cpu_check *res = x86_match_cpu_with_stepping(table);
> +
> +	if (!res || res->microcode_rev > boot_cpu_data.microcode)
> +		return false;
> +
> +	return true;
> +}
> +EXPORT_SYMBOL(x86_cpu_has_min_microcode_rev);

EXPORT_SYMBOL_GPL.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
