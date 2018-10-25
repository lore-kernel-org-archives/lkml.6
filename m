Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B191BC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5AB20848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RaOLnPng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D5AB20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbeJZAnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:43:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54810 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbeJZAns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:43:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9PG8Zp0037010;
        Thu, 25 Oct 2018 16:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=VeSa+x32gmkkdqtJBHd4XUZyVsVGAAlORy1PRDPnEgM=;
 b=RaOLnPngTjMZe8gQYqQEuN2vcZsWUoaPWdr5H4dIA+KhZQwhEgMwOFlbK7WjrB68CaSX
 AIlhcngRNV9hnBBPED54OePmMpJ+VZCmY7v0nSv53tEajYXtpmZWl7/ng62TeyiLI62L
 QOb08wB6BaAL32i5TdkWwCM1XD6yeetsTmlWnVFsbon32zhSs92rU6c08Z2YMIRpN8qe
 MAzVpYk6GvyU1QK6GdXkwMtv8gNy/c1uCZuktVk4zPgZx24PgBJzSVMeOjCDbYlO+TXB
 C4w4iFjFiA0z5G9ezLO//R40gg1q3UOJPf2hi2CD4TI5wHAthnn8c83Z5Zr/7Da8UC2s EA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2n7w0r2m6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Oct 2018 16:10:17 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9PGAGlT015009
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Oct 2018 16:10:16 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9PGAFr1018687;
        Thu, 25 Oct 2018 16:10:16 GMT
Received: from dhcp-burlington7-2nd-B-east-10-152-55-162.usdhcp.oraclecorp.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Oct 2018 09:10:15 -0700
Subject: Re: [PATCH] xen-swiotlb: exchange memory with Xen only when pages are
 contiguous
To:     Joe Jin <joe.jin@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     "DONGLI.ZHANG" <dongli.zhang@oracle.com>, konrad@kernel.org,
        Christoph Helwig <hch@lst.de>,
        John Sobecki <john.sobecki@oracle.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org\"" <linux-kernel@vger.kernel.org>
References: <bb6d87b4-c371-c6c0-8c48-bc95df018ad1@oracle.com>
 <20181024130246.GA22616@localhost.localdomain>
 <83900cf4-690c-9725-d022-d427fdeb4f7d@oracle.com>
 <581cb7ea-3112-791d-918d-9bb887e4744f@oracle.com>
 <24a62522-1629-5d0b-398e-6d2c1a0b97f7@oracle.com>
 <922914c9-22db-c5d1-33da-d07691ebd7d7@oracle.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <a47fabe8-53d1-47b8-0efc-f9f1e5b4898a@oracle.com>
