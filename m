Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7482CC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BDA320879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BDA320879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeLERRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:17:32 -0500
Received: from foss.arm.com ([217.140.101.70]:59478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbeLERRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:17:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FB01A78;
        Wed,  5 Dec 2018 09:17:32 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6524B3F575;
        Wed,  5 Dec 2018 09:17:31 -0800 (PST)
Subject: Re: [PATCH 0/5] Introduce device_iommu_maped() function
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20181204172504.19708-1-joro@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e34dcbe8-2f1b-31bb-2093-542361635cf5@arm.com>
Date:   Wed, 5 Dec 2018 17:17:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204172504.19708-1-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 04/12/2018 17:24, Joerg Roedel wrote:
> Hi,
> 
> here is a patch-set to replace the dev->iommu_group checks
> in the source tree by a proper function call. The pointer
> checks mostly happen to check whether a device is managed my
> an IOMMU. For that purpose a pointer check is not very
> descriptable, so replace it by a function call that make its
> purpose readable.

Nice, we can also clean up a whole load of vague iommu_present() usage 
and even one or two odd iommu_get_domain_for_dev() calls once we have this.

> This also starts to remove direct access to the
> dev->iommu_group pointer outside of iommu-code. This is
> another move towards consolidating the various
> iommu-related pointers in 'struct device' into one pointer
> only.
> 
> Please review.
> 
> Thanks,
> 
> 	Joerg
> 
> Joerg Roedel (5):
>    driver core: Introduce device_iommu_mapped() function
>    iommu/of: Use device_iommu_mapped()
>    ACPI/IORT: Use device_iommu_mapped()
>    powerpc/iommu: Use device_iommu_mapped()
>    xhci: Use device_iommu_mapped()
> 
>   arch/powerpc/kernel/eeh.c   |  2 +-
>   arch/powerpc/kernel/iommu.c |  6 +++---
>   drivers/acpi/arm64/iort.c   |  2 +-
>   drivers/iommu/of_iommu.c    |  2 +-
>   drivers/usb/host/xhci.c     |  2 +-
>   include/linux/device.h      | 10 ++++++++++
>   6 files changed, 17 insertions(+), 7 deletions(-)

There looks to be one more here:

drivers/dma/sh/rcar-dmac.c: rcar_dmac_probe()

Other than that and a minor comment on the OF/IORT part, though, for the 
whole series:

Acked-by: Robin Murphy <robin.murphy@arm.com>
