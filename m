Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F415C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7034521924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393768AbfBOKYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 05:24:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388223AbfBOKYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 05:24:17 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0B3D11219C6;
        Fri, 15 Feb 2019 10:24:17 +0000 (UTC)
Received: from gondolin (dhcp-192-213.str.redhat.com [10.33.192.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 23686600C5;
        Fri, 15 Feb 2019 10:24:08 +0000 (UTC)
Date:   Fri, 15 Feb 2019 11:24:06 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
Subject: Re: [PATCH v3 4/9] s390: ap: tools to find a queue with a specific
 APQN
Message-ID: <20190215112406.1ff79c50.cohuck@redhat.com>
In-Reply-To: <423e3f5b-dbbe-92b1-cfd3-d5a6f4e38f37@linux.ibm.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
        <1550152269-6317-5-git-send-email-pmorel@linux.ibm.com>
        <20190215104904.5cbe31bb.cohuck@redhat.com>
        <423e3f5b-dbbe-92b1-cfd3-d5a6f4e38f37@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 15 Feb 2019 10:24:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2019 11:10:43 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 15/02/2019 10:49, Cornelia Huck wrote:
> > On Thu, 14 Feb 2019 14:51:04 +0100
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> >   
> >> We need to find the queue with a specific APQN during the
> >> handling of the interception of the PQAP/AQIC instruction.
> >>
> >> To handle the AP associated device reference count we keep
> >> track of it in the vfio_ap_queue until we put the device.  
> > 
> > So, the relationship is
> > (struct ap_device)--(driver_data)-->(struct vfio_ap_queue)--(pointer)-->(struct ap_device)
> > ? IOW, a backlink?
> > 
> > If so, can't you already set that up during probe?  
> 
> Will do.
> 
> > 
> > Or am I confused by the various similar devices again? Maybe a diagram
> > would help...  
> 
> No you are right.

Good, I was fearing that I was more confused than normal for Fridays ;)

> 
> 
> >   
> >>
> >> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> >> ---
> >>   drivers/s390/crypto/vfio_ap_ops.c     | 54 +++++++++++++++++++++++++++++++++++
> >>   drivers/s390/crypto/vfio_ap_private.h |  1 +
> >>   2 files changed, 55 insertions(+)
> >>
> >> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> >> index 900b9cf..2a52c9b 100644
> >> --- a/drivers/s390/crypto/vfio_ap_ops.c
> >> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> >> @@ -24,6 +24,60 @@
> >>   #define VFIO_AP_MDEV_TYPE_HWVIRT "passthrough"
> >>   #define VFIO_AP_MDEV_NAME_HWVIRT "VFIO AP Passthrough Device"
> >>   
> >> +/**
> >> + * vfio_ap_check_apqn: check if a ap_queue is of a given APQN
> >> + *
> >> + * Returns 1 if we have a match.
> >> + * Otherwise returns 0.
> >> + */
> >> +static int vfio_ap_check_apqn(struct device *dev, void *data)
> >> +{
> >> +	struct vfio_ap_queue *q = dev_get_drvdata(dev);
> >> +
> >> +	return (q->apqn == *(int *)data);
> >> +}
> >> +
> >> +/**
> >> + * vfio_ap_get_queue: Retrieve a queue with a specific APQN
> >> + * @apqn: The queue APQN
> >> + *
> >> + * Retrieve a queue with a specific APQN from the list of the
> >> + * devices associated to the vfio_ap_driver.
> >> + *
> >> + * The vfio_ap_queue has been already associated with the device
> >> + * during the probe.
> >> + * Store the associated device for reference counting
> >> + *
> >> + * Returns the pointer to the associated vfio_ap_queue
> >> + */
> >> +static  __attribute__((unused))  
> > 
> > Eww. Can you get rid of that by reordering or squashing patches?  
> 
> I did this to avoid posting a very big patch.
> I will of course squash 4 and 5 with patch 6, when the two patches 4 and 
> 5 are reviewed.
> 
> If you think it brings more clarity to squash all for the next iteration 
> I will do.

Let's just see what the patches look like in the end. If a squashed
patch is not too unwieldy, I'd prefer that over those unused
annotations, though.

Hoping for review from others as well ;)

