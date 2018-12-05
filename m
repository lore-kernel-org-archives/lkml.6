Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89098C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504CA20989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504CA20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbeLEQJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:09:59 -0500
Received: from 8bytes.org ([81.169.241.247]:51974 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727945AbeLEQJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:09:58 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 12544191; Wed,  5 Dec 2018 17:09:56 +0100 (CET)
Date:   Wed, 5 Dec 2018 17:09:55 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: fix amd_iommu=force_isolation
Message-ID: <20181205160955.p3juusqdxarmo2yc@8bytes.org>
References: <20181204223716.214159-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204223716.214159-1-yuzhao@google.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 03:37:16PM -0700, Yu Zhao wrote:
> The parameter is still there but it's ignored. We need to check its
> value before deciding to go into passthrough mode for AMD IOMMU.
> 
> Fixes: aafd8ba0ca74 ("iommu/amd: Implement add_device and remove_device")
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  drivers/iommu/amd_iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 1167ff0416cf..3e4219e6cff0 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -2195,7 +2195,8 @@ static int amd_iommu_add_device(struct device *dev)
>  
>  	BUG_ON(!dev_data);
>  
> -	if (iommu_pass_through || dev_data->iommu_v2)
> +	if (iommu_pass_through ||
> +	    (!amd_iommu_force_isolation && dev_data->iommu_v2))

This breaks the iommu_v2 use-case, as it needs a direct mapping for the
devices that support it.

I think the force_isolation parameter does not make sense anymore today
and should be removed.


Regards,

	Joerg

