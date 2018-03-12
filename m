Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932661AbeCLPz0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:55:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932494AbeCLPzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:55:24 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: kvm list <kvm@vger.kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/3] x86/kvm/vmx: read MSR_FS_BASE from current->thread
References: <20180312140300.6166-1-vkuznets@redhat.com>
        <20180312140300.6166-2-vkuznets@redhat.com>
        <CALCETrXHBQjHR0w1YhJtzPyr6G1BzcBKRvY_smGufd0b6gizXQ@mail.gmail.com>
Date: Mon, 12 Mar 2018 16:55:21 +0100
In-Reply-To: <CALCETrXHBQjHR0w1YhJtzPyr6G1BzcBKRvY_smGufd0b6gizXQ@mail.gmail.com>
        (Andy Lutomirski's message of "Mon, 12 Mar 2018 15:34:47 +0000")
Message-ID: <87muzdcmqe.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:

> On Mon, Mar 12, 2018 at 2:02 PM, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>> vmx_save_host_state() is only called from kvm_arch_vcpu_ioctl_run() so
>> the context is pretty well defined. Read MSR_FS_BASE from
>> current->thread.fsbase after calling save_fsgs() which takes care of
>> X86_BUG_NULL_SEG case now and will do RD[FG,GS]BASE when FSGSBASE
>> extensions are exposed to userspace (currently they are not).
>>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/include/asm/processor.h |  3 +++
>>  arch/x86/kernel/process_64.c     | 20 ++++++++++++++++++++
>>  arch/x86/kvm/vmx.c               |  4 +++-
>>  3 files changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
>> index b0ccd4847a58..006352b85ba3 100644
>> --- a/arch/x86/include/asm/processor.h
>> +++ b/arch/x86/include/asm/processor.h
>> @@ -410,6 +410,9 @@ DECLARE_INIT_PER_CPU(irq_stack_union);
>>  DECLARE_PER_CPU(char *, irq_stack_ptr);
>>  DECLARE_PER_CPU(unsigned int, irq_count);
>>  extern asmlinkage void ignore_sysret(void);
>> +
>> +/* Save actual FS/GS selectors and bases to current->thread */
>> +void save_current_fsgs(void);
>>  #else  /* X86_64 */
>>  #ifdef CONFIG_CC_STACKPROTECTOR
>>  /*
>> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
>> index 9eb448c7859d..eb907fefe02e 100644
>> --- a/arch/x86/kernel/process_64.c
>> +++ b/arch/x86/kernel/process_64.c
>> @@ -205,6 +205,26 @@ static __always_inline void save_fsgs(struct task_struct *task)
>>         save_base_legacy(task, task->thread.gsindex, GS);
>>  }
>>
>> +/*
>> + * Currently, the only way for processes to change their FS/GS base is to call
>> + * ARCH_SET_FS/GS prctls and these reflect changes they make in task->thread.
>> + * There are, however, additional considerations:
>> + *
>> + * There is X86_BUG_NULL_SEG: on some CPUs writing '0' to FS/GS selectors zeroes
>> + * the base and on some it doesn't, we need to check for that
>> + * (see save_base_legacy()).
>> + *
>> + * When FSGSBASE extensions are enabled userspace processes will be able to
>> + * change their FS/GS bases without kernel intervention. save_fsgs() will
>> + * have to be updated to actually read FS and GS bases with RD[FG,GS]BASE
>> + * instructions.
>> + */
>
> This is all a very complicated way to say "while a process is running,
> current->thread.fsbase and current->thread.gsbase may not match the
> corresponding CPU registers.  KVM wants an efficient way to save and
> restore FSBASE and GSBASE."
>

Well, I though it is not really obvious why "current->thread.fsbase and
current->thread.gsbase may not match the corresponding CPU registers"
:-) but save_base_legacy() is really nearby so I'll trim my comment in
v2.

> And how about changing this to:
>
> #if IS_ENABLED(CONFIG_KVM)
> void save_fsgs_for_kvm(void)
> {
>     save_fsgs(current);
> }
> EXPORT_SYMBOL_GPL(save_fsgs_for_kvm);
>

Sure. Actually, there is nothing KVM-specific in this function but KVM
will probably be the only user for the time being.

-- 
  Vitaly
