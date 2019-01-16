Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02561C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1A720866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfAPUnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 15:43:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbfAPUnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 15:43:50 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3C2949F73B;
        Wed, 16 Jan 2019 20:43:50 +0000 (UTC)
Received: from [10.36.116.103] (ovpn-116-103.ams2.redhat.com [10.36.116.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A12519C7E;
        Wed, 16 Jan 2019 20:43:42 +0000 (UTC)
Subject: Re: [PATCH] iommu/intel-iommu: fix memory leak in
 intel_iommu_put_resv_regions()
To:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Joerg Roedel <jroedel@suse.de>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>
References: <20190116191144.15652-1-gerald.schaefer@de.ibm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <ce818491-4b9c-a5d8-7ad6-707aa25445ed@redhat.com>
Date:   Wed, 16 Jan 2019 21:43:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190116191144.15652-1-gerald.schaefer@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 16 Jan 2019 20:43:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerald,

On 1/16/19 8:11 PM, Gerald Schaefer wrote:
> Commit 9d3a4de4cb8d ("iommu: Disambiguate MSI region types") changed
> the reserved region type in intel_iommu_get_resv_regions() from
> IOMMU_RESV_RESERVED to IOMMU_RESV_MSI, but it forgot to also change
> the type in intel_iommu_put_resv_regions().
> 
> This leads to a memory leak, because now the check in
> intel_iommu_put_resv_regions() for IOMMU_RESV_RESERVED will never
> be true, and no allocated regions will be freed.
> 
> Fix this by changing the region type in intel_iommu_put_resv_regions()
> to IOMMU_RESV_MSI, matching the type of the allocated regions.
> 
> Fixes: 9d3a4de4cb8d ("iommu: Disambiguate MSI region types")
> Cc: <stable@vger.kernel.org> # v4.11+
> Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
>  drivers/iommu/intel-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 048b5ab36a02..b83e0f2025bb 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5295,7 +5295,7 @@ static void intel_iommu_put_resv_regions(struct device *dev,
>  	struct iommu_resv_region *entry, *next;
>  
>  	list_for_each_entry_safe(entry, next, head, list) {
> -		if (entry->type == IOMMU_RESV_RESERVED)
> +		if (entry->type == IOMMU_RESV_MSI)
>  			kfree(entry);
>  	}
>  }
> 
