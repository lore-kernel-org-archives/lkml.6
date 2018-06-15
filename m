Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 39E7DC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAEA208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBAEA208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936247AbeFONIn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 09:08:43 -0400
Received: from verein.lst.de ([213.95.11.211]:51131 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933771AbeFONIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 09:08:42 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id DBF9A68E44; Fri, 15 Jun 2018 15:17:10 +0200 (CEST)
Date:   Fri, 15 Jun 2018 15:17:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de
Subject: Re: [RFC] ARC: allow to use IOC and non-IOC DMA devices
        simultaneously
Message-ID: <20180615131710.GA30776@lst.de>
References: <20180615125819.527-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615125819.527-1-Eugeniy.Paltsev@synopsys.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#ifndef ASM_ARC_DMA_MAPPING_H
> +#define ASM_ARC_DMA_MAPPING_H
> +
> +#define arch_setup_dma_ops arch_setup_dma_ops
> +
> +#include <asm-generic/dma-mapping.h>
> +
> +void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> +			const struct iommu_ops *iommu, bool coherent);

Can you keep the #define for arch_setup_dma_ops right next to the
prototype?

> index 000000000000..9d0d310bbf5a
> --- /dev/null
> +++ b/arch/arc/mm/dma-mapping.c
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// (C) 2018 Synopsys, Inc. (www.synopsys.com)
> +
> +#include <linux/dma-mapping.h>
> +
> +void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> +			const struct iommu_ops *iommu, bool coherent)
> +{
> +	const struct dma_map_ops *dma_ops = &dma_noncoherent_ops;
> +
> +	/*
> +	 * IOC hardware snoops all DMA traffic keeping the caches consistent
> +	 * with memory - eliding need for any explicit cache maintenance of
> +	 * DMA buffers - so we can use dma_direct cache ops.
> +	 */
> +	if (is_isa_arcv2() && ioc_enable && coherent)
> +		dma_ops = &dma_direct_ops;
> +
> +	set_dma_ops(dev, dma_ops);
> +}


Why not just write the routines as:

void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
			const struct iommu_ops *iommu, bool coherent)
{
	if (is_isa_arcv2() && ioc_enable && coherent)
		set_dma_ops(dev, &dma_direct_ops);
	else
		set_dma_ops(dev, &dma_noncoherent_ops);
}

Also a new file just for this routine seems a little wasteful.  Can't
you just squeeze it into setup.c or some other file?
