Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E51C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8132075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E8132075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbeIGPX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:23:57 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:31374 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbeIGPX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:23:56 -0400
X-IronPort-AV: E=Sophos;i="5.53,342,1531785600"; 
   d="scan'208";a="78696431"
Date:   Fri, 7 Sep 2018 12:43:09 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Valentin Vidic <Valentin.Vidic@CARNet.hr>
CC:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, <xen-devel@lists.xenproject.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <drbd-user@lists.linbit.com>
Subject: Re: [PATCH] xen-blkback: Switch to closed state after releasing the
 backing device
Message-ID: <20180907104309.z4jsga5hcnphwxu7@mac.bytemobile.com>
References: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
 <20180905103649.edugijsjx4v2fbxd@mac.bytemobile.com>
 <20180905113515.GU26705@gavran.carpriv.carnet.hr>
 <20180905162801.GB26705@gavran.carpriv.carnet.hr>
 <20180906162932.7qge5dmrgyqbmbbj@mac.bytemobile.com>
 <20180906221929.GZ26705@gavran.carpriv.carnet.hr>
 <20180907071530.te5dxdvg4zqgqscj@mac.bytemobile.com>
 <20180907072319.GA26705@gavran.carpriv.carnet.hr>
 <20180907075455.szxahgevvlmfjvwy@mac.bytemobile.com>
 <20180907102026.GH26705@gavran.carpriv.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180907102026.GH26705@gavran.carpriv.carnet.hr>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 12:20:26PM +0200, Valentin Vidic wrote:
> On Fri, Sep 07, 2018 at 09:54:55AM +0200, Roger Pau Monné wrote:
> > Then I'm afraid you will have to look into the vbd_free/create fix.
> 
> Yes, here is a first draft for that idea, let me know if you see some
> problems there:

Thanks!

> --- xenbus.c.orig       2018-09-07 12:11:57.798071485 +0200
> +++ xenbus.c    2018-09-07 12:14:23.536077992 +0200
> @@ -758,6 +759,7 @@
>                              enum xenbus_state frontend_state)
>  {
>         struct backend_info *be = dev_get_drvdata(&dev->dev);
> +       struct block_device *bdev;
>         int err;
>  
>         pr_debug("%s %p %s\n", __func__, dev, xenbus_strstate(frontend_state));
> @@ -772,6 +774,22 @@
>  
>         case XenbusStateInitialised:
>         case XenbusStateConnected:
> +               if (!be->blkif->vbd.bdev) {
> +                       printk("blkdev_get");
> +                       bdev = blkdev_get_by_dev(be->blkif->vbd.pdevice,
> +                                                be->blkif->vbd.readonly ?
> +                                                FMODE_READ : FMODE_WRITE, NULL);
> +
> +                       if (IS_ERR(bdev)) {
> +                               pr_warn("frontend_changed: device %08x could not be opened\n",
> +                                       be->blkif->vbd.pdevice);
> +                               break;
> +                       }
> +
> +                       printk("blkdev_get good");
> +                       be->blkif->vbd.bdev = bdev;
> +               }
> +

I would prefer if you could avoid open-coding this here, and instead
use xen_vbd_create or similar. I would also prefer that the call to
xen_vbd_create in backend_changed was removed and we had a single call
to xen_vbd_create that's used for both initial device connection and
reconnection.

Also, I think this could cause issues if for some reason the frontend
switches to state 'Connected' before hotplug scripts have run, in
which case you would try to open an unexpected device because pdevice
won't be correctly set.

Roger.
