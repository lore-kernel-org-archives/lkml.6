Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFBFC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051F220989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfA2NJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:09:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49314 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfA2NJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:09:11 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3941D88E48;
        Tue, 29 Jan 2019 13:09:10 +0000 (UTC)
Received: from gondolin (dhcp-192-213.str.redhat.com [10.33.192.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 57FE1600C6;
        Tue, 29 Jan 2019 13:09:08 +0000 (UTC)
Date:   Tue, 29 Jan 2019 14:09:05 +0100
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
Subject: Re: [PATCH v6 11/13] KVM: s390: add functions to (un)register GISC
 with GISA
Message-ID: <20190129140905.288d750a.cohuck@redhat.com>
In-Reply-To: <20190124125939.130763-12-mimu@linux.ibm.com>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
        <20190124125939.130763-12-mimu@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 29 Jan 2019 13:09:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019 13:59:37 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> Add the Interruption Alert Mask (IAM) to the architecture specific
> kvm struct. This mask in the GISA is used to define for which ISC
> a GIB alert will be issued.
> 
> The functions kvm_s390_gisc_register() and kvm_s390_gisc_unregister()
> are used to (un)register a GISC (guest ISC) with a virtual machine and
> its GISA.
> 
> Upon successful completion, kvm_s390_gisc_register() returns the
> ISC to be used for GIB alert interruptions. A negative return code
> indicates an error during registration.
> 
> Theses functions will be used by other adapter types like AP and PCI to
> request pass-through interruption support.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  13 +++++
>  arch/s390/kvm/interrupt.c        | 117 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 130 insertions(+)
> 

> +int kvm_s390_gisc_register(struct kvm *kvm, u32 gisc)
> +{
> +	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
> +	u8 alert_mask;
> +
> +	if (!gi->origin)
> +		return -ENODEV;
> +	if (gisc > MAX_ISC)
> +		return -ERANGE;
> +
> +	spin_lock(&gi->alert.ref_lock);
> +	if (gi->alert.ref_count[gisc] == 0) {

If the ref_count is 0 here...

> +		alert_mask = gi->alert.mask | 0x80 >> gisc;
> +		WRITE_ONCE(gi->alert.mask, alert_mask);
> +	}
> +	gi->alert.ref_count[gisc]++;
> +	if (gi->alert.ref_count[gisc] == 1)

...it will certainly be 1 here, won't it?

Can you do all of the manipulations in a single if branch?

> +		gisa_set_iam(gi->origin, alert_mask);
> +	spin_unlock(&gi->alert.ref_lock);
> +
> +	return gib->nisc;
> +}
