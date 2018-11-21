Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8562AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56347214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56347214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbeKVDXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 22:23:17 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15572 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726941AbeKVDXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 22:23:16 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0CCD47647E327;
        Thu, 22 Nov 2018 00:47:59 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Thu, 22 Nov 2018
 00:47:54 +0800
Subject: Re: [PATCH v3] iommu/dma: Use NUMA aware memory allocations in
 __iommu_dma_alloc_pages()
To:     Will Deacon <will.deacon@arm.com>
References: <1542812051-178935-1-git-send-email-john.garry@huawei.com>
 <20181121160718.GB24883@arm.com>
CC:     <joro@8bytes.org>, <robin.murphy@arm.com>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <ganapatrao.kulkarni@cavium.com>, <hch@lst.de>,
        <m.szyprowski@samsung.com>, <linuxarm@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <24be0d21-63b1-c88d-fdfd-42575f12634f@huawei.com>
Date:   Wed, 21 Nov 2018 16:47:48 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181121160718.GB24883@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2018 16:07, Will Deacon wrote:
> On Wed, Nov 21, 2018 at 10:54:10PM +0800, John Garry wrote:
>> From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>>
>> Change function __iommu_dma_alloc_pages() to allocate pages for DMA from
>> respective device NUMA node. The ternary operator which would be for
>> alloc_pages_node() is tidied along with this.
>>
>> We also include a change to use kvzalloc() for kzalloc()/vzalloc()
>> combination.
>>
>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>> [JPG: Added kvzalloc(), drop pages ** being device local, tidied ternary operator]
>> Signed-off-by: John Garry <john.garry@huawei.com>
>
> Weird, you're missing a diffstat here.
>
> Anyway, the patch looks fine to me, but it would be nice if you could
> justify the change with some numbers. Do you actually see an improvement
> from this change?
>

Hi Will,

Ah, I missed adding my comments explaining the motivation. It would be 
better in the commit log. Anyway, here's the snippet:

" ... as mentioned in [3], dma_alloc_coherent() uses the locality
information from the device - as in direct DMA - so this patch is just
applying this same policy.

[3] 
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1692998.html"

I did have some numbers to show improvement in some scenarios when I 
tested this a while back which I'll dig out.

However I would say that some scenarios will improve and the opposite 
for others with this change, considering different conditions in which 
DMA memory may be used.

Cheers,
John

> Will
>
> .
>


