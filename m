Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81489C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED0621780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED0621780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388714AbeKPD4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:56:52 -0500
Received: from foss.arm.com ([217.140.101.70]:38812 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbeKPD4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 22:56:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 086DD80D;
        Thu, 15 Nov 2018 09:48:05 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A88BA3F718;
        Thu, 15 Nov 2018 09:48:04 -0800 (PST)
Date:   Thu, 15 Nov 2018 17:48:03 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, xiaobo.xie@nxp.com,
        ran.wang_1@nxp.com, linux-arm-kernel@lists.infradead.org,
        Rajesh Bhagat <rajesh.bhagat@nxp.com>
Subject: Re: [PATCH v1] arch: arm64: add ARM64 specific fucntions required
 for ehci fsl driver
Message-ID: <20181115174802.GB3087@brain-police>
References: <20181115092357.1556-1-yinbo.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115092357.1556-1-yinbo.zhu@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 05:23:57PM +0800, Yinbo Zhu wrote:
> From: Rajesh Bhagat <rajesh.bhagat@nxp.com>
> 
> Add set/clear bits functions for ARM platform which are used by ehci fsl
> driver
> 
> Signed-off-by: Rajesh Bhagat <rajesh.bhagat@nxp.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> ---
>  arch/arm64/include/asm/io.h |   29 +++++++++++++++++++++++++++++
>  1 files changed, 29 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> index e97b861..0dc4334 100644
> --- a/arch/arm64/include/asm/io.h
> +++ b/arch/arm64/include/asm/io.h
> @@ -185,6 +185,35 @@ extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
>  #define iowrite32be(v,p)	({ __iowmb(); __raw_writel((__force __u32)cpu_to_be32(v), p); })
>  #define iowrite64be(v,p)	({ __iowmb(); __raw_writeq((__force __u64)cpu_to_be64(v), p); })
>  
> +/* access ports */
> +#define setbits32(_addr, _v) iowrite32be(ioread32be(_addr) |  (_v), (_addr))
> +#define clrbits32(_addr, _v) iowrite32be(ioread32be(_addr) & ~(_v), (_addr))
> +
> +#define setbits16(_addr, _v) iowrite16be(ioread16be(_addr) |  (_v), (_addr))
> +#define clrbits16(_addr, _v) iowrite16be(ioread16be(_addr) & ~(_v), (_addr))
> +
> +#define setbits8(_addr, _v) iowrite8(ioread8(_addr) |  (_v), (_addr))
> +#define clrbits8(_addr, _v) iowrite8(ioread8(_addr) & ~(_v), (_addr))

Why isn't this defined in the driver? Adding it to the arch-code leads to
duplication of the definitions and encourages other drivers to start using
this weird interface.

So no, I don't want this in the arch code.

Will
