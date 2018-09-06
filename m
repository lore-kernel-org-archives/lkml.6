Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8102BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A1F2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A1F2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=CARNet.hr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeIGClL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 22:41:11 -0400
Received: from mail.CARNet.hr ([161.53.123.6]:48532 "EHLO mail.carnet.hr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727378AbeIGClL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 22:41:11 -0400
Received: from [2001:b68:ff:12::131] (port=49594 helo=gavran.carpriv.carnet.hr)
        by mail.carnet.hr with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <Valentin.Vidic@CARNet.hr>)
        id 1fy2N9-0006Wr-HU; Fri, 07 Sep 2018 00:03:32 +0200
Received: by gavran.carpriv.carnet.hr (Postfix, from userid 1000)
        id D03D9201A2; Fri,  7 Sep 2018 00:03:25 +0200 (CEST)
Date:   Fri, 7 Sep 2018 00:03:25 +0200
From:   Valentin Vidic <Valentin.Vidic@CARNet.hr>
To:     Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, drbd-user@lists.linbit.com
Message-ID: <20180906220325.GY26705@gavran.carpriv.carnet.hr>
References: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
 <20180905103649.edugijsjx4v2fbxd@mac.bytemobile.com>
 <20180905162756.GA26705@gavran.carpriv.carnet.hr>
 <20180906161421.ba35p6qx5rvktjos@mac.bytemobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180906161421.ba35p6qx5rvktjos@mac.bytemobile.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:b68:ff:12::131
Subject: Re: [PATCH] xen-blkback: Switch to closed state after releasing the
 backing device
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 06:14:21PM +0200, Roger Pau Monné wrote:
> On Wed, Sep 05, 2018 at 06:27:56PM +0200, Valentin Vidic wrote:
> > On Wed, Sep 05, 2018 at 12:36:49PM +0200, Roger Pau Monné wrote:
> > > On Wed, Aug 29, 2018 at 08:52:14AM +0200, Valentin Vidic wrote:
> > > > Switching to closed state earlier can cause the block-drbd
> > > > script to fail with 'Device is held open by someone':
> > > > 
> > > > root: /etc/xen/scripts/block-drbd: remove XENBUS_PATH=backend/vbd/6/51712
> > > > kernel: [ 2222.278235] block drbd6: State change failed: Device is held open by someone
> > > > kernel: [ 2222.278304] block drbd6:   state = { cs:Connected ro:Primary/Secondary ds:UpToDate/UpToDate r----- }
> > > > kernel: [ 2222.278340] block drbd6:  wanted = { cs:Connected ro:Secondary/Secondary ds:UpToDate/UpToDate r----- }
> > > > root: /etc/xen/scripts/block-drbd: Writing backend/vbd/6/51712/hotplug-error /etc/xen/scripts/block-drbd failed; error detected. backend/vbd/6/51712/hotplug-status error to xenstore.
> > > > root: /etc/xen/scripts/block-drbd: /etc/xen/scripts/block-drbd failed; error detected.
> > > > 
> > > > Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
> > > > Cc: stable@vger.kernel.org
> > > > ---
> > > >  drivers/block/xen-blkback/xenbus.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> > > > index a4bc74e72c39..43bddc996709 100644
> > > > --- a/drivers/block/xen-blkback/xenbus.c
> > > > +++ b/drivers/block/xen-blkback/xenbus.c
> > > > @@ -323,6 +323,7 @@ static void xen_blkif_free(struct xen_blkif *blkif)
> > > >  {
> > > >  	WARN_ON(xen_blkif_disconnect(blkif));
> > > >  	xen_vbd_free(&blkif->vbd);
> > > > +	xenbus_switch_state(blkif->be->dev, XenbusStateClosed);
> > > >  	kfree(blkif->be->mode);
> > > >  	kfree(blkif->be);
> > > >  
> > > > @@ -814,7 +815,6 @@ static void frontend_changed(struct xenbus_device *dev,
> > > >  
> > > >  	case XenbusStateClosed:
> > > >  		xen_blkif_disconnect(be->blkif);
> > > > -		xenbus_switch_state(dev, XenbusStateClosed);
> > > >  		if (xenbus_dev_is_online(dev))
> > > >  			break;
> > > 
> > > AFAICT, this will cause the backend to never switch to 'Closed' state
> > > until the toolstack sets online to 0, which is not good IMO.
> > > 
> > > If for example a frontend decides to close a device, the backend will
> > > stay in state 'Closing' until the toolstack actually removes the disk
> > > by setting online to 0.
> > > 
> > > This will prevent resetting blk connections, as blkback will refuse to
> > > switch to state XenbusStateInitWait unless it's at XenbusStateClosed
> > > (see the XenbusStateInitialising case in frontend_changed), which will
> > > never be reached with your patch.
> > 
> > Ok, is it possible to test this somehow?
> 
> Yes, you can try booting a PV guest with pvgrub, that will cause
> pvgrub to open a blk connection, then close it and afterwards the OS
> kernel will start a new connection.

Indeed the boot hangs after pvgrub loads the kernel and initrd, so it
seems this does not work as expected.

-- 
Valentin
