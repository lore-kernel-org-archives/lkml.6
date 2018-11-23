Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F45C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6764E20659
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6764E20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440650AbeKXD0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 22:26:12 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:58467 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730360AbeKXD0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 22:26:12 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 25D6E7AC9CFC3;
        Sat, 24 Nov 2018 00:41:11 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Sat, 24 Nov 2018
 00:41:04 +0800
Subject: Re: [PATCH v3] iommu/dma: Use NUMA aware memory allocations in
 __iommu_dma_alloc_pages()
To:     Will Deacon <will.deacon@arm.com>
References: <1542812051-178935-1-git-send-email-john.garry@huawei.com>
 <20181121160718.GB24883@arm.com>
 <24be0d21-63b1-c88d-fdfd-42575f12634f@huawei.com>
 <20181121165755.GE24883@arm.com>
CC:     <joro@8bytes.org>, <robin.murphy@arm.com>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <ganapatrao.kulkarni@cavium.com>, <hch@lst.de>,
        <m.szyprowski@samsung.com>, <linuxarm@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <86eaa286-d884-d599-4109-bbf31b5d5d97@huawei.com>
Date:   Fri, 23 Nov 2018 16:40:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181121165755.GE24883@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2018 16:57, Will Deacon wrote:
> On Wed, Nov 21, 2018 at 04:47:48PM +0000, John Garry wrote:
>> On 21/11/2018 16:07, Will Deacon wrote:
>>> On Wed, Nov 21, 2018 at 10:54:10PM +0800, John Garry wrote:
>>>> From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>>>>
>>>> Change function __iommu_dma_alloc_pages() to allocate pages for DMA from
>>>> respective device NUMA node. The ternary operator which would be for
>>>> alloc_pages_node() is tidied along with this.
>>>>
>>>> We also include a change to use kvzalloc() for kzalloc()/vzalloc()
>>>> combination.
>>>>
>>>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>>>> [JPG: Added kvzalloc(), drop pages ** being device local, tidied ternary operator]
>>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>>
>>> Weird, you're missing a diffstat here.
>>>
>>> Anyway, the patch looks fine to me, but it would be nice if you could
>>> justify the change with some numbers. Do you actually see an improvement
>> >from this change?
>>>
>>
>> Hi Will,
>>
>> Ah, I missed adding my comments explaining the motivation. It would be
>> better in the commit log. Anyway, here's the snippet:
>>
>> " ... as mentioned in [3], dma_alloc_coherent() uses the locality
>> information from the device - as in direct DMA - so this patch is just
>> applying this same policy.
>>
>> [3]
>> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1692998.html"
>
> Yes, please add to this to the commit log.
>

Sure,

>> I did have some numbers to show improvement in some scenarios when I tested
>> this a while back which I'll dig out.
>>
>> However I would say that some scenarios will improve and the opposite for
>> others with this change, considering different conditions in which DMA
>> memory may be used.
>
> Well, if you can show that it's useful in some cases and not catastrophic in
> others, then I think shooting for parity with direct DMA is a reasonable
> justification for the change.
>

So I have done some more testing with our SoC crypto engine, using 
tcrypt module. The reason I used this device was because we can utilise 
a local device per socket in the system, unlike other DMAing devices, 
which generally only exist on a single socket (for us, anyway).

Overall the results aren't brilliant - as expected - but show a general 
marginal improvement. Here's some figures:

Summary:
Average diff		+0.9%
Max diff		+1.5%
Min diff		+0.2%

Test			     Ops/second	before  after   diff %	

