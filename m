Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53452C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B1B204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B1B204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932742AbeFUJNT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 05:13:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932482AbeFUJNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 05:13:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4323D402345E;
        Thu, 21 Jun 2018 09:13:17 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-127.pek2.redhat.com [10.72.12.127])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DAB72026D6B;
        Thu, 21 Jun 2018 09:13:13 +0000 (UTC)
Subject: Re: [PATCH 1/4 V3] Add a function(ioremap_encrypted) for kdump when
 AMD sme enabled
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     iommu@lists.linux-foundation.org, kexec@lists.infradead.org,
        dyoung@redhat.com
References: <20180616082714.32035-1-lijiang@redhat.com>
 <20180616082714.32035-2-lijiang@redhat.com>
 <e5bb19b7-7db4-1c1c-d8bd-cc44d6b7bebb@amd.com>
From:   lijiang <lijiang@redhat.com>
Message-ID: <18563829-c8ec-87bd-90a6-137e79e2c8f1@redhat.com>
Date:   Thu, 21 Jun 2018 17:13:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <e5bb19b7-7db4-1c1c-d8bd-cc44d6b7bebb@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 21 Jun 2018 09:13:17 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 21 Jun 2018 09:13:17 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lijiang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年06月21日 00:00, Tom Lendacky 写道:
> On 6/16/2018 3:27 AM, Lianbo Jiang wrote:
>> It is convenient to remap the old memory encrypted to the second
>> kernel by calling ioremap_encrypted().
>>
>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>> ---
>> Some changes:
>> 1. remove the sme_active() check in __ioremap_caller().
>> 2. put some logic into the early_memremap_pgprot_adjust() for
>> early memremap.
>>
>>  arch/x86/include/asm/io.h |  3 +++
>>  arch/x86/mm/ioremap.c     | 28 ++++++++++++++++++++--------
>>  2 files changed, 23 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
>> index f6e5b93..989d60b 100644
>> --- a/arch/x86/include/asm/io.h
>> +++ b/arch/x86/include/asm/io.h
>> @@ -192,6 +192,9 @@ extern void __iomem *ioremap_cache(resource_size_t offset, unsigned long size);
>>  #define ioremap_cache ioremap_cache
>>  extern void __iomem *ioremap_prot(resource_size_t offset, unsigned long size, unsigned long prot_val);
>>  #define ioremap_prot ioremap_prot
>> +extern void __iomem *ioremap_encrypted(resource_size_t phys_addr,
>> +					unsigned long size);
>> +#define ioremap_encrypted ioremap_encrypted
>>  
>>  /**
>>   * ioremap     -   map bus memory into CPU space
>> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
>> index c63a545..e365fc4 100644
>> --- a/arch/x86/mm/ioremap.c
>> +++ b/arch/x86/mm/ioremap.c
>> @@ -24,6 +24,7 @@
>>  #include <asm/pgalloc.h>
>>  #include <asm/pat.h>
>>  #include <asm/setup.h>
>> +#include <linux/crash_dump.h>
>>  
>>  #include "physaddr.h"
>>  
>> @@ -131,7 +132,8 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
>>   * caller shouldn't need to know that small detail.
>>   */
>>  static void __iomem *__ioremap_caller(resource_size_t phys_addr,
>> -		unsigned long size, enum page_cache_mode pcm, void *caller)
>> +		unsigned long size, enum page_cache_mode pcm,
>> +		void *caller, bool encrypted)
>>  {
>>  	unsigned long offset, vaddr;
>>  	resource_size_t last_addr;
>> @@ -199,7 +201,7 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
>>  	 * resulting mapping.
>>  	 */
>>  	prot = PAGE_KERNEL_IO;
>> -	if (sev_active() && mem_flags.desc_other)
>> +	if ((sev_active() && mem_flags.desc_other) || encrypted)
>>  		prot = pgprot_encrypted(prot);
>>  
>>  	switch (pcm) {
>> @@ -291,7 +293,7 @@ void __iomem *ioremap_nocache(resource_size_t phys_addr, unsigned long size)
>>  	enum page_cache_mode pcm = _PAGE_CACHE_MODE_UC_MINUS;
>>  
>>  	return __ioremap_caller(phys_addr, size, pcm,
>> -				__builtin_return_address(0));
>> +				__builtin_return_address(0), false);
>>  }
>>  EXPORT_SYMBOL(ioremap_nocache);
>>  
>> @@ -324,7 +326,7 @@ void __iomem *ioremap_uc(resource_size_t phys_addr, unsigned long size)
>>  	enum page_cache_mode pcm = _PAGE_CACHE_MODE_UC;
>>  
>>  	return __ioremap_caller(phys_addr, size, pcm,
>> -				__builtin_return_address(0));
>> +				__builtin_return_address(0), false);
>>  }
>>  EXPORT_SYMBOL_GPL(ioremap_uc);
>>  
>> @@ -341,7 +343,7 @@ EXPORT_SYMBOL_GPL(ioremap_uc);
>>  void __iomem *ioremap_wc(resource_size_t phys_addr, unsigned long size)
>>  {
>>  	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WC,
>> -					__builtin_return_address(0));
>> +					__builtin_return_address(0), false);
>>  }
>>  EXPORT_SYMBOL(ioremap_wc);
>>  
>> @@ -358,14 +360,21 @@ EXPORT_SYMBOL(ioremap_wc);
>>  void __iomem *ioremap_wt(resource_size_t phys_addr, unsigned long size)
>>  {
>>  	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WT,
>> -					__builtin_return_address(0));
>> +					__builtin_return_address(0), false);
>>  }
>>  EXPORT_SYMBOL(ioremap_wt);
>>  
>> +void __iomem *ioremap_encrypted(resource_size_t phys_addr, unsigned long size)
>> +{
>> +	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WB,
>> +				__builtin_return_address(0), true);
>> +}
>> +EXPORT_SYMBOL(ioremap_encrypted);
>> +
>>  void __iomem *ioremap_cache(resource_size_t phys_addr, unsigned long size)
>>  {
>>  	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WB,
>> -				__builtin_return_address(0));
>> +				__builtin_return_address(0), false);
>>  }
>>  EXPORT_SYMBOL(ioremap_cache);
>>  
>> @@ -374,7 +383,7 @@ void __iomem *ioremap_prot(resource_size_t phys_addr, unsigned long size,
>>  {
>>  	return __ioremap_caller(phys_addr, size,
>>  				pgprot2cachemode(__pgprot(prot_val)),
>> -				__builtin_return_address(0));
>> +				__builtin_return_address(0), false);
>>  }
>>  EXPORT_SYMBOL(ioremap_prot);
>>  
>> @@ -688,6 +697,9 @@ pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
>>  	if (encrypted_prot && memremap_should_map_decrypted(phys_addr, size))
>>  		encrypted_prot = false;
>>  
>> +	if (sme_active() && is_kdump_kernel())
>> +		encrypted_prot = false;
>> +
> 
> This change doesn't seem to go with the patch description.  Maybe it
> should be a separate patch?  Or provide more detail in the description
> for this change.
> 
> What is this change addressing?  What early_memremap() calls were failing
> that required this?  If this truly is required, you can probably move it
> up into the "if (sme_active())" block a few lines higher in the function.
> 
Thanks. About this issue, you could read the description of cover letter, we put some
logic into the early_memremap_pgprot_adjust() in order to avoid the previous changes,
such as arch/x86/include/asm/dmi.h, arch/x86/kernel/acpi/boot.c and drivers/acpi/tables.c.					
They will call early_memremap() to remap the memory, but we need to remap the memory
without encryption.

Lianbo

> Thanks,
> Tom
> 
>>  	return encrypted_prot ? pgprot_encrypted(prot)
>>  			      : pgprot_decrypted(prot);
>>  }
>>
