Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CB2C65C31
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 14:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96B62084D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 14:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96B62084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbeJFVSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 17:18:55 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39394 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbeJFVSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 17:18:55 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g8nM7-0002Ao-3R; Sat, 06 Oct 2018 16:14:55 +0200
Date:   Sat, 6 Oct 2018 16:14:54 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andi Kleen <andi@firstfloor.org>
cc:     peterz@infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, kan.liang@intel.com, isaku.yamahata@intel.com,
        kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v1 1/2] x86/cpufeature: Add facility to match microcode
 revisions
In-Reply-To: <20181006001928.28097-1-andi@firstfloor.org>
Message-ID: <alpine.DEB.2.21.1810061555270.5454@nanos.tec.linutronix.de>
References: <20181006001928.28097-1-andi@firstfloor.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Oct 2018, Andi Kleen wrote:
> +/*
> + * Match specific microcodes or steppings.

What means microcodes or steppings? If you mean microcode revisions then
please spell it out and use it all over the place. steppings is confusing
at best as its associated to the CPU stepping.

> + *
> + * vendor/family/model/stepping must be all set.
> + * min_ucode/max_ucode/driver_data are optional and can be 0.
> + */
> +
> +struct x86_ucode_id {
> +	__u16 vendor;

__uXX are usually UAPI types. Please use the regular kernel uXX
types instead.

> +	__u16 family;
> +	__u16 model;
> +	__u16 stepping;

Why u16? The corresponding members in cpuinfo_x86 are 8bit wide so why
wasting memory for these tables?

> +	__u32 min_ucode;
> +	__u32 max_ucode;
> +	kernel_ulong_t driver_data;
> +};
> +
> +extern const struct x86_ucode_id *
> +x86_match_ucode_cpu(int cpu, const struct x86_ucode_id *match);
> +extern const struct x86_ucode_id *
> +x86_match_ucode_all(const struct x86_ucode_id *match);
> +
>  #endif
> diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
> index 3fed38812eea..f29a21b2809c 100644
> --- a/arch/x86/kernel/cpu/match.c
> +++ b/arch/x86/kernel/cpu/match.c
> @@ -48,3 +48,46 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
>  	return NULL;
>  }
>  EXPORT_SYMBOL(x86_match_cpu);
> +
> +const struct x86_ucode_id *x86_match_ucode_cpu(int cpu,
> +					       const struct x86_ucode_id *match)
> +{
> +	const struct x86_ucode_id *m;
> +	struct cpuinfo_x86 *c = &cpu_data(cpu);

Please use reverse fir tree ordering for variable declarations

	struct cpuinfo_x86 *c = &cpu_data(cpu);
	const struct x86_ucode_id *m;

It's simpler to parse.

> +	for (m = match; m->vendor | m->family | m->model; m++) {
> +		if (c->x86_vendor != m->vendor)
> +			continue;
> +		if (c->x86 != m->family)
> +			continue;
> +		if (c->x86_model != m->model)
> +			continue;
> +		if (c->x86_stepping != m->stepping)
> +			continue;
> +		if (m->min_ucode && c->microcode < m->min_ucode)
> +			continue;
> +		if (m->max_ucode && c->microcode > m->max_ucode)
> +			continue;
> +		return m;
> +	}
> +	return NULL;
> +}
> +
> +/* Check all CPUs */
> +const struct x86_ucode_id *x86_match_ucode_all(const struct x86_ucode_id *match)

Can you please name that so it's obvious that this checks all cpus, but
aside of that, why would a system ever end up with different microcode
revisions at all? The changelog is not mentioning any reason for this
function and "/* Check all CPUs */" is not helpful either.

> +	int cpu;
> +	const struct x86_ucode_id *all_m = NULL;
> +	bool first = true;
> +
> +	for_each_online_cpu(cpu) {

What guarantees that CPUs cannot be plugged? You either need to have
cpus_read_lock() in this function or a lockdep_assert_cpus_held().

> +		const struct x86_ucode_id *m = x86_match_ucode_cpu(cpu, match);
> +
> +		if (first)
> +			all_m = m;
> +		else if (m != all_m)
> +			return NULL;
> +		first = false;
> +	}
> +	return all_m;

Thanks,

	tglx
