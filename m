Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F590C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01C520861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01C520861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=CARNet.hr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbeIGPAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:00:51 -0400
Received: from mail.CARNet.hr ([161.53.123.6]:46557 "EHLO mail.carnet.hr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbeIGPAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:00:51 -0400
Received: from cnzgrivvl-t440p.carpriv.carnet.hr ([161.53.12.131]:59632 helo=gavran.carpriv.carnet.hr)
        by mail.carnet.hr with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <Valentin.Vidic@CARNet.hr>)
        id 1fyDsI-0002wZ-Nu; Fri, 07 Sep 2018 12:20:27 +0200
Received: by gavran.carpriv.carnet.hr (Postfix, from userid 1000)
        id 89AAE202E0; Fri,  7 Sep 2018 12:20:26 +0200 (CEST)
Date:   Fri, 7 Sep 2018 12:20:26 +0200
From:   Valentin Vidic <Valentin.Vidic@CARNet.hr>
To:     Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, drbd-user@lists.linbit.com
Message-ID: <20180907102026.GH26705@gavran.carpriv.carnet.hr>
References: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
 <20180905103649.edugijsjx4v2fbxd@mac.bytemobile.com>
 <20180905113515.GU26705@gavran.carpriv.carnet.hr>
 <20180905162801.GB26705@gavran.carpriv.carnet.hr>
 <20180906162932.7qge5dmrgyqbmbbj@mac.bytemobile.com>
 <20180906221929.GZ26705@gavran.carpriv.carnet.hr>
 <20180907071530.te5dxdvg4zqgqscj@mac.bytemobile.com>
 <20180907072319.GA26705@gavran.carpriv.carnet.hr>
 <20180907075455.szxahgevvlmfjvwy@mac.bytemobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180907075455.szxahgevvlmfjvwy@mac.bytemobile.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 161.53.12.131
Subject: Re: [PATCH] xen-blkback: Switch to closed state after releasing the
 backing device
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 09:54:55AM +0200, Roger Pau Monné wrote:
> Then I'm afraid you will have to look into the vbd_free/create fix.

Yes, here is a first draft for that idea, let me know if you see some
problems there:

--- xenbus.c.orig       2018-09-07 12:11:57.798071485 +0200
+++ xenbus.c    2018-09-07 12:14:23.536077992 +0200
@@ -758,6 +759,7 @@
                             enum xenbus_state frontend_state)
 {
        struct backend_info *be = dev_get_drvdata(&dev->dev);
+       struct block_device *bdev;
        int err;
 
        pr_debug("%s %p %s\n", __func__, dev, xenbus_strstate(frontend_state));
@@ -772,6 +774,22 @@
 
        case XenbusStateInitialised:
        case XenbusStateConnected:
+               if (!be->blkif->vbd.bdev) {
+                       printk("blkdev_get");
+                       bdev = blkdev_get_by_dev(be->blkif->vbd.pdevice,
+                                                be->blkif->vbd.readonly ?
+                                                FMODE_READ : FMODE_WRITE, NULL);
+
+                       if (IS_ERR(bdev)) {
+                               pr_warn("frontend_changed: device %08x could not be opened\n",
+                                       be->blkif->vbd.pdevice);
+                               break;
+                       }
+
+                       printk("blkdev_get good");
+                       be->blkif->vbd.bdev = bdev;
+               }
+
                /*
                 * Ensure we connect even when two watches fire in
                 * close succession and we miss the intermediate value
@@ -808,6 +826,7 @@
 
        case XenbusStateClosed:
                xen_blkif_disconnect(be->blkif);
+               xen_vbd_free(&be->blkif->vbd);
                xenbus_switch_state(dev, XenbusStateClosed);
                if (xenbus_dev_is_online(dev))
                        break;

-- 
Valentin
