Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752226AbeEPNUJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 09:20:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44416 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751151AbeEPNUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 09:20:07 -0400
Subject: Re: [PATCH 1/2] add a function(ioremap_encrypted) for kdump when AMD
 sme enabled.
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org, dyoung@redhat.com
References: <20180515015133.4363-1-lijiang@redhat.com>
 <20180515015133.4363-2-lijiang@redhat.com>
 <8c8f20cc-b39d-137c-9d71-1e566f905acb@amd.com>
From: lijiang <lijiang@redhat.com>
Message-ID: <7b36c2ea-5e96-d554-aaff-97587bc268e9@redhat.com>
Date: Wed, 16 May 2018 21:19:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <8c8f20cc-b39d-137c-9d71-1e566f905acb@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2018年05月15日 22:34, Tom Lendacky 写道:
> On 5/14/2018 8:51 PM, Lianbo Jiang wrote:
>> It is convenient to remap the old memory encrypted to the second kernel
>> by calling ioremap_encrypted().
>>
>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>> ---
>>  arch/x86/include/asm/io.h |  2 ++
>>  arch/x86/mm/ioremap.c     | 25 +++++++++++++++++--------
>>  2 files changed, 19 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
>> index f6e5b93..06d2a9f 100644
>> --- a/arch/x86/include/asm/io.h
>> +++ b/arch/x86/include/asm/io.h
>> @@ -192,6 +192,8 @@ extern void __iomem *ioremap_cache(resource_size_t offset, unsigned long size);
>>  #define ioremap_cache ioremap_cache
>>  extern void __iomem *ioremap_prot(resource_size_t offset, unsigned long size, unsigned long prot_val);
>>  #define ioremap_prot ioremap_prot
>> +extern void __iomem *ioremap_encrypted(resource_size_t phys_addr, unsigned long size);
>> +#define ioremap_encrypted ioremap_encrypted
>>  
>>  /**
>>   * ioremap     -   map bus memory into CPU space
>> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
>> index c63a545..7a52d1e 100644
>> --- a/arch/x86/mm/ioremap.c
>> +++ b/arch/x86/mm/ioremap.c
>> @@ -131,7 +131,8 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
>>   * caller shouldn't need to know that small detail.
>>   */
>>  static void __iomem *__ioremap_caller(resource_size_t phys_addr,
>> -		unsigned long size, enum page_cache_mode pcm, void *caller)
>> +		unsigned long size, enum page_cache_mode pcm,
>> +		void *caller, bool encrypted)
>>  {
>>  	unsigned long offset, vaddr;
>>  	resource_size_t last_addr;
>> @@ -199,7 +200,8 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
>>  	 * resulting mapping.
>>  	 */
>>  	prot = PAGE_KERNEL_IO;
>> -	if (sev_active() && mem_flags.desc_other)
>> +	if ((sev_active() && mem_flags.desc_other) ||
>> +			(encrypted && sme_active()))
> 
> You only need the encrypted check here.  If sme is not active,
> then the pgprot_encrypted will basically be a no-op.
> 
Great! Thank you, Tom.
It will be fixed.

Lianbo
> Also, extra indents.
> 
> Thanks,
> Tom
> 
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
>>
