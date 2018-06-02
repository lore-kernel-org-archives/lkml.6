Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751832AbeFBAZE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 20:25:04 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:38654 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeFBAZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 20:25:00 -0400
X-Google-Smtp-Source: ADUXVKKmPkmsuzBS8UcOaifnuwYVtsdsHFrpUZiH/QBK1ONxHvDOAG0cPUzYfPD6WK0E/ndY9A2WA9xcAg3AcnxJe08=
MIME-Version: 1.0
References: <1527576797-5738-1-git-send-email-wanpengli@tencent.com>
 <20180529142324.GA7819@flask> <20180529143102.GC7819@flask> <e85689ac-25be-a0ca-7618-51a918896ca4@redhat.com>
In-Reply-To: <e85689ac-25be-a0ca-7618-51a918896ca4@redhat.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Sat, 2 Jun 2018 08:24:36 +0800
Message-ID: <CANRm+Cyc-0WQd3tBZhbcRqQsPwmYsfZ=GNYVvfyetb8U1SCUdA@mail.gmail.com>
Subject: Re: [PATCH] KVM: VMX: Optimize tscdeadline timer latency
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krcmar <rkrcmar@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w520PBCV013379

On Wed, 30 May 2018 at 01:08, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 29/05/2018 16:31, Radim Krčmář wrote:
> > 2018-05-29 16:23+0200, Radim Krčmář:
> >> 2018-05-29 14:53+0800, Wanpeng Li:
> >>> From: Wanpeng Li <wanpengli@tencent.com>
> >>>
> >>> 'Commit d0659d946be0 ("KVM: x86: add option to advance tscdeadline
> >>> hrtimer expiration")' advances the tscdeadline (the timer is emulated
> >>> by hrtimer) expiration in order that the latency which is incurred
> >>> by hypervisor (apic_timer_fn -> vmentry) can be avoided. This patch
> >>> adds the advance tscdeadline expiration support to which the tscdeadline
> >>> timer is emulated by VMX preemption timer to reduce the hypervisor
> >>> lantency (handle_preemption_timer -> vmentry). clockevents infrastruture
> >>> can program minimum delay if hrtimer feeds a expiration in the past,
> >>> we set delta_tsc to 1(which will be converted to 0 before vmentry)
> >>> which can lead to an immediately vmexit when delta_tsc is not bigger
> >>> than advance ns.
> >>>
> >>> This patch can reduce ~63% latency (~4450 cycles to ~1660 cycles on
> >>> a haswell desktop) for kvm-unit-tests/tscdeadline_latency when testing
> >>> busy waits.
> >>>
> >>> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >>> Cc: Radim Krčmář <rkrcmar@redhat.com>
> >>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> >>> ---
> >>> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> >>> @@ -12444,6 +12444,12 @@ static int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc)
> >>>     tscl = rdtsc();
> >>>     guest_tscl = kvm_read_l1_tsc(vcpu, tscl);
> >>>     delta_tsc = max(guest_deadline_tsc, guest_tscl) - guest_tscl;
> >>> +   lapic_timer_advance_cycles = nsec_to_cycles(vcpu, lapic_timer_advance_ns);
> >>> +   if (delta_tsc > lapic_timer_advance_cycles)
> >>> +           delta_tsc -= lapic_timer_advance_cycles;
> >>> +   else
> >>> +           delta_tsc = 1;
> >>
> >> Why don't we just "return 1" to say that the timer has expired?
> >
> > This case might be rare, so setting delta_tsc = 0 would be safer.
>
> Queued with this change.  Indeed this case matches vmx_arm_hv_timer so

The patch description should also be updated in kvm/queue I think.

Regards,
Wanpeng Li
