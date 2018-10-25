Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6D3ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAEA220665
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yb8xj1+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAEA220665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbeJYW4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:56:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45054 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbeJYW4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:56:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9PENW4K177620;
        Thu, 25 Oct 2018 14:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=WXrMgic5dyQFEXdU5+9snwRpnQo9WT28NWlfxFKaskw=;
 b=Yb8xj1+0ZVDk+vdQKwwPY6mAwHBQDz7PlktLBJdAw9XPLjKH7wZCr24rWMBPEhSrCC8x
 a6VzKFpb5LnOIAXDgsIMXS227aQHUPKS6Cljrgonp4C+v4kB79s2cb0XqmX04509rGdX
 tH7za6MaeD6Eejqar3C6pxEhJI+fbeCSjTiKqY253sdE3A7avl8r3tJrsVAGUdBGweL7
 tCLDJnx29Cs2swCX0huWfVVz1FuFuXxEA75S+qAVQba10ZA+2x5sBnQPgtyQ5zft/PNT
 AbSMZ4hLaorH1k6v+d8DbWQtg2njF6vpUcjozPgf5a/yzXXTHq7bbpwfIedDi7TMxIXv kA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2n7usuhyw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Oct 2018 14:23:38 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9PENa9J018167
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Oct 2018 14:23:37 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9PENaId030341;
        Thu, 25 Oct 2018 14:23:36 GMT
Received: from [10.211.47.88] (/10.211.47.88)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Oct 2018 07:23:36 -0700
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
From:   Joe Jin <joe.jin@oracle.com>
Message-ID: <922914c9-22db-c5d1-33da-d07691ebd7d7@oracle.com>
Date:   Thu, 25 Oct 2018 07:23:35 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <24a62522-1629-5d0b-398e-6d2c1a0b97f7@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9056 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810250123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/18 4:45 AM, Boris Ostrovsky wrote:
> On 10/24/18 10:43 AM, Joe Jin wrote:
>> On 10/24/18 6:57 AM, Boris Ostrovsky wrote:
>>> On 10/24/18 9:02 AM, Konrad Rzeszutek Wilk wrote:
>>>> On Tue, Oct 23, 2018 at 08:09:04PM -0700, Joe Jin wrote:
>>>>> Commit 4855c92dbb7 "xen-swiotlb: fix the check condition for
>>>>> xen_swiotlb_free_coherent" only fixed memory address check condition
>>>>> on xen_swiotlb_free_coherent(), when memory was not physically
>>>>> contiguous and tried to exchanged with Xen via 
>>>>> xen_destroy_contiguous_region it will lead kernel panic.
>>>> s/it will lead/which lead to/?
>>>>
>>>>> The correct check condition should be memory is in DMA area and
>>>>> physically contiguous.
>>>> "The correct check condition to make Xen hypercall to revert the
>>>> memory back from its 32-bit pool is if it is:
>>>>  1) Above its DMA bit mask (for example 32-bit devices can only address
>>>> up to 4GB, and we may want 4GB+2K), and
>>> Is this "and' or 'or'?
>>>
>>>>  2) If it not physically contingous
>>>>
>>>> N.B. The logic in the code is inverted, which leads to all sorts of
>>>> confusions."
>>>
>>> I would, in fact, suggest to make the logic the same in both
>>> xen_swiotlb_alloc_coherent() and xen_swiotlb_free_coherent() to avoid
>>> this. This will involve swapping if and else in the former.
>>>
>>>
>>>> Does that sound correct?
>>>>
>>>>> Thank you Boris for pointing it out.
>>>>>
>>>> Fixes: 4855c92dbb7 ("xen-sw..") ?
>>>>
>>>>> Signed-off-by: Joe Jin <joe.jin@oracle.com>
>>>>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>>>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>>>> Reported-by: Boris Ostrovs... ?
>>>>> Cc: Christoph Helwig <hch@lst.de>
>>>>> Cc: Dongli Zhang <dongli.zhang@oracle.com>
>>>>> Cc: John Sobecki <john.sobecki@oracle.com>
>>>>> ---
>>>>>  drivers/xen/swiotlb-xen.c | 4 ++--
>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
>>>>> index f5c1af4ce9ab..aed92fa019f9 100644
>>>>> --- a/drivers/xen/swiotlb-xen.c
>>>>> +++ b/drivers/xen/swiotlb-xen.c
>>>>> @@ -357,8 +357,8 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
>>>>>  	/* Convert the size to actually allocated. */
>>>>>  	size = 1UL << (order + XEN_PAGE_SHIFT);
>>>>>  
>>>>> -	if (((dev_addr + size - 1 <= dma_mask)) ||
>>>>> -	    range_straddles_page_boundary(phys, size))
>>>>> +	if ((dev_addr + size - 1 <= dma_mask) &&
>>>>> +	    !range_straddles_page_boundary(phys, size))
>>>>>  		xen_destroy_contiguous_region(phys, order);
>>>
>>> I don't think this is right.
>>>
>>> if ((dev_addr + size - 1 > dma_mask) || range_straddles_page_boundary(phys, size))
>>>
>>> No?
>> No this is not correct.
>>
>> When allocate memory, it tried to allocated from Dom0/Guest, then check if physical
>> address is DMA memory also contiguous, if no, exchange with Hypervisor, code as below:
>>
>> 326         phys = *dma_handle;                                                     
>> 327         dev_addr = xen_phys_to_bus(phys);                                       
>> 328         if (((dev_addr + size - 1 <= dma_mask)) &&                              
>> 329             !range_straddles_page_boundary(phys, size))                         
>> 330                 *dma_handle = dev_addr;                                         
>> 331         else {                                                                  
>> 332                 if (xen_create_contiguous_region(phys, order,                   
>> 333                                                  fls64(dma_mask), dma_handle) != 0) {
>> 334                         xen_free_coherent_pages(hwdev, size, ret, (dma_addr_t)phys, attrs);
>> 335                         return NULL;                                            
>> 336                 }                                                               
>> 337         }                                                                       
>>                                                                      
>>
>> On freeing, need to return the memory to Xen, otherwise DMA memory will be used
>> up(this is the issue the patch intend to fix), so when memory is DMAable and
>> contiguous then call xen_destroy_contiguous_region(), return DMA memory to Xen.
> 
> So if you want to allocate 1 byte at address 0 (and dev_addr=phys),
> xen_create_contiguous_region() will not be called. And yet you will call
> xen_destroy_contiguous_region() in the free path.
> 
> Is this the expected behavior?

I could not say it's expected behavior, but I think it's reasonable.

On allocating, it used __get_free_pages() to allocate memory, if lucky the memory is 
DMAable, will not exchange memory with hypervisor, obviously this is not guaranteed.

And on freeing it could not be identified if memory from Dom0/guest own memory
or hypervisor, if don't back memory to hypervisor which will lead hypervisor DMA 
memory be used up, then on Dom0/guest, DMA request maybe failed, the worse thing is
could not start any new guest.

Thanks,
Joe

> 
> -boris
> 
