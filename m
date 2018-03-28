Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752651AbeC1I2H (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 04:28:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35852 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752570AbeC1I2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 04:28:05 -0400
Subject: Re: [PATCH v9 06/24] mm: make pte_unmap_same compatible with SPF
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
 <1520963994-28477-7-git-send-email-ldufour@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1803271417510.31115@chino.kir.corp.google.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Wed, 28 Mar 2018 10:27:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1803271417510.31115@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18032808-0008-0000-0000-000004E311F7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032808-0009-0000-0000-00001E764F75
Message-Id: <fd9eedf4-b885-d8f5-2daa-4cc450e72427@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-28_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803280093
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/03/2018 23:18, David Rientjes wrote:
> On Tue, 13 Mar 2018, Laurent Dufour wrote:
> 
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 2f3e98edc94a..b6432a261e63 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -1199,6 +1199,7 @@ static inline void clear_page_pfmemalloc(struct page *page)
>>  #define VM_FAULT_NEEDDSYNC  0x2000	/* ->fault did not modify page tables
>>  					 * and needs fsync() to complete (for
>>  					 * synchronous page faults in DAX) */
>> +#define VM_FAULT_PTNOTSAME 0x4000	/* Page table entries have changed */
>>  
>>  #define VM_FAULT_ERROR	(VM_FAULT_OOM | VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV | \
>>  			 VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE | \
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 21b1212a0892..4bc7b0bdcb40 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -2309,21 +2309,29 @@ static bool pte_map_lock(struct vm_fault *vmf)
>>   * parts, do_swap_page must check under lock before unmapping the pte and
>>   * proceeding (but do_wp_page is only called after already making such a check;
>>   * and do_anonymous_page can safely check later on).
>> + *
>> + * pte_unmap_same() returns:
>> + *	0			if the PTE are the same
>> + *	VM_FAULT_PTNOTSAME	if the PTE are different
>> + *	VM_FAULT_RETRY		if the VMA has changed in our back during
>> + *				a speculative page fault handling.
>>   */
>> -static inline int pte_unmap_same(struct mm_struct *mm, pmd_t *pmd,
>> -				pte_t *page_table, pte_t orig_pte)
>> +static inline int pte_unmap_same(struct vm_fault *vmf)
>>  {
>> -	int same = 1;
>> +	int ret = 0;
>> +
>>  #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
>>  	if (sizeof(pte_t) > sizeof(unsigned long)) {
>> -		spinlock_t *ptl = pte_lockptr(mm, pmd);
>> -		spin_lock(ptl);
>> -		same = pte_same(*page_table, orig_pte);
>> -		spin_unlock(ptl);
>> +		if (pte_spinlock(vmf)) {
>> +			if (!pte_same(*vmf->pte, vmf->orig_pte))
>> +				ret = VM_FAULT_PTNOTSAME;
>> +			spin_unlock(vmf->ptl);
>> +		} else
>> +			ret = VM_FAULT_RETRY;
>>  	}
>>  #endif
>> -	pte_unmap(page_table);
>> -	return same;
>> +	pte_unmap(vmf->pte);
>> +	return ret;
>>  }
>>  
>>  static inline void cow_user_page(struct page *dst, struct page *src, unsigned long va, struct vm_area_struct *vma)
>> @@ -2913,7 +2921,8 @@ int do_swap_page(struct vm_fault *vmf)
>>  	int exclusive = 0;
>>  	int ret = 0;
> 
> Initialization is now unneeded.

I'm sorry, what "initialization" are you talking about here ?

> 
> Otherwise:
> 
> Acked-by: David Rientjes <rientjes@google.com>

Thanks,
Laurent.
