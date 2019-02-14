Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03A6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACD6222DD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502968AbfBNQ56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:57:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56688 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502954AbfBNQ5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:57:45 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 455EE2D7EE;
        Thu, 14 Feb 2019 16:57:44 +0000 (UTC)
Received: from gondolin (dhcp-192-213.str.redhat.com [10.33.192.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C468611B0;
        Thu, 14 Feb 2019 16:57:33 +0000 (UTC)
Date:   Thu, 14 Feb 2019 17:57:30 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
Subject: Re: [PATCH v3 1/9] s390: vfio_ap: link the vfio_ap devices to the
 vfio_ap bus subsystem
Message-ID: <20190214175730.4ab609ae.cohuck@redhat.com>
In-Reply-To: <9403117a-04a6-8f69-2a61-f96d35a59555@linux.ibm.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
        <1550152269-6317-2-git-send-email-pmorel@linux.ibm.com>
        <20190214155441.087d2a68.cohuck@redhat.com>
        <9403117a-04a6-8f69-2a61-f96d35a59555@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 14 Feb 2019 16:57:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 16:47:30 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 14/02/2019 15:54, Cornelia Huck wrote:
> > On Thu, 14 Feb 2019 14:51:01 +0100
> > Pierre Morel <pmorel@linux.ibm.com> wrote:

> >> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> >> @@ -24,8 +24,9 @@ MODULE_LICENSE("GPL v2");
> >>   
> >>   static struct ap_driver vfio_ap_drv;
> >>   
> >> -static struct device_type vfio_ap_dev_type = {
> >> -	.name = VFIO_AP_DEV_TYPE_NAME,
> >> +struct matrix_driver {
> >> +	struct device_driver drv;
> >> +	int device_count;  
> > 
> > This counter basically ensures that at most one device may bind with
> > this driver... you'd still have that device on the bus, though.  
> 
> yes, this is what is wanted: this driver can only support one device.
> May be another matrix driver can support one or more other devices.
> 
> I should update comment message my be.
> 
> >   
> >>   };
> >>   
> >>   struct ap_matrix_dev *matrix_dev;  
> 
> >>   
> >> -	matrix_dev->device.type = &vfio_ap_dev_type;
> >>   	dev_set_name(&matrix_dev->device, "%s", VFIO_AP_DEV_NAME);
> >>   	matrix_dev->device.parent = root_device;
> >> +	matrix_dev->device.bus = &matrix_bus;
> >>   	matrix_dev->device.release = vfio_ap_matrix_dev_release;
> >> -	matrix_dev->device.driver = &vfio_ap_drv.driver;
> >> +	matrix_dev->vfio_ap_drv = &vfio_ap_drv;  
> > 
> > Can't you get that structure through matrix_dev->device.driver instead
> > when you need it in the function below?  
> 
> Not anymore.
> We have two different drivers and devices
> matrix_drv <-> matrix_dev
> and
> vfio_ap_drv <-> ap_devices
> 
> The driver behind the matrix_dev->dev->driver is matrix_drv
> what is needed here is vfio_ap_drv.

Wait, we had tacked a driver for ap devices unto a matrix device, which
is not on the ap bus? Maybe that's what trips libudev?

(And reading further in the current code, it seems we clear that
structure _after_ the matrix device had been setup, so how can that
even work? Where am I confused?)

> 
> >   
> >>   
> >>   	ret = device_register(&matrix_dev->device);
> >>   	if (ret)
> >>   		goto matrix_reg_err;
> >>   
> >> +	ret = driver_register(&matrix_driver.drv);
> >> +	if (ret)
> >> +		goto matrix_drv_err;
> >> +  
> > 
> > As you already have several structures that can be registered exactly
> > once (the root device, the bus, the driver, ...), you can already be
> > sure that there's only one device on the bus, can't you?  
> 
> hum, no I don't think so, no device can register before this module is 
> loaded, but what does prevent a device to register later from another 
> module?

Not unless you export the interface, I guess.
