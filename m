Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752207AbeBIB06 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 20:26:58 -0500
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:55668 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752021AbeBIB04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 20:26:56 -0500
From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To: Punit Agrawal <punit.agrawal@arm.com>
CC: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm: hwpoison: disable memory error handling on 1GB
 hugepage
Thread-Topic: [PATCH v2] mm: hwpoison: disable memory error handling on 1GB
 hugepage
Thread-Index: AQHToNikPYXLibQ98UmzH7feYbNX3qOarwWA
Date: Fri, 9 Feb 2018 01:17:48 +0000
Message-ID: <84c6e1f7-e693-30f3-d208-c3a094d9e3b0@ah.jp.nec.com>
References: <20180130013919.GA19959@hori1.linux.bs1.fc.nec.co.jp>
 <1517284444-18149-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <87inbbjx2w.fsf@e105922-lin.cambridge.arm.com>
 <20180207011455.GA15214@hori1.linux.bs1.fc.nec.co.jp>
 <87fu6bfytm.fsf@e105922-lin.cambridge.arm.com>
In-Reply-To: <87fu6bfytm.fsf@e105922-lin.cambridge.arm.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.128.101.2]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <F2F60818CFB5C248A8867FED819ECCCC@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2018 09:30 PM, Punit Agrawal wrote:
> Horiguchi-san,
> 
> Naoya Horiguchi <n-horiguchi@ah.jp.nec.com> writes:
> 
>> Hi Punit,
>>
>> On Mon, Feb 05, 2018 at 03:05:43PM +0000, Punit Agrawal wrote:
>>> Naoya Horiguchi <n-horiguchi@ah.jp.nec.com> writes:
>>>
> 
> [...]
> 
>>>>
>>>> You can easily reproduce this by calling madvise(MADV_HWPOISON) twice on
>>>> a 1GB hugepage. This happens because get_user_pages_fast() is not aware
>>>> of a migration entry on pud that was created in the 1st madvise() event.
>>>
>>> Maybe I'm doing something wrong but I wasn't able to reproduce the issue
>>> using the test at the end. I get -
>>>
>>>     $ sudo ./hugepage
>>>
>>>     Poisoning page...once
>>>     [  121.295771] Injecting memory failure for pfn 0x8300000 at process virtual address 0x400000000000
>>>     [  121.386450] Memory failure: 0x8300000: recovery action for huge page: Recovered
>>>
>>>     Poisoning page...once again
>>>     madvise: Bad address
>>>
>>> What am I missing?
>>
>> The test program below is exactly what I intended, so you did right
>> testing.
> 
> Thanks for the confirmation. And the flow outline below. 
> 
>> I try to guess what could happen. The related code is like below:
>>
>>   static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
>>                            int write, struct page **pages, int *nr)
>>   {
>>           ...
>>           do {
>>                   pud_t pud = READ_ONCE(*pudp);
>>
>>                   next = pud_addr_end(addr, end);
>>                   if (pud_none(pud))
>>                           return 0;
>>                   if (unlikely(pud_huge(pud))) {
>>                           if (!gup_huge_pud(pud, pudp, addr, next, write,
>>                                             pages, nr))
>>                                   return 0;
>>
>> pud_none() always returns false for hwpoison entry in any arch.
>> I guess that pud_huge() could behave in undefined manner for hwpoison entry
>> because pud_huge() assumes that a given pud has the present bit set, which
>> is not true for hwpoison entry.
> 
> This is where the arm64 helpers behaves differently (though more by
> chance then design). A poisoned pud passes pud_huge() as it doesn't seem
> to be explicitly checking for the present bit.
> 
>     int pud_huge(pud_t pud)
>     {
>             return pud_val(pud) && !(pud_val(pud) & PUD_TABLE_BIT);
>     }
> 
> 
> This doesn't lead to a crash as the first thing gup_huge_pud() does is
> check for pud_access_permitted() which does check for the present bit.
> 
> I was able to crash the kernel by changing pud_huge() to check for the
> present bit.
> 
>> As a result, pud_huge() checks an irrelevant bit used for other
>> purpose depending on non-present page table format of each arch. If
>> pud_huge() returns false for hwpoison entry, we try to go to the lower
>> level and the kernel highly likely to crash. So I guess your kernel
>> fell back the slow path and somehow ended up with returning EFAULT.
> 
> Makes sense. Due to the difference above on arm64, it ends up falling
> back to the slow path which eventually returns -EFAULT (via
> follow_hugetlb_page) for poisoned pages.
> 
>>
>> So I don't think that the above test result means that errors are properly
>> handled, and the proposed patch should help for arm64.
> 
> Although, the deviation of pud_huge() avoids a kernel crash the code
> would be easier to maintain and reason about if arm64 helpers are
> consistent with expectations by core code.
> 
> I'll look to update the arm64 helpers once this patch gets merged. But
> it would be helpful if there was a clear expression of semantics for
> pud_huge() for various cases. Is there any version that can be used as
> reference?

Sorry if I misunderstand you, but with this patch there is no non-present
pud entry, so I feel that you don't have to change pud_huge() in arm64.

When we get to have non-present pud entries (by enabling hwpoison or 1GB
hugepage migration), we need to explicitly check pud_present in every page
table walk. So I think the current semantics is like:

  if (pud_none(pud))
          /* skip this entry */
  else if (pud_huge(pud))
          /* do something for pud-hugetlb */
  else
          /* go to next (pmd) level */

and after enabling hwpoison or migartion:

  if (pud_none(pud))
          /* skip this entry */
  else if (!pud_present(pud))
          /* do what we need to handle peculiar cases */
  else if (pud_huge(pud))
          /* do something for pud-hugetlb */
  else
          /* go to next (pmd) level */

What we did for pmd can also be a reference to what we do for pud.

> 
> Also, do you know what the plans are for re-enabling hugepage poisoning
> disabled here?

I'd like to say yes, but it's not specific one because breaking pud isn't
a easy/simple task. But 1GB hugetlb is becoming more important, so we
might have to have code for it.

Thanks,
Naoya Horiguchi
