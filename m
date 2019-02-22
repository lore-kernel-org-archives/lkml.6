Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF0AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046E120823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfBVJjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:39:32 -0500
Received: from foss.arm.com ([217.140.101.70]:56616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbfBVJjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:39:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90A0080D;
        Fri, 22 Feb 2019 01:39:31 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B2C53F703;
        Fri, 22 Feb 2019 01:39:28 -0800 (PST)
Date:   Fri, 22 Feb 2019 09:39:23 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Christoffer Dall <christoffer.dall@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] KVM: arm/arm64: vgic: Improve comment on
 kvm_vgic_inject_irq
Message-ID: <20190222093923.09e36583@why.wild-wind.fr.eu.org>
In-Reply-To: <20190222085439.GA845@leoy-ThinkPad-X240s>
References: <20190222082327.3312-1-leo.yan@linaro.org>
        <20190222082327.3312-3-leo.yan@linaro.org>
        <20190222083756.359523ca@why.wild-wind.fr.eu.org>
        <20190222085439.GA845@leoy-ThinkPad-X240s>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 16:54:39 +0800
Leo Yan <leo.yan@linaro.org> wrote:

> Hi Marc,
> 
> On Fri, Feb 22, 2019 at 08:37:56AM +0000, Marc Zyngier wrote:
> > On Fri, 22 Feb 2019 16:23:24 +0800
> > Leo Yan <leo.yan@linaro.org> wrote:
> >   
> > > The function kvm_vgic_inject_irq() is not only used by PPIs but also can
> > > be used to inject interrupt for SPIs; this patch improves comment for
> > > argument @cpuid to reflect support SPIs as well.
> > > 
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > ---
> > >  virt/kvm/arm/vgic/vgic.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
> > > index 7cfdfbc910e0..79fe64c15051 100644
> > > --- a/virt/kvm/arm/vgic/vgic.c
> > > +++ b/virt/kvm/arm/vgic/vgic.c
> > > @@ -394,7 +394,7 @@ bool vgic_queue_irq_unlock(struct kvm *kvm, struct vgic_irq *irq,
> > >  /**
> > >   * kvm_vgic_inject_irq - Inject an IRQ from a device to the vgic
> > >   * @kvm:     The VM structure pointer
> > > - * @cpuid:   The CPU for PPIs
> > > + * @cpuid:   The CPU for PPIs and SPIs
> > >   * @intid:   The INTID to inject a new state to.
> > >   * @level:   Edge-triggered:  true:  to trigger the interrupt
> > >   *			      false: to ignore the call  
> > 
> > What does the CPU mean for SPIs? By definition, the routing of an SPI
> > is defined by the distributor configuration.  
> 
> In the code, KVM injects PPIs by specifying CPU id, so that every PPI
> is bound to specific target CPU.  But for SPIs, it always pass '0' for
> cpuid, from my understanding this means VM will set interrupt affinity
> to VCPU0 by default; in theory we also can set different cpuid for
> SPIs so that the SPIs also can be handled by other secondary VCPUs;
> this is why I think @cpuid also can be used by SPIs.

SPIs are not hardcoded to vcpu0. This would be a gross violation of the
architecture. To convince yourself of this, just run a guest:

root@unassigned-hostname:~# cat /proc/interrupts 
           CPU0       CPU1       
  2:       7315       7353     GIC-0  27 Level     arch_timer
  4:        158          0     GIC-0  33 Level     uart-pl011
 42:          0          0     GIC-0  23 Level     arm-pmu
 43:          0          0     pl061   3 Edge      ACPI:Event
 44:          0          0       MSI 32768 Edge      virtio1-config
 45:      10476          0       MSI 32769 Edge      virtio1-req.0
 46:          0          0       MSI 16384 Edge      virtio0-config
 47:          3         10       MSI 16385 Edge      virtio0-input.0
[...]

On this last line, you can see an SPI being routed to both of these
vcpus.

I urge you to read the code further, and understand that for any other
interrupt class, the cpuid parameter is *ignored*. Yes, we pass zero in
that case. We could also pass an approximation of PI with the same
effect. The interrupt affinity is either defined by the distributor
configuration (SPIs) or the ITS configuration (LPIs).

	M.
-- 
Without deviation from the norm, progress is not possible.
