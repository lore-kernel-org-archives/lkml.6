Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1167050AbeBOUvM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 15:51:12 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40966 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161064AbeBOUvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 15:51:11 -0500
X-Google-Smtp-Source: AH8x227mtVLNNdM1xD7nv7mirxdWwaC+ptEG4PjS7VjXx2L4Pvy6HUs8+rYZaHSVV4zuEzHkEusReg==
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH RFC v2 1/6] x86: Skip PTI when disable indication is set
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CALCETrXXJ7QYtexGd56+VDGOiJvmHmes7L9tKPg7dBdJnd7zeQ@mail.gmail.com>
Date: Thu, 15 Feb 2018 12:51:05 -0800
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, Willy Tarreau <w@1wt.eu>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-Id: <EA6A7DA4-77FB-4A01-A1FF-AD1F0B2D7F62@gmail.com>
References: <20180215163602.61162-1-namit@vmware.com>
 <20180215163602.61162-2-namit@vmware.com>
 <CALCETrXXJ7QYtexGd56+VDGOiJvmHmes7L9tKPg7dBdJnd7zeQ@mail.gmail.com>
To: Andy Lutomirski <luto@kernel.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1FKpIJR030725

Andy Lutomirski <luto@kernel.org> wrote:

> On Thu, Feb 15, 2018 at 4:35 PM, Nadav Amit <namit@vmware.com> wrote:
>> If PTI is disabled, we do not want to switch page-tables. On entry to
>> the kernel, this is done based on CR3 value. On return, do it according
>> to per core indication.
>> 
>> To be on the safe side, avoid speculative skipping of page-tables
>> switching when returning the userspace. This can be avoided if the CPU
>> cannot execute speculatively code without the proper permissions. When
>> switching to the kernel page-tables, this is anyhow not an issue: if PTI
>> is enabled and page-tables were not switched, the kernel part of the
>> user page-tables would not be set.
>> 
>> Signed-off-by: Nadav Amit <namit@vmware.com>
>> ---
>> arch/x86/entry/calling.h        | 33 +++++++++++++++++++++++++++++++++
>> arch/x86/include/asm/tlbflush.h | 17 +++++++++++++++--
>> arch/x86/kernel/asm-offsets.c   |  1 +
>> 3 files changed, 49 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
>> index 3f48f695d5e6..5e9895f44d11 100644
>> --- a/arch/x86/entry/calling.h
>> +++ b/arch/x86/entry/calling.h
>> @@ -216,7 +216,14 @@ For 32-bit we have the following conventions - kernel is built with
>> 
>> .macro SWITCH_TO_KERNEL_CR3 scratch_reg:req
>>        ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
>> +
>> +       /*
>> +        * Do not switch on compatibility mode.
>> +        */
> 
> That comment should just say "if we're already using kernel CR3, don't
> switch" or something like that.

ok.

> 
>>        mov     %cr3, \scratch_reg
>> +       testq   $PTI_USER_PGTABLE_MASK, \scratch_reg
>> +       jz      .Lend_\@
>> +
>>        ADJUST_KERNEL_CR3 \scratch_reg
>>        mov     \scratch_reg, %cr3
>> .Lend_\@:
>> @@ -225,8 +232,20 @@ For 32-bit we have the following conventions - kernel is built with
>> #define THIS_CPU_user_pcid_flush_mask   \
>>        PER_CPU_VAR(cpu_tlbstate) + TLB_STATE_user_pcid_flush_mask
>> 
>> +#define THIS_CPU_pti_disable \
>> +       PER_CPU_VAR(cpu_tlbstate) + TLB_STATE_pti_disable
>> +
>> .macro SWITCH_TO_USER_CR3_NOSTACK scratch_reg:req scratch_reg2:req
>>        ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
>> +
>> +       /*
>> +        * Do not switch on compatibility mode. If there is no need for a
>> +        * flush, run lfence to avoid speculative execution returning to user
>> +        * with the wrong CR3.
>> +        */
> 
> Nix the "compatibility mode" stuff please.  Also, can someone confirm
> whether the affected CPUs actually speculate through SYSRET?  Because
> your LFENCE might be so expensive that it negates a decent chunk of
> the benefit.

I will send performance numbers with in the next iteration. The LFENCE did
not introduce high overheads. Anyhow, it would surely be nice to remove it.

>> +       /*
>> +        * Cached value of mm.pti_enable to simplify and speed up kernel entry
>> +        * code.
>> +        */
>> +       unsigned short pti_disable;
> 
> Why unsigned short?
> 
> IIRC a lot of CPUs use a slow path when decoding instructions with
> 16-bit operands like cmpw, so u8 or u32 could be waaaay faster than
> u16.

Will do.

> 
>> +/* Return whether page-table isolation is disabled on this CPU */
>> +static inline unsigned short cpu_pti_disable(void)
>> +{
>> +       return this_cpu_read(cpu_tlbstate.pti_disable);
>> +}
> 
> This should return bool regardless of what type lives in the struct.

Ok. I think that it was so because I tried to support both CS64 and CS32.

> 
>> -       invalidate_user_asid(this_cpu_read(cpu_tlbstate.loaded_mm_asid));
>> +       if (!cpu_pti_disable())
>> +               invalidate_user_asid(this_cpu_read(cpu_tlbstate.loaded_mm_asid));
> 
> This will go badly wrong if pti_disable becomes dynamic.  Can you just
> leave the code as it was?

Will do.

> 
>>        /* If current->mm == NULL then the read_cr3() "borrows" an mm */
>>        native_write_cr3(__native_read_cr3());
>> @@ -404,7 +417,7 @@ static inline void __native_flush_tlb_single(unsigned long addr)
>> 
>>        asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
>> 
>> -       if (!static_cpu_has(X86_FEATURE_PTI))
>> +       if (!static_cpu_has(X86_FEATURE_PTI) || cpu_pti_disable())
>>                return;
> 
> Ditto.

As for this last one - I don’t see why. Can you please explain? If you are
only worried about enabling/disabling PTI dynamically, I can address this
specific issue by flushing the TLB when it happens.

Thanks,
Nadav
