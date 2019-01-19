Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207D7C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 09:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58DD2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 09:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfASJkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 04:40:05 -0500
Received: from verein.lst.de ([213.95.11.211]:48398 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbfASJkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 04:40:05 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C23A968D93; Sat, 19 Jan 2019 10:40:02 +0100 (CET)
Date:   Sat, 19 Jan 2019 10:40:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/vt-d: Implement dma_[un]map_resource()
Message-ID: <20190119094002.GA21653@lst.de>
References: <20190119000559.12784-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119000559.12784-1-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 05:05:59PM -0700, Logan Gunthorpe wrote:
> However, this doesn't create the IOVA entries necessary for addresses
> mapped this way to work when the IOMMU is enabled. Thus, when the
> IOMMU is enabled, drivers relying on dma_map_resource() will trigger
> DMAR errors. We see this when running ntb_transport with the IOMMU
> enabled, DMA, and switchtec hardware.

Which resources do you plan to map?  At least for PCIe P2P adding
an address translation seems wrong to me.

> 
> The implementation for intel_map_resource() is nearly identical to
> intel_map_page(), we just have to re-create __intel_map_single().
> dma_unmap_resource() uses intel_unmap_page() directly as the
> functions are identical.

Instead of having two tiny wrappers I'd just revert
964f2311a6862f1fbcc044d0828ad90030928b7f if we need to pass a real
physical address now.
