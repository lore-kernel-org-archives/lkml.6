Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752486AbeDKBYX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 21:24:23 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33576 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751946AbeDKBYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 21:24:21 -0400
X-Google-Smtp-Source: AIpwx4/xrKpQsDIG7t6jZck5ERLmfVJC118HOYYC5sbHSoT2QIIVz/lM0mNrHQyaGZ0ftmPVXMSxr5Ipq8TBs+v22W0=
MIME-Version: 1.0
In-Reply-To: <1523362546-20909-1-git-send-email-karahmed@amazon.de>
References: <1523362546-20909-1-git-send-email-karahmed@amazon.de>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Wed, 11 Apr 2018 09:24:20 +0800
Message-ID: <CANRm+Cx_j3n7O=KnuW9t3XW9RaUhhdboCE6TFdSwmPomi6asVw@mail.gmail.com>
Subject: Re: [PATCH v3] X86/VMX: Disable VMX preemption timer if MWAIT is not intercepted
To: KarimAllah Ahmed <karahmed@amazon.de>
Cc: kvm <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3B1OTEk015435

2018-04-10 20:15 GMT+08:00 KarimAllah Ahmed <karahmed@amazon.de>:
> The VMX-preemption timer is used by KVM as a way to set deadlines for the
> guest (i.e. timer emulation). That was safe till very recently when
> capability KVM_X86_DISABLE_EXITS_MWAIT to disable intercepting MWAIT was
> introduced. According to Intel SDM 25.5.1:
>
> """
> The VMX-preemption timer operates in the C-states C0, C1, and C2; it also
> operates in the shutdown and wait-for-SIPI states. If the timer counts down
> to zero in any state other than the wait-for SIPI state, the logical
> processor transitions to the C0 C-state and causes a VM exit; the timer
> does not cause a VM exit if it counts down to zero in the wait-for-SIPI
> state. The timer is not decremented in C-states deeper than C2.
> """

Thanks for the patch. In addition, does it also mean we should prevent
host from entering deeper C-states than C2 even if w/o disable
intercept stuffs?

Regards,
Wanpeng Li

>
> Now once the guest issues the MWAIT with a c-state deeper than
> C2 the preemption timer will never wake it up again since it stopped
> ticking! Usually this is compensated by other activities in the system that
> would wake the core from the deep C-state (and cause a VMExit). For
> example, if the host itself is ticking or it received interrupts, etc!
>
> So disable the VMX-preemption timer if MWAIT is exposed to the guest!
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> ---
> v2 -> v3:
> - return -EOPNOTSUPP before any other operation in vmx_set_hv_timer
>
> v1 -> v2:
> - Drop everything .. just return -EOPNOTSUPP (pbonzini@) :D
> ---
>  arch/x86/kvm/vmx.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index d2e54e7..31a4204 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -11903,10 +11903,16 @@ static inline int u64_shl_div_u64(u64 a, unsigned int shift,
>
>  static int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc)
>  {
> -       struct vcpu_vmx *vmx = to_vmx(vcpu);
> -       u64 tscl = rdtsc();
> -       u64 guest_tscl = kvm_read_l1_tsc(vcpu, tscl);
> -       u64 delta_tsc = max(guest_deadline_tsc, guest_tscl) - guest_tscl;
> +       struct vcpu_vmx *vmx;
> +       u64 tscl, guest_tscl, delta_tsc;
> +
> +       if (kvm_pause_in_guest(vcpu->kvm))
> +               return -EOPNOTSUPP;
> +
> +       vmx = to_vmx(vcpu);
> +       tscl = rdtsc();
> +       guest_tscl = kvm_read_l1_tsc(vcpu, tscl);
> +       delta_tsc = max(guest_deadline_tsc, guest_tscl) - guest_tscl;
>
>         /* Convert to host delta tsc if tsc scaling is enabled */
>         if (vcpu->arch.tsc_scaling_ratio != kvm_default_tsc_scaling_ratio &&
> --
> 2.7.4
>
