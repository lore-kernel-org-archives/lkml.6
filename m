Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF5DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318AE21773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbfBRTZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:25:36 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:40542 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725308AbfBRTZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:25:36 -0500
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1IJLdKB024579;
        Mon, 18 Feb 2019 19:24:43 GMT
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com with ESMTP id 2qqy9ehs00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Feb 2019 19:24:43 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 9847492;
        Mon, 18 Feb 2019 19:24:42 +0000 (UTC)
Received: from [16.214.130.214] (unknown [16.214.130.214])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 229B34A;
        Mon, 18 Feb 2019 19:24:40 +0000 (UTC)
Subject: Re: [PATCH v3 6/6] x86/mm/KASLR: Do not adapt the size of the direct
 mapping section for SGI UV system
To:     Baoquan He <bhe@redhat.com>, Mike Travis <mike.travis@hpe.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, thgarnie@google.com, linux-kernel@vger.kernel.org,
        keescook@chromium.org, akpm@linux-foundation.org,
        yamada.masahiro@socionext.com, kirill@shutemov.name,
        Russ Anderson <rja@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>
References: <20190216140008.28671-1-bhe@redhat.com>
 <20190216140008.28671-7-bhe@redhat.com>
 <20190217020904.GF14858@MiWiFi-R3L-srv>
From:   Mike Travis <mike.travis@hpe.com>
Message-ID: <2556be96-3bf9-746e-8a15-6339355869af@hpe.com>
Date:   Mon, 18 Feb 2019 11:24:40 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190217020904.GF14858@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-18_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902180144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,

There was a breakage in the TSC code (for UV) where the change was to 
introduce an early TSC "adjustment".  This bypassed the UV auto setting 
of TSC by BIOS because it came before the UV init code could indicate 
that the TSC was already in sync.  (I believe I already sent you a note 
about this?)

To fix this, I sent in two patches, the first had this 
is_early_uv_system() function defined and the second had the check to 
avoid adjusting TSC too early.

The commit referred to is:

> commit 20a8378aa9dd108a01cb0e695599f5257a885c4b
> Author: Mike Travis <mike.travis@hpe.com>
> Date:   Tue Oct 2 13:01:45 2018 -0500
> 
>     x86/platform/uv: Provide is_early_uv_system()
>     
>     Introduce is_early_uv_system() which uses efi.uv_systab to decide early
>     in the boot process whether the kernel is running on a UV system.
>     
>     This is needed to skip other early setup/init code that might break
>     the UV platform if done too early such as before necessary ACPI tables
>     parsing takes place.
>     

Check to see if that function is defined in the kernels you are pushing 
this patch to.

As to testing on a UV system, I can schedule the time to do that, just 
send me the details.

Thanks,
Mike

