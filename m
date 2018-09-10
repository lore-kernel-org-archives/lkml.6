Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1329C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C01220645
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C01220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbeIJVpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:45:14 -0400
Received: from foss.arm.com ([217.140.101.70]:60756 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbeIJVpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:45:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FCD618A;
        Mon, 10 Sep 2018 09:50:16 -0700 (PDT)
Received: from armageddon.cambridge.arm.com (armageddon.emea.arm.com [10.4.13.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 843BB3F557;
        Mon, 10 Sep 2018 09:50:14 -0700 (PDT)
Date:   Mon, 10 Sep 2018 17:50:11 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux@armlinux.org.uk,
        steve.capper@linaro.org, will.deacon@arm.com,
        linux-kernel@vger.kernel.org,
        android-treble-mediatek-ext@partner.android.com,
        kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
        Simon Horman <horms@verge.net.au>
Subject: Re: [RFC 1/3] arm: mm: reordering memory type table
Message-ID: <20180910165011.zcighyuabshsmxjb@armageddon.cambridge.arm.com>
References: <20180906102212.218294-1-minchan@kernel.org>
 <20180906102212.218294-2-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906102212.218294-2-minchan@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 07:22:10PM +0900, Minchan Kim wrote:
> diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
> index 92fd2c8a9af0..91b99fadcba1 100644
> --- a/arch/arm/include/asm/pgtable-2level.h
> +++ b/arch/arm/include/asm/pgtable-2level.h
> @@ -164,14 +164,23 @@
>  #define L_PTE_MT_BUFFERABLE	(_AT(pteval_t, 0x01) << 2)	/* 0001 */
>  #define L_PTE_MT_WRITETHROUGH	(_AT(pteval_t, 0x02) << 2)	/* 0010 */
>  #define L_PTE_MT_WRITEBACK	(_AT(pteval_t, 0x03) << 2)	/* 0011 */
> +#define L_PTE_MT_DEV_SHARED	(_AT(pteval_t, 0x04) << 2)	/* 0100 */
>  #define L_PTE_MT_MINICACHE	(_AT(pteval_t, 0x06) << 2)	/* 0110 (sa1100, xscale) */
>  #define L_PTE_MT_WRITEALLOC	(_AT(pteval_t, 0x07) << 2)	/* 0111 */
> -#define L_PTE_MT_DEV_SHARED	(_AT(pteval_t, 0x04) << 2)	/* 0100 */
> -#define L_PTE_MT_DEV_NONSHARED	(_AT(pteval_t, 0x0c) << 2)	/* 1100 */
> +#if defined(CONFIG_CPU_V7) || defined(CONFIG_CPU_V7M) || \
> +	defined (CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K)
> +#define L_PTE_MT_DEV_WC		L_PTE_MT_BUFFERABLE
> +#define L_PTE_MT_DEV_CACHED	L_PTE_MT_WRITEBACK
> +#define L_PTE_MT_DEV_NONSHARED	L_PTE_MT_MINICACHE

I think you can just ignore v7M here, it doesn't have an MMU.

You are defining L_PTE_MT_DEV_NONSHARED to L_PTE_MT_MINICACHE but what I
think you just meant is index 6 in the cpu_v6_mt_table which I would use
explicitly to avoid confusion.

Anyway, on ARMv7 or ARMv6+LPAE, the non-shared device gets mapped to
shared device in hardware. Looking through the arm32 code, it seems that
MT_DEVICE_NONSHARED is used by arch/arm/mach-shmobile/setup-r8a7779.c
and IIUC that's a v7 platform (R-Car H1, Cortex-A9). I think the above
should be defined to L_PTE_MT_DEV_SHARED, unless I miss any place where
DEV_NONSHARED is relevant on ARMv6 (adding Simon to confirm on
shmobile).

> diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
> index 81d0efb055c6..f896a30653fa 100644
> --- a/arch/arm/mm/proc-macros.S
> +++ b/arch/arm/mm/proc-macros.S
> @@ -134,21 +134,21 @@
>  	.macro	armv6_mt_table pfx
>  \pfx\()_mt_table:

Since you changed the MT index, you'd have to fix proc-v7-*levels.S  as
well. If you define DEV_NONSHARED to SHARED, I think you only need to
update the index for L_PTE_MT_VECTORS.

-- 
Catalin
