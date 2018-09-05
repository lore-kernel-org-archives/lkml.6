Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996B1C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F2E2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F2E2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=CARNet.hr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeIEU7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 16:59:02 -0400
Received: from mail.CARNet.hr ([161.53.123.6]:48874 "EHLO mail.carnet.hr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbeIEU7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 16:59:01 -0400
Received: from cnzgrivvl-t440p.carpriv.carnet.hr ([161.53.12.131]:56480 helo=gavran.carpriv.carnet.hr)
        by mail.carnet.hr with smtp (Exim 4.80)
        (envelope-from <Valentin.Vidic@CARNet.hr>)
        id 1fxaev-0004zl-LE; Wed, 05 Sep 2018 18:28:02 +0200
Received: by gavran.carpriv.carnet.hr (Postfix, from userid 1000)
        id 8E2DE2012E; Wed,  5 Sep 2018 18:28:01 +0200 (CEST)
Date:   Wed, 5 Sep 2018 18:28:01 +0200
From:   Valentin Vidic <Valentin.Vidic@CARNet.hr>
To:     Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, drbd-user@lists.linbit.com
Message-ID: <20180905162801.GB26705@gavran.carpriv.carnet.hr>
References: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
 <20180905103649.edugijsjx4v2fbxd@mac.bytemobile.com>
 <20180905113515.GU26705@gavran.carpriv.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905113515.GU26705@gavran.carpriv.carnet.hr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 161.53.12.131
Subject: Re: [PATCH] xen-blkback: Switch to closed state after releasing the
 backing device
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 01:35:15PM +0200, Valentin Vidic wrote:
> > AFAICT, this will cause the backend to never switch to 'Closed' state
> > until the toolstack sets online to 0, which is not good IMO.
> > 
> > If for example a frontend decides to close a device, the backend will
> > stay in state 'Closing' until the toolstack actually removes the disk
> > by setting online to 0.
> > 
> > This will prevent resetting blk connections, as blkback will refuse to
> > switch to state XenbusStateInitWait unless it's at XenbusStateClosed
> > (see the XenbusStateInitialising case in frontend_changed), which will
> > never be reached with your patch.

Would it be possible to call xen_vbd_free before the state change?

        case XenbusStateClosed:
                xen_blkif_disconnect(be->blkif);
                xen_vbd_free(&be->blkif->vbd);
                xenbus_switch_state(dev, XenbusStateClosed);

-- 
Valentin
