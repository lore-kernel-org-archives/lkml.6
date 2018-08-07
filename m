Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BCEC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6581D217BD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6581D217BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389004AbeHGOXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 10:23:23 -0400
Received: from gloria.sntech.de ([185.11.138.130]:50752 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbeHGOXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 10:23:23 -0400
Received: from wd0970.dip.tu-dresden.de ([141.76.111.202] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fn0na-000658-SJ; Tue, 07 Aug 2018 14:09:14 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH 1/2] iommu/rockchip: Handle errors returned from PM framework
Date:   Tue, 07 Aug 2018 14:09:14 +0200
Message-ID: <2940317.dDZy1L4CDY@phil>
In-Reply-To: <20180807085406.3863-2-marc.zyngier@arm.com>
References: <20180807085406.3863-1-marc.zyngier@arm.com> <20180807085406.3863-2-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Am Dienstag, 7. August 2018, 10:54:05 CEST schrieb Marc Zyngier:
> pm_runtime_get_if_in_use can fail: either PM has been disabled
> altogether (-EINVAL), or the device hasn't been enabled yet (0).
> Sadly, the Rockchip IOMMU driver tends to conflate the two things
> by considering a non-zero return value as successful.
> 
> This has the consequence of hiding other bugs, so let's handle this
> case throughout the driver, with a WARN_ON_ONCE so that we can try
> and work out what happened.
> 
> Fixes: 0f181d3cf7d98 ("iommu/rockchip: Add runtime PM support")
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

I'm still not sure about the !CONFIG_PM case, as it was probably silently
working in that case before.

But on the other hand we're also already running over it in other places
like in the iommu-shutdown and I guess if someone _really_ disabled
CONFIG_PM, a lot of additional stuff would fail anyway.


So should we wrap that in some #ifdef magic, just ignore it or simply
select PM similar to what Tegra, Renesas and Vexpress seem to do?

I guess I like the 3rd option best ;-)


Heiko



>  drivers/iommu/rockchip-iommu.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 054cd2c8e9c8..4e0f9b61cd7f 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -521,10 +521,11 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
>  	u32 int_status;
>  	dma_addr_t iova;
>  	irqreturn_t ret = IRQ_NONE;
> -	int i;
> +	int i, err;
>  
> -	if (WARN_ON(!pm_runtime_get_if_in_use(iommu->dev)))
> -		return 0;
> +	err = pm_runtime_get_if_in_use(iommu->dev);
> +	if (WARN_ON_ONCE(err <= 0))
> +		return ret;
>  
>  	if (WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks)))
>  		goto out;
> @@ -620,11 +621,15 @@ static void rk_iommu_zap_iova(struct rk_iommu_domain *rk_domain,
>  	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
>  	list_for_each(pos, &rk_domain->iommus) {
>  		struct rk_iommu *iommu;
> +		int ret;
>  
>  		iommu = list_entry(pos, struct rk_iommu, node);
>  
>  		/* Only zap TLBs of IOMMUs that are powered on. */
> -		if (pm_runtime_get_if_in_use(iommu->dev)) {
> +		ret = pm_runtime_get_if_in_use(iommu->dev);
> +		if (WARN_ON_ONCE(ret < 0))
> +			continue;
> +		if (ret) {
>  			WARN_ON(clk_bulk_enable(iommu->num_clocks,
>  						iommu->clocks));
>  			rk_iommu_zap_lines(iommu, iova, size);
> @@ -891,6 +896,7 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
>  	struct rk_iommu *iommu;
>  	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
>  	unsigned long flags;
> +	int ret;
>  
>  	/* Allow 'virtual devices' (eg drm) to detach from domain */
>  	iommu = rk_iommu_from_dev(dev);
> @@ -909,7 +915,9 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
>  	list_del_init(&iommu->node);
>  	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
>  
> -	if (pm_runtime_get_if_in_use(iommu->dev)) {
> +	ret = pm_runtime_get_if_in_use(iommu->dev);
> +	WARN_ON_ONCE(ret < 0);
> +	if (ret > 0) {
>  		rk_iommu_disable(iommu);
>  		pm_runtime_put(iommu->dev);
>  	}
> @@ -946,7 +954,8 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>  	list_add_tail(&iommu->node, &rk_domain->iommus);
>  	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
>  
> -	if (!pm_runtime_get_if_in_use(iommu->dev))
> +	ret = pm_runtime_get_if_in_use(iommu->dev);
> +	if (!ret || WARN_ON_ONCE(ret < 0))
>  		return 0;
>  
  	ret = rk_iommu_enable(iommu);
> 




