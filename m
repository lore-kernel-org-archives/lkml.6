Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5063DC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FAD52151D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FAD52151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbeHUSDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:03:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726590AbeHUSDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:03:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1F37F7D84D;
        Tue, 21 Aug 2018 14:42:49 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A570F94653;
        Tue, 21 Aug 2018 14:42:45 +0000 (UTC)
Date:   Tue, 21 Aug 2018 16:42:43 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] KVM: s390: vsie: BUG correction by shadow_crycb
Message-ID: <20180821164243.584e891f.cohuck@redhat.com>
In-Reply-To: <4c91cd0c-d679-eecc-0566-ed45158f6b7f@redhat.com>
References: <1534861178-30372-1-git-send-email-pmorel@linux.ibm.com>
        <20180821163348.327ce02d.cohuck@redhat.com>
        <4c91cd0c-d679-eecc-0566-ed45158f6b7f@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 21 Aug 2018 14:42:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 21 Aug 2018 14:42:49 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2018 16:36:19 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 21.08.2018 16:33, Cornelia Huck wrote:
> > On Tue, 21 Aug 2018 16:19:38 +0200
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> >   
> >> Copy the key mask to the right offset inside the shadow CRYCB
> >>
> >> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> >> ---
> >>  arch/s390/kvm/vsie.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> >> index 63844b9..a2b28cd 100644
> >> --- a/arch/s390/kvm/vsie.c
> >> +++ b/arch/s390/kvm/vsie.c
> >> @@ -173,7 +173,8 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
> >>  		return set_validity_icpt(scb_s, 0x0039U);
> >>  
> >>  	/* copy only the wrapping keys */
> >> -	if (read_guest_real(vcpu, crycb_addr + 72, &vsie_page->crycb, 56))
> >> +	if (read_guest_real(vcpu, crycb_addr + 72,
> >> +			    vsie_page->crycb.dea_wrapping_key_mask, 56))  
> > 
> > Don't you need the address here?  
> 
> As it is defined as an array, the address would result in the same value.
> 
> (&vsie_page->crycb.dea_wrapping_key_mask[0])

/me looks...

Indeed, it just looks a bit odd.

With the changed subject

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

> 
> >   
> >>  		return set_validity_icpt(scb_s, 0x0035U);
> >>  
> >>  	scb_s->ecb3 |= ecb3_flags;  
> >   
> 
> 

