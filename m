Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932989AbeCEKEJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 05:04:09 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55542 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751824AbeCEKEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 05:04:07 -0500
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH RFC 3/3] x86/kvm/vmx: avoid expensive rdmsr for MSR_GS_BASE
References: <20180302105503.24428-1-vkuznets@redhat.com>
        <20180302105503.24428-4-vkuznets@redhat.com>
        <CALCETrVhRP5W8jS0a+_Kq8BqJatszz0vu6keB=M7kr5c=KLi4g@mail.gmail.com>
Date: Mon, 05 Mar 2018 11:04:04 +0100
In-Reply-To: <CALCETrVhRP5W8jS0a+_Kq8BqJatszz0vu6keB=M7kr5c=KLi4g@mail.gmail.com>
        (Andy Lutomirski's message of "Fri, 2 Mar 2018 20:20:54 +0000")
Message-ID: <87zi3mzvmz.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:

> On Fri, Mar 2, 2018 at 10:55 AM, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>> vmx_save_host_state() is only called from kvm_arch_vcpu_ioctl_run() so
>> the context is pretty well defined and as we're past 'swapgs' MSR_GS_BASE
>> should contain kernel's GS base which we point to irq_stack_union.
>>
>> irq_stack_union needs to be exported as KVM can be a module.
>>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/kernel/cpu/common.c | 1 +
>>  arch/x86/kvm/vmx.c           | 3 ++-
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
>> index 348cf4821240..057393711093 100644
>> --- a/arch/x86/kernel/cpu/common.c
>> +++ b/arch/x86/kernel/cpu/common.c
>> @@ -1398,6 +1398,7 @@ __setup("clearcpuid=", setup_clearcpuid);
>>  #ifdef CONFIG_X86_64
>>  DEFINE_PER_CPU_FIRST(union irq_stack_union,
>>                      irq_stack_union) __aligned(PAGE_SIZE) __visible;
>> +EXPORT_PER_CPU_SYMBOL(irq_stack_union);
>
> GPL.
>
> Also, can you add a static inline unsigned long
> this_cpu_kernelmode_gs_base() that returns the actual value and then
> use it here and in arch/x86/cpu/common.c?  I really don't like the way
> that KVM code hardcodes all kinds of assumptions about how the rest of
> the x86 code works rather than improving the x86 code to have the
> right hooks for KVM's use.

Sure, will do.

Doing plain rdmsr() in KVM is definitely cleaner and less fragile but
assuming 240 cpu cycles I'm cutting with this series justify the
increased complexity suggestions to avoid hardcoding x86 internals and
make clean API are more than welcome. Thank you!

-- 
  Vitaly
