Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD38C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 01:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF8F20844
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 01:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfBABpV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 20:45:21 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:59528 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726425AbfBABpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 20:45:21 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id E5C3184347B16684D83C;
        Fri,  1 Feb 2019 09:45:18 +0800 (CST)
Received: from DGGEMM422-HUB.china.huawei.com (10.1.198.39) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 1 Feb 2019 09:45:19 +0800
Received: from DGGEMM528-MBX.china.huawei.com ([169.254.8.130]) by
 dggemm422-hub.china.huawei.com ([10.1.198.39]) with mapi id 14.03.0415.000;
 Fri, 1 Feb 2019 09:45:14 +0800
From:   "liujian (CE)" <liujian56@huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "xiubli@redhat.com" <xiubli@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5] driver: uio: fix possible memory leak in uio_open
Thread-Topic: [PATCH v5] driver: uio: fix possible memory leak in uio_open
Thread-Index: AQHUsk9Xli2nkkNmlU2QOYPShi2DXaXJCrOAgAEmm7A=
Date:   Fri, 1 Feb 2019 01:45:14 +0000
Message-ID: <4F88C5DDA1E80143B232E89585ACE27D025EBEBB@DGGEMM528-MBX.china.huawei.com>
References: <1548196704-352035-1-git-send-email-liujian56@huawei.com>
 <20190131153621.GA16678@kroah.com>
In-Reply-To: <20190131153621.GA16678@kroah.com>
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
> Sent: Thursday, January 31, 2019 11:36 PM
> To: liujian (CE) <liujian56@huawei.com>
> Cc: xiubli@redhat.com; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v5] driver: uio: fix possible memory leak in uio_open
> 
> On Wed, Jan 23, 2019 at 06:38:24AM +0800, Liu Jian wrote:
> > If 'idev->info' is NULL, we need to  free 'listener'
> >
> > Fixes: 57c5f4df0a5a ("uio: fix crash after the device is
> > unregistered")
> > Signed-off-by: Liu Jian <liujian56@huawei.com>
> > ---
> > v1->v2:
> > rename the "err_infoopen" to "err_idev_info"
> > v2->3:
> > put the extra info after the "--"
> > v3-v4:
> > add git log
> > v4-v5:
> > correct git log
> >
> >  drivers/uio/uio.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c index
> > 1313422..b4ae2d9 100644
> > --- a/drivers/uio/uio.c
> > +++ b/drivers/uio/uio.c
> > @@ -491,18 +491,19 @@ static int uio_open(struct inode *inode, struct
> file *filep)
> >  	if (!idev->info) {
> >  		mutex_unlock(&idev->info_lock);
> >  		ret = -EINVAL;
> > -		goto err_alloc_listener;
> > +		goto err_idev_info;
> >  	}
> >
> >  	if (idev->info && idev->info->open)
> >  		ret = idev->info->open(idev->info, inode);
> >  	mutex_unlock(&idev->info_lock);
> >  	if (ret)
> > -		goto err_infoopen;
> > +		goto err_idev_info;
> >
> >  	return 0;
> >
> > -err_infoopen:
> > +err_idev_info:
> > +	filep->private_data = NULL;
> >  	kfree(listener);
> >
> >  err_alloc_listener:
> > --
> > 2.7.4
> >
> 
> This does not apply to my tree at all :(

I am sorry to have sent so many versions, during which this issue has been resolved by commit 1e09cdd506c8833a9d52cb61009798660cff4051.
So please ignore this patch , and thank you and Xiubo Li in this patch~

> Please rebase it against the char-misc-next branch of my char-misc.git
> tree and resend.
> 
> thanks,
> 
> greg k-h
