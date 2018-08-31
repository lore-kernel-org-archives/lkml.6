Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E58C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FDE52054F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FDE52054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeHaFqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:46:40 -0400
Received: from regular1.263xmail.com ([211.150.99.132]:60532 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbeHaFqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:46:40 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.234])
        by regular1.263xmail.com (Postfix) with ESMTP id 91CF52AD;
        Fri, 31 Aug 2018 09:41:33 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from [172.16.10.60] (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id D3469359;
        Fri, 31 Aug 2018 09:41:25 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: hjc@rock-chips.com
X-FST-TO: sandy.huang@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: hjc@rock-chips.com
X-UNIQUE-TAG: <767fb6b1527651cce384bdf4fb8526ac>
X-ATTACHMENT-NUM: 0
X-SENDER: hjc@rock-chips.com
X-DNS-TYPE: 0
Received: from [172.16.10.60] (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 32569LLNTHU;
        Fri, 31 Aug 2018 09:41:29 +0800 (CST)
Subject: Re: [PATCH v8 1/3] drm/rockchip: add function to check if endpoint is
 a subdriver
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     seanpaul@chromium.org, linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180830211207.10480-1-heiko@sntech.de>
 <20180830211207.10480-2-heiko@sntech.de>
From:   Sandy Huang <hjc@rock-chips.com>
Message-ID: <ad6135e6-e2d4-7b97-3d77-4aa085270960@rock-chips.com>
Date:   Fri, 31 Aug 2018 09:41:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830211207.10480-2-heiko@sntech.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2018/8/31 5:12, Heiko Stuebner Ð´µÀ:
> To be able to have both internal subdrivers and external bridge
> drivers as output endpoints of vops, add a function to be able
> to distinguish these.
> 
> changes in v8:
> - improved function documentation
> - better error handling
> - put calls for node and pdev references
> changes in v6:
> - added function to check subdriver vs. bridge
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 48 +++++++++++++++++++++
>   drivers/gpu/drm/rockchip/rockchip_drm_drv.h |  1 +
>   2 files changed, 49 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> index 1d9c4a9201c8..5864cb452c5c 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> @@ -24,6 +24,7 @@
>   #include <linux/pm_runtime.h>
>   #include <linux/module.h>
>   #include <linux/of_graph.h>
> +#include <linux/of_platform.h>
>   #include <linux/component.h>
>   #include <linux/console.h>
>   #include <linux/iommu.h>
> @@ -267,6 +268,53 @@ static const struct dev_pm_ops rockchip_drm_pm_ops = {
>   static struct platform_driver *rockchip_sub_drivers[MAX_ROCKCHIP_SUB_DRIVERS];
>   static int num_rockchip_sub_drivers;
>   
> +/*
> + * Check if a vop endpoint is leading to a rockchip subdriver or bridge.
> + * Should be called from the component bind stage of the drivers
> + * to ensure that all subdrivers are probed.
> + *
> + * @ep: endpoint of a rockchip vop
> + *
> + * returns true if subdriver, false if external bridge and -ENODEV
> + * if remote port does not contain a device.
> + */
> +int rockchip_drm_endpoint_is_subdriver(struct device_node *ep)
> +{
> +	struct device_node *node = of_graph_get_remote_port_parent(ep);
> +	struct platform_device *pdev;
> +	struct device_driver *drv;
> +	int i;
> +
> +	if (!node)
> +		return -ENODEV;
> +
> +	/* status disabled will prevent creation of platform-devices */
> +	pdev = of_find_device_by_node(node);
> +	of_node_put(node);
> +	if (!pdev)
> +		return -ENODEV;
> +
> +	/*
> +	 * All rockchip subdrivers have probed at this point, so
> +	 * any device not having a driver now is an external bridge.
> +	 */
> +	drv = pdev->dev.driver;
> +	if (!drv) {
> +		platform_device_put(pdev);
> +		return false;
> +	}
> +
> +	for (i = 0; i < num_rockchip_sub_drivers; i++) {
> +		if (rockchip_sub_drivers[i] == to_platform_driver(drv)) {
> +			platform_device_put(pdev);
> +			return true;
> +		}
> +	}
> +
> +	platform_device_put(pdev);
> +	return false;
> +}
> +
>   static int compare_dev(struct device *dev, void *data)
>   {
>   	return dev == (struct device *)data;
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
> index d67ad0a3cf36..21a023a97bb8 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
> @@ -64,6 +64,7 @@ void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
>   				    struct device *dev);
>   int rockchip_drm_wait_vact_end(struct drm_crtc *crtc, unsigned int mstimeout);
>   
> +int rockchip_drm_endpoint_is_subdriver(struct device_node *ep);
>   extern struct platform_driver cdn_dp_driver;
>   extern struct platform_driver dw_hdmi_rockchip_pltfm_driver;
>   extern struct platform_driver dw_mipi_dsi_driver;
> 

Reviewed-by Sandy Huang <hjc@rock-chips.com>

