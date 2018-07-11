Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8C8C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F2D20878
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F2D20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbeGKJ6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:58:52 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46245 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeGKJ6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:58:52 -0400
Received: from 79.184.255.246.ipv4.supernova.orange.pl (79.184.255.246) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 25041061c4622ed5; Wed, 11 Jul 2018 11:55:19 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        robin.murphy@arm.com, will.deacon@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
        robdclark@gmail.com, linux-pm@vger.kernel.org,
        freedreno@lists.freedesktop.org, sboyd@kernel.org,
        tfiga@chromium.org, sricharan@codeaurora.org,
        m.szyprowski@samsung.com, architt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jcrouse@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v12 3/4] iommu/arm-smmu: Add the device_link between masters and smmu
Date:   Wed, 11 Jul 2018 11:53:48 +0200
Message-ID: <5179668.PHK6S3sxLu@aspire.rjw.lan>
In-Reply-To: <20180708173413.1965-4-vivek.gautam@codeaurora.org>
References: <20180708173413.1965-1-vivek.gautam@codeaurora.org> <20180708173413.1965-4-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, July 8, 2018 7:34:12 PM CEST Vivek Gautam wrote:
> From: Sricharan R <sricharan@codeaurora.org>
> 
> Finally add the device link between the master device and
> smmu, so that the smmu gets runtime enabled/disabled only when the
> master needs it. This is done from add_device callback which gets
> called once when the master is added to the smmu.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Lukas Wunner <lukas@wunner.de>
> ---
> 
>  - Change since v11
>    * Replaced DL_FLAG_AUTOREMOVE flag with DL_FLAG_AUTOREMOVE_SUPPLIER.
> 
>  drivers/iommu/arm-smmu.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 09265e206e2d..916cde4954d2 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1461,8 +1461,20 @@ static int arm_smmu_add_device(struct device *dev)
>  
>  	iommu_device_link(&smmu->iommu, dev);
>  
> +	if (pm_runtime_enabled(smmu->dev) &&

Why does the creation of the link depend on whether or not runtime PM
is enabled for the MMU device?

What about system-wide PM and system shutdown?  Are they always guaranteed
to happen in the right order without the link?

> +	    !device_link_add(dev, smmu->dev,
> +			DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER)) {
> +		dev_err(smmu->dev, "Unable to add link to the consumer %s\n",
> +			dev_name(dev));
> +		ret = -ENODEV;
> +		goto out_unlink;
> +	}
> +
>  	return 0;
>  
> +out_unlink:
> +	iommu_device_unlink(&smmu->iommu, dev);
> +	arm_smmu_master_free_smes(fwspec);
>  out_cfg_free:
>  	kfree(cfg);
>  out_free:
> 


