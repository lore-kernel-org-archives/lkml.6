Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4A8C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7322084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E7322084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeJEQ2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 12:28:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41432 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbeJEQ2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 12:28:53 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 49043308FB85;
        Fri,  5 Oct 2018 09:30:59 +0000 (UTC)
Received: from gondolin (dhcp-192-213.str.redhat.com [10.33.192.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C223D105704B;
        Fri,  5 Oct 2018 09:30:55 +0000 (UTC)
Date:   Fri, 5 Oct 2018 11:30:53 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com
Subject: Re: [PATCH v1 1/2] KVM: s390: Tracing APCB changes
Message-ID: <20181005113053.7a3e1f72.cohuck@redhat.com>
In-Reply-To: <f06ad8c4-2f59-b693-aec8-b93fac9c2177@linux.ibm.com>
References: <7d147350-4284-8e01-d1fa-0795d2da85c1@de.ibm.com>
        <1538728270-10340-1-git-send-email-pmorel@linux.ibm.com>
        <1538728270-10340-2-git-send-email-pmorel@linux.ibm.com>
        <20181005104925.04a1f3ef.cohuck@redhat.com>
        <f06ad8c4-2f59-b693-aec8-b93fac9c2177@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 05 Oct 2018 09:30:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Oct 2018 10:57:22 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 05/10/2018 10:49, Cornelia Huck wrote:
> > On Fri,  5 Oct 2018 10:31:09 +0200
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> >   
> >> kvm_arch_crypto_set_masks is a new function to centralize
> >> the setup the APCB masks inside the CRYCB SIE satelite.  
> > 
> > s/satelite/satellite/
> >   
> >>
> >> To trace APCB mask changes, we add KVM_EVENT() tracing to
> >> both kvm_arch_crypto_set_masks and kvm_arch_crypto_clear_masks.
> >>
> >> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> >> ---
> >>   arch/s390/include/asm/kvm_host.h |  2 ++
> >>   arch/s390/kvm/kvm-s390.c         | 41 ++++++++++++++++++++++++++++++++++++++++
> >>   2 files changed, 43 insertions(+)

(...)

> > The locking and requests makes me wonder if we missed them before...
> > were they simply not needed for the prior use case (mdev group
> > notifier)?  
> 
> Before we used to set the mask before creating the vcpu.
> In fact since we still call this function from the initialization
> of VFIO AP we still do.
> 
> But since this function is more generic we need to be more careful
> if it is called when vcpu are running.
> We do the same locking mechanism in the kvm_arch_crypto_clear_mask().

Yes, that makes sense.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
