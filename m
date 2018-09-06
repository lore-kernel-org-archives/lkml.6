Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA85C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B12420861
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B12420861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbeIFVF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:05:57 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:18731 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeIFVF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:05:56 -0400
X-IronPort-AV: E=Sophos;i="5.53,338,1531785600"; 
   d="scan'208";a="78658170"
Date:   Thu, 6 Sep 2018 18:29:32 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Valentin Vidic <Valentin.Vidic@CARNet.hr>
CC:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, <xen-devel@lists.xenproject.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <drbd-user@lists.linbit.com>
Subject: Re: [PATCH] xen-blkback: Switch to closed state after releasing the
 backing device
Message-ID: <20180906162932.7qge5dmrgyqbmbbj@mac.bytemobile.com>
References: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
 <20180905103649.edugijsjx4v2fbxd@mac.bytemobile.com>
 <20180905113515.GU26705@gavran.carpriv.carnet.hr>
 <20180905162801.GB26705@gavran.carpriv.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180905162801.GB26705@gavran.carpriv.carnet.hr>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 06:28:01PM +0200, Valentin Vidic wrote:
> On Wed, Sep 05, 2018 at 01:35:15PM +0200, Valentin Vidic wrote:
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
> 
> Would it be possible to call xen_vbd_free before the state change?
> 
>         case XenbusStateClosed:
>                 xen_blkif_disconnect(be->blkif);
>                 xen_vbd_free(&be->blkif->vbd);
>                 xenbus_switch_state(dev, XenbusStateClosed);

I think that will break reconnection, since xen_vbd_create is only
called after hotplug script execution is performed (which happens only
once at device attachment), but not when DomU changes frontend
state.

If you want to perform this xen_vbd_free you will also have to move
the xen_vbd_create call AFAICT, to a place that's also called when
reconnecting a device. Note that I could be wrong, so it might be
worth a shot to try different approaches since the blkback code is
quite tangled and I might miss something.

Thanks, Roger.
