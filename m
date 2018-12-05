Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8572C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE3B20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE3B20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeLEOkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:40:13 -0500
Received: from foss.arm.com ([217.140.101.70]:55752 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbeLEOkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:40:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FD2380D;
        Wed,  5 Dec 2018 06:40:12 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E4E63F59C;
        Wed,  5 Dec 2018 06:40:08 -0800 (PST)
Subject: Re: [PATCH v4 3/3] iommu/io-pgtable-arm-v7s: Request DMA32 memory,
 and improve debugging
To:     Christoph Hellwig <hch@infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Cc:     Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Levin Alexander <Alexander.Levin@microsoft.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.com,
        Matthew Wilcox <willy@infradead.org>
References: <20181205054828.183476-1-drinkcat@chromium.org>
 <20181205054828.183476-4-drinkcat@chromium.org>
 <20181205135406.GA29031@infradead.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <1d211576-9153-cca1-5cd0-8c9881bd3fa4@arm.com>
Date:   Wed, 5 Dec 2018 14:40:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181205135406.GA29031@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2018 13:54, Christoph Hellwig wrote:
> On Wed, Dec 05, 2018 at 01:48:28PM +0800, Nicolas Boichat wrote:
>> IOMMUs using ARMv7 short-descriptor format require page tables
>> (level 1 and 2) to be allocated within the first 4GB of RAM, even
>> on 64-bit systems.
> 
>> +#ifdef CONFIG_ZONE_DMA32
>> +#define ARM_V7S_TABLE_GFP_DMA GFP_DMA32
>> +#define ARM_V7S_TABLE_SLAB_CACHE SLAB_CACHE_DMA32
>> +#else
>> +#define ARM_V7S_TABLE_GFP_DMA GFP_DMA
>> +#define ARM_V7S_TABLE_SLAB_CACHE SLAB_CACHE_DMA
>> +#endif
> 
> How does using GFP_DMA make sense based on the above?  If the system
> has more than 32-bits worth of RAM it should be using GFP_DMA32, else
> GFP_KERNEL, not GFP_DMA for an arch defined small addressability pool.

32-bit Arm doesn't have ZONE_DMA32, but has (or at least had at the 
time) a 2GB ZONE_DMA. Whether we actually need that or not depends on 
how this all interacts with LPAE and highmem, but I'm not sure of those 
details off-hand.

Robin.