On 2/16/2019 6:09 PM, Baoquan He wrote:
> Hi Mike,
> 
> On 02/16/19 at 10:00pm, Baoquan He wrote:
>> On SGI UV system, kernel often hangs when KASLR is enabled. Disabling
>> KASLR makes kernel work well.
> 
> I wrap codes which calculate the size of the direct mapping section
> into a new function calc_direct_mapping_size() as Ingo suggested. This
> code change has passed basic testing, but hasn't been tested on a
> SGI UV machine after reproducing since it needs UV machine with UV
> module installed of enough size.
> 
> To reproduce it, we can apply patches 0001~0005. If reproduced, patch
> 0006 can be applied on top to check if bug is fixed. Please help check
> if the code is OK, if you have a machine, I can have a test.
> 
> Thanks
> Baoquan
> 
>>
>> The back trace is:
>>
>> kernel BUG at arch/x86/mm/init_64.c:311!
>> invalid opcode: 0000 [#1] SMP
>> [...]
>> RIP: 0010:__init_extra_mapping+0x188/0x196
>> [...]
>> Call Trace:
>>   init_extra_mapping_uc+0x13/0x15
>>   map_high+0x67/0x75
>>   map_mmioh_high_uv3+0x20a/0x219
>>   uv_system_init_hub+0x12d9/0x1496
>>   uv_system_init+0x27/0x29
>>   native_smp_prepare_cpus+0x28d/0x2d8
>>   kernel_init_freeable+0xdd/0x253
>>   ? rest_init+0x80/0x80
>>   kernel_init+0xe/0x110
>>   ret_from_fork+0x2c/0x40
>>
>> This is because the SGI UV system need map its MMIOH region to the direct
>> mapping section, and the mapping happens in rest_init() which is much
>> later than the calling of kernel_randomize_memory() to do mm KASLR. So
>> mm KASLR can't count in the size of the MMIOH region when calculate the
>> needed size of address space for the direct mapping section.
>>
>> When KASLR is disabled, there are 64TB address space for both system RAM
>> and the MMIOH regions to share. When KASLR is enabled, the current code
>> of mm KASLR only reserves the actual size of system RAM plus extra 10TB
>> for the direct mapping. Thus later the MMIOH mapping could go beyond
>> the upper bound of the direct mapping to step into VMALLOC or VMEMMAP area.
>> Then BUG_ON() in __init_extra_mapping() will be triggered.
>>
>> E.g on the SGI UV3 machine where this bug was reported , there are two
>> MMIOH regions:
>>
>> [    1.519001] UV: Map MMIOH0_HI 0xffc00000000 - 0x100000000000
>> [    1.523001] UV: Map MMIOH1_HI 0x100000000000 - 0x200000000000
>>
>> They are [16TB-16G, 16TB) and [16TB, 32TB). On this machine, 512G RAM are
>> spread out to 1TB regions. Then above two SGI MMIOH regions also will be
>> mapped into the direct mapping section.
>>
>> To fix it, we need check if it's SGI UV system by calling
>> is_early_uv_system() in kernel_randomize_memory(). If yes, do not adapt
>> thesize of the direct mapping section, just keep it as is, e.g in level-4
>> paging mode, 64TB.
>>
>> Signed-off-by: Baoquan He <bhe@redhat.com>
>> ---
>>   arch/x86/mm/kaslr.c | 57 +++++++++++++++++++++++++++++++++------------
>>   1 file changed, 42 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
>> index ca12ed4e5239..754b5da91d43 100644
>> --- a/arch/x86/mm/kaslr.c
>> +++ b/arch/x86/mm/kaslr.c
>> @@ -29,6 +29,7 @@
>>   #include <asm/pgtable.h>
>>   #include <asm/setup.h>
>>   #include <asm/kaslr.h>
>> +#include <asm/uv/uv.h>
>>   
>>   #include "mm_internal.h"
>>   
>> @@ -113,15 +114,51 @@ static inline bool kaslr_memory_enabled(void)
>>   	return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
>>   }
>>   
>> +/*
>> + * Even though a huge virtual address space is reserved for the direct
>> + * mapping of physical memory, e.g in 4-level pageing mode, it's 64TB,
>> + * rare system can own enough physical memory to use it up, most are
>> + * even less than 1TB. So with KASLR enabled, we adapt the size of
>> + * direct mapping area to size of actual physical memory plus the
>> + * configured padding CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING.
>> + * The left part will be taken out to join memory randomization.
>> + *
>> + * Note that UV system is an exception, its MMIOH region need be mapped
>> + * into the direct mapping area too, while the size can't be got until
>> + * rest_init() calling. Hence for UV system, do not adapt the size
>> + * of direct mapping area.
>> + */
>> +static inline unsigned long calc_direct_mapping_size(void)
>> +{
>> +	unsigned long size_tb, memory_tb;
>> +
>> +	/*
>> +	 * Update Physical memory mapping to available and
>> +	 * add padding if needed (especially for memory hotplug support).
>> +	 */
>> +	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
>> +		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
>> +
>> +	size_tb = 1 << (MAX_PHYSMEM_BITS - TB_SHIFT);
>> +
>> +	/*
>> +	 * Adapt phyiscal memory region size based on available memory if
>> +	 * it's not UV system.
>> +	 */
>> +	if (memory_tb < size_tb && !is_early_uv_system())
>> +		size_tb = memory_tb;
>> +
>> +	return size_tb;
>> +}
>> +
>>   /* Initialize base and padding for each memory region randomized with KASLR */
>>   void __init kernel_randomize_memory(void)
>>   {
>> -	size_t i;
>> -	unsigned long vaddr_start, vaddr;
>> -	unsigned long rand, memory_tb;
>> -	struct rnd_state rand_state;
>> +	unsigned long vaddr_start, vaddr, rand;
>>   	unsigned long remain_entropy;
>>   	unsigned long vmemmap_size;
>> +	struct rnd_state rand_state;
>> +	size_t i;
>>   
>>   	vaddr_start = pgtable_l5_enabled() ? __PAGE_OFFSET_BASE_L5 : __PAGE_OFFSET_BASE_L4;
>>   	vaddr = vaddr_start;
>> @@ -138,20 +175,10 @@ void __init kernel_randomize_memory(void)
>>   	if (!kaslr_memory_enabled())
>>   		return;
>>   
>> -	kaslr_regions[0].size_tb = 1 << (MAX_PHYSMEM_BITS - TB_SHIFT);
>> +	kaslr_regions[0].size_tb = calc_direct_mapping_size();
>>   	kaslr_regions[1].size_tb = VMALLOC_SIZE_TB;
>>   
>> -	/*
>> -	 * Update Physical memory mapping to available and
>> -	 * add padding if needed (especially for memory hotplug support).
>> -	 */
>>   	BUG_ON(kaslr_regions[0].base != &page_offset_base);
>> -	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
>> -		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
>> -
>> -	/* Adapt phyiscal memory region size based on available memory */
>> -	if (memory_tb < kaslr_regions[0].size_tb)
>> -		kaslr_regions[0].size_tb = memory_tb;
>>   
>>   	/*
>>   	 * Calculate how many TB vmemmap region needs, and align to
>> -- 
>> 2.17.2
>>
