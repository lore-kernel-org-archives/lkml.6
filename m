Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752863AbeDKJJO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:09:14 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:43306 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751960AbeDKJJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:09:10 -0400
Subject: Re: [PATCH v3 2/2] mm: remove odd HAVE_PTE_SPECIAL
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        mhocko@kernel.org, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Vineet Gupta <vgupta@synopsys.com>, Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <1523433816-14460-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1523433816-14460-3-git-send-email-ldufour@linux.vnet.ibm.com>
 <de6ee514-8b7e-24d0-a7ee-a8887e8b0ae9@c-s.fr>
 <93ed4fe4-dd1e-51be-948b-d53b16de21c5@linux.vnet.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <278a5212-b962-9a3a-cc86-76cac744afab@c-s.fr>
Date: Wed, 11 Apr 2018 11:09:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <93ed4fe4-dd1e-51be-948b-d53b16de21c5@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 11/04/2018 à 11:03, Laurent Dufour a écrit :
> 
> 
> On 11/04/2018 10:58, Christophe LEROY wrote:
>>
>>
>> Le 11/04/2018 à 10:03, Laurent Dufour a écrit :
>>> Remove the additional define HAVE_PTE_SPECIAL and rely directly on
>>> CONFIG_ARCH_HAS_PTE_SPECIAL.
>>>
>>> There is no functional change introduced by this patch
>>>
>>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>>> ---
>>>    mm/memory.c | 19 ++++++++-----------
>>>    1 file changed, 8 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 96910c625daa..7f7dc7b2a341 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -817,17 +817,12 @@ static void print_bad_pte(struct vm_area_struct *vma,
>>> unsigned long addr,
>>>     * PFNMAP mappings in order to support COWable mappings.
>>>     *
>>>     */
>>> -#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
>>> -# define HAVE_PTE_SPECIAL 1
>>> -#else
>>> -# define HAVE_PTE_SPECIAL 0
>>> -#endif
>>>    struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>>>                     pte_t pte, bool with_public_device)
>>>    {
>>>        unsigned long pfn = pte_pfn(pte);
>>>    -    if (HAVE_PTE_SPECIAL) {
>>> +    if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL)) {
>>>            if (likely(!pte_special(pte)))
>>>                goto check_pfn;
>>>            if (vma->vm_ops && vma->vm_ops->find_special_page)
>>> @@ -862,7 +857,7 @@ struct page *_vm_normal_page(struct vm_area_struct *vma,
>>> unsigned long addr,
>>>            return NULL;
>>>        }
>>>    -    /* !HAVE_PTE_SPECIAL case follows: */
>>> +    /* !CONFIG_ARCH_HAS_PTE_SPECIAL case follows: */
>>>          if (unlikely(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP))) {
>>>            if (vma->vm_flags & VM_MIXEDMAP) {
>>> @@ -881,7 +876,8 @@ struct page *_vm_normal_page(struct vm_area_struct *vma,
>>> unsigned long addr,
>>>          if (is_zero_pfn(pfn))
>>>            return NULL;
>>> -check_pfn:
>>> +
>>> +check_pfn: __maybe_unused
>>
>> See below
>>
>>>        if (unlikely(pfn > highest_memmap_pfn)) {
>>>            print_bad_pte(vma, addr, pte, NULL);
>>>            return NULL;
>>> @@ -891,7 +887,7 @@ struct page *_vm_normal_page(struct vm_area_struct *vma,
>>> unsigned long addr,
>>>         * NOTE! We still have PageReserved() pages in the page tables.
>>>         * eg. VDSO mappings can cause them to exist.
>>>         */
>>> -out:
>>> +out: __maybe_unused
>>
>> Why do you need that change ?
>>
>> There is no reason for the compiler to complain. It would complain if the goto
>> was within a #ifdef, but all the purpose of using IS_ENABLED() is to allow the
>> compiler to properly handle all possible cases. That's all the force of
>> IS_ENABLED() compared to ifdefs, and that the reason why they are plebicited,
>> ref Linux Codying style for a detailed explanation.
> 
> Fair enough.
> 
> Should I submit a v4 just to remove these so ugly __maybe_unused ?
> 

Most likely, unless the mm maintainer agrees to remove them by himself 
when applying your patch ?

Christophe
