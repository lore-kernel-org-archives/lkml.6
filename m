Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDB4C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E13A20834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E13A20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeLAGPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:15:10 -0500
Received: from foss.arm.com ([217.140.101.70]:35082 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbeLAGPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:15:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 925231682;
        Fri, 30 Nov 2018 11:04:54 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33D683F575;
        Fri, 30 Nov 2018 11:04:52 -0800 (PST)
Subject: Re: [PATCH 2/9] dma-direct: reject highmem pages from
 dma_alloc_from_contiguous
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Guo Ren <ren_guo@c-sky.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181105121931.13481-1-hch@lst.de>
 <20181105121931.13481-3-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e479a766-07c0-c319-0d91-318aaafdf7bc@arm.com>
Date:   Fri, 30 Nov 2018 19:04:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105121931.13481-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2018 12:19, Christoph Hellwig wrote:
> dma_alloc_from_contiguous can return highmem pages depending on the
> setup, which a plain non-remapping DMA allocator can't handle.  Detect
> this case and try the normal page allocator instead.

...except the actual implementation is "Detect this case and fail the 
entire allocation if so".

Again, the diff itself makes sense, so given an accurate commit message,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/direct.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 680287779b0a..c49849bcced6 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -162,6 +162,18 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>   	if (!page)
>   		return NULL;
>   
> +	if (PageHighMem(page)) {
> +		/*
> +		 * Depending on the cma= arguments and per-arch setup
> +		 * dma_alloc_from_contiguous could return highmem pages.
> +		 * Without remapping there is no way to return them here,
> +		 * so log an error and fail.
> +		 */
> +		dev_info(dev, "Rejecting highmem page from CMA.\n");
> +		__dma_direct_free_pages(dev, size, page);
> +		return NULL;
> +	}
> +
>   	ret = page_address(page);
>   	if (force_dma_unencrypted()) {
>   		set_memory_decrypted((unsigned long)ret, 1 << get_order(size));
> 
