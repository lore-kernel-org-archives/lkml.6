Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172F2C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAAC320821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAAC320821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbeLJQcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:32:14 -0500
Received: from foss.arm.com ([217.140.101.70]:58194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbeLJQcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:32:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41A2C1596;
        Mon, 10 Dec 2018 08:32:10 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E9753F6A8;
        Mon, 10 Dec 2018 08:32:08 -0800 (PST)
Subject: Re: [PATCH v3 2/9] arch/arm/mm/dma-mapping.c: Convert to use
 vm_insert_range
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        iamjoonsoo.kim@lge.com, treding@nvidia.com,
        Kees Cook <keescook@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org
References: <20181206184103.GA25872@jordon-HP-15-Notebook-PC>
 <CAFqt6zY9JjGhedtmhYh-+mxSMrYs6P5vtQDMSzCfL02CbLys=g@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <217b80f9-e02c-d02c-3c82-425c550e4ed7@arm.com>
Date:   Mon, 10 Dec 2018 16:32:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAFqt6zY9JjGhedtmhYh-+mxSMrYs6P5vtQDMSzCfL02CbLys=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2018 20:01, Souptick Joarder wrote:
> Hi Robin,
> 
> On Fri, Dec 7, 2018 at 12:07 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>
>> Convert to use vm_insert_range() to map range of kernel
>> memory to user vma.
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> ---
>>   arch/arm/mm/dma-mapping.c | 21 +++++++--------------
>>   1 file changed, 7 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>> index 661fe48..4eec323 100644
>> --- a/arch/arm/mm/dma-mapping.c
>> +++ b/arch/arm/mm/dma-mapping.c
>> @@ -1582,31 +1582,24 @@ static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma
>>                      void *cpu_addr, dma_addr_t dma_addr, size_t size,
>>                      unsigned long attrs)
>>   {
>> -       unsigned long uaddr = vma->vm_start;
>> -       unsigned long usize = vma->vm_end - vma->vm_start;
>> +       unsigned long page_count = vma_pages(vma);
>>          struct page **pages = __iommu_get_pages(cpu_addr, attrs);
>>          unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
>>          unsigned long off = vma->vm_pgoff;
>> +       int err;
>>
>>          if (!pages)
>>                  return -ENXIO;
>>
>> -       if (off >= nr_pages || (usize >> PAGE_SHIFT) > nr_pages - off)
>> +       if (off >= nr_pages || page_count > nr_pages - off)
>>                  return -ENXIO;
>>
>>          pages += off;
>> +       err = vm_insert_range(vma, vma->vm_start, pages, page_count);
> 
> Just to clarify, do we need to adjust page_count with vma->vm_pgoff as
> original code
> have not consider it and run the loop for entire range irrespective of
> vma->vm_pgoff value ?

In this instance, page_count is the size of the VMA, not the size of the 
pages array itself, so as I understand things this patch is true to the 
original code as-is.

Robin.

> 
>> +       if (err)
>> +               pr_err("Remapping memory failed: %d\n", err);
>>
>> -       do {
>> -               int ret = vm_insert_page(vma, uaddr, *pages++);
>> -               if (ret) {
>> -                       pr_err("Remapping memory failed: %d\n", ret);
>> -                       return ret;
>> -               }
>> -               uaddr += PAGE_SIZE;
>> -               usize -= PAGE_SIZE;
>> -       } while (usize > 0);
>> -
>> -       return 0;
>> +       return err;
>>   }
>>   static int arm_iommu_mmap_attrs(struct device *dev,
>>                  struct vm_area_struct *vma, void *cpu_addr,
>> --
>> 1.9.1
>>
