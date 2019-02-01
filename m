Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C9FC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DFCB21916
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbfBAKuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:50:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbfBAKuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:50:51 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9FDE581DED;
        Fri,  1 Feb 2019 10:50:50 +0000 (UTC)
Received: from gondolin (ovpn-117-104.ams2.redhat.com [10.36.117.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 003335C226;
        Fri,  1 Feb 2019 10:50:44 +0000 (UTC)
Date:   Fri, 1 Feb 2019 11:50:41 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com
Subject: Re: [PATCH v1] KVM: s390: vsie: fix Do the CRYCB validation first
Message-ID: <20190201115041.04797c4c.cohuck@redhat.com>
In-Reply-To: <1549014725-28216-2-git-send-email-pmorel@linux.ibm.com>
References: <1549014725-28216-1-git-send-email-pmorel@linux.ibm.com>
        <1549014725-28216-2-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 01 Feb 2019 10:50:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 Feb 2019 10:52:05 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> The case when the SIE for guest3 is not setup for using
> encryption keys nor Adjunct processor but the guest2
> does use these features was not properly handled.
> 
> This leads SIE entry for guest3 to crash with validity intercept
> because the guest2, not having the use of encryption keys nor
> Adjunct Processor did not initialize the CRYCB designation.
> 
> In the case where none of ECA_APIE, ECB3_AES or ECB3_DEA
> are set in guest3 a format 0 CRYCB is allowed for guest3
> and the CRYCB designation in the SIE for guest3 is not checked
> on SIE entry.
> 
> Let's allow the CRYCD designation to be ignored when the

s/CRYCD/CRYCB/

> SIE for guest3 is not initialized for encryption key usage
> nor AP.
> 
> Fixup: d6f6959 (KVM: s390: vsie: Do the CRYCB validation first)

I think the canonical format is

Fixes: d6f6959ac587 ("KVM: s390: vsie: Do the CRYCB validation first")

> 

CC: stable@vger.kernel.org # 4.20+

> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reported-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  arch/s390/kvm/vsie.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index a153257..a748f76 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -300,6 +300,9 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  	if (!apie_h && !key_msk)
>  		return 0;
>  
> +	if (!(scb_o->eca & ECA_APIE) && !(scb_o->ecb3 & (ECB3_AES | ECB3_DEA)))
> +		return 0;
> +
>  	if (!crycb_addr)
>  		return set_validity_icpt(scb_s, 0x0039U);
>  

Looks sane to me, but I'll let vsie experts comment.
