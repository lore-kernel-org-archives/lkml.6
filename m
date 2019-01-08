Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26115C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC07B20850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfAHNlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:41:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49163 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbfAHNlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:41:44 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7DB13E2D0;
        Tue,  8 Jan 2019 13:41:43 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD80F100164E;
        Tue,  8 Jan 2019 13:41:37 +0000 (UTC)
Date:   Tue, 8 Jan 2019 14:41:35 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Michael Mueller <mimu@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        KVM Mailing List <kvm@vger.kernel.org>,
        Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v5 10/15] KVM: s390: add functions to (un)register GISC
 with GISA
Message-ID: <20190108144135.3fe5c23b.cohuck@redhat.com>
In-Reply-To: <20190108143613.2ca1a9d3@oc2783563651>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
        <20181219191756.57973-11-mimu@linux.ibm.com>
        <bd1a6082-cb73-5ef7-f2b6-8cbd7d8c7136@linux.ibm.com>
        <20190104141836.0ca98a77.cohuck@redhat.com>
        <b001fc9b-c174-644f-a9fa-e60ff5b4aa58@linux.ibm.com>
        <20190108113444.56e76f13.cohuck@redhat.com>
        <20190108143613.2ca1a9d3@oc2783563651>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 08 Jan 2019 13:41:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019 14:36:13 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Tue, 8 Jan 2019 11:34:44 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > > >>      
> > > >>> +	spin_unlock(&kvm->arch.iam_ref_lock);
> > > >>> +
> > > >>> +	return gib->nisc;
> > > >>> +}
> > > >>> +EXPORT_SYMBOL_GPL(kvm_s390_gisc_register);
> > > >>> +
> > > >>> +int kvm_s390_gisc_unregister(struct kvm *kvm, u32 gisc)
> > > >>> +{
> > > >>> +	int rc = 0;
> > > >>> +
> > > >>> +	if (!kvm->arch.gib_in_use)
> > > >>> +		return -ENODEV;
> > > >>> +	if (gisc > MAX_ISC)
> > > >>> +		return -ERANGE;
> > > >>> +
> > > >>> +	spin_lock(&kvm->arch.iam_ref_lock);
> > > >>> +	if (kvm->arch.iam_ref_count[gisc] == 0) {
> > > >>> +		rc = -EINVAL;
> > > >>> +		goto out;
> > > >>> +	}
> > > >>> +	kvm->arch.iam_ref_count[gisc]--;
> > > >>> +	if (kvm->arch.iam_ref_count[gisc] == 0) {
> > > >>> +		kvm->arch.iam &= ~(0x80 >> gisc);
> > > >>> +		set_iam(kvm->arch.gisa, kvm->arch.iam);      
> > > > 
> > > > Any chance of this function failing here? If yes, would there be any
> > > > implications?      
> > > 
> > > It is the same here.    
> > 
> > I'm not sure that I follow: This is the reverse operation
> > (unregistering the gisc). Can we rely on get_ipm() to do any fixup
> > later? Is that a problem for the caller?  
> 
> IMHO gib alerts are all about not loosing initiative. I.e. avoiding
> substantially delayed delivery of interrupts due to vCPUs in wait
> state.
> 
> Thus we must avoid letting go before setting up stuff (gisa.iam under
> consideration of gisa ipm, gisa.next_alert, and gib.alert_list_origin)
> so that we can react on the next interrupt (if necessary).
> 
> On the other hand, getting more gisa alerts than necessary is not
> fatal -- better avoided if not too much hassle of course.

Yes, unless the caller does not expect any more alerts after
unregistering (I guess that's what you're saying?)

> 
> Bottom line is, while it may be critical that the IAM changes implied
> by register take place immediately, unregister is a different story.

It does feel a bit weird, though. But maybe I just have trouble
grasping the design :/
