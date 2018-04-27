Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933679AbeD0PTR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 11:19:17 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:38188 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933456AbeD0PTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 11:19:14 -0400
X-Google-Smtp-Source: AB8JxZqCgIIhqaJDtXGCOYo58EJX86rYl3uCXk0HP8QgltfS8eddzkhkGgzLm7YVYUfMqkTbXviKYJRiiBGpySy09Q0=
MIME-Version: 1.0
In-Reply-To: <f8875546-da53-fc36-d3da-5b5ff089ccc0@redhat.com>
References: <1523545958-28059-1-git-send-email-karahmed@amazon.de>
 <1523545958-28059-2-git-send-email-karahmed@amazon.de> <CALMp9eSS4nL1-1i1Df=vyPFT1FZVprPB0Yx-JX0auknNc09Gtg@mail.gmail.com>
 <1523898937.22952.13.camel@amazon.de> <CALMp9eS6D4pfbGEfcz7MpRncTte5weUJE9g-C_qMVxnaGd+RtQ@mail.gmail.com>
 <f8875546-da53-fc36-d3da-5b5ff089ccc0@redhat.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 27 Apr 2018 08:19:13 -0700
Message-ID: <CALMp9eSG-nAuJEyavJoBp7QS1_VuYpuNSjKNUoK6MMEeywypeQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kvm: nVMX: Introduce KVM_CAP_STATE
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Raslan, KarimAllah" <karahmed@amazon.de>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 3:03 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 27/04/2018 00:28, Jim Mattson wrote:
>> The other thing that comes to mind is that there are some new fields
>> in the VMCS12 since I first implemented this. One potentially
>> troublesome field is the VMX preemption timer. If the current timer
>> value is not saved on VM-exit, then it won't be stashed in the shadow
>> VMCS12 by sync_vmcs12. Post-migration, the timer will be reset to its
>> original value.
>>
>> Do we care? Is this any different from what happens on real hardware
>> when there's an SMI? According to the SDM, this appears to be exacty
>> what happens when the dual-monitor treatment of SMIs and SMM is
>> active, but it's not clear what happens with the default treatment of
>> SMIs and SMM.
>
> I think it should be the same, because the preemption timer countdown is
> not part of the VMX-critical state.
>
> Paolo

Section 25.5.1 of the SDM says:

If the default treatment of SMIs and SMM (see Section 34.14) is
active, the VMX-preemption timer counts across an SMI to VMX non-root
operation, subsequent execution in SMM, and the return from SMM via
the RSM instruction. However, the timer can cause a VM exit only from
VMX non-root operation. If the timer expires during SMI, in SMM, or
during RSM, a timer-induced VM exit occurs immediately after RSM with
its normal priority unless it is blocked based on activity state
(Section 25.2).

So, there's no loophole here that allows us to reset the VMX
preemption timer when restoring nested state.

As a follow-on change, we should probably fix this.
