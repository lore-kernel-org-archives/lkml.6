Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4077C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FC821852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbeLRQW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:22:59 -0500
Received: from mga14.intel.com ([192.55.52.115]:31017 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbeLRQW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:22:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 08:22:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,368,1539673200"; 
   d="scan'208";a="102477418"
Received: from kohsamui.iil.intel.com (HELO [10.236.193.12]) ([10.236.193.12])
  by orsmga008.jf.intel.com with ESMTP; 18 Dec 2018 08:22:55 -0800
Subject: Re: [PATCH v3] staging: android: ion: Add implementation of
 dma_buf_vmap and dma_buf_vunmap
To:     Liam Mark <lmark@codeaurora.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, tkjos@android.com, rve@android.com,
        linux-kernel@vger.kernel.org, maco@android.com,
        sumit.semwal@linaro.org
References: <1517400222-2854-1-git-send-email-alexey.skidanov@intel.com>
 <20180131130047.GA22917@kroah.com>
 <89be45dd-ac0e-4efb-2b21-e6c07b0cd66e@intel.com>
 <bf909d75-21a4-9d6d-2f72-887492821252@redhat.com>
 <7d836085-cd8d-300b-56be-e8db4ff37afc@intel.com>
 <alpine.DEB.2.10.1812152119130.2951@lmark-linux.qualcomm.com>
 <67f288db-d9ea-2d45-ddcf-a15dbff316f5@intel.com>
 <alpine.DEB.2.10.1812171036080.23226@lmark-linux.qualcomm.com>
From:   Alexey Skidanov <alexey.skidanov@intel.com>
Message-ID: <3740948f-02be-cf7a-bc41-54b4fd195103@intel.com>
Date:   Tue, 18 Dec 2018 18:24:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1812171036080.23226@lmark-linux.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/17/18 20:42, Liam Mark wrote:
> On Sun, 16 Dec 2018, Alexey Skidanov wrote:
> 
>>
>>
>> On 12/16/18 7:20 AM, Liam Mark wrote:
>>> On Tue, 6 Feb 2018, Alexey Skidanov wrote:
>>>
>>>>
>>>>
>>>> On 02/07/2018 01:56 AM, Laura Abbott wrote:
>>>>> On 01/31/2018 10:10 PM, Alexey Skidanov wrote:
>>>>>>
>>>>>> On 01/31/2018 03:00 PM, Greg KH wrote:
>>>>>>> On Wed, Jan 31, 2018 at 02:03:42PM +0200, Alexey Skidanov wrote:
>>>>>>>> Any driver may access shared buffers, created by ion, using
>>>>>>>> dma_buf_vmap and
>>>>>>>> dma_buf_vunmap dma-buf API that maps/unmaps previosuly allocated
>>>>>>>> buffers into
>>>>>>>> the kernel virtual address space. The implementation of these API is
>>>>>>>> missing in
>>>>>>>> the current ion implementation.
>>>>>>>>
>>>>>>>> Signed-off-by: Alexey Skidanov <alexey.skidanov@intel.com>
>>>>>>>> ---
>>>>>>>
>>>>>>> No review from any other Intel developers? :(
>>>>>> Will add.
>>>>>>>
>>>>>>> Anyway, what in-tree driver needs access to these functions?
>>>>>> I'm not sure that there are the in-tree drivers using these functions
>>>>>> and ion as> buffer exporter because they are not implemented in ion :)
>>>>>> But there are some in-tre> drivers using these APIs (gpu drivers) with
>>>>>> other buffer exporters.
>>>>>
>>>>> It's still not clear why you need to implement these APIs.
>>>> How the importing kernel module may access the content of the buffer? :)
>>>> With the current ion implementation it's only possible by dma_buf_kmap,
>>>> mapping one page at a time. For pretty large buffers, it might have some
>>>> performance impact.
>>>> (Probably, the page by page mapping is the only way to access large
>>>> buffers on 32 bit systems, where the vmalloc range is very small. By the
>>>> way, the current ion dma_map_kmap doesn't really map only 1 page at a
>>>> time - it uses the result of vmap() that might fail on 32 bit systems.)
>>>>
>>>>> Are you planning to use Ion with GPU drivers? I'm especially
>>>>> interested in this if you have a non-Android use case.
>>>> Yes, my use case is the non-Android one. But not with GPU drivers.
>>>>>
>>>>> Thanks,
>>>>> Laura
>>>>
>>>> Thanks,
>>>> Alexey
>>>
>>> I was wondering if we could re-open the discussion on adding support to 
>>> ION for dma_buf_vmap.
>>> It seems like the patch was not taken as the reviewers wanted more 
>>> evidence of an upstream use case.
>>>
>>> Here would be my upstream usage argument for including dma_buf_vmap 
>>> support in ION.
>>>
>>> Currently all calls to ion_dma_buf_begin_cpu_access result in the creation 
>>> of a kernel mapping for the buffer, unfortunately the resulting call to 
>>> alloc_vmap_area can be quite expensive and this has caused a performance 
>>> regression for certain clients when they have moved to the new version of 
>>> ION.
>>>
>>> The kernel mapping is not actually needed in ion_dma_buf_begin_cpu_access, 
>>> and generally isn't needed by clients. So if we remove the creation of the 
>>> kernel mapping in ion_dma_buf_begin_cpu_access and only create it when 
>>> needed we can speed up the calls to ion_dma_buf_begin_cpu_access.
>>>
>>> An additional benefit of removing the creation of kernel mappings from 
>>> ion_dma_buf_begin_cpu_access is that it makes the ION code more secure.
>>> Currently a malicious client could call the DMA_BUF_IOCTL_SYNC IOCTL with 
>>> flags DMA_BUF_SYNC_END multiple times to cause the ION buffer kmap_cnt to 
>>> go negative which could lead to undesired behavior.
>>>
>>> One disadvantage of the above change is that a kernel mapping is not 
>>> already created when a client calls dma_buf_kmap. So the following 
>>> dma_buf_kmap contract can't be satisfied.
>>>
>>> /**
>>> * dma_buf_kmap - Map a page of the buffer object into kernel address 
>>> space. The
>>> * same restrictions as for kmap and friends apply.
>>> * @dmabuf:	[in]	buffer to map page from.
>>> * @page_num:	[in]	page in PAGE_SIZE units to map.
>>> *
>>> * This call must always succeed, any necessary preparations that might 
>>> fail
>>> * need to be done in begin_cpu_access.
>>> */
>>>
>>> But hopefully we can work around this by moving clients to dma_buf_vmap.
>> I think the problem is with the contract. We can't ensure that the call
>> is always succeeds regardless the implementation - any mapping might
>> fail. Probably this is why  *all* clients of dma_buf_kmap() check the
>> return value (so it's safe to return NULL in case of failure).
>>
> 
> I think currently the call to dma_buf_kmap will always succeed since the 
> DMA-Buf contract requires that the client first successfully call 
> dma_buf_begin_cpu_access(), and if dma_buf_begin_cpu_access() succeeds 
> then dma_buf_kmap will succeed.
> 
>> I would suggest to fix the contract and to keep the dma_buf_kmap()
>> support in ION.
> 
> I will leave it to the DMA-Buf maintainers as to whether they want to 
> change their contract.
> 
> Liam
> 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

Ok. We need the list of the clients using the ION in the mainline tree.

Alexey
