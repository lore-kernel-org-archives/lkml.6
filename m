Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753544AbeC1RLI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 13:11:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42052 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752311AbeC1RLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 13:11:06 -0400
Subject: Re: [PATCH v9 08/24] mm: Protect VMA modifications using VMA sequence
 count
To: David Rientjes <rientjes@google.com>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        Andrew Morton <akpm@linux-foundation.org>, kirill@shutemov.name,
        ak@linux.intel.com, mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
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
 <1520963994-28477-9-git-send-email-ldufour@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1803271454390.41987@chino.kir.corp.google.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Wed, 28 Mar 2018 19:10:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1803271454390.41987@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18032817-0020-0000-0000-0000040AC91C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032817-0021-0000-0000-0000429ED160
Message-Id: <f42499e6-746d-e9d0-2e71-6ee1003c8228@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-28_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803280177
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/03/2018 23:57, David Rientjes wrote:
> On Tue, 13 Mar 2018, Laurent Dufour wrote:
> 
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index 5898255d0aeb..d6533cb85213 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -847,17 +847,18 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
>>  	}
>>  
>>  	if (start != vma->vm_start) {
>> -		vma->vm_start = start;
>> +		WRITE_ONCE(vma->vm_start, start);
>>  		start_changed = true;
>>  	}
>>  	if (end != vma->vm_end) {
>> -		vma->vm_end = end;
>> +		WRITE_ONCE(vma->vm_end, end);
>>  		end_changed = true;
>>  	}
>> -	vma->vm_pgoff = pgoff;
>> +	WRITE_ONCE(vma->vm_pgoff, pgoff);
>>  	if (adjust_next) {
>> -		next->vm_start += adjust_next << PAGE_SHIFT;
>> -		next->vm_pgoff += adjust_next;
>> +		WRITE_ONCE(next->vm_start,
>> +			   next->vm_start + (adjust_next << PAGE_SHIFT));
>> +		WRITE_ONCE(next->vm_pgoff, next->vm_pgoff + adjust_next);
>>  	}
>>  
>>  	if (root) {
>> @@ -1781,6 +1782,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>>  out:
>>  	perf_event_mmap(vma);
>>  
>> +	vm_write_begin(vma);
>>  	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
>>  	if (vm_flags & VM_LOCKED) {
>>  		if (!((vm_flags & VM_SPECIAL) || is_vm_hugetlb_page(vma) ||
>> @@ -1803,6 +1805,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>>  	vma->vm_flags |= VM_SOFTDIRTY;
>>  
>>  	vma_set_page_prot(vma);
>> +	vm_write_end(vma);
>>  
>>  	return addr;
>>  
> 
> Shouldn't this also protect vma->vm_flags?

Nice catch !
I just found that too while reviewing the entire patch to answer your previous
email.

> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1796,7 +1796,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  					vma == get_gate_vma(current->mm)))
>  			mm->locked_vm += (len >> PAGE_SHIFT);
>  		else
> -			vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
> +			WRITE_ONCE(vma->vm_flags,
> +				   vma->vm_flags & VM_LOCKED_CLEAR_MASK);
>  	}
> 
>  	if (file)
> @@ -1809,7 +1810,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	 * then new mapped in-place (which must be aimed as
>  	 * a completely new data area).
>  	 */
> -	vma->vm_flags |= VM_SOFTDIRTY;
> +	WRITE_ONCE(vma->vm_flags, vma->vm_flags | VM_SOFTDIRTY);
> 
>  	vma_set_page_prot(vma);
>  	vm_write_end(vma);
> 
