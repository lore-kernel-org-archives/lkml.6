Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751578AbeENFPE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 01:15:04 -0400
Received: from mail-pl0-f48.google.com ([209.85.160.48]:36161 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeENFPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 01:15:02 -0400
X-Google-Smtp-Source: AB8JxZptukWvpvLY6tgGLk2xG4zZ90lV3uSzMGWQe5PWsYTegPwgovcd+4oCh0BDRYomeCaS9axyj5WdT2f8k/7D2dQ=
MIME-Version: 1.0
In-Reply-To: <20180514030205.GI677@sol.localdomain>
References: <20180514030007.GH677@sol.localdomain> <20180514030205.GI677@sol.localdomain>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 14 May 2018 07:14:41 +0200
Message-ID: <CACT4Y+bV3HQTZ5+ugQmukiiJBkhN_FWqPRuNRYRbe6xoKstWVA@mail.gmail.com>
Subject: Re: CONFIG_KCOV causing crash in svm_vcpu_run()
To: Eric Biggers <ebiggers3@gmail.com>
Cc: KVM list <kvm@vger.kernel.org>, karahmed@amazon.de,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 5:02 AM, Eric Biggers <ebiggers3@gmail.com> wrote:
> Sorry, messed up address for KVM mailing list.  See message below.
>
> On Sun, May 13, 2018 at 08:00:07PM -0700, Eric Biggers wrote:
>> With CONFIG_KCOV=y and an AMD processor, running the following program crashes
>> the kernel with no output (I'm testing in a VM, so it's using nested
>> virtualization):
>>
>>       #include <fcntl.h>
>>       #include <linux/kvm.h>
>>       #include <sys/ioctl.h>
>>
>>       int main()
>>       {
>>               int dev, vm, cpu;
>>               char page[4096] __attribute__((aligned(4096))) = { 0 };
>>               struct kvm_userspace_memory_region memreg = {
>>                       .memory_size = 4096,
>>                       .userspace_addr = (unsigned long)page,
>>               };
>>               dev = open("/dev/kvm", O_RDONLY);
>>               vm = ioctl(dev, KVM_CREATE_VM, 0);
>>               cpu = ioctl(vm, KVM_CREATE_VCPU, 0);
>>               ioctl(vm, KVM_SET_USER_MEMORY_REGION, &memreg);
>>               ioctl(cpu, KVM_RUN, 0);
>>       }
>>
>> It bisects down to commit b2ac58f90540e39 ("KVM/SVM: Allow direct access to
>> MSR_IA32_SPEC_CTRL").  The bug is apparently that due to the new code for
>> managing the SPEC_CTRL MSR, __sanitizer_cov_trace_pc() is being called from
>> svm_vcpu_run() before the host's MSR_GS_BASE has been restored, which causes a
>> crash somehow.  The following patch fixes it, though I don't know that it's the
>> right solution; maybe KCOV should be disabled in the function instead, or maybe
>> there's a more fundamental problem.  What do people think?


If __sanitizer_cov_trace_pc() crashes, I would expect there must be
few more of them here:

if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
    svm->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);

if (svm->spec_ctrl)
    native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);

Compiler inserts these callbacks into every basic block/edge.. Aren't there?

Unfortunately we don't have an attribute that disables instrumentation
of a single function. This is currently possible only on file level.



>> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
>> index 1fc05e428aba8..d35ef241e66d8 100644
>> --- a/arch/x86/kvm/svm.c
>> +++ b/arch/x86/kvm/svm.c
>> @@ -5652,6 +5652,15 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
>>  #endif
>>               );
>>
>> +#ifdef CONFIG_X86_64
>> +     wrmsrl(MSR_GS_BASE, svm->host.gs_base);
>> +#else
>> +     loadsegment(fs, svm->host.fs);
>> +#ifndef CONFIG_X86_32_LAZY_GS
>> +     loadsegment(gs, svm->host.gs);
>> +#endif
>> +#endif
>> +
>>       /*
>>        * We do not use IBRS in the kernel. If this vCPU has used the
>>        * SPEC_CTRL MSR it may have left it on; save the value and
>> @@ -5676,15 +5685,6 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
>>       /* Eliminate branch target predictions from guest mode */
>>       vmexit_fill_RSB();
>>
>> -#ifdef CONFIG_X86_64
>> -     wrmsrl(MSR_GS_BASE, svm->host.gs_base);
>> -#else
>> -     loadsegment(fs, svm->host.fs);
>> -#ifndef CONFIG_X86_32_LAZY_GS
>> -     loadsegment(gs, svm->host.gs);
>> -#endif
>> -#endif
>> -
>>       reload_tss(vcpu);
>>
>>       local_irq_disable();
