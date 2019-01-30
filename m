Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FAFC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7682220855
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbfA3M15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:27:57 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53416 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbfA3M14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:27:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19864A78;
        Wed, 30 Jan 2019 04:27:56 -0800 (PST)
Received: from [10.1.197.2] (ostrya.cambridge.arm.com [10.1.197.2])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29D023F557;
        Wed, 30 Jan 2019 04:27:55 -0800 (PST)
Subject: Re: [PATCH 2/2] iommu/amd: Remove clear_flush_young notifier
To:     Peter Xu <peterx@redhat.com>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Jason Wang <jasowang@redhat.com>
References: <20190130055758.3994-1-peterx@redhat.com>
 <20190130055758.3994-3-peterx@redhat.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <69af2b6f-bfc1-a4b9-675a-6fc93a7efef2@arm.com>
Date:   Wed, 30 Jan 2019 12:27:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130055758.3994-3-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 30/01/2019 05:57, Peter Xu wrote:
> AMD IOMMU driver is using the clear_flush_young() to do cache flushing
> but that's actually already covered by invalidate_range().  Remove the
> extra notifier and the chunks.

Aren't uses of clear_flush_young() and invalidate_range() orthogonal? If
I understood correctly, when doing reclaim the kernel clears the young
bit from the PTE. This requires flushing secondary TLBs (ATCs), so that
new accesses from devices will go through the IOMMU, set the young bit
again and the kernel can accurately track page use. I didn't see
invalidate_range() being called by rmap or vmscan in this case, but
might just be missing it.

Two MMU notifiers are used for the young bit, clear_flush_young() and
clear_young(). I believe the former should invalidate ATCs so that DMA
accesses participate in PTE aging. Otherwise the kernel can't know that
the device is still using entries marked 'old'. The latter,
clear_young() is exempted from invalidating the secondary TLBs by
mmu_notifier.h and the IOMMU driver doesn't need to implement it.

Thanks,
Jean

> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  drivers/iommu/amd_iommu_v2.c | 24 ------------------------
>  1 file changed, 24 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
> index 23dae9348ace..5d7ef750e4a0 100644
> --- a/drivers/iommu/amd_iommu_v2.c
> +++ b/drivers/iommu/amd_iommu_v2.c
> @@ -370,29 +370,6 @@ static struct pasid_state *mn_to_state(struct mmu_notifier *mn)
>  	return container_of(mn, struct pasid_state, mn);
>  }
>  
> -static void __mn_flush_page(struct mmu_notifier *mn,
> -			    unsigned long address)
> -{
> -	struct pasid_state *pasid_state;
> -	struct device_state *dev_state;
> -
> -	pasid_state = mn_to_state(mn);
> -	dev_state   = pasid_state->device_state;
> -
> -	amd_iommu_flush_page(dev_state->domain, pasid_state->pasid, address);
> -}
> -
> -static int mn_clear_flush_young(struct mmu_notifier *mn,
> -				struct mm_struct *mm,
> -				unsigned long start,
> -				unsigned long end)
> -{
> -	for (; start < end; start += PAGE_SIZE)
> -		__mn_flush_page(mn, start);
> -
> -	return 0;
> -}
> -
>  static void mn_invalidate_range(struct mmu_notifier *mn,
>  				struct mm_struct *mm,
>  				unsigned long start, unsigned long end)
> @@ -430,7 +407,6 @@ static void mn_release(struct mmu_notifier *mn, struct mm_struct *mm)
>  
>  static const struct mmu_notifier_ops iommu_mn = {
>  	.release		= mn_release,
> -	.clear_flush_young      = mn_clear_flush_young,
>  	.invalidate_range       = mn_invalidate_range,
>  };
>  
> 

