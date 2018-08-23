Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D76EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465B12098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465B12098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbeHWKzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 06:55:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbeHWKzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 06:55:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 24E1E40241C5;
        Thu, 23 Aug 2018 07:27:29 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 887F72026DE4;
        Thu, 23 Aug 2018 07:27:24 +0000 (UTC)
Date:   Thu, 23 Aug 2018 09:27:22 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH v2 1/5] KVM: s390: vsie: BUG correction by shadow_crycb
Message-ID: <20180823092722.5853bd4b.cohuck@redhat.com>
In-Reply-To: <8300634d-8500-1898-e283-175fc893054a@redhat.com>
References: <1534956717-14087-1-git-send-email-pmorel@linux.ibm.com>
        <1534956717-14087-2-git-send-email-pmorel@linux.ibm.com>
        <8300634d-8500-1898-e283-175fc893054a@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 23 Aug 2018 07:27:29 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 23 Aug 2018 07:27:29 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2018 18:53:02 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 22.08.2018 18:51, Pierre Morel wrote:
> > Copy the key mask to the right offset inside the shadow CRYCB
> > 
> > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > ---
> >  arch/s390/kvm/vsie.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> > index 9175518..12b9707 100644
> > --- a/arch/s390/kvm/vsie.c
> > +++ b/arch/s390/kvm/vsie.c
> > @@ -173,7 +173,8 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
> >  		return set_validity_icpt(scb_s, 0x0039U);
> >  
> >  	/* copy only the wrapping keys */
> > -	if (read_guest_real(vcpu, crycb_addr + 72, &vsie_page->crycb, 56))
> > +	if (read_guest_real(vcpu, crycb_addr + 72,
> > +			    vsie_page->crycb.dea_wrapping_key_mask, 56))
> >  		return set_validity_icpt(scb_s, 0x0035U);
> >  
> >  	scb_s->ecb3 |= ecb3_flags;
> >   
> 
> Please fixup the subject as requested.

+1

> (were there more RB-s?)
> 

Yep, mine. FTR:

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
