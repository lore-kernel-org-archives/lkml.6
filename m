Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5702C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887AA21873
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfA2NWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:22:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfA2NWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:22:30 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 34CDB19CF22;
        Tue, 29 Jan 2019 13:22:30 +0000 (UTC)
Received: from gondolin (dhcp-192-213.str.redhat.com [10.33.192.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 321595C3FD;
        Tue, 29 Jan 2019 13:22:23 +0000 (UTC)
Date:   Tue, 29 Jan 2019 14:22:20 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Michael Mueller <mimu@linux.ibm.com>,
        KVM Mailing List <kvm@vger.kernel.org>,
        Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v6 07/13] KVM: s390: introduce struct
 kvm_s390_gisa_interrupt
Message-ID: <20190129142220.3f08a1e9.cohuck@redhat.com>
In-Reply-To: <20190128175054.67979549@oc2783563651>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
        <20190124125939.130763-8-mimu@linux.ibm.com>
        <20190128175054.67979549@oc2783563651>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 29 Jan 2019 13:22:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2019 17:50:54 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Thu, 24 Jan 2019 13:59:33 +0100
> Michael Mueller <mimu@linux.ibm.com> wrote:
> 
> > Use this struct analog to the kvm interruption structs
> > for kvm emulated floating and local interruptions.
> > Further fields will be added with this series as
> > required.
> > 
> > Signed-off-by: Michael Mueller <mimu@linux.ibm.com>  
> 
> While looking at this I was asking myself what guards against invalid
> gisa pointer dereference e.g. when pending_irqs() is called (see below).
> 
> AFAIU we set up gisa_int.origin only if we have
> css_general_characteristics.aiv. Opinions?

I think you're right that this is a (pre-existing) problem.

> > diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> > index 942cc7d33766..ee91d1de0036 100644
> > --- a/arch/s390/kvm/interrupt.c
> > +++ b/arch/s390/kvm/interrupt.c
> > @@ -246,7 +246,8 @@ static inline unsigned long pending_irqs_no_gisa(struct kvm_vcpu *vcpu)
> >  static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu)
> >  {
> >  	return pending_irqs_no_gisa(vcpu) |
> > -		gisa_get_ipm(vcpu->kvm->arch.gisa) << IRQ_PEND_IO_ISC_7;
> > +		gisa_get_ipm(vcpu->kvm->arch.gisa_int.origin) <<  
> 
> Unconditional call to gisa_get_ipm(), and get ipm just accesses ->ipm.

All other callers of this function check for gisa != NULL first, so
either we should check here as well or move the check into the
gisa_get_ipm() function.

> 
> > +			IRQ_PEND_IO_ISC_7;
> >  }
> >    
