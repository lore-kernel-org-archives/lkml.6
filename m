Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932614AbeENPKF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 11:10:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43836 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752311AbeENPKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 11:10:03 -0400
Subject: Re: [PATCH v10 06/25] mm: make pte_unmap_same compatible with SPF
To: vinayak menon <vinayakm.list@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kirill@shutemov.name,
        ak@linux.intel.com, dave@stgolabs.net, jack@suse.cz,
        Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
        mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
        sergey.senozhatsky.work@gmail.com,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Ganesh Mahendran <opensource.ganesh@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
        npiggin@gmail.com, bsingharora@gmail.com,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, Vinayak Menon <vinmenon@codeaurora.org>
References: <1523975611-15978-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1523975611-15978-7-git-send-email-ldufour@linux.vnet.ibm.com>
 <CAOaiJ-n6P-hjBEkiR4+MyFYunocPgzAYkG1wALDcmi7ROe4-ag@mail.gmail.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Mon, 14 May 2018 17:09:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAOaiJ-n6P-hjBEkiR4+MyFYunocPgzAYkG1wALDcmi7ROe4-ag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18051415-0008-0000-0000-000004F65F67
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051415-0009-0000-0000-00001E8ABF88
Message-Id: <e543c7a9-5aff-3f87-4ccf-e7da345f5bb1@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140156
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/05/2018 18:15, vinayak menon wrote:
> On Tue, Apr 17, 2018 at 8:03 PM, Laurent Dufour
> <ldufour@linux.vnet.ibm.com> wrote:
>> pte_unmap_same() is making the assumption that the page table are still
>> around because the mmap_sem is held.
>> This is no more the case when running a speculative page fault and
>> additional check must be made to ensure that the final page table are still
>> there.
>>
>> This is now done by calling pte_spinlock() to check for the VMA's
>> consistency while locking for the page tables.
>>
>> This is requiring passing a vm_fault structure to pte_unmap_same() which is
>> containing all the needed parameters.
>>
>> As pte_spinlock() may fail in the case of a speculative page fault, if the
>> VMA has been touched in our back, pte_unmap_same() should now return 3
>> cases :
>>         1. pte are the same (0)
>>         2. pte are different (VM_FAULT_PTNOTSAME)
>>         3. a VMA's changes has been detected (VM_FAULT_RETRY)
>>
>> The case 2 is handled by the introduction of a new VM_FAULT flag named
>> VM_FAULT_PTNOTSAME which is then trapped in cow_user_page().
>> If VM_FAULT_RETRY is returned, it is passed up to the callers to retry the
>> page fault while holding the mmap_sem.
>>
>> Acked-by: David Rientjes <rientjes@google.com>
>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>> ---
>>  include/linux/mm.h |  1 +
>>  mm/memory.c        | 39 ++++++++++++++++++++++++++++-----------
>>  2 files changed, 29 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 4d1aff80669c..714da99d77a3 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -1208,6 +1208,7 @@ static inline void clear_page_pfmemalloc(struct page *page)
>>  #define VM_FAULT_NEEDDSYNC  0x2000     /* ->fault did not modify page tables
>>                                          * and needs fsync() to complete (for
>>                                          * synchronous page faults in DAX) */
>> +#define VM_FAULT_PTNOTSAME 0x4000      /* Page table entries have changed */
> 
> 
> This has to be added to VM_FAULT_RESULT_TRACE ?

Indeed there is no chance that the macro VM_FAULT_RESULT_TRACE would have to
translate that code to a string since VM_FAULT_PTNOTSAME is currently only
returned by pte_unmap_same() and then converted by its only caller
do_swap_page() to return 0. So VM_FAULT_PTNOTSAME is not expected to be seen
outside of these services which are never using VM_FAULT_RESULT_TRACE().

This being said, this may be a good idea to add it in the case of future
potential usage.
