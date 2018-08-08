Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246DFC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA93C21742
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA93C21742
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeHHPDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 11:03:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59332 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726680AbeHHPDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 11:03:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB24487A82;
        Wed,  8 Aug 2018 12:44:18 +0000 (UTC)
Received: from gondolin (dhcp-192-215.str.redhat.com [10.33.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 685EE2166BA0;
        Wed,  8 Aug 2018 12:44:17 +0000 (UTC)
Date:   Wed, 8 Aug 2018 14:44:14 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH RFC 1/2] KVM: s390: vsie: simulate VCPU SIE entry/exit
Message-ID: <20180808144414.75369a40.cohuck@redhat.com>
In-Reply-To: <20180807125131.3606-2-david@redhat.com>
References: <20180807125131.3606-1-david@redhat.com>
        <20180807125131.3606-2-david@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 08 Aug 2018 12:44:18 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 08 Aug 2018 12:44:18 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Aug 2018 14:51:30 +0200
David Hildenbrand <david@redhat.com> wrote:

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
> ---
>  arch/s390/kvm/kvm-s390.c |  9 ++++++++-
>  arch/s390/kvm/kvm-s390.h |  1 +
>  arch/s390/kvm/vsie.c     | 20 ++++++++++++++++++--
>  3 files changed, 27 insertions(+), 3 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
