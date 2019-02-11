Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0E4C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08492082F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfBKJr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:47:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbfBKJr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:47:26 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8CF227F3E8;
        Mon, 11 Feb 2019 09:47:26 +0000 (UTC)
Received: from gondolin (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 083264F685;
        Mon, 11 Feb 2019 09:47:20 +0000 (UTC)
Date:   Mon, 11 Feb 2019 10:47:17 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com
Subject: Re: [PATCH v2] s390: vsie: Use effective CRYCBD.31 to check CRYCBD
 validity
Message-ID: <20190211104717.21299b01.cohuck@redhat.com>
In-Reply-To: <1549876849-32680-1-git-send-email-pmorel@linux.ibm.com>
References: <1549876849-32680-1-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 11 Feb 2019 09:47:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019 10:20:49 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> When facility.76 MSAX3 is present for the guest we must issue a validity
> interception if the CRYCBD is not valid.
> 
> The bit CRYCBD.31 is an effective field and tested at each guest
> level and has for effect to mask the facility.76
> 
> It follows that if CRYCBD.31 is clear and AP is not in use  we do not
> have to test the CRYCBD validatity even facility.76 is present in the

s/even/even if/

> host.
> 
> Fixes: 6ee74098201b ("KVM: s390: vsie: allow CRYCB FORMAT-0")
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reported-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/kvm/vsie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index a153257..d62fa14 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -297,7 +297,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  	scb_s->crycbd = 0;
>  
>  	apie_h = vcpu->arch.sie_block->eca & ECA_APIE;
> -	if (!apie_h && !key_msk)
> +	if (!apie_h && (!key_msk || fmt_o == CRYCB_FORMAT0))
>  		return 0;
>  
>  	if (!crycb_addr)

Acked-by: Cornelia Huck <cohuck@redhat.com>
