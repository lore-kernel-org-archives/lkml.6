Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D192ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D85B2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D85B2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbeJRRgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:36:18 -0400
Received: from foss.arm.com ([217.140.101.70]:34960 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727363AbeJRRgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:36:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A2ACA78;
        Thu, 18 Oct 2018 02:36:09 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95BE43F5D3;
        Thu, 18 Oct 2018 02:36:07 -0700 (PDT)
Date:   Thu, 18 Oct 2018 10:36:01 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Teng Fei Fan <tengfei@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        linux-arm-msm@vger.kernel.org, will.deacon@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] arm: kernel: add support for detecting armv8 cpu cache
 information
Message-ID: <20181018093601.GA25667@e107155-lin>
References: <1539843407-7439-1-git-send-email-tengfei@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539843407-7439-1-git-send-email-tengfei@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 02:16:47PM +0800, Teng Fei Fan wrote:
> This patch adds support for cacheinfo on 32bit ARMv8 platform.
> Add support for detecting cpu cache information cpu cache information
> via sysfs for 32bit armv8 platform. And export to sysfs then userspace
> can get from /sys/devices/system/cpu/cpuX/cache.
>
> Signed-off-by: Teng Fei Fan <tengfei@codeaurora.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  arch/arm/include/asm/cachetype.h |  38 ++++++++++++
>  arch/arm/kernel/Makefile         |   3 +-
>  arch/arm/kernel/cacheinfo.c      | 128 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 168 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/kernel/cacheinfo.c
>
> diff --git a/arch/arm/include/asm/cachetype.h b/arch/arm/include/asm/cachetype.h
> index 01509ae..f639c64 100644
> --- a/arch/arm/include/asm/cachetype.h
> +++ b/arch/arm/include/asm/cachetype.h
> @@ -1,6 +1,31 @@
>  #ifndef __ASM_ARM_CACHETYPE_H
>  #define __ASM_ARM_CACHETYPE_H
>
> +/*
> + * NumSets, bits[27:13] - (Number of sets in cache) - 1
> + * Associativity, bits[12:3] - (Associativity of cache) - 1
> + * LineSize, bits[2:0] - (Log2(Number of words in cache line)) - 2
> + */
> +#define CCSIDR_EL1_WRITE_THROUGH	BIT(31)
> +#define CCSIDR_EL1_WRITE_BACK		BIT(30)
> +#define CCSIDR_EL1_READ_ALLOCATE	BIT(29)
> +#define CCSIDR_EL1_WRITE_ALLOCATE	BIT(28)
> +#define CCSIDR_EL1_LINESIZE_MASK	0x7
> +#define CCSIDR_EL1_LINESIZE(x)		((x) & CCSIDR_EL1_LINESIZE_MASK)
> +#define CCSIDR_EL1_ASSOCIATIVITY_SHIFT	3
> +#define CCSIDR_EL1_ASSOCIATIVITY_MASK	0x3ff
> +#define CCSIDR_EL1_ASSOCIATIVITY(x) \
> +	(((x) >> CCSIDR_EL1_ASSOCIATIVITY_SHIFT) \
> +	& CCSIDR_EL1_ASSOCIATIVITY_MASK)
> +#define CCSIDR_EL1_NUMSETS_SHIFT	13
> +#define CCSIDR_EL1_NUMSETS_MASK		0x7fff
> +#define CCSIDR_EL1_NUMSETS(x) \
> +	(((x) >> CCSIDR_EL1_NUMSETS_SHIFT) & CCSIDR_EL1_NUMSETS_MASK)
> +
> +#define CACHE_LINESIZE(x)	(16 << CCSIDR_EL1_LINESIZE(x))
> +#define CACHE_NUMSETS(x)	(CCSIDR_EL1_NUMSETS(x) + 1)
> +#define CACHE_ASSOCIATIVITY(x)	(CCSIDR_EL1_ASSOCIATIVITY(x) + 1)
> +

This was dropped from arm64 via the commit
a8d4636f96ad ("arm64: cacheinfo: Remove CCSIDR-based cache information probing")

So it makes no sense to add CCSIDR based cacheinfo back. If we add this
support, it should be entirely based on DT.

--
Regards,
Sudeep
