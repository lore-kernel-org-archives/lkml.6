Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8CCC282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE94218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbfAYSIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:08:20 -0500
Received: from foss.arm.com ([217.140.101.70]:52006 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729531AbfAYSIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:08:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 951841596;
        Fri, 25 Jan 2019 10:08:17 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85BE93F5AF;
        Fri, 25 Jan 2019 10:08:16 -0800 (PST)
Date:   Fri, 25 Jan 2019 18:08:14 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
Cc:     'Mark Rutland' <mark.rutland@arm.com>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        "'will.deacon@arm.com'" <will.deacon@arm.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Message-ID: <20190125180813.GM25901@arrakis.emea.arm.com>
References: <8898674D84E3B24BA3A2D289B872026A6A2A32D6@G01JPEXMBKW03>
 <8898674D84E3B24BA3A2D289B872026A6A2A32EB@G01JPEXMBKW03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8898674D84E3B24BA3A2D289B872026A6A2A32EB@G01JPEXMBKW03>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 08:54:33AM +0000, Zhang, Lei wrote:
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index efb7b2c..37e4f18 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -666,6 +666,28 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>  	return 0;
>  }
>  
> +static int do_bad_unknown_63(unsigned long addr, unsigned int esr, struct pt_regs *regs)
> +{
> +	/*
> +	 * On some variants of the Fujitsu-A64FX cores ver(1.0, 1.1),
> +	 * memory accesses may spuriously trigger data aborts with
> +	 * DFSC=0b111111.
> +	 */
> +	if (IS_ENABLED(CONFIG_FUJITSU_ERRATUM_010001)) {
> +		if (cpus_have_cap(ARM64_WORKAROUND_FUJITSU_A64FX_0100001)) {
> +			return 0;
> +		} else { /* cpu capabilities maybe not ready*/
> +			unsigned int current_cpu_midr = read_cpuid_id();
> +			const struct midr_range fujitsu_a64fx_midr_range = {
> +				MIDR_FUJITSU_A64FX, MIDR_CPU_VAR_REV(0, 0), MIDR_CPU_VAR_REV(1, 0)
> +			};
> +			if (is_midr_in_range(current_cpu_midr, &fujitsu_a64fx_midr_range) == TRUE)
> +				return 0;
> +		}
> +	}
> +	return do_bad(addr, esr, regs);
> +}

IIUC, this can happen very early when the errata framework isn't yet
ready. Given that this is not on a fast path (you already took a fault),
I don't think it's worth optimising for cpus_have_cap() (and
ARM64_WORKAROUND_FUJITSU_A64FX_0100001). I've seen Mark's comments on
why checking MIDR in a preemptible context is not a good idea but I
suspect your platform is homogeneous (i.e. not big.LITTLE).

-- 
Catalin
