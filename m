Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72AAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883FC20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfAQNCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:02:19 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39580 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbfAQNCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:02:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3EAA80D;
        Thu, 17 Jan 2019 05:02:18 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B9393F557;
        Thu, 17 Jan 2019 05:02:17 -0800 (PST)
Subject: Re: [PATCH v1] iommu/s390: Declare s390 iommu reserved regions
To:     Pierre Morel <pmorel@linux.ibm.com>, gerald.schaefer@de.ibm.com
Cc:     linux-s390@vger.kernel.org, walling@linux.ibm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        alex.williamson@redhat.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <1547573850-9459-1-git-send-email-pmorel@linux.ibm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <cc070df1-e7dc-8cce-f443-879e0e5e2903@arm.com>
Date:   Thu, 17 Jan 2019 13:02:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1547573850-9459-1-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/2019 17:37, Pierre Morel wrote:
> The s390 iommu can only allow DMA transactions between the zPCI device
> entries start_dma and end_dma.
> 
> Let's declare the regions before start_dma and after end_dma as
> reserved regions using the appropriate callback in iommu_ops.
> 
> The reserved region may later be retrieved from sysfs or from
> the vfio iommu internal interface.

For this particular case, I think the best solution is to give VFIO the 
ability to directly interrogate the domain geometry (which s390 appears 
to set correctly already). The idea of reserved regions was really for 
'unexpected' holes inside the usable address space - using them to also 
describe places that are entirely outside that address space rather 
confuses things IMO.

Furthermore, even if we *did* end up going down the route of actively 
reserving addresses beyond the usable aperture, it doesn't seem sensible 
for individual drivers to do it themselves when the core API already 
describes the relevant information generically.

Robin.

> 
> This seems to me related with the work Shameer has started on
> vfio_iommu_type1 so I add Alex and Shameer to the CC list.
> 
> 
> Pierre Morel (1):
>    iommu/s390: Declare s390 iommu reserved regions
> 
>   drivers/iommu/s390-iommu.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
