Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D85BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE69C2146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE69C2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388952AbeKPF7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:59:18 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40542 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725742AbeKPF7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:59:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0D3AEBD;
        Thu, 15 Nov 2018 11:50:06 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B9643F5BD;
        Thu, 15 Nov 2018 11:50:06 -0800 (PST)
Date:   Thu, 15 Nov 2018 19:50:04 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guo Ren <ren_guo@c-sky.com>, Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] dma-mapping: move the arm64 ncoherent alloc/free
 support to common code
Message-ID: <20181115195004.GB4535@brain-police>
References: <20181105121931.13481-1-hch@lst.de>
 <20181105121931.13481-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105121931.13481-5-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Minor nit: typo in the subject "ncoherent".

On Mon, Nov 05, 2018 at 01:19:26PM +0100, Christoph Hellwig wrote:
> The arm64 codebase to implement coherent dma allocation for architectures
> with non-coherent DMA is a good start for a generic implementation, given
> that is uses the generic remap helpers, provides the atomic pool for
> allocations that can't sleep and still is realtively simple and well
> tested.  Move it to kernel/dma and allow architectures to opt into it
> using a config symbol.  Architectures just need to provide a new
> arch_dma_prep_coherent helper to writeback an invalidate the caches
> for any memory that gets remapped for uncached access.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm64/Kconfig              |   2 +-
>  arch/arm64/mm/dma-mapping.c     | 184 ++------------------------------
>  include/linux/dma-mapping.h     |   5 +
>  include/linux/dma-noncoherent.h |   2 +
>  kernel/dma/Kconfig              |   6 ++
>  kernel/dma/remap.c              | 158 ++++++++++++++++++++++++++-
>  6 files changed, 181 insertions(+), 176 deletions(-)

I'm currently at LPC, so I've not been able to test this, but I've been
through the changes this morning and they look fine to me, so:

Reviewed-by: Will Deacon <will.deacon@arm.com>

Hopefully we'll get the fallout from the previous changes addressed next
week.

Cheers,

Will
