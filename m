Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89558C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F99C21480
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F99C21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeIZMhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 08:37:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbeIZMhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 08:37:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E4655308A94D;
        Wed, 26 Sep 2018 06:25:44 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-101.pek2.redhat.com [10.72.12.101])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 51638600C3;
        Wed, 26 Sep 2018 06:25:31 +0000 (UTC)
Subject: Re: [PATCH 1/4 v7] x86/ioremap: add a function ioremap_encrypted() to
 remap kdump old memory
From:   lijiang <lijiang@redhat.com>
To:     Baoquan He <bhe@redhat.com>
References: <20180907081805.368-1-lijiang@redhat.com>
 <20180907081805.368-2-lijiang@redhat.com>
 <20180926022123.GA2555@MiWiFi-R3L-srv>
 <e6cd5448-b314-e142-1169-9e3e907faf16@redhat.com>
Cc:     linux-kernel@vger.kernel.org, joro@8bytes.org, mingo@redhat.com,
        ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de,
        Dave Young <dyoung@redhat.com>,
        "Lendacky, Thomas" <thomas.lendacky@amd.com>
Message-ID: <e7634c77-1657-4665-3bc4-bd00196f28e4@redhat.com>
Date:   Wed, 26 Sep 2018 14:25:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e6cd5448-b314-e142-1169-9e3e907faf16@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 26 Sep 2018 06:25:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also cc maintainer and other reviewer. Thanks.

