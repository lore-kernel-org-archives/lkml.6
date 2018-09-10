Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDA3C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25B22087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25B22087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbeIJT4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:56:18 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:46413 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728795AbeIJT4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:56:17 -0400
X-IronPort-AV: E=Sophos;i="5.53,356,1531785600"; 
   d="scan'208";a="78796359"
Date:   Mon, 10 Sep 2018 17:00:58 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Valentin Vidic <Valentin.Vidic@CARNet.hr>
CC:     <drbd-user@lists.linbit.com>, Jens Axboe <axboe@kernel.dk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <xen-devel@lists.xenproject.org>
Subject: Re: [DRBD-user] [PATCH] xen-blkback: Switch to closed state after
 releasing the backing device
Message-ID: <20180910150058.suxehc3uheyho4qx@mac.bytemobile.com>
References: <20180905103649.edugijsjx4v2fbxd@mac.bytemobile.com>
 <20180905162756.GA26705@gavran.carpriv.carnet.hr>
 <20180907120337.GB11834@soda.linbit>
 <20180907121348.GM26705@gavran.carpriv.carnet.hr>
 <20180907132828.GC11834@soda.linbit>
 <20180907164500.GN26705@gavran.carpriv.carnet.hr>
 <20180907171459.GO26705@gavran.carpriv.carnet.hr>
 <20180908073432.GP26705@gavran.carpriv.carnet.hr>
 <20180910124531.GA31737@soda.linbit>
 <20180910132252.GE26705@gavran.carpriv.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180910132252.GE26705@gavran.carpriv.carnet.hr>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 03:22:52PM +0200, Valentin Vidic wrote:
> On Mon, Sep 10, 2018 at 02:45:31PM +0200, Lars Ellenberg wrote:
> > On Sat, Sep 08, 2018 at 09:34:32AM +0200, Valentin Vidic wrote:
> > > On Fri, Sep 07, 2018 at 07:14:59PM +0200, Valentin Vidic wrote:
> > > > In fact the first one is the original code path before I modified
> > > > blkback.  The problem is it gets executed async from workqueue so
> > > > it might not always run before the call to drbdadm secondary.
> > > 
> > > As the DRBD device gets released only when the last IO request
> > > has finished, I found a way to check and wait for this in the
> > > block-drbd script:
> > 
> > > --- block-drbd.orig     2018-09-08 09:07:23.499648515 +0200
> > > +++ block-drbd  2018-09-08 09:28:12.892193649 +0200
> > > @@ -230,6 +230,24 @@
> > >  and so cannot be mounted ${m2}${when}."
> > >  }
> > >  
> > > +wait_for_inflight()
> > > +{
> > > +  local dev="$1"
> > > +  local inflight="/sys/block/${dev#/dev/}/inflight"
> > > +  local rd wr
> > > +
> > > +  if ! [ -f "$inflight" ]; then
> > > +    return
> > > +  fi
> > > +
> > > +  while true; do
> > > +    read rd wr < $inflight
> > > +    if [ "$rd" = "0" -a "$wr" = "0" ]; then
> > 
> > If it is "idle" now, but still "open",
> > this will not sleep, and still fail the demotion below.
> 
> True, but in this case blkback is holding it open until all
> the writes have finished and the last write closes the device.
> Since fuser can't check blkback this is an approximation that
> seems to work because I don't get any failed drbdadm calls now.
> 
> > You try to help it by "waiting forever until it appears to be idle".
> > I suggest to at least limit the retries by iteration or time.
> > And also (or, instead; but you'd potentially get a number of
> > "scary messages" in the logs) add something like:
> 
> Ok, should I open a PR to discuss this change further?
> 
> > Or, well, yes, fix blkback to not "defer" the final close "too long",
> > if at all possible.
> 
> blkback needs to finish the writes on shutdown or I get a fsck errors
> on next boot. Ideally XenbusStateClosed should be delayed until the
> device release but currently it does not seem possible without breaking
> other things.

I can try to take a look at this and attempt to make sure the state is
only changed to closed in blkback _after_ the device has been
released, but it might take me a couple of days to get you a patch.

I'm afraid that other hotplug scripts will also have issues with such
behavior, and we shouldn't force all users of hotplug scripts to add
such workarounds.

Roger.
