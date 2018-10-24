Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E651C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98B2205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3RQ3YDzo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98B2205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeJYAeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 20:34:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55974 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbeJYAeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 20:34:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9OG4R6a117844;
        Wed, 24 Oct 2018 16:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=6agoU7alTHiWAx6DoRytImdcajTbjXamv5ky2Y6SWPo=;
 b=3RQ3YDzoAet0rdMxjVjg4C5rNQlYw+RxnHMUJA95BohzFjq5FWgfTWcXsQK4j2kBMBrK
 E3EfZzYKnOpNGUYfMVfg5x90VKMKfv5ehd/B/2KACEtFo3EDhh63y3dKROIBXy27AzK7
 NIgb/yYqOovZf/MJmAjxwbdLVkMOrTJrjJK9r3L16RHUZ+c31zWqkqU3wpgp1UCnx1zi
 O+Z4Z2Nn90DaN771Xdf9kmVUiJcAQsUVLi3uHSCy9NCSklRHVC8dM30Bya5wB/7cTGeb
 jprEN4tAI6J3Av8ZbcFLlyfmMENY9VBSp+mdgmbJ90I51KQYQfGbXs6xJL++UiibtmZJ Ng== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2n7vaq4kj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 16:05:32 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9OG5VUo007121
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 16:05:31 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9OG5V1S007440;
        Wed, 24 Oct 2018 16:05:31 GMT
Received: from [10.211.46.5] (/10.211.46.5)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Oct 2018 09:05:31 -0700
Subject: Re: [PATCH] xen-swiotlb: exchange memory with Xen only when pages are
 contiguous
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     "DONGLI.ZHANG" <dongli.zhang@oracle.com>, konrad@kernel.org,
        Christoph Helwig <hch@lst.de>,
        John Sobecki <john.sobecki@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org\"" <linux-kernel@vger.kernel.org>
References: <bb6d87b4-c371-c6c0-8c48-bc95df018ad1@oracle.com>
 <20181024130246.GA22616@localhost.localdomain>
From:   Joe Jin <joe.jin@oracle.com>
Message-ID: <b6f5e6e3-0536-d8e1-d100-aaa7f944731d@oracle.com>
Date:   Wed, 24 Oct 2018 09:05:30 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181024130246.GA22616@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9055 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810240137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/18 6:02 AM, Konrad Rzeszutek Wilk wrote:
> On Tue, Oct 23, 2018 at 08:09:04PM -0700, Joe Jin wrote:
>> Commit 4855c92dbb7 "xen-swiotlb: fix the check condition for
>> xen_swiotlb_free_coherent" only fixed memory address check condition
>> on xen_swiotlb_free_coherent(), when memory was not physically
>> contiguous and tried to exchanged with Xen via 
>> xen_destroy_contiguous_region it will lead kernel panic.
> 
> s/it will lead/which lead to/?
> 
>>
>> The correct check condition should be memory is in DMA area and
>> physically contiguous.
> 
> "The correct check condition to make Xen hypercall to revert the
> memory back from its 32-bit pool is if it is:
>  1) Above its DMA bit mask (for example 32-bit devices can only address
> up to 4GB, and we may want 4GB+2K), and
>  2) If it not physically contingous

Here should be physically contiguous? on allocating, it asked physically
contiguous memory for DMA, if not contiguous, it can not do DMA,
am I right?

Andy range_straddles_page_boundary() return 0 means is physically contiguous,
is that correct?

Thanks,
Joe

> 
> N.B. The logic in the code is inverted, which leads to all sorts of
> confusions."
> 
> Does that sound correct?
> 
>>
>> Thank you Boris for pointing it out.
>>
> 
> Fixes: 4855c92dbb7 ("xen-sw..") ?
> 
>> Signed-off-by: Joe Jin <joe.jin@oracle.com>
>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> 
> Reported-by: Boris Ostrovs... ?
>> Cc: Christoph Helwig <hch@lst.de>
>> Cc: Dongli Zhang <dongli.zhang@oracle.com>
>> Cc: John Sobecki <john.sobecki@oracle.com>
>> ---
>>  drivers/xen/swiotlb-xen.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
>> index f5c1af4ce9ab..aed92fa019f9 100644
>> --- a/drivers/xen/swiotlb-xen.c
>> +++ b/drivers/xen/swiotlb-xen.c
>> @@ -357,8 +357,8 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
>>  	/* Convert the size to actually allocated. */
>>  	size = 1UL << (order + XEN_PAGE_SHIFT);
>>  
>> -	if (((dev_addr + size - 1 <= dma_mask)) ||
>> -	    range_straddles_page_boundary(phys, size))
>> +	if ((dev_addr + size - 1 <= dma_mask) &&
>> +	    !range_straddles_page_boundary(phys, size))
>>  		xen_destroy_contiguous_region(phys, order);
>>  
>>  	xen_free_coherent_pages(hwdev, size, vaddr, (dma_addr_t)phys, attrs);
>> -- 
>> 2.17.1 (Apple Git-112)
>>
