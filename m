Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B8BC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 19:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D24924077
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 19:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D24924077
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753999AbeGETfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 15:35:17 -0400
Received: from verein.lst.de ([213.95.11.211]:56217 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753846AbeGETfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 15:35:16 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2C3B768D4B; Thu,  5 Jul 2018 21:36:13 +0200 (CEST)
Date:   Thu, 5 Jul 2018 21:36:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        noring@nocrew.org, JuergenUrban@gmx.de
Subject: Re: [PATCH] dma-mapping: Relax warnings for per-device areas
Message-ID: <20180705193613.GA28905@lst.de>
References: <1f8262d206c6886072d04cc93454f6e3f812bd20.1530623284.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f8262d206c6886072d04cc93454f6e3f812bd20.1530623284.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -	BUG_ON(!ops);
> -	WARN_ON_ONCE(dev && !dev->coherent_dma_mask);
> -
>  	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
>  		return cpu_addr;
>  
> +	BUG_ON(!ops);
> +	WARN_ON_ONCE(dev && !dev->coherent_dma_mask);

I think doing dma on a device without ops is completely broken no matter
what you think of it, so I very much disagree with that part of the change.

Also while I don't think not having a dma mask is a good idea even for
a driver purely using dma coherent pools.  If the pools really are on
the device itself I can see why it might not matter, but for the case
commonly used on some ARM SOCs where we just reserve memory for certain
devices from a system pool it very much does matter.

There really is no good excuse to not set a coherent mask in the drivers.
