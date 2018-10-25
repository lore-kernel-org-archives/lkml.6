Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55A3C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8B32082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xx9xbOnh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8B32082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbeJZDaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:30:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37774 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbeJZDaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:30:11 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9PImmV5026039;
        Thu, 25 Oct 2018 18:56:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=eRCZtFilEXCLjZ184vIqaC85sbQy3WfOEarMPjaubZ4=;
 b=Xx9xbOnhuE9EuPD5VybQSXguX877O1lTRqiKd0skatwzf3xFEqHSX9jITv/iUfY3BRnU
 I6D2hsOdR4NHnS7mhV2DS0B6kwvCBOZZEHKQvtTEtzyancyxhrc2S1hbd9ur0dWF3XqK
 RvqcyXQxBRb+i0Or1OMvnaIB3MkLRRIY/wqsCh6liaggseRjvPRfpPxrVxehaggNwgTS
 w/v7Kt7Hkw+pS134w8hHoMLfY5X2FfuvEnc7vnkLwt52N40j6C79Gxo02uvJSupiDdFH
 Yv5pFub5b6IOLVm+OBHaY9tO1WwCp419kwwXSXZTalZTgyVarrjZ8r4UJZqebMt0BDHf xA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2n7vaqbenn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Oct 2018 18:56:06 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9PIu5PM014030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Oct 2018 18:56:05 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9PIu3kd019128;
        Thu, 25 Oct 2018 18:56:03 GMT
Received: from [10.211.47.88] (/10.211.47.88)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Oct 2018 11:56:03 -0700
Subject: Re: [PATCH] xen-swiotlb: exchange memory with Xen only when pages are
 contiguous
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
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
 <a47fabe8-53d1-47b8-0efc-f9f1e5b4898a@oracle.com>
 <45f5ffe8-3f48-4485-53f0-5a056be69b0c@oracle.com>
From:   Joe Jin <joe.jin@oracle.com>
Message-ID: <5b64850f-9142-0360-fe4e-9e7bc74d2368@oracle.com>
Date:   Thu, 25 Oct 2018 11:56:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <45f5ffe8-3f48-4485-53f0-5a056be69b0c@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9057 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810250156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I just discussed this patch with Boris in private, his opinions(Boris,
please correct me if any misunderstood) are:

1. With/without the check, both are incorrect, he thought we need to
   prevented unalloc'd free at here. 
2. On freeing, if upper layer already checked the memory was DMA-able,
   the checking at here does not make sense, we can remove all checks.
3. xen_create_contiguous_region() and xen_destroy_contiguous_region()
   to come in pairs.

For #1 and #3, I think we need something associate it, like a list, on
allocating, add addr to it, on freeing, check if in the list.

For #2, I'm was not found anywhere validated the address on 
dma_free_coherent() callpath, not just xen-swiotlb.

From my side, I think the checks are make sense, it prevented to exchange
non-contiguous memory with Xen also make sure Xen has enough DMA memory
for DMA also for guest creation. I'm not sure if we can merge this patch
to avoid exchanged non-contiguous memory with Xen?

Any input will appreciate.

Thanks,
Joe 

