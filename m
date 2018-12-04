Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90031C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267C02146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Y1uvGU6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267C02146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbeLDIiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:38:08 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37300 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbeLDIiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:38:08 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181204083805euoutp011bc7e5879b2766f65ba27c11002760d7~tFGhXjNb31876518765euoutp01w
        for <linux-kernel@vger.kernel.org>; Tue,  4 Dec 2018 08:38:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181204083805euoutp011bc7e5879b2766f65ba27c11002760d7~tFGhXjNb31876518765euoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543912685;
        bh=WGxtswQqn4h66ME4iCiW15yYR9vJ45S5aAsiCuNpQqY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Y1uvGU6JEPevaRa/8QDYfh7bvwdYHnU7Z0HpruhQ/VWRgioWnDzs7DWQxHa1RbPuL
         rEGLN1hAPvwExCCzYnMIey7ESbnQV8gX5FbEdMwkpdna1ctZLWK7AAJuy6plOs5UNJ
         OQryigJGt/Hi8orCMhsg6Iv/0PPMvZsoF+PF/tgo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181204083804eucas1p165844a3c9db9db56b2e3cdc5013e72c0~tFGgl_tAj1670116701eucas1p1Z;
        Tue,  4 Dec 2018 08:38:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 60.4D.04441.CEC360C5; Tue,  4
        Dec 2018 08:38:04 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181204083803eucas1p2d3db2562c83ae4f6d56d2811943e44dd~tFGfu-ipX1273112731eucas1p2i;
        Tue,  4 Dec 2018 08:38:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181204083803eusmtrp169804637468478bd3253004effc5f36e~tFGftAMVJ2288622886eusmtrp1W;
        Tue,  4 Dec 2018 08:38:03 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-c8-5c063cecbf6c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8E.E0.04284.BEC360C5; Tue,  4
        Dec 2018 08:38:03 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181204083803eusmtip2a6d759f5f7d18c87f55bd99f5a8c88ee~tFGfPGk_A0835708357eusmtip2U;
        Tue,  4 Dec 2018 08:38:03 +0000 (GMT)
Subject: Re: [PATCH 5/9] dma-mapping: support highmem in the generic remap
 allocator
To:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <e1567e0d-4724-fb6b-cc22-3a723eec5e0f@samsung.com>
Date:   Tue, 4 Dec 2018 09:38:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <449e0631-aa32-d4a8-9fa9-07234ae1e533@arm.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUhUYRTtm7fMm7GRz9HwopUwhlCUZiQ9UGyCKeZfVqBYko35UHFtRk3L
        yg21wbCaUptMJURzaXNLVBQV9zK3TM0fhpIpyqhjprSQz5flv3PPPYdzLlyGkDdQdkxIRDSn
        jdCEKWgpWdux/v7QvAftd3hybg9rKs5EbGl5u4gtbHZnSxvXRGzl1AjFDtXn0eyv9jNsy+I0
        xc4udZFKiboivwKp9Wu5lLqq6JbaMFqC1A1jibTa1PSBVpsr93qJz0s9ArmwkFhO6+J5SRo8
        +uWHKGreIS7ZYCIT0RN7PZIwgI/C6vMGsR5JGTl+hiCnYBoJwwqCr7nfKWEwI3g4s0huWcyT
        C2Iey3EJgvIRK0FkQjCXZt5cWGNv+JlcumFgGBscCre7TvMaAo8jeJWUjXgNjV1Bv6CneSzD
        nlDY+pjgMYn3QdODTDHv3YX9oH4mQZBYQfej6c0OEuwOZeZKiscEdoCUGsFKYFsYny4Q8VmA
        e8RQk9VICaVVkLOe+Bdbw1xntVjAu6HXkEkKhhQE6blGsTBkIqjJq6MFlTu0dQ5QfCMC74eX
        9S4CfQJWp4ppngZsCaMLVkIJS7hfm0MItAwy0uSC2gmMnS/+xbb0DxJ3kcK47TTjtnOM284x
        /s8tRGQZsuVidOFBnM41grvqrNOE62IigpwvR4ZXoo2X6v3duVyHvg0GtCLMIMVOmVJJ+ckp
        TawuPrwVAUMobGQTTrSfXBaoib/GaSP9tTFhnK4V2TOkwlZ2fcfkBTkO0kRzoRwXxWm3tiJG
        YpeIVNypi26TRpFvVkB/T226l/+ItXdClWHi5KdjHzuchl1QHLhJGqpzfB3P+lYdDLxxJGkI
        WxCkKit7KO3KZ9/FhNeOSpXS595Yib/B3Wep72bkLPhnvHuab93ntPp2RVk7fAfapvqW1cdN
        qecslCVmpUNW93Jq10DRG5VDhbRZQeqCNa4HCK1O8wcdIkI6TgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsVy+t/xe7qvbdhiDLoe6Fm8X9bDaLFy9VEm
        iwX7rS1W7vnBZLHp8TVWi8u75rBZ/D0aaHHwwxNWi5cfT7A4cHqsmbeG0aPrxwxWj81L6j0m
        31jO6LH7ZgObx/t9V9k8Pm+SC2CP0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7Uy
        MlXSt7NJSc3JLEst0rdL0Mu48ew3U8Eb+Yqmye9ZGhjnSncxcnJICJhIfH7wlr2LkYtDSGAp
        o8TWKafYIRIyEienNbBC2MISf651sYHYQgJvGSXmPQ8GsYUFwiT+NK1kAbFFBLIl7u69yAwy
        iFngFqPEvtmfGCGmAjnLTk5jBqliEzCU6HoLMYlXwE5iwaHZYHEWARWJfVN6wDaLCsRITLn8
        mhWiRlDi5MwnYBs4BawlVn3eBBZnFlCX+DPvEjOELS/RvHU2lC0ucevJfKYJjEKzkLTPQtIy
        C0nLLCQtCxhZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgRG5rZjPzfvYLy0MfgQowAHoxIP
        7wwn1hgh1sSy4srcQ4wSHMxKIrx31NhihHhTEiurUovy44tKc1KLDzGaAj03kVlKNDkfmDTy
        SuINTQ3NLSwNzY3Njc0slMR5zxtURgkJpCeWpGanphakFsH0MXFwSjUwmpZaTGpkdL7youuM
        YMb+nwXpOzfIN64JdQiaufkp/9obe/eu1dr9YY1IvsqaNRlX/3NHXF57ojjy1x95z4DFRRJW
        gS1vKou+32eQav+3cdOlLGfGy7P5pSWYlh+e/GKCw2ueo1EN6jsfPZ/38qeD2wm7nLWWR12z
        /PR+rnk+c+ZVFs/fosmf1ZVYijMSDbWYi4oTAbHi/FXiAgAA
