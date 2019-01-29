Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C957C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D4420857
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfA2JRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:17:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:55876 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725355AbfA2JRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:17:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ACDCFAE67;
        Tue, 29 Jan 2019 09:17:35 +0000 (UTC)
Date:   Tue, 29 Jan 2019 10:17:33 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH 1/4] IOMMU: Make dwo drivers use stateless device links
Message-ID: <20190129091733.3ue6ifr3tpwu237j@suse.de>
References: <2405639.4es7pRLqn0@aspire.rjw.lan>
 <3532356.d9GMSSLOvP@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3532356.d9GMSSLOvP@aspire.rjw.lan>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 12:05:21AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The device links used by rockchip-iommu and exynos-iommu are
> completely managed by these drivers within the IOMMU framework,
> so there is no reason to involve the driver core in the management
> of these links.
> 
> For this reason, make rockchip-iommu and exynos-iommu pass
> DL_FLAG_STATELESS in flags to device_link_add(), so that the device
> links used by them are stateless.
> 
> [Note that this change is requisite for a subsequent one that will
>  rework the management of stateful device links in the driver core
>  and it will not be compatible with the two drivers in question any
>  more.]
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/iommu/exynos-iommu.c   |    1 +
>  drivers/iommu/rockchip-iommu.c |    3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)

Acked-by: Joerg Roedel <jroedel@suse.de>

> 
> Index: linux-pm/drivers/iommu/rockchip-iommu.c
> ===================================================================
> --- linux-pm.orig/drivers/iommu/rockchip-iommu.c
> +++ linux-pm/drivers/iommu/rockchip-iommu.c
> @@ -1071,7 +1071,8 @@ static int rk_iommu_add_device(struct de
>  	iommu_group_put(group);
>  
>  	iommu_device_link(&iommu->iommu, dev);
> -	data->link = device_link_add(dev, iommu->dev, DL_FLAG_PM_RUNTIME);
> +	data->link = device_link_add(dev, iommu->dev,
> +				     DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
>  
>  	return 0;
>  }
> Index: linux-pm/drivers/iommu/exynos-iommu.c
> ===================================================================
> --- linux-pm.orig/drivers/iommu/exynos-iommu.c
> +++ linux-pm/drivers/iommu/exynos-iommu.c
> @@ -1260,6 +1260,7 @@ static int exynos_iommu_add_device(struc
>  		 * direct calls to pm_runtime_get/put in this driver.
>  		 */
>  		data->link = device_link_add(dev, data->sysmmu,
> +					     DL_FLAG_STATELESS |
>  					     DL_FLAG_PM_RUNTIME);
>  	}
>  	iommu_group_put(group);