在 2018年09月26日 14:18, lijiang 写道:
> 在 2018年09月26日 10:21, Baoquan He 写道:
>> Hi Lianbo,
>>
>> On 09/07/18 at 04:18pm, Lianbo Jiang wrote:
>>> When SME is enabled on AMD machine, the memory is encrypted in the first
>>> kernel. In this case, SME also needs to be enabled in kdump kernel, and
>>> we have to remap the old memory with the memory encryption mask.
>>
>> This patch series looks good to me. One thing is in your v5 post, Boris
>> reviewed and complained about the git log, we worked together to make an
>> document to explain, wondering why you don't rearrange it into log of
>> this patch. Other than this, all looks fine.
>>
>> http://lkml.kernel.org/r/53536964-2b57-4630-de91-3d4da2b643a8@redhat.com
>>
> Thank you, Baoquan.
> 
> Previously i had considered whether i should put these explaining into patch log,
> because these contents are a little more, i might just put the description of
> Solution A into this patch log and post this patch again.
> 
> Lianbo
>>
>>>
>>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>>> ---
>>>  arch/x86/include/asm/io.h |  3 +++
>>>  arch/x86/mm/ioremap.c     | 25 +++++++++++++++++--------
>>>  2 files changed, 20 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
>>> index 6de64840dd22..f8795f9581c7 100644
>>> --- a/arch/x86/include/asm/io.h
>>> +++ b/arch/x86/include/asm/io.h
>>> @@ -192,6 +192,9 @@ extern void __iomem *ioremap_cache(resource_size_t offset, unsigned long size);
>>>  #define ioremap_cache ioremap_cache
>>>  extern void __iomem *ioremap_prot(resource_size_t offset, unsigned long size, unsigned long prot_val);
>>>  #define ioremap_prot ioremap_prot
>>> +extern void __iomem *ioremap_encrypted(resource_size_t phys_addr,
>>> +					unsigned long size);
>>> +#define ioremap_encrypted ioremap_encrypted
>>>  
>>>  /**
>>>   * ioremap     -   map bus memory into CPU space
>>> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
>>> index c63a545ec199..e01e6c695add 100644
>>> --- a/arch/x86/mm/ioremap.c
>>> +++ b/arch/x86/mm/ioremap.c
>>> @@ -24,6 +24,7 @@
>>>  #include <asm/pgalloc.h>
>>>  #include <asm/pat.h>
>>>  #include <asm/setup.h>
>>> +#include <linux/crash_dump.h>
>>>  
>>>  #include "physaddr.h"
>>>  
>>> @@ -131,7 +132,8 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
>>>   * caller shouldn't need to know that small detail.
>>>   */
>>>  static void __iomem *__ioremap_caller(resource_size_t phys_addr,
>>> -		unsigned long size, enum page_cache_mode pcm, void *caller)
>>> +		unsigned long size, enum page_cache_mode pcm,
>>> +		void *caller, bool encrypted)
>>>  {
>>>  	unsigned long offset, vaddr;
>>>  	resource_size_t last_addr;
>>> @@ -199,7 +201,7 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
>>>  	 * resulting mapping.
>>>  	 */
>>>  	prot = PAGE_KERNEL_IO;
>>> -	if (sev_active() && mem_flags.desc_other)
>>> +	if ((sev_active() && mem_flags.desc_other) || encrypted)
>>>  		prot = pgprot_encrypted(prot);
>>>  
>>>  	switch (pcm) {
>>> @@ -291,7 +293,7 @@ void __iomem *ioremap_nocache(resource_size_t phys_addr, unsigned long size)
>>>  	enum page_cache_mode pcm = _PAGE_CACHE_MODE_UC_MINUS;
>>>  
>>>  	return __ioremap_caller(phys_addr, size, pcm,
>>> -				__builtin_return_address(0));
>>> +				__builtin_return_address(0), false);
>>>  }
>>>  EXPORT_SYMBOL(ioremap_nocache);
>>>  
>>> @@ -324,7 +326,7 @@ void __iomem *ioremap_uc(resource_size_t phys_addr, unsigned long size)
>>>  	enum page_cache_mode pcm = _PAGE_CACHE_MODE_UC;
>>>  
>>>  	return __ioremap_caller(phys_addr, size, pcm,
>>> -				__builtin_return_address(0));
>>> +				__builtin_return_address(0), false);
>>>  }
>>>  EXPORT_SYMBOL_GPL(ioremap_uc);
>>>  
>>> @@ -341,7 +343,7 @@ EXPORT_SYMBOL_GPL(ioremap_uc);
>>>  void __iomem *ioremap_wc(resource_size_t phys_addr, unsigned long size)
>>>  {
>>>  	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WC,
>>> -					__builtin_return_address(0));
>>> +					__builtin_return_address(0), false);
>>>  }
>>>  EXPORT_SYMBOL(ioremap_wc);
>>>  
>>> @@ -358,14 +360,21 @@ EXPORT_SYMBOL(ioremap_wc);
>>>  void __iomem *ioremap_wt(resource_size_t phys_addr, unsigned long size)
>>>  {
>>>  	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WT,
>>> -					__builtin_return_address(0));
>>> +					__builtin_return_address(0), false);
>>>  }
>>>  EXPORT_SYMBOL(ioremap_wt);
>>>  
>>> +void __iomem *ioremap_encrypted(resource_size_t phys_addr, unsigned long size)
>>> +{
>>> +	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WB,
>>> +				__builtin_return_address(0), true);
>>> +}
>>> +EXPORT_SYMBOL(ioremap_encrypted);
>>> +
>>>  void __iomem *ioremap_cache(resource_size_t phys_addr, unsigned long size)
>>>  {
>>>  	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WB,
>>> -				__builtin_return_address(0));
>>> +				__builtin_return_address(0), false);
>>>  }
>>>  EXPORT_SYMBOL(ioremap_cache);
>>>  
>>> @@ -374,7 +383,7 @@ void __iomem *ioremap_prot(resource_size_t phys_addr, unsigned long size,
>>>  {
>>>  	return __ioremap_caller(phys_addr, size,
>>>  				pgprot2cachemode(__pgprot(prot_val)),
>>> -				__builtin_return_address(0));
>>> +				__builtin_return_address(0), false);
>>>  }
>>>  EXPORT_SYMBOL(ioremap_prot);
>>>  
>>> -- 
>>> 2.17.1
>>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>>
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 