Date:   Thu, 25 Oct 2018 12:10:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <922914c9-22db-c5d1-33da-d07691ebd7d7@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9056 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810250135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/18 10:23 AM, Joe Jin wrote:
> On 10/25/18 4:45 AM, Boris Ostrovsky wrote:
>> On 10/24/18 10:43 AM, Joe Jin wrote:
>>> On 10/24/18 6:57 AM, Boris Ostrovsky wrote:
>>>> On 10/24/18 9:02 AM, Konrad Rzeszutek Wilk wrote:
>>>>> On Tue, Oct 23, 2018 at 08:09:04PM -0700, Joe Jin wrote:
>>>>>> Commit 4855c92dbb7 "xen-swiotlb: fix the check condition for
>>>>>> xen_swiotlb_free_coherent" only fixed memory address check condition
>>>>>> on xen_swiotlb_free_coherent(), when memory was not physically
>>>>>> contiguous and tried to exchanged with Xen via 
>>>>>> xen_destroy_contiguous_region it will lead kernel panic.
>>>>> s/it will lead/which lead to/?
>>>>>
>>>>>> The correct check condition should be memory is in DMA area and
>>>>>> physically contiguous.
>>>>> "The correct check condition to make Xen hypercall to revert the
>>>>> memory back from its 32-bit pool is if it is:
>>>>>  1) Above its DMA bit mask (for example 32-bit devices can only address
>>>>> up to 4GB, and we may want 4GB+2K), and
>>>> Is this "and' or 'or'?
>>>>
>>>>>  2) If it not physically contingous
>>>>>
>>>>> N.B. The logic in the code is inverted, which leads to all sorts of
>>>>> confusions."
>>>> I would, in fact, suggest to make the logic the same in both
>>>> xen_swiotlb_alloc_coherent() and xen_swiotlb_free_coherent() to avoid
>>>> this. This will involve swapping if and else in the former.
>>>>
>>>>
>>>>> Does that sound correct?
>>>>>
>>>>>> Thank you Boris for pointing it out.
>>>>>>
>>>>> Fixes: 4855c92dbb7 ("xen-sw..") ?
>>>>>
>>>>>> Signed-off-by: Joe Jin <joe.jin@oracle.com>
>>>>>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>>>>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>>>>> Reported-by: Boris Ostrovs... ?
>>>>>> Cc: Christoph Helwig <hch@lst.de>
>>>>>> Cc: Dongli Zhang <dongli.zhang@oracle.com>
>>>>>> Cc: John Sobecki <john.sobecki@oracle.com>
>>>>>> ---
>>>>>>  drivers/xen/swiotlb-xen.c | 4 ++--
>>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
>>>>>> index f5c1af4ce9ab..aed92fa019f9 100644
>>>>>> --- a/drivers/xen/swiotlb-xen.c
>>>>>> +++ b/drivers/xen/swiotlb-xen.c
>>>>>> @@ -357,8 +357,8 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
>>>>>>  	/* Convert the size to actually allocated. */
>>>>>>  	size = 1UL << (order + XEN_PAGE_SHIFT);
>>>>>>  
>>>>>> -	if (((dev_addr + size - 1 <= dma_mask)) ||
>>>>>> -	    range_straddles_page_boundary(phys, size))
>>>>>> +	if ((dev_addr + size - 1 <= dma_mask) &&
>>>>>> +	    !range_straddles_page_boundary(phys, size))
>>>>>>  		xen_destroy_contiguous_region(phys, order);
>>>> I don't think this is right.
>>>>
>>>> if ((dev_addr + size - 1 > dma_mask) || range_straddles_page_boundary(phys, size))
>>>>
>>>> No?
>>> No this is not correct.
>>>
>>> When allocate memory, it tried to allocated from Dom0/Guest, then check if physical
>>> address is DMA memory also contiguous, if no, exchange with Hypervisor, code as below:
>>>
>>> 326         phys = *dma_handle;                                                     
>>> 327         dev_addr = xen_phys_to_bus(phys);                                       
>>> 328         if (((dev_addr + size - 1 <= dma_mask)) &&                              
>>> 329             !range_straddles_page_boundary(phys, size))                         
>>> 330                 *dma_handle = dev_addr;                                         
>>> 331         else {                                                                  
>>> 332                 if (xen_create_contiguous_region(phys, order,                   
>>> 333                                                  fls64(dma_mask), dma_handle) != 0) {
>>> 334                         xen_free_coherent_pages(hwdev, size, ret, (dma_addr_t)phys, attrs);
>>> 335                         return NULL;                                            
>>> 336                 }                                                               
>>> 337         }                                                                       
>>>                                                                      
>>>
>>> On freeing, need to return the memory to Xen, otherwise DMA memory will be used
>>> up(this is the issue the patch intend to fix), so when memory is DMAable and
>>> contiguous then call xen_destroy_contiguous_region(), return DMA memory to Xen.
>> So if you want to allocate 1 byte at address 0 (and dev_addr=phys),
>> xen_create_contiguous_region() will not be called. And yet you will call
>> xen_destroy_contiguous_region() in the free path.
>>
>> Is this the expected behavior?
> I could not say it's expected behavior, but I think it's reasonable.

I would expect xen_create_contiguous_region() and
xen_destroy_contiguous_region() to come in pairs. If a region is
created, it needs to be destroyed. And vice versa.


>
> On allocating, it used __get_free_pages() to allocate memory, if lucky the memory is 
> DMAable, will not exchange memory with hypervisor, obviously this is not guaranteed.
>
> And on freeing it could not be identified if memory from Dom0/guest own memory
> or hypervisor


I think it can be. if (!(dev_addr + size - 1 <= dma_mask) ||
range_straddles_page_boundary()) then it must have come from the
hypervisor, because that's the check we make in
xen_swiotlb_alloc_coherent().


-boris


> , if don't back memory to hypervisor which will lead hypervisor DMA 
> memory be used up, then on Dom0/guest, DMA request maybe failed, the worse thing is
> could not start any new guest.
>
> Thanks,
> Joe
>
>> -boris
>>

