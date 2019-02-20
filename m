Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD739C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A1D2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfBTJ1h convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:27:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40606 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbfBTJ1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:27:36 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D1198EDE10;
        Wed, 20 Feb 2019 09:27:35 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C929D19C57;
        Wed, 20 Feb 2019 09:27:33 +0000 (UTC)
Date:   Wed, 20 Feb 2019 10:27:31 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com
Subject: Re: [PATCH v2 1/1] s390: vfio_ap: link the vfio_ap devices to the
 vfio_ap bus subsystem
Message-ID: <20190220102731.4fca4f91.cohuck@redhat.com>
In-Reply-To: <6cc5b478-4678-9a82-b902-cc9aed22becf@linux.ibm.com>
References: <1550513328-12646-1-git-send-email-pmorel@linux.ibm.com>
        <1550513328-12646-2-git-send-email-pmorel@linux.ibm.com>
        <8e6853ba-12ed-a4f3-1263-0e15f715b644@linux.ibm.com>
        <6cc5b478-4678-9a82-b902-cc9aed22becf@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 20 Feb 2019 09:27:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 22:31:17 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 19/02/2019 19:52, Tony Krowiak wrote:
> > On 2/18/19 1:08 PM, Pierre Morel wrote:  
> >> Libudev relies on having a subsystem link for non-root devices. To
> >> avoid libudev (and potentially other userspace tools) choking on the
> >> matrix device let us introduce a vfio_ap bus and with that the vfio_ap
> >> bus subsytem, and make the matrix device reside within it.
> >>
> >> Doing this we need to suppress the forced link from the matrix device to
> >> the vfio_ap driver and we suppress the device_type we do not need
> >> anymore.
> >>
> >> Since the associated matrix driver is not the vfio_ap driver any more,
> >> we have to change the search for the devices on the vfio_ap driver in
> >> the function vfio_ap_verify_queue_reserved.
> >>
> >> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> >> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> >> ---
> >>   drivers/s390/crypto/vfio_ap_drv.c     | 48 
> >> +++++++++++++++++++++++++++++------
> >>   drivers/s390/crypto/vfio_ap_ops.c     |  4 +--
> >>   drivers/s390/crypto/vfio_ap_private.h |  1 +
> >>   3 files changed, 43 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/drivers/s390/crypto/vfio_ap_drv.c 
> >> b/drivers/s390/crypto/vfio_ap_drv.c
> >> index 31c6c84..8e45559 100644
> >> --- a/drivers/s390/crypto/vfio_ap_drv.c
> >> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> >> @@ -24,10 +24,6 @@ MODULE_LICENSE("GPL v2");
> >>   static struct ap_driver vfio_ap_drv;
> >> -static struct device_type vfio_ap_dev_type = {
> >> -    .name = VFIO_AP_DEV_TYPE_NAME,
> >> -};
> >> -
> >>   struct ap_matrix_dev *matrix_dev;
> >>   /* Only type 10 adapters (CEX4 and later) are supported
> >> @@ -62,6 +58,27 @@ static void vfio_ap_matrix_dev_release(struct 
> >> device *dev)
> >>       kfree(matrix_dev);
> >>   }
> >> +static int matrix_bus_match(struct device *dev, struct device_driver 
> >> *drv)
> >> +{
> >> +    return 1;  
> > 
> > I think we should verify the following:
> > 
> > * dev == matrix_dev->device
> > * drv == &matrix_driver
> > 
> > The model employed is for the matrix device to be a singleton, so I
> > think we should verify that the matrix device and driver defined herein
> > ought to be the only possible choices for a match. Of course, doing so
> > will require some restructuring of this patch.  
> 
> I think Conny already answered this question.

Not quite :), but I don't think we need any magic in there, as there's
only one device and only one driver on that bus. No need to make this
more complicated.

> 
> >   
> >> +}
> >> +
> >> +static struct bus_type matrix_bus = {
> >> +    .name = "vfio_ap",
> >> +    .match = &matrix_bus_match,
> >> +};
> >> +
> >> +static int matrix_probe(struct device *dev)
> >> +{
> >> +    return 0;
> >> +}
> >> +
> >> +static struct device_driver matrix_driver = {
> >> +    .name = "vfio_ap",  
> > 
> > This is the same name used for the original device driver. I think
> > this driver ought to have a different name to avoid confusion.
> > How about vfio_ap_matrix or some other name to differentiate the
> > two.  
> 
> I would like too, but changing this will change the path to the mediated 
> device supported type.

Yes, we don't want to change that.

> 
> 
> >   
> >> +    .bus = &matrix_bus,
> >> +    .probe = matrix_probe,  
> > 
> > I would add:
> >      .suppress_bind_attrs = true;
> > 
> > This will remove the sysfs bind/unbind interfaces. Since there is only
> > one matrix device and it's lifecycle is controlled herein, there is no
> > sense in allowing a root user to bind/unbind it.
> >   
> 
> OTOH bind/unbind has no impact.
> If no one else ask for this I will not change what has already been 
> reviewed by Conny and Christian.

As we only have one driver, it does not really make sense anyway.
