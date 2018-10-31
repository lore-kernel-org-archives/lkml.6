Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04AFECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F292080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hdQ/nyXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F292080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbeKADkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:40:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36898 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729785AbeKADkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:40:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id g9-v6so17620406wrq.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 11:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WtYS++Eq2aKwebxiYSlbkwQV34nMjfy4iBCJpS0awSw=;
        b=hdQ/nyXbfRzLkuTjrCs+yt4AzN38RVEgQhSi/O8VUC5RcMchuISzBsyZJL1VYH2Frd
         EEOj3uIby+3hOsmcYzl+uFlpUahxCiq5zKOrtPNCdr3QyOddDFKIJ4zqQT+lvmodn2nu
         ORdFQfg5/C1Cx0QHT5BZWjF6cV+MJh4h6LW6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WtYS++Eq2aKwebxiYSlbkwQV34nMjfy4iBCJpS0awSw=;
        b=K+4ajdq0gcy61XVxS2BGa/gcHmL3EVI3PqNjq3UFIG+Qcunjc+1bNadXHS9jbuE+T4
         Wvzet6a/gXvY5YdcqsJ7D2JTGFiOJLTdd0XcD0A4nLznckLx8F6iraxtyAkadTLtD7c/
         gMKFaYnjiZkfcklaBEjfKFMvilzq7SPbPCEuzrxplgIX1IoIwKr2/kvA8LlLLv0otDku
         aYidA+/uupTum48vlseskMuTs2ybheomy07nVg1xD+m0NZY9wAtJKbJhqiyGbPgwWIA5
         fBhfH20g1wAauQBwGI/YGXADTGIZsmciIN64mfkECWSk8O4Wv1m3sKnzYnMcEtM0mFUc
         NY9A==
X-Gm-Message-State: AGRZ1gLcvrBr41HCG4sKeVYSjou5iZb/5qSiNeFxM6OeJncFGJgwvR1B
        WxC/fnF9aIGPqlA4YgjazvoTlQ==
X-Google-Smtp-Source: AJdET5cW1DPUxxa9WGN3IWebi0IepbzWy8AHnIeVuGeUiXFAb/j4Sh57UviFzEx5cdIbZsHCTGri7g==
X-Received: by 2002:adf:8909:: with SMTP id s9-v6mr3821947wrs.309.1541011254757;
        Wed, 31 Oct 2018 11:40:54 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id 191-v6sm18863435wmk.30.2018.10.31.11.40.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 11:40:53 -0700 (PDT)
Date:   Wed, 31 Oct 2018 18:40:50 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Hogan <jhogan@kernel.org>, linux-hexagon@vger.kernel.org,
        Vineet Gupta <vgupta@synopsys.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Rich Felker <dalias@libc.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-snps-arc@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Will Deacon <will.deacon@arm.com>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] kgdb: Fix kgdb_roundup_cpus() for arches who used
 smp_call_function()
Message-ID: <20181031184050.sd5opni3mznaapkv@holly.lan>
References: <20181030221843.121254-1-dianders@chromium.org>
 <20181030221843.121254-3-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030221843.121254-3-dianders@chromium.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 03:18:43PM -0700, Douglas Anderson wrote:
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index f3cadda45f07..9a3f952de6ed 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -55,6 +55,7 @@
>  #include <linux/mm.h>
>  #include <linux/vmacache.h>
>  #include <linux/rcupdate.h>
> +#include <linux/irq.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/byteorder.h>
> @@ -220,6 +221,39 @@ int __weak kgdb_skipexception(int exception, struct pt_regs *regs)
>  	return 0;
>  }
>  
> +/*
> + * Default (weak) implementation for kgdb_roundup_cpus
> + */
> +
> +static DEFINE_PER_CPU(call_single_data_t, kgdb_roundup_csd);
> +
> +void __weak kgdb_call_nmi_hook(void *ignored)
> +{
> +	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
> +}
> +
> +void __weak kgdb_roundup_cpus(void)
> +{
> +	call_single_data_t *csd;
> +	int cpu;
> +
> +	for_each_cpu(cpu, cpu_online_mask) {
> +		csd = &per_cpu(kgdb_roundup_csd, cpu);
> +		smp_call_function_single_async(cpu, csd);
> +	}

smp_call_function() automatically skips the calling CPU but this code does
not. It isn't a hard bug since kgdb_nmicallback() does a re-entrancy
check but I'd still prefer to skip the calling CPU.

As mentioned in another part of the thread we can also add robustness
by skipping a cpu where csd->flags != 0 (and adding an appropriately
large comment regarding why). Doing the check directly is abusing
internal knowledge that smp.c normally keeps to itself so an accessor
of some kind would be needed.


> +}
> +
> +static void kgdb_generic_roundup_init(void)
> +{
> +	call_single_data_t *csd;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		csd = &per_cpu(kgdb_roundup_csd, cpu);
> +		csd->func = kgdb_call_nmi_hook;
> +	}
> +}

I can't help noticing this code is very similar to kgdb_roundup_cpus. Do
we really gain much from ahead-of-time initializing csd->func?


Daniel.
