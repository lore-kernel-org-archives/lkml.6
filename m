Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4BBC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8DDB2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfBKKYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:24:17 -0500
Received: from 8bytes.org ([81.169.241.247]:39356 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbfBKKYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:24:17 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 27A4539A; Mon, 11 Feb 2019 11:24:15 +0100 (CET)
Date:   Mon, 11 Feb 2019 11:24:15 +0100
From:   "joro@8bytes.org" <joro@8bytes.org>
To:     wen yang <yellowriver2010@hotmail.com>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Magnus Damm <damm+renesas@opensource.se>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: fix device reference leaks
Message-ID: <20190211102414.GZ32526@8bytes.org>
References: <HK0PR02MB3634F6AE1FAE6B86EF82B291B26C0@HK0PR02MB3634.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK0PR02MB3634F6AE1FAE6B86EF82B291B26C0@HK0PR02MB3634.apcprd02.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a few more people to Cc.

On Sun, Feb 03, 2019 at 10:27:09AM +0000, wen yang wrote:
> Make sure to drop the reference to the device taken by
> of_find_device_by_node() on driver unbind.
> 
> Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/iommu/ipmmu-vmsa.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 7a4529c..cebf56d 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -756,6 +756,9 @@ static int ipmmu_init_platform_device(struct device *dev,
>  
>  	fwspec->iommu_priv = platform_get_drvdata(ipmmu_pdev);
>  
> +	if (!fwspec->iommu_priv)
> +		put_device(&ipmmu_pdev->dev);
> +
>  	return 0;
>  }
>  
> -- 
> 2.7.4
