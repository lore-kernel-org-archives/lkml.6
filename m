Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753282AbeC1R7P (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 13:59:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38462 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752829AbeC1R7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 13:59:14 -0400
Subject: Re: [PATCH v9 07/24] mm: VMA sequence count
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
 <1520963994-28477-8-git-send-email-ldufour@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1803271429230.36401@chino.kir.corp.google.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Wed, 28 Mar 2018 19:58:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1803271429230.36401@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18032817-0008-0000-0000-000004E34088
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032817-0009-0000-0000-00001E7680D1
Message-Id: <d8d65544-1844-b4c3-f246-27572ab6dee2@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-28_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803280187
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/03/2018 23:30, David Rientjes wrote:
> On Tue, 13 Mar 2018, Laurent Dufour wrote:
> 
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index faf85699f1a1..5898255d0aeb 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -558,6 +558,10 @@ void __vma_link_rb(struct mm_struct *mm, struct vm_area_struct *vma,
>>  	else
>>  		mm->highest_vm_end = vm_end_gap(vma);
>>  
>> +#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
>> +	seqcount_init(&vma->vm_sequence);
>> +#endif
>> +
>>  	/*
>>  	 * vma->vm_prev wasn't known when we followed the rbtree to find the
>>  	 * correct insertion point for that vma. As a result, we could not
>> @@ -692,6 +696,30 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
>>  	long adjust_next = 0;
>>  	int remove_next = 0;
>>  
>> +	/*
>> +	 * Why using vm_raw_write*() functions here to avoid lockdep's warning ?
>> +	 *
>> +	 * Locked is complaining about a theoretical lock dependency, involving
>> +	 * 3 locks:
>> +	 *   mapping->i_mmap_rwsem --> vma->vm_sequence --> fs_reclaim
>> +	 *
>> +	 * Here are the major path leading to this dependency :
>> +	 *  1. __vma_adjust() mmap_sem  -> vm_sequence -> i_mmap_rwsem
>> +	 *  2. move_vmap() mmap_sem -> vm_sequence -> fs_reclaim
>> +	 *  3. __alloc_pages_nodemask() fs_reclaim -> i_mmap_rwsem
>> +	 *  4. unmap_mapping_range() i_mmap_rwsem -> vm_sequence
>> +	 *
>> +	 * So there is no way to solve this easily, especially because in
>> +	 * unmap_mapping_range() the i_mmap_rwsem is grab while the impacted
>> +	 * VMAs are not yet known.
>> +	 * However, the way the vm_seq is used is guarantying that we will
>> +	 * never block on it since we just check for its value and never wait
>> +	 * for it to move, see vma_has_changed() and handle_speculative_fault().
>> +	 */
>> +	vm_raw_write_begin(vma);
>> +	if (next)
>> +		vm_raw_write_begin(next);
>> +
>>  	if (next && !insert) {
>>  		struct vm_area_struct *exporter = NULL, *importer = NULL;
>>  
> 
> Eek, what about later on:
> 
> 		/*
> 		 * Easily overlooked: when mprotect shifts the boundary,
> 		 * make sure the expanding vma has anon_vma set if the
> 		 * shrinking vma had, to cover any anon pages imported.
> 		 */
> 		if (exporter && exporter->anon_vma && !importer->anon_vma) {
> 			int error;
> 
> 			importer->anon_vma = exporter->anon_vma;
> 			error = anon_vma_clone(importer, exporter);
> 			if (error)
> 				return error;
> 		}
> 
> This needs
> 
> if (error) {
> 	if (next && next != vma)
> 		vm_raw_write_end(next);
> 	vm_raw_write_end(vma);
> 	return error;
> }

Nice catch !

Thanks,
Laurent.
