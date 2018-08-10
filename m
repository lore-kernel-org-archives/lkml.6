Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3CDC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 11:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9022240E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 11:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9022240E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbeHJNq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 09:46:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34226 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727598AbeHJNq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 09:46:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DD1A272620;
        Fri, 10 Aug 2018 11:16:56 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3373E7C54;
        Fri, 10 Aug 2018 11:16:51 +0000 (UTC)
Date:   Fri, 10 Aug 2018 13:16:48 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
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
        frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v8 17/22] s390: vfio-ap: zeroize the AP queues.
Message-ID: <20180810131648.4fab1d7a.cohuck@redhat.com>
In-Reply-To: <fa85257e-fda1-8f1d-aa7c-c98e74196d37@linux.ibm.com>
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1533739472-7172-18-git-send-email-akrowiak@linux.vnet.ibm.com>
        <20180810111445.015fcf2a.cohuck@redhat.com>
        <fa85257e-fda1-8f1d-aa7c-c98e74196d37@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 10 Aug 2018 11:16:57 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 10 Aug 2018 11:16:57 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2018 12:49:08 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 10/08/2018 11:14, Cornelia Huck wrote:
> > On Wed,  8 Aug 2018 10:44:27 -0400
> > Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> >  
> >> From: Tony Krowiak <akrowiak@linux.ibm.com>
> >>
> >> Let's call PAPQ(ZAPQ) to zeroize a queue:
> >>
> >> * For each queue configured for a mediated matrix device
> >>    when it is released.
> >>
> >> Zeroizing a queue resets the queue, clears all pending
> >> messages for the queue entries and disables adapter interruptions
> >> associated with the queue.
> >>
> >> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> >> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> >> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> >> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> >> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >> ---
> >>   drivers/s390/crypto/vfio_ap_ops.c     |   29 ++++++++++++++++++++++++++++-
> >>   drivers/s390/crypto/vfio_ap_private.h |   25 +++++++++++++++++++++++++
> >>   2 files changed, 53 insertions(+), 1 deletions(-)
> >>
> >> @@ -788,7 +812,10 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
> >>   {
> >>   	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> >>   
> >> -	kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
> >> +	if (matrix_mdev->kvm)
> >> +		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);  
> > Confused. Why is the check for matrix_mdev->kvm added here?  
> 
> When using the KVM notifier we can get two notifications:
> -> KVM is here / is comming
> -> KVM is not here / disappearing  
> 
> In the first case we initialize matrix_mdev->kvm with a pointer to KVM
> In the second case we nullify the pointer.
> 
> During the open of the mediated device, the guest should have been started
> or we refuse to start.
> 
> During the close of the mediated device, the guest should be there, but
> we have no certitude that the guest did not disappear before the VFIO
> file being closed.
> Since we do not allow multiple guests using the same mediated device
> this case should not happen with QEMU. But I am not sure that
> a rogue user program could not stop KVM before closing the VFIO
> mediated device.

I'm not sure why the check is introduced in this patch, though. But
maybe I just need weekend :)

> 
> Maybe Alex can confirm this point, if not we can remove the test.
