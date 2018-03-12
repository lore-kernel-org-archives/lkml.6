Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932376AbeCLPfK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:35:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751442AbeCLPfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:35:09 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D680021778
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELud5+7hZa77puKrhimM6fgaDycd1l6ACyT/xwkfKV6CLNGS/oQqWY3i6N52nmol1aZ9Kw7NIyaDgBlljBhiXEI=
MIME-Version: 1.0
In-Reply-To: <20180312140300.6166-2-vkuznets@redhat.com>
References: <20180312140300.6166-1-vkuznets@redhat.com> <20180312140300.6166-2-vkuznets@redhat.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 12 Mar 2018 15:34:47 +0000
X-Gmail-Original-Message-ID: <CALCETrXHBQjHR0w1YhJtzPyr6G1BzcBKRvY_smGufd0b6gizXQ@mail.gmail.com>
Message-ID: <CALCETrXHBQjHR0w1YhJtzPyr6G1BzcBKRvY_smGufd0b6gizXQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/kvm/vmx: read MSR_FS_BASE from current->thread
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm list <kvm@vger.kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 2:02 PM, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> vmx_save_host_state() is only called from kvm_arch_vcpu_ioctl_run() so
> the context is pretty well defined. Read MSR_FS_BASE from
> current->thread.fsbase after calling save_fsgs() which takes care of
> X86_BUG_NULL_SEG case now and will do RD[FG,GS]BASE when FSGSBASE
> extensions are exposed to userspace (currently they are not).
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/include/asm/processor.h |  3 +++
>  arch/x86/kernel/process_64.c     | 20 ++++++++++++++++++++
>  arch/x86/kvm/vmx.c               |  4 +++-
>  3 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index b0ccd4847a58..006352b85ba3 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -410,6 +410,9 @@ DECLARE_INIT_PER_CPU(irq_stack_union);
>  DECLARE_PER_CPU(char *, irq_stack_ptr);
>  DECLARE_PER_CPU(unsigned int, irq_count);
>  extern asmlinkage void ignore_sysret(void);
> +
> +/* Save actual FS/GS selectors and bases to current->thread */
> +void save_current_fsgs(void);
>  #else  /* X86_64 */
>  #ifdef CONFIG_CC_STACKPROTECTOR
>  /*
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index 9eb448c7859d..eb907fefe02e 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -205,6 +205,26 @@ static __always_inline void save_fsgs(struct task_struct *task)
>         save_base_legacy(task, task->thread.gsindex, GS);
>  }
>
> +/*
> + * Currently, the only way for processes to change their FS/GS base is to call
> + * ARCH_SET_FS/GS prctls and these reflect changes they make in task->thread.
> + * There are, however, additional considerations:
> + *
> + * There is X86_BUG_NULL_SEG: on some CPUs writing '0' to FS/GS selectors zeroes
> + * the base and on some it doesn't, we need to check for that
> + * (see save_base_legacy()).
> + *
> + * When FSGSBASE extensions are enabled userspace processes will be able to
> + * change their FS/GS bases without kernel intervention. save_fsgs() will
> + * have to be updated to actually read FS and GS bases with RD[FG,GS]BASE
> + * instructions.
> + */

This is all a very complicated way to say "while a process is running,
current->thread.fsbase and current->thread.gsbase may not match the
corresponding CPU registers.  KVM wants an efficient way to save and
restore FSBASE and GSBASE."

And how about changing this to:

#if IS_ENABLED(CONFIG_KVM)
void save_fsgs_for_kvm(void)
{
    save_fsgs(current);
}
EXPORT_SYMBOL_GPL(save_fsgs_for_kvm);

--Andy
