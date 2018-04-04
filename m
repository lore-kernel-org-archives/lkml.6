Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeDDP5C (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 11:57:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751780AbeDDP5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 11:57:00 -0400
Subject: Re: [PATCH v9 14/24] mm: Introduce __maybe_mkwrite()
To: David Rientjes <rientjes@google.com>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
        mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
        Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
        mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
        sergey.senozhatsky.work@gmail.com,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
        npiggin@gmail.com, bsingharora@gmail.com,
        Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org
References: <1520963994-28477-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1520963994-28477-15-git-send-email-ldufour@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1804021611590.102694@chino.kir.corp.google.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Wed, 4 Apr 2018 17:56:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1804021611590.102694@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18040415-0008-0000-0000-000004E6B65F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040415-0009-0000-0000-00001E79C683
Message-Id: <403a5d84-99f9-d1a5-0c75-38b0d4cc1637@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-04_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804040161
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2018 01:12, David Rientjes wrote:
> On Tue, 13 Mar 2018, Laurent Dufour wrote:
> 
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index dfa81a638b7c..a84ddc218bbd 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -684,13 +684,18 @@ void free_compound_page(struct page *page);
>>   * pte_mkwrite.  But get_user_pages can cause write faults for mappings
>>   * that do not have writing enabled, when used by access_process_vm.
>>   */
>> -static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
>> +static inline pte_t __maybe_mkwrite(pte_t pte, unsigned long vma_flags)
>>  {
>> -	if (likely(vma->vm_flags & VM_WRITE))
>> +	if (likely(vma_flags & VM_WRITE))
>>  		pte = pte_mkwrite(pte);
>>  	return pte;
>>  }
>>  
>> +static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
>> +{
>> +	return __maybe_mkwrite(pte, vma->vm_flags);
>> +}
>> +
>>  int alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
>>  		struct page *page);
>>  int finish_fault(struct vm_fault *vmf);
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 0a0a483d9a65..af0338fbc34d 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -2472,7 +2472,7 @@ static inline void wp_page_reuse(struct vm_fault *vmf)
>>  
>>  	flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
>>  	entry = pte_mkyoung(vmf->orig_pte);
>> -	entry = maybe_mkwrite(pte_mkdirty(entry), vma);
>> +	entry = __maybe_mkwrite(pte_mkdirty(entry), vmf->vma_flags);
>>  	if (ptep_set_access_flags(vma, vmf->address, vmf->pte, entry, 1))
>>  		update_mmu_cache(vma, vmf->address, vmf->pte);
>>  	pte_unmap_unlock(vmf->pte, vmf->ptl);
>> @@ -2549,8 +2549,8 @@ static int wp_page_copy(struct vm_fault *vmf)
>>  			inc_mm_counter_fast(mm, MM_ANONPAGES);
>>  		}
>>  		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
>> -		entry = mk_pte(new_page, vma->vm_page_prot);
>> -		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
>> +		entry = mk_pte(new_page, vmf->vma_page_prot);
>> +		entry = __maybe_mkwrite(pte_mkdirty(entry), vmf->vma_flags);
>>  		/*
>>  		 * Clear the pte entry and flush it first, before updating the
>>  		 * pte with the new entry. This will avoid a race condition
> 
> Don't you also need to do this in do_swap_page()?

Indeed I'll drop this patch as all the changes are now done in the patch 11
"mm: Cache some VMA fields in the vm_fault structure" where, as you suggested,
maybe_mkwrite() is now getting passed the vm_flags value directly.

> diff --git a/mm/memory.c b/mm/memory.c
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3067,9 +3067,9 @@ int do_swap_page(struct vm_fault *vmf)
> 
>  	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
>  	dec_mm_counter_fast(vma->vm_mm, MM_SWAPENTS);
> -	pte = mk_pte(page, vma->vm_page_prot);
> +	pte = mk_pte(page, vmf->vma_page_prot);
>  	if ((vmf->flags & FAULT_FLAG_WRITE) && reuse_swap_page(page, NULL)) {
> -		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
> +		pte = __maybe_mkwrite(pte_mkdirty(pte), vmf->vma_flags);
>  		vmf->flags &= ~FAULT_FLAG_WRITE;
>  		ret |= VM_FAULT_WRITE;
>  		exclusive = RMAP_EXCLUSIVE;
> 
