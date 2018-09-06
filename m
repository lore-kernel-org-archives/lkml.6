Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EA4C4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3A4206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3A4206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=CARNet.hr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbeIGC5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 22:57:10 -0400
Received: from mail.CARNet.hr ([161.53.123.6]:49517 "EHLO mail.carnet.hr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727261AbeIGC5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 22:57:10 -0400
Received: from cnzgrivvl-t440p.carpriv.carnet.hr ([161.53.12.131]:58854 helo=gavran.carpriv.carnet.hr)
        by mail.carnet.hr with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <Valentin.Vidic@CARNet.hr>)
        id 1fy2cb-0008Fm-Iu; Fri, 07 Sep 2018 00:19:30 +0200
Received: by gavran.carpriv.carnet.hr (Postfix, from userid 1000)
        id 57B93201A2; Fri,  7 Sep 2018 00:19:29 +0200 (CEST)
Date:   Fri, 7 Sep 2018 00:19:29 +0200
From:   Valentin Vidic <Valentin.Vidic@CARNet.hr>
To:     Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, drbd-user@lists.linbit.com
Message-ID: <20180906221929.GZ26705@gavran.carpriv.carnet.hr>
References: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
 <20180905103649.edugijsjx4v2fbxd@mac.bytemobile.com>
 <20180905113515.GU26705@gavran.carpriv.carnet.hr>
 <20180905162801.GB26705@gavran.carpriv.carnet.hr>
 <20180906162932.7qge5dmrgyqbmbbj@mac.bytemobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180906162932.7qge5dmrgyqbmbbj@mac.bytemobile.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 161.53.12.131
Subject: Re: [PATCH] xen-blkback: Switch to closed state after releasing the
 backing device
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 06:29:32PM +0200, Roger Pau Monné wrote:
> On Wed, Sep 05, 2018 at 06:28:01PM +0200, Valentin Vidic wrote:
> > On Wed, Sep 05, 2018 at 01:35:15PM +0200, Valentin Vidic wrote:
> > > > AFAICT, this will cause the backend to never switch to 'Closed' state
> > > > until the toolstack sets online to 0, which is not good IMO.
> > > > 
> > > > If for example a frontend decides to close a device, the backend will
> > > > stay in state 'Closing' until the toolstack actually removes the disk
> > > > by setting online to 0.
> > > > 
> > > > This will prevent resetting blk connections, as blkback will refuse to
> > > > switch to state XenbusStateInitWait unless it's at XenbusStateClosed
> > > > (see the XenbusStateInitialising case in frontend_changed), which will
> > > > never be reached with your patch.
> > 
> > Would it be possible to call xen_vbd_free before the state change?
> > 
> >         case XenbusStateClosed:
> >                 xen_blkif_disconnect(be->blkif);
> >                 xen_vbd_free(&be->blkif->vbd);
> >                 xenbus_switch_state(dev, XenbusStateClosed);
> 
> I think that will break reconnection, since xen_vbd_create is only
> called after hotplug script execution is performed (which happens only
> once at device attachment), but not when DomU changes frontend
> state.
> 
> If you want to perform this xen_vbd_free you will also have to move
> the xen_vbd_create call AFAICT, to a place that's also called when
> reconnecting a device. Note that I could be wrong, so it might be
> worth a shot to try different approaches since the blkback code is
> quite tangled and I might miss something.

It seems like the Closed state is not a good point to call the remove
script since the device could go back from Closed to Connected.

Maybe it would help to introduce a new final state (7 = XenbusStateFree
or XenbusStateRemove) that would be set after xen_vbd_free to let the
userspace know it is safe to run the remove script?

static void xen_blkif_free(struct xen_blkif *blkif)
{

        WARN_ON(xen_blkif_disconnect(blkif));
        xen_vbd_free(&blkif->vbd);
        xenbus_switch_state(blkif->be->dev, XenbusStateFree);
        kfree(blkif->be->mode);
        kfree(blkif->be);

        /* Make sure everything is drained before shutting down */
        kmem_cache_free(xen_blkif_cachep, blkif);
}

-- 
Valentin