X-CMS-MailID: 20181204083803eucas1p2d3db2562c83ae4f6d56d2811943e44dd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181130190639epcas3p2c9a23f5788b7f8eea26ce8d305b5e6f7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181130190639epcas3p2c9a23f5788b7f8eea26ce8d305b5e6f7
References: <20181105121931.13481-1-hch@lst.de>
        <20181105121931.13481-6-hch@lst.de>
        <CGME20181130190639epcas3p2c9a23f5788b7f8eea26ce8d305b5e6f7@epcas3p2.samsung.com>
        <449e0631-aa32-d4a8-9fa9-07234ae1e533@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 2018-11-30 20:05, Robin Murphy wrote:
> On 05/11/2018 12:19, Christoph Hellwig wrote:
>> By using __dma_direct_alloc_pages we can deal entirely with struct page
>> instead of having to derive a kernel virtual address.
>
> Simple enough :)
>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

This patch has landed linux-next yesterday and I've noticed that it
breaks operation of many drivers. The change looked simple, but a stupid
bug managed to slip into the code. After a short investigation I've
noticed that __dma_direct_alloc_pages() doesn't set dma_handle and zero
allocated memory, while dma_direct_alloc_pages() did. The other
difference is the lack of set_memory_decrypted() handling.

Following patch fixes the issue, but maybe it would be better to fix it
in kernel/dma/direct.c:

diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index dcc82dd668f8..7765ddc56e4e 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -219,8 +219,14 @@ void *arch_dma_alloc(struct device *dev, size_t
size, dma_addr_t *dma_handle,
        ret = dma_common_contiguous_remap(page, size, VM_USERMAP,
                        arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs),
                        __builtin_return_address(0));
-       if (!ret)
+       if (!ret) {
                __dma_direct_free_pages(dev, size, page);
+               return ret;
+       }
+
+       *dma_handle = phys_to_dma(dev, page_to_phys(page));
+       memset(ret, 0, size);
+
        return ret;
 }

>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   kernel/dma/remap.c | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
>> index bc42766f52df..8f1fca34b894 100644
>> --- a/kernel/dma/remap.c
>> +++ b/kernel/dma/remap.c
>> @@ -196,7 +196,7 @@ void *arch_dma_alloc(struct device *dev, size_t
>> size, dma_addr_t *dma_handle,
>>           gfp_t flags, unsigned long attrs)
>>   {
>>       struct page *page = NULL;
>> -    void *ret, *kaddr;
>> +    void *ret;
>>         size = PAGE_ALIGN(size);
>>   @@ -208,10 +208,9 @@ void *arch_dma_alloc(struct device *dev,
>> size_t size, dma_addr_t *dma_handle,
>>           return ret;
>>       }
>>   -    kaddr = dma_direct_alloc_pages(dev, size, dma_handle, flags,
>> attrs);
>> -    if (!kaddr)
>> +    page = __dma_direct_alloc_pages(dev, size, dma_handle, flags,
>> attrs);
>> +    if (!page)
>>           return NULL;
>> -    page = virt_to_page(kaddr);
>>         /* remove any dirty cache lines on the kernel alias */
>>       arch_dma_prep_coherent(page, size);
>> @@ -221,7 +220,7 @@ void *arch_dma_alloc(struct device *dev, size_t
>> size, dma_addr_t *dma_handle,
>>               arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs),
>>               __builtin_return_address(0));
>>       if (!ret)
>> -        dma_direct_free_pages(dev, size, kaddr, *dma_handle, attrs);
>> +        __dma_direct_free_pages(dev, size, page);
>>       return ret;
>>   }
>>   @@ -229,10 +228,11 @@ void arch_dma_free(struct device *dev, size_t
>> size, void *vaddr,
>>           dma_addr_t dma_handle, unsigned long attrs)
>>   {
>>       if (!dma_free_from_pool(vaddr, PAGE_ALIGN(size))) {
>> -        void *kaddr = phys_to_virt(dma_to_phys(dev, dma_handle));
>> +        phys_addr_t phys = dma_to_phys(dev, dma_handle);
>> +        struct page *page = pfn_to_page(__phys_to_pfn(phys));
>>             vunmap(vaddr);
>> -        dma_direct_free_pages(dev, size, kaddr, dma_handle, attrs);
>> +        __dma_direct_free_pages(dev, size, page);
>>       }
>>   }
>>  
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

