Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C4DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15482084A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbeLSUKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 15:10:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42608 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728479AbeLSUKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 15:10:11 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B6F8B3DBD2;
        Wed, 19 Dec 2018 20:10:10 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD99210018F8;
        Wed, 19 Dec 2018 20:10:05 +0000 (UTC)
Date:   Wed, 19 Dec 2018 21:10:03 +0100
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
Subject: Re: [PATCH v5 01/15] KVM: s390: unregister debug feature on failing
 arch init
Message-ID: <20181219210934.2f370eb7.cohuck@redhat.com>
In-Reply-To: <20181219191756.57973-2-mimu@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
        <20181219191756.57973-2-mimu@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 19 Dec 2018 20:10:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2018 20:17:42 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> Make sure the debug feature and its allocated resources get
> released upon unsuccessful architecture initialization.
> 
> A related indication of the issue will be reported as kernel
> message.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Message-Id: <20181130143215.69496-2-mimu@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  Documentation/kmsg/s390/kvm | 12 ++++++++++++
>  arch/s390/kvm/kvm-s390.c    | 17 ++++++++++++++---
>  2 files changed, 26 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/kmsg/s390/kvm
> 
> diff --git a/Documentation/kmsg/s390/kvm b/Documentation/kmsg/s390/kvm
> new file mode 100644
> index 000000000000..76ffe2012254
> --- /dev/null
> +++ b/Documentation/kmsg/s390/kvm
> @@ -0,0 +1,12 @@
> +/*?
> + * Text: "Failed to register FLIC rc=%d\n"
> + * Severity: Error
> + * Parameter:
> + *   @1: return code of the FLIC registration call
> + * Description:
> + * The registration of the FLIC (Floating Interrupt Controller Interface)
> + * was not successful.
> + * User action:
> + * If this problem persists after a reload of the kvm kernel module, gather
> + * Linux debug data and contact your support organization.
> + */

Hm, it seems that the kmsg stuff crept in there again...
