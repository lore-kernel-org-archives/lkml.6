Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752266AbeBHOgS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:36:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37988 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750882AbeBHOgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:36:12 -0500
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 04/24] mm: Dont assume page-table invariance during
 faults
To: Matthew Wilcox <willy@infradead.org>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
        mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
        benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
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
References: <1517935810-31177-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1517935810-31177-5-git-send-email-ldufour@linux.vnet.ibm.com>
 <20180206202831.GB16511@bombadil.infradead.org>
Date: Thu, 8 Feb 2018 15:35:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180206202831.GB16511@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18020814-0040-0000-0000-0000042DCB72
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020814-0041-0000-0000-000020D18201
Message-Id: <484242d8-e632-9e39-5c99-2e1b4b3b69a5@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802080169
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2018 21:28, Matthew Wilcox wrote:
> On Tue, Feb 06, 2018 at 05:49:50PM +0100, Laurent Dufour wrote:
>> From: Peter Zijlstra <peterz@infradead.org>
>>
>> One of the side effects of speculating on faults (without holding
>> mmap_sem) is that we can race with free_pgtables() and therefore we
>> cannot assume the page-tables will stick around.
>>
>> Remove the reliance on the pte pointer.
>>
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>
>> In most of the case pte_unmap_same() was returning 1, which meaning that
>> do_swap_page() should do its processing. So in most of the case there will
>> be no impact.
>>
>> Now regarding the case where pte_unmap_safe() was returning 0, and thus
>> do_swap_page return 0 too, this happens when the page has already been
>> swapped back. This may happen before do_swap_page() get called or while in
>> the call to do_swap_page(). In that later case, the check done when
>> swapin_readahead() returns will detect that case.
>>
>> The worst case would be that a page fault is occuring on 2 threads at the
>> same time on the same swapped out page. In that case one thread will take
>> much time looping in __read_swap_cache_async(). But in the regular page
>> fault path, this is even worse since the thread would wait for semaphore to
>> be released before starting anything.
>>
>> [Remove only if !CONFIG_SPECULATIVE_PAGE_FAULT]
>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> 
> I have a great deal of trouble connecting all of the words above to the
> contents of the patch.

Thanks for pushing forward here, this raised some doubts on my side.

I reviewed that part of code, and I think I could now change the way
pte_unmap_safe() is checking for the pte's value. Since we now have all the
needed details in the vm_fault structure, I will pass it to
pte_unamp_same() and deal with the VMA checks when locking for the pte as
it is done in the other part of the page fault handler by calling
pte_spinlock().

This means that this patch will be dropped, and pte_unmap_same() will become :

static inline int pte_unmap_same(struct vm_fault *vmf, int *same)
{
	int ret = 0;

	*same = 1;
#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
	if (sizeof(pte_t) > sizeof(unsigned long)) {
		if (pte_spinlock(vmf)) {
			*same = pte_same(*vmf->pte, vmf->orig_pte);
			spin_unlock(vmf->ptl);
		}
		else
			ret = VM_FAULT_RETRY;
	}
#endif
	pte_unmap(vmf->pte);
	return ret;
}

Laurent.

> 
>>  
>> +#ifndef CONFIG_SPECULATIVE_PAGE_FAULT
>>  /*
>>   * handle_pte_fault chooses page fault handler according to an entry which was
>>   * read non-atomically.  Before making any commitment, on those architectures
>> @@ -2311,6 +2312,7 @@ static inline int pte_unmap_same(struct mm_struct *mm, pmd_t *pmd,
>>  	pte_unmap(page_table);
>>  	return same;
>>  }
>> +#endif /* CONFIG_SPECULATIVE_PAGE_FAULT */
>>  
>>  static inline void cow_user_page(struct page *dst, struct page *src, unsigned long va, struct vm_area_struct *vma)
>>  {
>> @@ -2898,11 +2900,13 @@ int do_swap_page(struct vm_fault *vmf)
>>  		swapcache = page;
>>  	}
>>  
>> +#ifndef CONFIG_SPECULATIVE_PAGE_FAULT
>>  	if (!pte_unmap_same(vma->vm_mm, vmf->pmd, vmf->pte, vmf->orig_pte)) {
>>  		if (page)
>>  			put_page(page);
>>  		goto out;
>>  	}
>> +#endif
>>  
> 
> This feels to me like we want:
> 
> #ifdef CONFIG_SPECULATIVE_PAGE_FAULT
> [current code]
> #else
> /*
>  * Some words here which explains why we always want to return this
>  * value if we support speculative page faults.
>  */
> static inline int pte_unmap_same(struct mm_struct *mm, pmd_t *pmd,
> 				pte_t *page_table, pte_t orig_pte)
> {
> 	return 1;
> }
> #endif
> 
> instead of cluttering do_swap_page with an ifdef.
> 
