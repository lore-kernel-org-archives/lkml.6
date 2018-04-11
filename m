Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeDKJdS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:33:18 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:64154 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbeDKJdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:33:15 -0400
X-IronPort-AV: E=Sophos;i="5.48,435,1517875200";
   d="scan'208";a="725616829"
From: "Raslan, KarimAllah" <karahmed@amazon.de>
To: "kernellwp@gmail.com" <kernellwp@gmail.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>
Subject: Re: [PATCH v3] X86/VMX: Disable VMX preemption timer if MWAIT is not
 intercepted
Thread-Topic: [PATCH v3] X86/VMX: Disable VMX preemption timer if MWAIT is not
 intercepted
Thread-Index: AQHT0MWzkJsKxzgzikWEsfUgePG0OaP6xhYAgACIlAA=
Date: Wed, 11 Apr 2018 09:33:10 +0000
Message-ID: <1523439190.5178.16.camel@amazon.de>
References: <1523362546-20909-1-git-send-email-karahmed@amazon.de>
         <CANRm+Cx_j3n7O=KnuW9t3XW9RaUhhdboCE6TFdSwmPomi6asVw@mail.gmail.com>
In-Reply-To: <CANRm+Cx_j3n7O=KnuW9t3XW9RaUhhdboCE6TFdSwmPomi6asVw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.96]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A7781531D660A4BA125F1C4119599D4@amazon.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3B9XMPx005888

On Wed, 2018-04-11 at 09:24 +0800, Wanpeng Li wrote:
> 2018-04-10 20:15 GMT+08:00 KarimAllah Ahmed <karahmed@amazon.de>:
> > 
> > The VMX-preemption timer is used by KVM as a way to set deadlines for the
> > guest (i.e. timer emulation). That was safe till very recently when
> > capability KVM_X86_DISABLE_EXITS_MWAIT to disable intercepting MWAIT was
> > introduced. According to Intel SDM 25.5.1:
> > 
> > """
> > The VMX-preemption timer operates in the C-states C0, C1, and C2; it also
> > operates in the shutdown and wait-for-SIPI states. If the timer counts down
> > to zero in any state other than the wait-for SIPI state, the logical
> > processor transitions to the C0 C-state and causes a VM exit; the timer
> > does not cause a VM exit if it counts down to zero in the wait-for-SIPI
> > state. The timer is not decremented in C-states deeper than C2.
> > """
> 
> Thanks for the patch. In addition, does it also mean we should prevent
> host from entering deeper C-states than C2 even if w/o disable
> intercept stuffs?

The only thing that we should be worried about is the availability of 
LAPIC ARAT. If it is available then even if the guest issued an MWAIT 
that went to C6 state. The LAPIC timer will still be ticket and will 
still cause a VMExit when it ticks to meet some host kernel timer 
deadline.

Ironically I was about to say that we already do that for MWAIT 
passthrough, but I decided to also paste the snippet of the code that
shows that does it .. then I realized that when we upstreamed the
MWAIT passthrough we dropped this check by acciddent!

Anyway .. I send this patch to fix it:
https://lkml.org/lkml/2018/4/11/194

> 
> Regards,
> Wanpeng Li
> 
> > 
> > 
> > Now once the guest issues the MWAIT with a c-state deeper than
> > C2 the preemption timer will never wake it up again since it stopped
> > ticking! Usually this is compensated by other activities in the system that
> > would wake the core from the deep C-state (and cause a VMExit). For
> > example, if the host itself is ticking or it received interrupts, etc!
> > 
> > So disable the VMX-preemption timer if MWAIT is exposed to the guest!
> > 
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Radim Krčmář <rkrcmar@redhat.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: H. Peter Anvin <hpa@zytor.com>
> > Cc: x86@kernel.org
> > Cc: kvm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> > ---
> > v2 -> v3:
> > - return -EOPNOTSUPP before any other operation in vmx_set_hv_timer
> > 
> > v1 -> v2:
> > - Drop everything .. just return -EOPNOTSUPP (pbonzini@) :D
> > ---
> >  arch/x86/kvm/vmx.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> > index d2e54e7..31a4204 100644
> > --- a/arch/x86/kvm/vmx.c
> > +++ b/arch/x86/kvm/vmx.c
> > @@ -11903,10 +11903,16 @@ static inline int u64_shl_div_u64(u64 a, unsigned int shift,
> > 
> >  static int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc)
> >  {
> > -       struct vcpu_vmx *vmx = to_vmx(vcpu);
> > -       u64 tscl = rdtsc();
> > -       u64 guest_tscl = kvm_read_l1_tsc(vcpu, tscl);
> > -       u64 delta_tsc = max(guest_deadline_tsc, guest_tscl) - guest_tscl;
> > +       struct vcpu_vmx *vmx;
> > +       u64 tscl, guest_tscl, delta_tsc;
> > +
> > +       if (kvm_pause_in_guest(vcpu->kvm))
> > +               return -EOPNOTSUPP;
> > +
> > +       vmx = to_vmx(vcpu);
> > +       tscl = rdtsc();
> > +       guest_tscl = kvm_read_l1_tsc(vcpu, tscl);
> > +       delta_tsc = max(guest_deadline_tsc, guest_tscl) - guest_tscl;
> > 
> >         /* Convert to host delta tsc if tsc scaling is enabled */
> >         if (vcpu->arch.tsc_scaling_ratio != kvm_default_tsc_scaling_ratio &&
> > --
> > 2.7.4
> > 
> 
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
