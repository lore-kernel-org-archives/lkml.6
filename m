Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525271923; cv=none;
        d=google.com; s=arc-20160816;
        b=0zXoTD8Pgvt+A7P5NJJMshTykVbDjP1cpQfdJYdLbnAAUQR5CzzLzI4sRHuWlnlD6N
         zEehqCbOaKBunjYxECbNMZdKVwauoAvVgJl++11E+elOoItc4dx7Y4DMYbVgU1xqGFcf
         3yor+0wgMaBwQWOE/imI5/fDiyTXuUilSIX9bC9K2cDLpsJn0WIKB2W/kPBy3V7pKg0M
         2kNQA1Oc3GWyxH7zXOX4567DWsIxrV0N4d1yE5t5VQsYHhtssE8H+QHvmkZLX6UtAaY3
         cSiIpHHaRDHPTNIG4Vm4SJk8XimQwaszL9IuirWUV85+mlnjMz8LqvT6/3Bo4WkAPC8+
         nEHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=DXU0ue7x0O5Z2LY9ESQDuy7uCc1Z+sCJDx4n4/AVxi0=;
        b=t3ZJTPnxVjMqleWZOCUkyoDbC6uQx8R1BQrIymQdRivxINpKkx1r66XfDvIQ9J9+zJ
         esejUs06RJ+tZ8aGVS74DjwYXlUF8bQ7AbzjHXjCQrKaIs7+jgFE+QVXqneoouu5X6j3
         QzArn9/cbY9X3kAWbjSRnjznv0IPWBT8HVA+PcYKJI2L/AgHt7zbSGlhmw8hFFqp8Ozb
         7nQzUJ4/AgHOn5WF6Hp4UEzXJ2+kW0q+LkhxTrlOa4xLqOnvHcFjeYXE3GWvij123q4Q
         /1BreRB+Cr7NHTKyZGIjw7M9igV0dHg5yHe1yd6OBO0GtbjtSFOOict8cMp+d3/MJfEU
         RucQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=luHD/RO1;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=luHD/RO1;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AB8JxZoV9iQFv8pLmN1CdwSNsYbEoZN8AXd9juaA1vjowJKYmTHzaBfy/MraSWa0Wr0qBhTDIEYnj9EbtK4zMco6wvU=
MIME-Version: 1.0
In-Reply-To: <20180426174714.4jtb72q56w3xonsa@armageddon.cambridge.arm.com>
References: <cover.1524077494.git.andreyknvl@google.com> <0db34d04fa16be162336106e3b4a94f3dacc0af4.1524077494.git.andreyknvl@google.com>
 <20180426174714.4jtb72q56w3xonsa@armageddon.cambridge.arm.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Wed, 2 May 2018 16:38:42 +0200
Message-ID: <CAAeHK+zY8p9E4FZa7mbdgR=wR0u-RDS552dn=h9fKRC-ArYLdw@mail.gmail.com>
Subject: Re: [PATCH 4/6] mm, arm64: untag user addresses in mm/gup.c
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>,
	Al Viro <viro@zeniv.linux.org.uk>, James Morse <james.morse@arm.com>,
	Kees Cook <keescook@chromium.org>, Bart Van Assche <bart.vanassche@wdc.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>, Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Zi Yan <zi.yan@cs.rutgers.edu>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-doc@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>, Jacob Bramley <Jacob.Bramley@arm.com>,
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Lee Smith <Lee.Smith@arm.com>,
	Kostya Serebryany <kcc@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Evgeniy Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598111199483906995?=
X-GMAIL-MSGID: =?utf-8?q?1599363532352517668?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 7:47 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:

My approach with this was to add untagging to every gup.c function
that is exposed for external use, but perhaps adding untagging only
where it is actually required is a better approach.

> On Wed, Apr 18, 2018 at 08:53:13PM +0200, Andrey Konovalov wrote:
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 76af4cfeaf68..fb375de7d40d 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -386,6 +386,8 @@ struct page *follow_page_mask(struct vm_area_struct *vma,
>>       struct page *page;
>>       struct mm_struct *mm = vma->vm_mm;
>>
>> +     address = untagged_addr(address);
>> +
>>       *page_mask = 0;
>>
>>       /* make this handle hugepd */
>
> Does having a tagged address here makes any difference? I couldn't hit a
> failure with my simple tests (LD_PRELOAD a library that randomly adds
> tags to pointers returned by malloc).

I think you're right, follow_page_mask is only called from
__get_user_pages, which already untagged the address. I'll remove
untagging here.

>
>> @@ -647,6 +649,8 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
>>       if (!nr_pages)
>>               return 0;
>>
>> +     start = untagged_addr(start);
>> +
>>       VM_BUG_ON(!!pages != !!(gup_flags & FOLL_GET));
>>
>>       /*
>> @@ -801,6 +805,8 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
>>       struct vm_area_struct *vma;
>>       int ret, major = 0;
>>
>> +     address = untagged_addr(address);
>> +
>>       if (unlocked)
>>               fault_flags |= FAULT_FLAG_ALLOW_RETRY;
>>
>> @@ -854,6 +860,8 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
>>       long ret, pages_done;
>>       bool lock_dropped;
>>
>> +     start = untagged_addr(start);
>> +
>>       if (locked) {
>>               /* if VM_FAULT_RETRY can be returned, vmas become invalid */
>>               BUG_ON(vmas);
>
> Isn't __get_user_pages() untagging enough to cover this case as well?
> Can this function not cope with tagged pointers?

Yes, I think you're right here as well. I'll remove untagging here.

>
>> @@ -1751,6 +1759,8 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
>>       unsigned long flags;
>>       int nr = 0;
>>
>> +     start = untagged_addr(start);
>> +
>>       start &= PAGE_MASK;
>>       addr = start;
>>       len = (unsigned long) nr_pages << PAGE_SHIFT;
>> @@ -1803,6 +1813,8 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
>>       unsigned long addr, len, end;
>>       int nr = 0, ret = 0;
>>
>> +     start = untagged_addr(start);
>> +
>>       start &= PAGE_MASK;
>>       addr = start;
>>       len = (unsigned long) nr_pages << PAGE_SHIFT;
>
> Have you hit a problem with the fast gup functions and tagged pointers?
> The page table walking macros (e.g. p*d_index()) should mask the tag out
> already.

I didn't hit a problem, but the plan was to add untagging to all gup.c
interface functions as I mentioned above. Here get_user_pages_fast can
cope with tagged addresses as long as gup_pgd_range can. And looks
like the latter can indeed do that since it only uses addr through the
page table walking macros you mentioned. I'll remove untagging here as
well.

Thanks!
