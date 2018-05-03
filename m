Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbeECO7d (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 10:59:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42200 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751069AbeECO73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 10:59:29 -0400
Subject: Re: [PATCH v10 24/25] x86/mm: add speculative pagefault handling
To: Punit Agrawal <punitagrawal@gmail.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, peterz@infradead.org,
        kirill@shutemov.name, ak@linux.intel.com, dave@stgolabs.net,
        jack@suse.cz, Matthew Wilcox <willy@infradead.org>,
        benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
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
        npiggin@gmail.com, bsingharora@gmail.com, paulmck@linux.vnet.ibm.com,
        Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org
References: <1523975611-15978-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1523975611-15978-25-git-send-email-ldufour@linux.vnet.ibm.com>
 <CAD4BONd5DZiKkGPGaYqEcVb+YubVDy43MNNQ8_yztDHWpf0Y7w@mail.gmail.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Thu, 3 May 2018 16:59:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAD4BONd5DZiKkGPGaYqEcVb+YubVDy43MNNQ8_yztDHWpf0Y7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18050314-0008-0000-0000-000004F29C78
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050314-0009-0000-0000-00001E86C421
Message-Id: <fb143123-d54e-b08d-1bd8-07767c86c7d0@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805030131
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2018 20:43, Punit Agrawal wrote:
> Hi Laurent,
> 
> I am looking to add support for speculative page fault handling to
> arm64 (effectively porting this patch) and had a few questions.
> Apologies if I've missed an obvious explanation for my queries. I'm
> jumping in bit late to the discussion.

Hi Punit,

Thanks for giving this series a review.
I don't have arm64 hardware to play with, but I'll be happy to add arm64
patches to my series and to try to maintain them.

> 
> On Tue, Apr 17, 2018 at 3:33 PM, Laurent Dufour
> <ldufour@linux.vnet.ibm.com> wrote:
>> From: Peter Zijlstra <peterz@infradead.org>
>>
>> Try a speculative fault before acquiring mmap_sem, if it returns with
>> VM_FAULT_RETRY continue with the mmap_sem acquisition and do the
>> traditional fault.
>>
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>
>> [Clearing of FAULT_FLAG_ALLOW_RETRY is now done in
>>  handle_speculative_fault()]
>> [Retry with usual fault path in the case VM_ERROR is returned by
>>  handle_speculative_fault(). This allows signal to be delivered]
>> [Don't build SPF call if !CONFIG_SPECULATIVE_PAGE_FAULT]
>> [Try speculative fault path only for multi threaded processes]
>> [Try reuse to the VMA fetch during the speculative path in case of retry]
>> [Call reuse_spf_or_find_vma()]
>> [Handle memory protection key fault]
>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>> ---
>>  arch/x86/mm/fault.c | 42 ++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 38 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>> index 73bd8c95ac71..59f778386df5 100644
>> --- a/arch/x86/mm/fault.c
>> +++ b/arch/x86/mm/fault.c
>> @@ -1220,7 +1220,7 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
>>         struct mm_struct *mm;
>>         int fault, major = 0;
>>         unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
>> -       u32 pkey;
>> +       u32 pkey, *pt_pkey = &pkey;
>>
>>         tsk = current;
>>         mm = tsk->mm;
>> @@ -1310,6 +1310,30 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
>>                 flags |= FAULT_FLAG_INSTRUCTION;
>>
>>         /*
>> +        * Do not try speculative page fault for kernel's pages and if
>> +        * the fault was due to protection keys since it can't be resolved.
>> +        */
>> +       if (IS_ENABLED(CONFIG_SPECULATIVE_PAGE_FAULT) &&
>> +           !(error_code & X86_PF_PK)) {
> 
> You can simplify this condition by dropping the IS_ENABLED() check as
> you already provide an alternate implementation of
> handle_speculative_fault() when CONFIG_SPECULATIVE_PAGE_FAULT is not
> defined.

Yes you're right, I completely forgot about that define of
handle_speculative_fault() when CONFIG_SPECULATIVE_PAGE_FAULT is not set, that
will definitively makes that part of code more readable.

> 
>> +               fault = handle_speculative_fault(mm, address, flags, &vma);
>> +               if (fault != VM_FAULT_RETRY) {
>> +                       perf_sw_event(PERF_COUNT_SW_SPF, 1, regs, address);
>> +                       /*
>> +                        * Do not advertise for the pkey value since we don't
>> +                        * know it.
>> +                        * This is not a matter as we checked for X86_PF_PK
>> +                        * earlier, so we should not handle pkey fault here,
>> +                        * but to be sure that mm_fault_error() callees will
>> +                        * not try to use it, we invalidate the pointer.
>> +                        */
>> +                       pt_pkey = NULL;
>> +                       goto done;
>> +               }
>> +       } else {
>> +               vma = NULL;
>> +       }
> 
> The else part can be dropped if vma is initialised to NULL when it is
> declared at the top of the function.
Sure.

> 
>> +
>> +       /*
>>          * When running in the kernel we expect faults to occur only to
>>          * addresses in user space.  All other faults represent errors in
>>          * the kernel and should generate an OOPS.  Unfortunately, in the
>> @@ -1342,7 +1366,8 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
>>                 might_sleep();
>>         }
>>
>> -       vma = find_vma(mm, address);
>> +       if (!vma || !can_reuse_spf_vma(vma, address))
>> +               vma = find_vma(mm, address);
> 
> Is there a measurable benefit from reusing the vma?
> 
> Dropping the vma reference unconditionally after speculative page
> fault handling gets rid of the implicit state when "vma != NULL"
> (increased ref-count). I found it a bit confusing to follow.

I do agree, this is quite confusing. My initial goal was to be able to reuse
the VMA in the case a protection key error was detected, but it's not really
necessary on x86 since we know at the beginning of the fault operation that
protection key are in the loop. This is not the case on ppc64 but I couldn't
find a way to easily rely on the speculatively fetched VMA neither, so for
protection keys, this didn't help.

Regarding the measurable benefit of reusing the fetched vma, I did further
tests using will-it-scale/page_fault2_threads test, and I'm no more really
convince that this worth the added complexity. I think I'll drop the patch "mm:
speculative page fault handler return VMA" of the series, and thus remove the
call to can_reuse_spf_vma().

Thanks,
Laurent.

> 
>>         if (unlikely(!vma)) {
>>                 bad_area(regs, error_code, address);
>>                 return;
>> @@ -1409,8 +1434,15 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
>>                 if (flags & FAULT_FLAG_ALLOW_RETRY) {
>>                         flags &= ~FAULT_FLAG_ALLOW_RETRY;
>>                         flags |= FAULT_FLAG_TRIED;
>> -                       if (!fatal_signal_pending(tsk))
>> +                       if (!fatal_signal_pending(tsk)) {
>> +                               /*
>> +                                * Do not try to reuse this vma and fetch it
>> +                                * again since we will release the mmap_sem.
>> +                                */
>> +                               if (IS_ENABLED(CONFIG_SPECULATIVE_PAGE_FAULT))
>> +                                       vma = NULL;
> 
> Regardless of the above comment, can the vma be reset here unconditionally?
> 
> Thanks,
> Punit
> 
