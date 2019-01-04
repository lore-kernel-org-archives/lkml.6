Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9292DC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6933B21871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfADNTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 08:19:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfADNTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 08:19:15 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9A2FF42BD3;
        Fri,  4 Jan 2019 13:19:14 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F843600D6;
        Fri,  4 Jan 2019 13:19:09 +0000 (UTC)
Date:   Fri, 4 Jan 2019 14:19:06 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     Michael Mueller <mimu@linux.ibm.com>,
        KVM Mailing List <kvm@vger.kernel.org>,
        Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v5 10/15] KVM: s390: add functions to (un)register GISC
 with GISA
Message-ID: <20190104141836.0ca98a77.cohuck@redhat.com>
In-Reply-To: <bd1a6082-cb73-5ef7-f2b6-8cbd7d8c7136@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
        <20181219191756.57973-11-mimu@linux.ibm.com>
        <bd1a6082-cb73-5ef7-f2b6-8cbd7d8c7136@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 04 Jan 2019 13:19:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2019 18:29:00 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 19/12/2018 20:17, Michael Mueller wrote:
> > Add the IAM (Interruption Alert Mask) to the architecture specific
> > kvm struct. This mask in the GISA is used to define for which ISC
> > a GIB alert can be issued.
> > 
> > The functions kvm_s390_gisc_register() and kvm_s390_gisc_unregister()
> > are used to (un)register a GISC (guest ISC) with a virtual machine and
> > its GISA.
> > 
> > Upon successful completion, kvm_s390_gisc_register() returns the
> > ISC to be used for GIB alert interruptions. A negative return code
> > indicates an error during registration.
> > 
> > Theses functions will be used by other adapter types like AP and PCI to
> > request pass-through interruption support.
> > 
> > Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> > ---
> >   arch/s390/include/asm/kvm_host.h |  9 ++++++
> >   arch/s390/kvm/interrupt.c        | 66 ++++++++++++++++++++++++++++++++++++++++
> >   2 files changed, 75 insertions(+)
> > 

> > +int kvm_s390_gisc_register(struct kvm *kvm, u32 gisc)
> > +{
> > +	if (!kvm->arch.gib_in_use)
> > +		return -ENODEV;
> > +	if (gisc > MAX_ISC)
> > +		return -ERANGE;
> > +
> > +	spin_lock(&kvm->arch.iam_ref_lock);
> > +	if (kvm->arch.iam_ref_count[gisc] == 0)
> > +		kvm->arch.iam |= 0x80 >> gisc;
> > +	kvm->arch.iam_ref_count[gisc]++;
> > +	if (kvm->arch.iam_ref_count[gisc] == 1)
> > +		set_iam(kvm->arch.gisa, kvm->arch.iam);  
> 
> testing the set_iam return value?
> Even it should be fine if the caller works correctly, this is done 
> before GISA is ever used.

My feeling is that checking the return code is a good idea, even if it
Should Never Fail(tm).

> 
> > +	spin_unlock(&kvm->arch.iam_ref_lock);
> > +
> > +	return gib->nisc;
> > +}
> > +EXPORT_SYMBOL_GPL(kvm_s390_gisc_register);
> > +
> > +int kvm_s390_gisc_unregister(struct kvm *kvm, u32 gisc)
> > +{
> > +	int rc = 0;
> > +
> > +	if (!kvm->arch.gib_in_use)
> > +		return -ENODEV;
> > +	if (gisc > MAX_ISC)
> > +		return -ERANGE;
> > +
> > +	spin_lock(&kvm->arch.iam_ref_lock);
> > +	if (kvm->arch.iam_ref_count[gisc] == 0) {
> > +		rc = -EINVAL;
> > +		goto out;
> > +	}
> > +	kvm->arch.iam_ref_count[gisc]--;
> > +	if (kvm->arch.iam_ref_count[gisc] == 0) {
> > +		kvm->arch.iam &= ~(0x80 >> gisc);
> > +		set_iam(kvm->arch.gisa, kvm->arch.iam);

Any chance of this function failing here? If yes, would there be any
implications?

> > +	}
> > +out:
> > +	spin_unlock(&kvm->arch.iam_ref_lock);
> > +
> > +	return rc;
> > +}
> > +EXPORT_SYMBOL_GPL(kvm_s390_gisc_unregister);
> > +
> >   void kvm_s390_gib_destroy(void)
> >   {
> >   	if (!gib)
> >   
> 
> 

