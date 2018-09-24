Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE87FECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C5B2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C5B2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbeIXQfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:35:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727730AbeIXQfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:35:37 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B4ABA308FB8F;
        Mon, 24 Sep 2018 10:34:12 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0A0C104C529;
        Mon, 24 Sep 2018 10:34:04 +0000 (UTC)
Date:   Mon, 24 Sep 2018 12:34:02 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com,
        pbonzini@redhat.com, alex.williamson@redhat.com,
        pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com
Subject: Re: [PATCH v10 03/26] KVM: s390: refactor crypto initialization
Message-ID: <20180924123402.51e231a7.cohuck@redhat.com>
In-Reply-To: <e340e3ec-4f8f-1f7b-b2f5-6fec77c4c5f9@linux.ibm.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1536781396-13601-4-git-send-email-akrowiak@linux.vnet.ibm.com>
        <e340e3ec-4f8f-1f7b-b2f5-6fec77c4c5f9@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 24 Sep 2018 10:34:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2018 19:18:57 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 09/12/2018 03:42 PM, Tony Krowiak wrote:
> > From: Tony Krowiak <akrowiak@linux.ibm.com>
> > 
> > This patch refactors the code that initializes and sets up the
> > crypto configuration for a guest. The following changes are
> > implemented via this patch:
> > 
> > 1. Prior to the introduction of AP device virtualization, it
> >     was not necessary to provide guest access to the CRYCB
> >     unless the MSA extension 3 (MSAX3) facility was installed
> >     on the host system. With the introduction of AP device
> >     virtualization, the CRYCB must be made accessible to the
> >     guest if the AP instructions are installed on the host
> >     and are to be provided to the guest.
> > 
> > 2. Introduces a flag indicating AP instructions executed on
> >     the guest shall be interpreted by the firmware. It is
> >     initialized to indicate AP instructions are to be
> >     to be interpreted and is used to set the SIE bit for
> >     each vcpu during vcpu setup.
> > 
> > Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> > Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> > Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > Acked-by: Janosch Frank <frankja@linux.ibm.com>
> > Tested-by: Michael Mueller <mimu@linux.ibm.com>
> > Tested-by: Farhan Ali <alifm@linux.ibm.com>
> > Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > ---
> >   arch/s390/include/asm/kvm_host.h |    2 +
> >   arch/s390/include/uapi/asm/kvm.h |    1 +
> >   arch/s390/kvm/kvm-s390.c         |   71 ++++++++++++++++++--------------------
> >   3 files changed, 37 insertions(+), 37 deletions(-)

(...)

> The fixup! patch below modifies this patch (03/26) to illustrate how
> 
> David's recommendation will be implemented for v11 of the series. It
> 
> is one of three fixup! patches (the other two are in responses to
> 11/26
>   and 25/26) included to generate discussion in v10 rather than
> 
> waiting until v11 for comments.

(...)

Looks good to me.