On 10/25/18 9:28 AM, Joe Jin wrote:
> On 10/25/18 9:10 AM, Boris Ostrovsky wrote:
>> On 10/25/18 10:23 AM, Joe Jin wrote:
>>> On 10/25/18 4:45 AM, Boris Ostrovsky wrote:
>>>> On 10/24/18 10:43 AM, Joe Jin wrote:
>>>>> On 10/24/18 6:57 AM, Boris Ostrovsky wrote:
>>>>>> On 10/24/18 9:02 AM, Konrad Rzeszutek Wilk wrote:
>>>>>>> On Tue, Oct 23, 2018 at 08:09:04PM -0700, Joe Jin wrote:
>>>>>>>> Commit 4855c92dbb7 "xen-swiotlb: fix the check condition for
>>>>>>>> xen_swiotlb_free_coherent" only fixed memory address check condition
>>>>>>>> on xen_swiotlb_free_coherent(), when memory was not physically
>>>>>>>> contiguous and tried to exchanged with Xen via 
>>>>>>>> xen_destroy_contiguous_region it will lead kernel panic.
>>>>>>> s/it will lead/which lead to/?
>>>>>>>
>>>>>>>> The correct check condition should be memory is in DMA area and
>>>>>>>> physically contiguous.
>>>>>>> "The correct check condition to make Xen hypercall to revert the
>>>>>>> memory back from its 32-bit pool is if it is:
>>>>>>>  1) Above its DMA bit mask (for example 32-bit devices can only address
>>>>>>> up to 4GB, and we may want 4GB+2K), and
>>>>>> Is this "and' or 'or'?
>>>>>>
>>>>>>>  2) If it not physically contingous
>>>>>>>
>>>>>>> N.B. The logic in the code is inverted, which leads to all sorts of
>>>>>>> confusions."
>>>>>> I would, in fact, suggest to make the logic the same in both
>>>>>> xen_swiotlb_alloc_coherent() and xen_swiotlb_free_coherent() to avoid
>>>>>> this. This will involve swapping if and else in the former.
>>>>>>
>>>>>>
>>>>>>> Does that sound correct?
>>>>>>>
>>>>>>>> Thank you Boris for pointing it out.
>>>>>>>>
>>>>>>> Fixes: 4855c92dbb7 ("xen-sw..") ?
>>>>>>>
>>>>>>>> Signed-off-by: Joe Jin <joe.jin@oracle.com>
>>>>>>>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>>>>>>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>>>>>>> Reported-by: Boris Ostrovs... ?
>>>>>>>> Cc: Christoph Helwig <hch@lst.de>
>>>>>>>> Cc: Dongli Zhang <dongli.zhang@oracle.com>
>>>>>>>> Cc: John Sobecki <john.sobecki@oracle.com>
>>>>>>>> ---
>>>>>>>>  drivers/xen/swiotlb-xen.c | 4 ++--
>>>>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
>>>>>>>> index f5c1af4ce9ab..aed92fa019f9 100644
>>>>>>>> --- a/drivers/xen/swiotlb-xen.c
>>>>>>>> +++ b/drivers/xen/swiotlb-xen.c
>>>>>>>> @@ -357,8 +357,8 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
>>>>>>>>  	/* Convert the size to actually allocated. */
>>>>>>>>  	size = 1UL << (order + XEN_PAGE_SHIFT);
>>>>>>>>  
>>>>>>>> -	if (((dev_addr + size - 1 <= dma_mask)) ||
>>>>>>>> -	    range_straddles_page_boundary(phys, size))
>>>>>>>> +	if ((dev_addr + size - 1 <= dma_mask) &&
>>>>>>>> +	    !range_straddles_page_boundary(phys, size))
>>>>>>>>  		xen_destroy_contiguous_region(phys, order);
>>>>>> I don't think this is right.
>>>>>>
>>>>>> if ((dev_addr + size - 1 > dma_mask) || range_straddles_page_boundary(phys, size))
>>>>>>
>>>>>> No?
>>>>> No this is not correct.
>>>>>
>>>>> When allocate memory, it tried to allocated from Dom0/Guest, then check if physical
>>>>> address is DMA memory also contiguous, if no, exchange with Hypervisor, code as below:
>>>>>
>>>>> 326         phys = *dma_handle;                                                     
>>>>> 327         dev_addr = xen_phys_to_bus(phys);                                       
>>>>> 328         if (((dev_addr + size - 1 <= dma_mask)) &&                              
>>>>> 329             !range_straddles_page_boundary(phys, size))                         
>>>>> 330                 *dma_handle = dev_addr;                                         
>>>>> 331         else {                                                                  
>>>>> 332                 if (xen_create_contiguous_region(phys, order,                   
>>>>> 333                                                  fls64(dma_mask), dma_handle) != 0) {
>>>>> 334                         xen_free_coherent_pages(hwdev, size, ret, (dma_addr_t)phys, attrs);
>>>>> 335                         return NULL;                                            
>>>>> 336                 }                                                               
>>>>> 337         }                                                                       
>>>>>                                                                      
>>>>>
>>>>> On freeing, need to return the memory to Xen, otherwise DMA memory will be used
>>>>> up(this is the issue the patch intend to fix), so when memory is DMAable and
>>>>> contiguous then call xen_destroy_contiguous_region(), return DMA memory to Xen.
>>>> So if you want to allocate 1 byte at address 0 (and dev_addr=phys),
>>>> xen_create_contiguous_region() will not be called. And yet you will call
>>>> xen_destroy_contiguous_region() in the free path.
>>>>
>>>> Is this the expected behavior?
>>> I could not say it's expected behavior, but I think it's reasonable.
>>
>> I would expect xen_create_contiguous_region() and
>> xen_destroy_contiguous_region() to come in pairs. If a region is
>> created, it needs to be destroyed. And vice versa.
>>
>>
>>>
>>> On allocating, it used __get_free_pages() to allocate memory, if lucky the memory is 
>>> DMAable, will not exchange memory with hypervisor, obviously this is not guaranteed.
>>>
>>> And on freeing it could not be identified if memory from Dom0/guest own memory
>>> or hypervisor
>>
>>
>> I think it can be. if (!(dev_addr + size - 1 <= dma_mask) ||
>> range_straddles_page_boundary()) then it must have come from the
>> hypervisor, because that's the check we make in
>> xen_swiotlb_alloc_coherent().
> 
> This is not true.
> 
> dev_addr was came from dma_handle, *dma_handle will be changed  after called
> xen_create_contiguous_region():
> 
> 2590 int xen_create_contiguous_region(phys_addr_t pstart, unsigned int order,        
> 2591                                  unsigned int address_bits,                     
> 2592                                  dma_addr_t *dma_handle)                        
> 2593 {                                                                               
> ......
> 2617         success = xen_exchange_memory(1UL << order, 0, in_frames,               
> 2618                                       1, order, &out_frame,                     
> 2619                                       address_bits);                            
> 2620                                                                                 
> 2621         /* 3. Map the new extent in place of old pages. */                      
> 2622         if (success)                                                            
> 2623                 xen_remap_exchanged_ptes(vstart, order, NULL, out_frame);       
> 2624         else                                                                    
> 2625                 xen_remap_exchanged_ptes(vstart, order, in_frames, 0);          
> 2626                                                                                 
> 2627         spin_unlock_irqrestore(&xen_reservation_lock, flags);                   
> 2628                                                                                 
> 2629         *dma_handle = virt_to_machine(vstart).maddr;                            
> 2630         return success ? 0 : -ENOMEM;                                           
> 2631 }                                                                               
> 
> 
> So means dev_addr check on xen_swiotlb_alloc_coherent() is not same one on
> xen_swiotlb_free_coherent().
> 
> Thanks,
> Joe
> 
> 
>>
>>
>> -boris
>>
>>
>>> , if don't back memory to hypervisor which will lead hypervisor DMA 
>>> memory be used up, then on Dom0/guest, DMA request maybe failed, the worse thing is
>>> could not start any new guest.
>>>
>>> Thanks,
>>> Joe
>>>
>>>> -boris
>>>>
>>


-- 
Oracle <http://www.oracle.com>
Joe Jin | Software Development Director 
ORACLE | Linux and Virtualization
500 Oracle Parkway Redwood City, CA US 94065
