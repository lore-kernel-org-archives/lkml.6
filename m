Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D992C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E42A206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E42A206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeLDQlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:41:39 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36746 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbeLDQli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:41:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4C8B15BE;
        Tue,  4 Dec 2018 08:41:37 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1DA23F614;
        Tue,  4 Dec 2018 08:41:35 -0800 (PST)
Subject: Re: [PATCH 01/23] dma-mapping: provide a generic DMA_MAPPING_ERROR
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org
References: <20181130132231.16512-1-hch@lst.de>
 <20181130132231.16512-2-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <653ca801-63a1-3c19-ee09-ade19fa2bbb8@arm.com>
Date:   Tue, 4 Dec 2018 16:41:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130132231.16512-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2018 13:22, Christoph Hellwig wrote:
> Error handling of the dma_map_single and dma_map_page APIs is a little
> problematic at the moment, in that we use different encodings in the
> returned dma_addr_t to indicate an error.  That means we require an
> additional indirect call to figure out if a dma mapping call returned
> an error, and a lot of boilerplate code to implement these semantics.
> 
> Instead return the maximum addressable value as the error.  As long
> as we don't allow mapping single-byte ranges with single-byte alignment
> this value can never be a valid return.  Additionaly if drivers do
> not check the return value from the dma_map* routines this values means
> they will generally not be pointed to actual memory.
> 
> Once the default value is added here we can start removing the
> various mapping_error methods and just rely on this generic check.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/dma-mapping.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 0f81c713f6e9..46bd612d929e 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -133,6 +133,8 @@ struct dma_map_ops {
>   	u64 (*get_required_mask)(struct device *dev);
>   };
>   
> +#define DMA_MAPPING_ERROR		(~(dma_addr_t)0)
> +
>   extern const struct dma_map_ops dma_direct_ops;
>   extern const struct dma_map_ops dma_virt_ops;
>   
> @@ -576,6 +578,10 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
>   	const struct dma_map_ops *ops = get_dma_ops(dev);
>   
>   	debug_dma_mapping_error(dev, dma_addr);
> +
> +	if (dma_addr == DMA_MAPPING_ERROR)
> +		return 1;
> +
>   	if (ops->mapping_error)
>   		return ops->mapping_error(dev, dma_addr);
>   	return 0;

I'd have been inclined to put the default check here, i.e.

-	return 0
+	return dma_addr == DMA_MAPPING_ERROR

such that the callback retains full precedence and we don't have to deal 
with the non-trivial removals immediately if it comes to it. Not that it 
makes a vast difference though, so either way,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
