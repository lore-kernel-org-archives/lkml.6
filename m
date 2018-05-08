Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755745AbeEHVEO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 17:04:14 -0400
Received: from mail-pl0-f44.google.com ([209.85.160.44]:45056 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755620AbeEHVEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 17:04:10 -0400
X-Google-Smtp-Source: AB8JxZqB6TTZl65gHJ63IHa2zURFiRmWdGHQxBMlZ13F2evT5QSD0HhzOnxTlVklA7Ft+kJg7bzBnw==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: Proof-of-concept: better(?) page-table manipulation API
From: Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15E302)
In-Reply-To: <20180507113124.ewpbrfd3anyg7pli@kshutemo-mobl1>
Date: Tue, 8 May 2018 14:04:07 -0700
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Message-Id: <C56B16CA-CADF-4270-85E5-776E9219D41A@amacapital.net>
References: <20180424154355.mfjgkf47kdp2by4e@black.fi.intel.com> <CALCETrVzD8oPv=h2q91AMdCHn3S782GmvsY-+mwoaPUw=5N7HQ@mail.gmail.com> <20180507113124.ewpbrfd3anyg7pli@kshutemo-mobl1>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w48L4Lbv013447



>> On May 7, 2018, at 4:31 AM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
>> 
>> On Mon, May 07, 2018 at 04:51:57AM +0000, Andy Lutomirski wrote:
>> On Tue, Apr 24, 2018 at 8:44 AM Kirill A. Shutemov <
>> kirill.shutemov@linux.intel.com> wrote:
>> 
>>> Hi everybody,
>> 
>>> I've proposed to talk about page able manipulation API on the LSF/MM'2018,
>>> so I need something material to talk about.
>> 
>> 
>> I gave it a quick read.  I like the concept a lot, and I have a few
>> comments.
> 
> Thank you for the input.
> 
>>> +/*
>>> + * How manu bottom level we account to mm->pgtables_bytes
>>> + */
>>> +#define PT_ACCOUNT_LVLS 3
>>> +
>>> +struct pt_ptr {
>>> +       unsigned long *ptr;
>>> +       int lvl;
>>> +};
>>> +
>> 
>> I think you've inherited something that I consider to be a defect in the
>> old code: you're conflating page *tables* with page table *entries*.  Your
>> 'struct pt_ptr' sounds like a pointer to an entire page table, but AFAICT
>> you're using it to point to a specific entry within a table.  I think that
>> both the new core code and the code that uses it would be clearer and less
>> error prone if you made the distinction explicit.  I can think of two clean
>> ways to do it:
>> 
>> 1. Add a struct pt_entry_ptr, and make it so that get_ptv(), etc take a
>> pt_entry_ptr instead of a pt_ptr.  Add a helper to find a pt_entry_ptr
>> given a pt_ptr and either an index or an address.
>> 
>> 2. Don't allow pointers to page table entries at all.  Instead, get_ptv()
>> would take an address or an index parameter.
> 
> Well, I'm not sure how useful pointer to whole page tables are.
> Where do you them useful?

Hmm, that’s a fair question. I guess that, in your patch, you pass around a ptv_t when you want to refer to a whole page table. That seems to work okay. Maybe still rename ptp_t to ptep_t or similar to emphasize that it points to an entry, not a table.

That being said, once you implement map/unmap for real, it might be more natural for map to return a pointer to a table rather than a pointer to an entry.

> 
>  In x86-64 case I pretend that CR3 is single-entry page table. It
>  requires a special threatement in ptp_page_vaddr(), but works fine
>  otherwise.
> 

Hmm. If you stick with that, it definitely needs better comments. Why do you need this, though?  What’s the benefit over simply starting with a pointer to the root table or a pointer to the first entry in the root table?  We certainly don’t want anyone to do ptp_set() on the fake CR3 entry.

> 
>> 
>>> +/*
>>> + * When walking page tables, get the address of the next boundary,
>>> + * or the end address of the range if that comes earlier.  Although no
>>> + * vma end wraps to 0, rounded up __boundary may wrap to 0 throughout.
>>> + */
>> 
>> I read this comment twice, and I still don't get it.  Can you clarify what
>> this function does and why you would use it?
> 
> That's basically ported variant of p?d_addr_end. It helps step address by
> right value for the page table entry and handles wrapping properly.
> 
> See example in copy_pt_range().

Ok

> 
>>> +/* Operations on page table pointers */
>>> +
>>> +/* Initialize ptp_t with pointer to top page table level. */
>>> +static inline ptp_t ptp_init(struct mm_struct *mm)
>>> +{
>>> +       struct pt_ptr ptp ={
>>> +               .ptr = (unsigned long *)mm->pgd,
>>> +               .lvl = PT_TOP_LEVEL,
>>> +       };
>>> +
>>> +       return ptp;
>>> +}
>>> +
>> 
>> On some architectures, there are multiple page table roots.  For example,
>> ARM64 has a root for the kernel half of the address space and a root for
>> the user half (at least -- I don't fully understand it).  x86 PAE sort-of
>> has four roots.  Would it make sense to expose this in the API for
>> real?
> 
> I will give it a thought.
> 
> Is there a reason not to threat it as an additional page table layer and
> deal with it in a unified way?

I was thinking that it would be more confusing to treat it as one table. After all, it doesn’t exist in memory. Also, if anyone ever makes the top half be per-cpu and the bottom half be per-mm (which would be awesome if x86 had hardware support, hint hint), then pretending that it’s one table gets even weirder.  The code that emulates it as a table would have to know what mm *and* what CPU it is faking.

> 
> 
>>> +static inline void ptp_walk(ptp_t *ptp, unsigned long addr)
>>> +{
>>> +       ptp->ptr = (unsigned long *)ptp_page_vaddr(ptp);
>>> +       ptp->ptr += __pt_index(addr, --ptp->lvl);
>>> +}
>> 
>> Can you add a comment that says what this function does?
> 
> Okay, I will.
> 
>> Why does it not change the level?
> 
> It does. --ptp->lvl.

Hmm.

Maybe change this to ptp_t ptp_walk(ptp_t ptp, unsigned long addr)?  It’s less error prone and should generate identical code.

> 
>>> +
>>> +static void ptp_free(struct mm_struct *mm, ptv_t ptv)
>>> +{
>>> +       if (ptv.lvl < PT_SPLIT_LOCK_LVLS)
>>> +               ptlock_free(pfn_to_page(ptv_pfn(ptv)));
>>> +}
>>> +
>> 
>> As it stands, this is a function that seems easy easy to misuse given the
>> confusion between page tables and page table entries.
> 
> Hm. I probably have a blind spot, but I don't see it.
> 

Hmm, I guess you’re right - it takes a ptv_t.

>> Finally, a general comment.  Actually fully implementing this the way
>> you've done it seems like a giant mess given that you need to support all
>> architectures.  But couldn't you implement the new API as a wrapper around
>> the old API so you automatically get all architectures?
> 
> I will look into this. But I'm not sure if it possbile without measurable
> overhead.
> 

So what?  Make x86 fast and everything else slow but correct. POWER, ARM64, and s390 will make themes fast. Everyone else can, too, if they care.
