Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774EFECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 09:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB57A2084A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 09:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="YJE7pqSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB57A2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbeGUKEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 06:04:04 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33892 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbeGUKEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 06:04:04 -0400
Received: from avalon.localnet (unknown [IPv6:2a02:587:8041:9d00:717d:d1d9:bcc8:c702])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AE9EAB7F;
        Sat, 21 Jul 2018 11:11:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1532164319;
        bh=6UmvBeFWxsp68hgbWRiUsMfIMPXhXHUjYKp7LG8KUfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YJE7pqSuvUdikyINjEpWudtIwoGVv3N46V4KH+0tpKfIIIEo/Ijkt6evVkDqtqiw8
         L/kN/SipB8IDiFD0mA5Eb4Cp/9nsoLQPEsuLLa0x3PoiDEWfa53OoHiGmadftVwuiB
         8ECgEHDmPpbWDaOpmbVNz8mV1iCYMAdRUnnCb8HU=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        iommu@lists.linux-foundation.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Fix allocation in atomic context
Date:   Sat, 21 Jul 2018 12:12:33 +0300
Message-ID: <25541397.uzn8ZjuUG8@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180720161659.29800-1-geert+renesas@glider.be>
References: <20180720161659.29800-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Friday, 20 July 2018 19:16:59 EEST Geert Uytterhoeven wrote:
> When attaching a device to an IOMMU group with
> CONFIG_DEBUG_ATOMIC_SLEEP=y:
> 
>     BUG: sleeping function called from invalid context at mm/slab.h:421
>     in_atomic(): 1, irqs_disabled(): 128, pid: 61, name: kworker/1:1
>     ...
>     Call trace:
>      ...
>      arm_lpae_alloc_pgtable+0x114/0x184
>      arm_64_lpae_alloc_pgtable_s1+0x2c/0x128
>      arm_32_lpae_alloc_pgtable_s1+0x40/0x6c
>      alloc_io_pgtable_ops+0x60/0x88
>      ipmmu_attach_device+0x140/0x334
> 
> ipmmu_attach_device() takes a spinlock, while arm_lpae_alloc_pgtable()
> allocates memory using GFP_KERNEL.  Originally, the ipmmu-vmsa driver
> had its own custom page table allocation implementation using
> GFP_ATOMIC, hence the spinlock was fine.
> 
> Fix this by replacing the spinlock by a mutex, like the arm-smmu driver
> does.
> 
> Fixes: f20ed39f53145e45 ("iommu/ipmmu-vmsa: Use the ARM LPAE page table
> allocator") Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 6a0e7142f41bf667..8f54f25404456035 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -73,7 +73,7 @@ struct ipmmu_vmsa_domain {
>  	struct io_pgtable_ops *iop;
> 
>  	unsigned int context_id;
> -	spinlock_t lock;			/* Protects mappings */
> +	struct mutex mutex;			/* Protects mappings */
>  };
> 
>  static struct ipmmu_vmsa_domain *to_vmsa_domain(struct iommu_domain *dom)
> @@ -599,7 +599,7 @@ static struct iommu_domain
> *__ipmmu_domain_alloc(unsigned type) if (!domain)
>  		return NULL;
> 
> -	spin_lock_init(&domain->lock);
> +	mutex_init(&domain->mutex);
> 
>  	return &domain->io_domain;
>  }
> @@ -645,7 +645,6 @@ static int ipmmu_attach_device(struct iommu_domain
> *io_domain, struct iommu_fwspec *fwspec = dev->iommu_fwspec;
>  	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
>  	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
> -	unsigned long flags;
>  	unsigned int i;
>  	int ret = 0;
> 
> @@ -654,7 +653,7 @@ static int ipmmu_attach_device(struct iommu_domain
> *io_domain, return -ENXIO;
>  	}
> 
> -	spin_lock_irqsave(&domain->lock, flags);
> +	mutex_lock(&domain->mutex);

As the ipmmu_attach_device() function is called from a sleepable context this 
should be fine.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> 
>  	if (!domain->mmu) {
>  		/* The domain hasn't been used yet, initialize it. */
> @@ -678,7 +677,7 @@ static int ipmmu_attach_device(struct iommu_domain
> *io_domain, } else
>  		dev_info(dev, "Reusing IPMMU context %u\n", domain->context_id);
> 
> -	spin_unlock_irqrestore(&domain->lock, flags);
> +	mutex_unlock(&domain->mutex);
> 
>  	if (ret < 0)
>  		return ret;


-- 
Regards,

Laurent Pinchart