async ecb(aes) encrypt
test 0 (128 bit key, 16 byte blocks)	68717	69057	0.5
test 1 (128 bit key, 64 byte blocks):	72633	73163	0.7
test 2 (128 bit key, 256 byte blocks):	71475	72076	0.8
test 3 (128 bit key, 1024 byte blocks):	66819	67467	1.0
test 4 (128 bit key, 8192 byte blocks):	38237	38495	0.7
test 5 (192 bit key, 16 byte blocks): 	70273	71079	1.2
test 6 (192 bit key, 64 byte blocks):	72455	73292	1.2
test 7 (192 bit key, 256 byte blocks):	71085	71876	1.1
test 8 (192 bit key, 1024 byte blocks):	65891	66576	1.0
test 9 (192 bit key, 8192 byte blocks): 34846	35061	0.6
test 10 (256 bit key, 16 byte blocks):	72927	73762	1.2
test 11 (256 bit key, 64 byte blocks):	72361	73207	1.2
test 12 (256 bit key, 256 byte blocks):	70907	71602	1.0
test 13 (256 bit key, 1024 byte blocks):65035	65653	1.0
test 14 (256 bit key, 8192 byte blocks):32835	32998	0.5
async ecb(aes) decrypt
test 0 (128 bit key, 16 byte blocks)	68384	69130	1.1
test 1 (128 bit key, 64 byte blocks):	72645	73133	0.7
test 2 (128 bit key, 256 byte blocks):	71523	71912	0.5
test 3 (128 bit key, 1024 byte blocks):	66902	67258	0.5
test 4 (128 bit key, 8192 byte blocks):	38260	38434	0.5
test 5 (192 bit key, 16 byte blocks): 	70301	70816	0.7
test 6 (192 bit key, 64 byte blocks):	72473	73064	0.8
test 7 (192 bit key, 256 byte blocks):	71106	71663	0.8
test 8 (192 bit key, 1024 byte blocks):	65915	66363	0.7
test 9 (192 bit key, 8192 byte blocks): 34876	35006	0.4
test 10 (256 bit key, 16 byte blocks):	72969	73519	0.8
test 11 (256 bit key, 64 byte blocks):	72404	72925	0.7
test 12 (256 bit key, 256 byte blocks):	70861	71350	0.7
test 13 (256 bit key, 1024 byte blocks):65074	65485	0.6
test 14 (256 bit key, 8192 byte blocks):32861	32974	0.3
async cbc(aes) encrypt
test 0 (128 bit key, 16 byte blocks)	58306	59131	1.4
test 1 (128 bit key, 64 byte blocks):	61647	62565	1.5
test 2 (128 bit key, 256 byte blocks):	60841	61666	1.4
test 3 (128 bit key, 1024 byte blocks):	57503	58204	1.2
test 4 (128 bit key, 8192 byte blocks):	34760	35055	0.9
test 5 (192 bit key, 16 byte blocks): 	59684	60452	1.3
test 6 (192 bit key, 64 byte blocks):	61705	62516	1.3
test 7 (192 bit key, 256 byte blocks):	60678	61426	1.2
test 8 (192 bit key, 1024 byte blocks):	56805	57487	1.2
test 9 (192 bit key, 8192 byte blocks): 31836	32093	0.8
test 10 (256 bit key, 16 byte blocks):	61961	62785	1.3
test 11 (256 bit key, 64 byte blocks):	61584	62427	1.4
test 12 (256 bit key, 256 byte blocks):	60407	61246	1.4
test 13 (256 bit key, 1024 byte blocks):56135	56868	1.3
test 14 (256 bit key, 8192 byte blocks):30128	30380	0.8
async cbc(aes) decrypt
test 0 (128 bit key, 16 byte blocks)	58555	59044	0.8
test 1 (128 bit key, 64 byte blocks):	61853	62589	1.2
test 2 (128 bit key, 256 byte blocks):	60992	61728	1.2
test 3 (128 bit key, 1024 byte blocks):	57591	58250	1.1
test 4 (128 bit key, 8192 byte blocks):	34796	35064	0.8
test 5 (192 bit key, 16 byte blocks): 	59843	60506	1.1
test 6 (192 bit key, 64 byte blocks):	61808	62521	1.2
test 7 (192 bit key, 256 byte blocks):	60800	61445	1.1
test 8 (192 bit key, 1024 byte blocks):	56949	57513	1.0
test 9 (192 bit key, 8192 byte blocks): 31890	32107	0.7
test 10 (256 bit key, 16 byte blocks):	62109	62778	1.1
test 11 (256 bit key, 64 byte blocks):	61748	62418	1.1
test 12 (256 bit key, 256 byte blocks):	60604	61226	1.0
test 13 (256 bit key, 1024 byte blocks):56277	56845	1.0
test 14 (256 bit key, 8192 byte blocks):30165	30340	0.6
sync xts(aes) encrypt
test 0 (256 bit key, 16 byte blocks):	59501	59742	0.4
test 1 (256 bit key, 64 byte blocks):	62894	63249	0.6
test 2 (256 bit key, 256 byte blocks):	62074	62476	0.7
test 3 (256 bit key, 1024 byte blocks):	58569	58894	0.6
test 4 (256 bit key, 8192 byte blocks):	35271	35462	0.5
test 5 (512 bit key, 16 byte blocks):	60749	61174	0.7
test 6 (512 bit key, 64 byte blocks):	62760	63148	0.6
test 7 (512 bit key, 256 byte blocks):	61625	61928	0.5
test 8 (512 bit key, 1024 byte blocks):	57162	57452	0.5
test 9 (512 bit key, 8192 byte blocks):	30582	30718	0.4
async xts(aes) decrypt
test 0 (256 bit key, 16 byte blocks):	59423	59587	0.3
test 1 (256 bit key, 64 byte blocks):	62849	62974	0.2
test 2 (256 bit key, 256 byte blocks):	61884	62231	0.6
test 3 (256 bit key, 1024 byte blocks):	58402	58699	0.5
test 4 (256 bit key, 8192 byte blocks):	35244	35353	0.3
test 5 (512 bit key, 16 byte blocks):	60693	60882	0.3
test 6 (512 bit key, 64 byte blocks):	62671	62896	0.4
test 7 (512 bit key, 256 byte blocks):	61488	61722	0.4
test 8 (512 bit key, 1024 byte blocks):	57092	57261	0.3
test 9 (512 bit key, 8192 byte blocks):	30572	30655	0.3
sync ctr(aes) encrypt	
test 0 (128 bit key, 16 byte blocks):	59673	9926	0.4
test 1 (128 bit key, 64 byte blocks):	62738	63024	0.5
test 2 (128 bit key, 256 byte blocks):	61841	62171	0.5
test 3 (128 bit key, 1024 byte blocks):	58374	58633	0.4
test 4 (128 bit key, 8192 byte blocks):	35137	35273	0.4
test 5 (192 bit key, 16 byte blocks):	60736	61049	0.5
test 6 (192 bit key, 64 byte blocks):	62718	63081	0.6
test 7 (192 bit key, 256 byte blocks):	61652	61973	0.5
test 8 (192 bit key, 1024 byte blocks):	57709	58002	0.5
test 9 (192 bit key, 8192 byte blocks):	32171	32306	0.4
test 10 (256 bit key, 16 byte blocks):	63000	63428	0.7
test 11 (256 bit key, 64 byte blocks):	62594	63027	0.7
test 12 (256 bit key, 256 byte blocks):	61452	61845	0.6
test 13 (256 bit key, 1024 byte blocks):57019	57346	0.6
test 14 (256 bit key, 8192 byte blocks):30422	30544	0.4
async ctr(aes) decrypt
test 0 (128 bit key, 16 byte blocks):	59488	59994	0.9
test 1 (128 bit key, 64 byte blocks):	62651	63173	0.8
test 2 (128 bit key, 256 byte blocks):	61778	62464	1.1
test 3 (128 bit key, 1024 byte blocks):	58290	58909	1.1
test 4 (128 bit key, 8192 byte blocks):	35115	35358	0.7
test 5 (192 bit key, 16 byte blocks):	60590	61244	1.1
test 6 (192 bit key, 64 byte blocks):	62604	63296	1.1
test 7 (192 bit key, 256 byte blocks):	61540	62199	1.1
test 8 (192 bit key, 1024 byte blocks):	57577	58149	1.0
test 9 (192 bit key, 8192 byte blocks):	32146	32368	0.7
test 10 (256 bit key, 16 byte blocks):	62852	63610	1.2
test 11 (256 bit key, 64 byte blocks):	62523	63276	1.2
test 12 (256 bit key, 256 byte blocks):	61356	62049	1.1
test 13 (256 bit key, 1024 byte blocks):56943	57546	1.1
test 14 (256 bit key, 8192 byte blocks):30399	30593	0.6

Let me know if any more questions or comments.

Thanks,
John

> Will
>
> .
>


