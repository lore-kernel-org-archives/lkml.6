Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751785AbeDDK3B (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 06:29:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46638 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751735AbeDDK3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 06:29:00 -0400
Subject: Re: [mm] b1f0502d04: INFO:trying_to_register_non-static_key
To: David Rientjes <rientjes@google.com>
Cc: kernel test robot <fengguang.wu@intel.com>, paulmck@linux.vnet.ibm.com,
        peterz@infradead.org, akpm@linux-foundation.org, kirill@shutemov.name,
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
        x86@kernel.org, lkp@01.org
References: <20180317075119.u6yuem2bhxvggbz3@inn>
 <792c0f75-7e7f-cd81-44ae-4205f6e4affc@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1803251510040.80485@chino.kir.corp.google.com>
 <aa6f2ff1-ff67-106a-e0e4-522ac82a7bf0@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1804031748120.27686@chino.kir.corp.google.com>
 <alpine.DEB.2.20.1804031802110.50064@chino.kir.corp.google.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Wed, 4 Apr 2018 12:28:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1804031802110.50064@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18040410-0020-0000-0000-0000040DEB11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040410-0021-0000-0000-000042A1F98D
Message-Id: <964ecdb1-3a2a-96b5-5a9c-5c12f874ea84@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-04_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804040111
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/04/2018 03:03, David Rientjes wrote:
> On Tue, 3 Apr 2018, David Rientjes wrote:
> 
>>>>> I found the root cause of this lockdep warning.
>>>>>
>>>>> In mmap_region(), unmap_region() may be called while vma_link() has not been
>>>>> called. This happens during the error path if call_mmap() failed.
>>>>>
>>>>> The only to fix that particular case is to call
>>>>> seqcount_init(&vma->vm_sequence) when initializing the vma in mmap_region().
>>>>>
>>>>
>>>> Ack, although that would require a fixup to dup_mmap() as well.
>>>
>>> You're right, I'll fix that too.
>>>
>>
>> I also think the following is needed:
>>
>> diff --git a/fs/exec.c b/fs/exec.c
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -312,6 +312,10 @@ static int __bprm_mm_init(struct linux_binprm *bprm)
>>  	vma->vm_flags = VM_SOFTDIRTY | VM_STACK_FLAGS | VM_STACK_INCOMPLETE_SETUP;
>>  	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
>>  	INIT_LIST_HEAD(&vma->anon_vma_chain);
>> +#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
>> +	seqcount_init(&vma->vm_sequence);
>> +	atomic_set(&vma->vm_ref_count, 0);
>> +#endif
>>  
>>  	err = insert_vm_struct(mm, vma);
>>  	if (err)
>>
> 
> Ugh, I think there are a number of other places where this is needed as 
> well in mm/mmap.c.  I think it would be better to just create a new 
> alloc_vma(unsigned long flags) that all vma allocators can use and for 
> CONFIG_SPECULATIVE_PAGE_FAULT will initialize the seqcount_t and atomic_t.
> 

I don't think this is really needed, most of the time the vma structure is
allocated cleared and is then link to rb tree via vma_link.

The only case generating a locked warning is when the vma is referenced in the
error path before being linked in the mm tree and that is not usual.
