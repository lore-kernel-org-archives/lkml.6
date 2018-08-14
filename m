Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F645C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 08:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC2921531
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 08:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC2921531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbeHNLg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 07:36:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727701AbeHNLg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 07:36:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3E6BCC12A4;
        Tue, 14 Aug 2018 08:50:15 +0000 (UTC)
Received: from gondolin (ovpn-117-136.ams2.redhat.com [10.36.117.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 810822026D7E;
        Tue, 14 Aug 2018 08:50:06 +0000 (UTC)
Date:   Tue, 14 Aug 2018 10:50:03 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com,
        pbonzini@redhat.com, alex.williamson@redhat.com,
        pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com, David Hildenbrand <david@redhat.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v9 05/22] KVM: s390: vsie: simulate VCPU SIE entry/exit
Message-ID: <20180814105003.290cf5f1.cohuck@redhat.com>
In-Reply-To: <1534196899-16987-6-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1534196899-16987-6-git-send-email-akrowiak@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 14 Aug 2018 08:50:15 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 14 Aug 2018 08:50:15 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2018 17:48:02 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> From: David Hildenbrand <david@redhat.com>
> 
> VCPU requests and VCPU blocking right now don't take care of the vSIE
> (as it was not necessary until now). But we want to have VCPU requests
> that will also be handled before running the vSIE again.
> 
> So let's simulate a SIE entry when entering the vSIE loop and check
> for PROG_ flags. The existing infrastructure (e.g. exit_sie()) will then
> detect that the SIE (in form of the vSIE execution loop) is running and
> properly kick the vSIE CPU, resulting in it leaving the vSIE loop and
> therefore the vSIE interception handler, allowing it to handle VCPU
> requests.
> 
> E.g. if we want to modify the crycb of the VCPU and make sure that any
> masks also get applied to the VSIE crycb shadow (which uses masks from the
> VCPU crycb), we will need a way to hinder the vSIE from running and make
> sure to process the updated crycb before reentering the vSIE again.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c |    9 ++++++++-
>  arch/s390/kvm/kvm-s390.h |    1 +
>  arch/s390/kvm/vsie.c     |   20 ++++++++++++++++++--
>  3 files changed, 27 insertions(+), 3 deletions(-)

I think that is the RFC version of David's patch, not the v1? Again,
not really relevant for reviewing, but I hope that you test the final
version.
