Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12584C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59B920849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59B920849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeLKOSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:18:20 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48256 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbeLKOSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:18:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E47E21596;
        Tue, 11 Dec 2018 06:18:19 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B57043F59C;
        Tue, 11 Dec 2018 06:18:19 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id BE1781AE0B6B; Tue, 11 Dec 2018 14:18:42 +0000 (GMT)
Date:   Tue, 11 Dec 2018 14:18:42 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: fix ARM64_USER_VA_BITS_52 builds
Message-ID: <20181211141842.GA11618@edgewater-inn.cambridge.arm.com>
References: <20181211140832.567893-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211140832.567893-1-arnd@arndb.de>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 03:08:10PM +0100, Arnd Bergmann wrote:
> In some randconfig builds, the new CONFIG_ARM64_USER_VA_BITS_52
> triggered a build failure:
> 
> arch/arm64/mm/proc.S:287: Error: immediate out of range
> 
> As it turns out, we were incorrectly setting PGTABLE_LEVELS here,
> lacking any other default value.
> This fixes the calculation of CONFIG_PGTABLE_LEVELS to consider
> all combinations again.
> 
> Fixes: 68d23da4373a ("arm64: Kconfig: Re-jig CONFIG options for 52-bit VA")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index df201d93697d..a0f3b921b6e6 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -278,7 +278,7 @@ config PGTABLE_LEVELS
>  	int
>  	default 2 if ARM64_16K_PAGES && ARM64_VA_BITS_36
>  	default 2 if ARM64_64K_PAGES && ARM64_VA_BITS_42
> -	default 3 if ARM64_64K_PAGES && ARM64_VA_BITS_48
> +	default 3 if ARM64_64K_PAGES && (ARM64_VA_BITS_48 || ARM64_USER_VA_BITS_52)
>  	default 3 if ARM64_4K_PAGES && ARM64_VA_BITS_39
>  	default 3 if ARM64_16K_PAGES && ARM64_VA_BITS_47
>  	default 4 if !ARM64_64K_PAGES && ARM64_VA_BITS_48

Thanks, Arnd. I'll pick this one up too.

Will
