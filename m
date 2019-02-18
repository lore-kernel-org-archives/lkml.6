Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FF7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6B221773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbfBRMVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:21:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729016AbfBRMV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:21:29 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4FC03A0B5A;
        Mon, 18 Feb 2019 12:21:29 +0000 (UTC)
Received: from gondolin (ovpn-116-217.ams2.redhat.com [10.36.116.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D62F5D71A;
        Mon, 18 Feb 2019 12:21:15 +0000 (UTC)
Date:   Mon, 18 Feb 2019 13:21:11 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com,
        alex.williamson@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com, mimu@linux.ibm.com
Subject: Re: [PATCH v3 4/9] s390: ap: tools to find a queue with a specific
 APQN
Message-ID: <20190218132111.3684b1f1.cohuck@redhat.com>
In-Reply-To: <56f583e7-fb41-ec54-ccf9-585a3e51b1c4@linux.ibm.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
        <1550152269-6317-5-git-send-email-pmorel@linux.ibm.com>
        <56f583e7-fb41-ec54-ccf9-585a3e51b1c4@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 18 Feb 2019 12:21:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2019 17:13:21 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 2/14/19 8:51 AM, Pierre Morel wrote:
> > We need to find the queue with a specific APQN during the
> > handling of the interception of the PQAP/AQIC instruction.
> > 
> > To handle the AP associated device reference count we keep
> > track of it in the vfio_ap_queue until we put the device.
> > 
> > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> > ---
> >   drivers/s390/crypto/vfio_ap_ops.c     | 54 +++++++++++++++++++++++++++++++++++
> >   drivers/s390/crypto/vfio_ap_private.h |  1 +
> >   2 files changed, 55 insertions(+)

> > +/**
> > + * vfio_ap_get_queue: Retrieve a queue with a specific APQN
> > + * @apqn: The queue APQN
> > + *
> > + * Retrieve a queue with a specific APQN from the list of the
> > + * devices associated to the vfio_ap_driver.
> > + *
> > + * The vfio_ap_queue has been already associated with the device
> > + * during the probe.
> > + * Store the associated device for reference counting
> > + *
> > + * Returns the pointer to the associated vfio_ap_queue
> > + */
> > +static  __attribute__((unused))
> > +	struct vfio_ap_queue *vfio_ap_get_queue(int apqn)  
> 
> I think you should change this signature for the reasons I stated
> below:
> 
> struct device *vfio_ap_get_queue_dev(int apqn)
> 
> > +{
> > +	struct device *dev;
> > +	struct vfio_ap_queue *q;
> > +
> > +	dev = driver_find_device(&matrix_dev->vfio_ap_drv->driver, NULL, &apqn,
> > +				 vfio_ap_check_apqn);
> > +	if (!dev)
> > +		return NULL;
> > +	q = dev_get_drvdata(dev);
> > +	q->dev = dev;  
> 
> Why store the device with the vfio_ap_queue object? Why not just return
> the device. The caller can get the vfio_ap_queue from the device's
> driver data. It seems the only reason for the 'dev' field is to
> temporarily hold a ref to the device so it can be put later. Why not
> just put the device.

Having looked at the remainder of the patches, I tend to agree that we
don't really need the backlink; we walk the driver's list of devices in
any case IIUC.

We *might* want a mechanism to grab the queue quickly (i.e. without
walking the list) if there's anything performance sensitive in there;
but from the patch descriptions, I don't think anything is done in a
hot path, so it should be fine.
