Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D37ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B17214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B17214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbeIQS5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:57:40 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59048 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728273AbeIQS5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:57:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 063937A9;
        Mon, 17 Sep 2018 06:30:20 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CB0F93F557;
        Mon, 17 Sep 2018 06:30:19 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 62C191AE3063; Mon, 17 Sep 2018 14:30:38 +0100 (BST)
Date:   Mon, 17 Sep 2018 14:30:38 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Mian Yousaf Kaukab <ykaukab@suse.de>
Cc:     marc.zyngier@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robert.richter@cavium.com,
        cwu@amperecomputing.com
Subject: Re: [PATCH RESEND 2/6] arm64: add sysfs vulnerability show for
 meltdown
Message-ID: <20180917133037.GB23040@arm.com>
References: <20180827143310.641-1-ykaukab@suse.de>
 <20180827143310.641-3-ykaukab@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827143310.641-3-ykaukab@suse.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 04:33:06PM +0200, Mian Yousaf Kaukab wrote:
> Checking CSV3 support directly in case CONFIG_UNMAP_KERNEL_AT_EL0
> is not enabled.
> 
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> ---
>  arch/arm64/kernel/cpu_errata.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index dec10898d688..996edb4e18ad 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -22,6 +22,7 @@
>  #include <asm/cpu.h>
>  #include <asm/cputype.h>
>  #include <asm/cpufeature.h>
> +#include <asm/mmu.h>
>  
>  static bool __maybe_unused
>  is_affected_midr_range(const struct arm64_cpu_capabilities *entry, int scope)
> @@ -683,3 +684,26 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>  	{
>  	}
>  };
> +
> +#ifdef CONFIG_GENERIC_CPU_VULNERABILITIES
> +
> +ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	u64 pfr0;
> +	u32 csv3;
> +
> +	if (arm64_kernel_unmapped_at_el0())
> +		return sprintf(buf, "Mitigation: KPTI\n");
> +
> +	pfr0 = read_cpuid(ID_AA64PFR0_EL1);
> +	csv3 = cpuid_feature_extract_unsigned_field(pfr0,
> +			ID_AA64PFR0_CSV3_SHIFT);
> +
> +	if (csv3 || is_cpu_meltdown_safe())
> +		return sprintf(buf, "Not affected\n");
> +
> +	return sprintf(buf, "Vulnerable\n");

This should say something like "Unknown", since we don't actually have a
reliable way to determine that a CPU is vulnerable. That's also a large
part of the reason why we haven't bothered implementing the sysfs interface
so far.

Will
