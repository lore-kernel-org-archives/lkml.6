Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3D0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A892133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbfB0TaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 14:30:15 -0500
Received: from foss.arm.com ([217.140.101.70]:38696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbfB0TaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 14:30:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78898A78;
        Wed, 27 Feb 2019 11:30:14 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD5F43F703;
        Wed, 27 Feb 2019 11:30:11 -0800 (PST)
Subject: Re: [PATCH 04/13] iommu/mediatek: Add device_link between the
 consumer and the larb devices
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     youlin.pei@mediatek.com, devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>, arnd@arndb.de,
        srv_heupstream@mediatek.com, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@google.com>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, yingjoe.chen@mediatek.com,
        linux-arm-kernel@lists.infradead.org
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
 <1546318276-18993-5-git-send-email-yong.wu@mediatek.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <709d7d66-9610-eeb3-128e-e2156bcfb616@arm.com>
Date:   Wed, 27 Feb 2019 19:30:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1546318276-18993-5-git-send-email-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/01/2019 04:51, Yong Wu wrote:
> MediaTek IOMMU don't have its power-domain. all the consumer connect
> with smi-larb, then connect with smi-common.
> 
>          M4U
>           |
>      smi-common
>           |
>    -------------
>    |         |    ...
>    |         |
> larb1     larb2
>    |         |
> vdec       venc
> 
> When the consumer works, it should enable the smi-larb's power which
> also need enable the smi-common's power firstly.
> 
> Thus, First of all, use the device link connect the consumer and the
> smi-larbs. then add device link between the smi-larb and smi-common.
> 
> This patch adds device_link between the consumer and the larbs.
> 
> Suggested-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c    | 15 +++++++++++++--
>   drivers/iommu/mtk_iommu_v1.c | 14 ++++++++++++--
>   2 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 202e41b..735ae8d 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -247,6 +247,7 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
>   	struct mtk_smi_larb_iommu    *larb_mmu;
>   	unsigned int                 larbid, portid;
>   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct device_link *link;
>   	int i;
>   
>   	for (i = 0; i < fwspec->num_ids; ++i) {
> @@ -257,10 +258,20 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
>   		dev_dbg(dev, "%s iommu port: %d\n",
>   			enable ? "enable" : "disable", portid);
>   
> -		if (enable)
> +		if (enable) {
>   			larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
> -		else
> +			/* Link the consumer with the larb device(supplier) */
> +			link = device_link_add(dev, larb_mmu->dev,
> +					       DL_FLAG_PM_RUNTIME |
> +					       DL_FLAG_AUTOREMOVE_CONSUMER);

This looks technically wrong, since we get here from 
mtk_iommu_attach_device(), and in theory a device could get attached to 
any number of domains over its lifetime, so adding a link at this point 
when there's no corresponding cleanup on detach is definitely 
unbalanced. If you want this layer to manage the link on behalf of the 
consumer, it would probably be better to do it at the point of 
mtk_iommu_add_device(), and either track it for manual cleanup in 
mtk_iommu_remove_device() or rely on AUTOREMOVE_SUPPLIER.

Robin.

> +			if (!link) {
> +				dev_err(dev, "Unable to link %s\n",
> +					dev_name(larb_mmu->dev));
> +				return;
> +			}
> +		} else {
>   			larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
> +		}
>   	}
>   }
>   
> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> index 9386aee..022bad9 100644
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
> @@ -201,6 +201,7 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
>   	struct mtk_smi_larb_iommu    *larb_mmu;
>   	unsigned int                 larbid, portid;
>   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct device_link *link;
>   	int i;
>   
>   	for (i = 0; i < fwspec->num_ids; ++i) {
> @@ -211,10 +212,19 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
>   		dev_dbg(dev, "%s iommu port: %d\n",
>   			enable ? "enable" : "disable", portid);
>   
> -		if (enable)
> +		if (enable) {
>   			larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
> -		else
> +			link = device_link_add(dev, larb_mmu->dev,
> +					       DL_FLAG_PM_RUNTIME |
> +					       DL_FLAG_AUTOREMOVE_CONSUMER);
> +			if (!link) {
> +				dev_err(dev, "Unable to link %s\n",
> +					dev_name(larb_mmu->dev));
> +				return;
> +			}
> +		} else {
>   			larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
> +		}
>   	}
>   }
>   
> 
