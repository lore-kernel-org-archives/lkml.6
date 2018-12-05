Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60204C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3F3206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:02:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3F3206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbeLEPCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:02:33 -0500
Received: from foss.arm.com ([217.140.101.70]:56350 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbeLEPCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:02:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7764180D;
        Wed,  5 Dec 2018 07:02:32 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 474343F5AF;
        Wed,  5 Dec 2018 07:02:32 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 07DF41AE0BC5; Wed,  5 Dec 2018 15:02:52 +0000 (GMT)
Date:   Wed, 5 Dec 2018 15:02:52 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, dave.martin@arm.com, mark.rutland@arm.com,
        vladimir.murzin@arm.com, Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v2 1/7] arm64: capabilities: Merge entries for
 ARM64_WORKAROUND_CLEAN_CACHE
Message-ID: <20181205150252.GB16171@arm.com>
References: <1543598286-2663-1-git-send-email-suzuki.poulose@arm.com>
 <1543598286-2663-2-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543598286-2663-2-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 05:18:00PM +0000, Suzuki K Poulose wrote:
> We have two entries for ARM64_WORKAROUND_CLEAN_CACHE capability :
> 
> 1) ARM Errata 826319, 827319, 824069, 819472 on A53 r0p[012]
> 2) ARM Errata 819472 on A53 r0p[01]
> 
> Both have the same work around. Merge these entries to avoid
> duplicate entries for a single capability. Add a new Kconfig
> entry to control the "capability" entry to make it easier
> to handle combinations of the CONFIGs.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/Kconfig               |  7 +++++++
>  arch/arm64/include/asm/cputype.h |  1 +
>  arch/arm64/kernel/cpu_errata.c   | 28 ++++++++++++++++------------
>  3 files changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 787d785..ad69e15 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -313,9 +313,13 @@ menu "Kernel Features"
>  
>  menu "ARM errata workarounds via the alternatives framework"
>  
> +config ARM64_WORKAROUND_CLEAN_CACHE
> +	def_bool n
> +
>  config ARM64_ERRATUM_826319
>  	bool "Cortex-A53: 826319: System might deadlock if a write cannot complete until read data is accepted"
>  	default y
> +	select ARM64_WORKAROUND_CLEAN_CACHE
>  	help
>  	  This option adds an alternative code sequence to work around ARM
>  	  erratum 826319 on Cortex-A53 parts up to r0p2 with an AMBA 4 ACE or
> @@ -337,6 +341,7 @@ config ARM64_ERRATUM_826319
>  config ARM64_ERRATUM_827319
>  	bool "Cortex-A53: 827319: Data cache clean instructions might cause overlapping transactions to the interconnect"
>  	default y
> +	select ARM64_WORKAROUND_CLEAN_CACHE
>  	help
>  	  This option adds an alternative code sequence to work around ARM
>  	  erratum 827319 on Cortex-A53 parts up to r0p2 with an AMBA 5 CHI
> @@ -358,6 +363,7 @@ config ARM64_ERRATUM_827319
>  config ARM64_ERRATUM_824069
>  	bool "Cortex-A53: 824069: Cache line might not be marked as clean after a CleanShared snoop"
>  	default y
> +	select ARM64_WORKAROUND_CLEAN_CACHE
>  	help
>  	  This option adds an alternative code sequence to work around ARM
>  	  erratum 824069 on Cortex-A53 parts up to r0p2 when it is connected
> @@ -380,6 +386,7 @@ config ARM64_ERRATUM_824069
>  config ARM64_ERRATUM_819472
>  	bool "Cortex-A53: 819472: Store exclusive instructions might cause data corruption"
>  	default y
> +	select ARM64_WORKAROUND_CLEAN_CACHE
>  	help
>  	  This option adds an alternative code sequence to work around ARM
>  	  erratum 819472 on Cortex-A53 parts up to r0p1 with an L2 cache
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index 12f93e4d..2e26375 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -151,6 +151,7 @@ struct midr_range {
>  		.rv_max = MIDR_CPU_VAR_REV(v_max, r_max),	\
>  	}
>  
> +#define MIDR_REV_RANGE(m, v, r_min, r_max) MIDR_RANGE(m, v, r_min, v, r_max)

What's the point of this macro?

Will
