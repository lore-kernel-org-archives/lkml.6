Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2989AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F014B21741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731884AbeLTMVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:21:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57904 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729161AbeLTMVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:21:38 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D197FC07C570;
        Thu, 20 Dec 2018 12:21:37 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 39EB6600C0;
        Thu, 20 Dec 2018 12:21:33 +0000 (UTC)
Date:   Thu, 20 Dec 2018 13:21:30 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Michael Mueller <mimu@linux.ibm.com>
Cc:     KVM Mailing List <kvm@vger.kernel.org>,
        Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v5 05/15] KVM: s390: unify pending_irqs() and
 pending_irqs_no_gisa()
Message-ID: <20181220132130.33a417fa.cohuck@redhat.com>
In-Reply-To: <62bf4bcf-585f-ddfc-e7a5-18fc946819d9@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
        <20181219191756.57973-6-mimu@linux.ibm.com>
        <20181220120614.65acacac.cohuck@redhat.com>
        <62bf4bcf-585f-ddfc-e7a5-18fc946819d9@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 20 Dec 2018 12:21:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2018 12:49:56 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> On 20.12.18 12:06, Cornelia Huck wrote:
> > On Wed, 19 Dec 2018 20:17:46 +0100
> > Michael Mueller <mimu@linux.ibm.com> wrote:
> >   
> >> Use a single function with parameter irq_flags to differentiate
> >> between cases.
> >>
> >> New irq flag:
> >>     IRQ_FLAG_LOCAL: include vcpu local interruptions pending
> >>     IRQ_FLAG_FLOATING: include vcpu floating interruptions pending
> >>     IRQ_FLAG_GISA: include GISA interruptions pending in IPM  
> > 
> > I presume that means that irqs may be in more than one set? Or are gisa
> > irqs not considered floating irqs, because they use a different
> > mechanism?  
> 
> Currently, the interruptions managed in GISA are floating only. But
> that might change in future. The idea is not to subsume IRQ_FLAG_GISA
> in IRQ_FLAG_FLOATING but to be able to address the right set of 
> procedures to determine the irq pending set for a given subset of irq
> types that have different implementations.
> 
> There might be a better name for IRQ_FLAG_FLOATING then?

So the split is:

- local interrupts that are pending via kvm structures;
- floating interrupts that are pending via kvm structures;
- interrupts that are pending via gisa?

If so, what about
- IRQ_FLAG_KVM_LOCAL
- IRQ_FLAG_KVM_FLOATING
- IRQ_FLAG_GISA (or maybe IRQ_FLAG_GISA_FLOATING, if you need to
  distinguish those later on?)

> 
> >   
> >>
> >> New irq masks:
> >>     IRQ_MASK_ALL: include all types
> >>     IRQ_MASK_NO_GISA: include all types but GISA
> >>
> >> Examples:
> >>     pending_irqs(vcpu, IRQ_MASK_ALL)
> >>     pending_irqs(vcpu, IRQ_MASK_NO_GISA)
> >>
> >> There will be more irq flags with upcoming patches.
> >>
> >> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> >> ---
> >>   arch/s390/kvm/interrupt.c | 33 +++++++++++++++++++++------------
> >>   1 file changed, 21 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> >> index 093b568b6356..4ab20d2eb180 100644
> >> --- a/arch/s390/kvm/interrupt.c
> >> +++ b/arch/s390/kvm/interrupt.c
> >> @@ -31,6 +31,13 @@
> >>   #define PFAULT_DONE 0x0680
> >>   #define VIRTIO_PARAM 0x0d00
> >>   
> >> +#define IRQ_FLAG_LOCAL    0x8000 /* include local interruption pending mask */
> >> +#define IRQ_FLAG_FLOATING 0x4000 /* include float interruption pending mask */
> >> +#define IRQ_FLAG_GISA     0x2000 /* include GISA interruption pending mask */
> >> +
> >> +#define IRQ_MASK_ALL      (IRQ_FLAG_LOCAL | IRQ_FLAG_FLOATING | IRQ_FLAG_GISA)
> >> +#define IRQ_MASK_NO_GISA  (IRQ_MASK_ALL & ~IRQ_FLAG_GISA)
> >> +
> >>   /* handle external calls via sigp interpretation facility */
> >>   static int sca_ext_call_pending(struct kvm_vcpu *vcpu, int *src_id)
> >>   {
> >> @@ -237,16 +244,18 @@ static inline int kvm_s390_gisa_tac_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gis
> >>   	return test_and_clear_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
> >>   }
> >>   
> >> -static inline unsigned long pending_irqs_no_gisa(struct kvm_vcpu *vcpu)
> >> +static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu, u16 irq_flags)  
> > 
> > Any deeper reason why this is a u16? 16 bits should be enough for
> > everyone? :)  
> 
> I want to use the 8 bits for the IRQ type and the other 8 for additional 
> controls, see: "KVM: s390: restore IAM in get_ipm() when IPM is clean"

Still need to look at that patch, but my question mainly was "why only
16 bits"? I would think making this local variable larger is cheap.

> 
> >   
> >>   {
> >> -	return vcpu->kvm->arch.float_int.pending_irqs |
> >> -		vcpu->arch.local_int.pending_irqs;
> >> -}
