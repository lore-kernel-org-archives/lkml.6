Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E9CC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 02:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9EEA2085A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 02:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfAHCvK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 21:51:10 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:6955 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727052AbfAHCvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 21:51:09 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id B6A6D3CDED83C5A08D9A;
        Tue,  8 Jan 2019 10:51:07 +0800 (CST)
Received: from DGGEMM423-HUB.china.huawei.com (10.1.198.40) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 8 Jan 2019 10:51:07 +0800
Received: from DGGEMM528-MBX.china.huawei.com ([169.254.8.187]) by
 dggemm423-hub.china.huawei.com ([10.1.198.40]) with mapi id 14.03.0415.000;
 Tue, 8 Jan 2019 10:51:02 +0800
From:   "liujian (CE)" <liujian56@huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "hamish.martin@alliedtelesis.co.nz" 
        <hamish.martin@alliedtelesis.co.nz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] driver: uio: fix possible memory leak and
 use-after-free in __uio_register_device
Thread-Topic: [PATCH v2] driver: uio: fix possible memory leak and
 use-after-free in __uio_register_device
Thread-Index: AQHUo+SIvIeTJgGl7E6Ihu2x7IZq86WjeeSAgAEx3bA=
Date:   Tue, 8 Jan 2019 02:51:01 +0000
Message-ID: <4F88C5DDA1E80143B232E89585ACE27D0258ECAE@DGGEMM528-MBX.china.huawei.com>
References: <1546611548-205765-1-git-send-email-liujian56@huawei.com>
 <20190107161315.GA25694@kroah.com>
In-Reply-To: <20190107161315.GA25694@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.97.126]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Tuesday, January 08, 2019 12:13 AM
> To: liujian (CE) <liujian56@huawei.com>
> Cc: michal.simek@xilinx.com; hamish.martin@alliedtelesis.co.nz;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2] driver: uio: fix possible memory leak and use-after-free
> in __uio_register_device
> 
> On Fri, Jan 04, 2019 at 10:19:08PM +0800, liujian wrote:
> > 'idev' is malloced in __uio_register_device() and leak free it before
> > leaving from the uio_get_minor() error handing case, it will cause
> > memory leak.
> >
> > Also, in uio_dev_add_attributes() error handing case, idev is used
> > after device_unregister(), in which 'idev' has been released, touch
> > idev cause use-after-free.
> >
> > Fixes: a93e7b331568 ("uio: Prevent device destruction while fds are
> > open")
> > Fixes: e6789cd3dfb5 ("uio: Simplify uio error path by using devres
> > functions")
> > Signed-off-by: liujian <liujian56@huawei.com>
> > Reviewed-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
> > ---
> > v1->v2:
> > change git log and fix code
> >
> >  drivers/uio/uio.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c index
> > 1313422..be2a943 100644
> > --- a/drivers/uio/uio.c
> > +++ b/drivers/uio/uio.c
> > @@ -940,9 +940,12 @@ int __uio_register_device(struct module *owner,
> >  	atomic_set(&idev->event, 0);
> >
> >  	ret = uio_get_minor(idev);
> > -	if (ret)
> > +	if (ret) {
> > +		kfree(idev);
> >  		return ret;
> > +	}
> >
> > +	device_initialize(&idev->dev);
> >  	idev->dev.devt = MKDEV(uio_major, idev->minor);
> >  	idev->dev.class = &uio_class;
> >  	idev->dev.parent = parent;
> > @@ -953,7 +956,7 @@ int __uio_register_device(struct module *owner,
> >  	if (ret)
> >  		goto err_device_create;
> >
> > -	ret = device_register(&idev->dev);
> > +	ret = device_add(&idev->dev);
> >  	if (ret)
> >  		goto err_device_create;
> >
> > @@ -985,9 +988,10 @@ int __uio_register_device(struct module *owner,
> >  err_request_irq:
> >  	uio_dev_del_attributes(idev);
> >  err_uio_dev_add_attributes:
> > -	device_unregister(&idev->dev);
> > +	device_del(&idev->dev);
> >  err_device_create:
> >  	uio_free_minor(idev);
> > +	put_device(&idev->dev);
> 
> device_del() and then put_device()?  I don't think that's a correct error
> cleanup path do you?
> 
In err_uio_dev_add_attributes error handling case, device_unregister()  will call put_device(), and idev will be released in put_device()
Then in err_device_create error handling case,  uio_free_minor() will trigger use-after-free

Now, divide device_register() into device_initialize() and device_add(), and divide device_unregister() into device_del() and put_device(). 
Call uio_free_minor() and then call put_device() to avoid use-after-free

> Please fix one thing at a time here also, this should be a a patch series, right?
> 
Yes, I will do, thanks~

Best Regards,
Liujian

> thanks,
> 
> greg k-h
