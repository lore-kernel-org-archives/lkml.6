Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A80C64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 07:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5928920834
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 07:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJ7geMEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5928920834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbeLBHdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 02:33:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:55608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbeLBHdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 02:33:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A5862080A;
        Sun,  2 Dec 2018 07:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543736027;
        bh=Pb8bBnXNHfMbNzaDb1Irwh+tFG1LSTMFKfhvLsmVox0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fJ7geMExouxD6nU9zvCZWsFtNCC5snKXQomlPJji1eqLK0i1gwS+lQ87zCSJk9uzP
         z/dlK2BFCCdVUioGC8uXtzYPIiqAlnlXbQQHz9DxZdxiOuKtW6I03ltRG78Env1Mr4
         9ePjhvRl2ltsQyAWAEqh+DP2shhq/EzjBcNXBsJI=
Date:   Sun, 2 Dec 2018 08:33:45 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] [repost] Drivers: hv: vmbus: Offload the handling of
 channels to two workqueues
Message-ID: <20181202073345.GC31761@kroah.com>
References: <PU1P153MB016946D99D63F9713E32B99ABFD20@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181129074435.GA12347@kroah.com>
 <PU1P153MB01695E455F77117812AA0D1ABFD20@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <SN4PR2101MB0815A8C285162E3B48CD209AA0D30@SN4PR2101MB0815.namprd21.prod.outlook.com>
 <PU1P153MB016907FDC34F47CFE71B82EABFD30@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PU1P153MB016907FDC34F47CFE71B82EABFD30@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 06:09:54PM +0000, Dexuan Cui wrote:
> > From: KY Srinivasan <kys@microsoft.com>
> > Sent: Friday, November 30, 2018 9:31 AM
> > > From: Dexuan Cui <decui@microsoft.com>
> > > Sent: Thursday, November 29, 2018 12:17 AM
> > > To: gregkh@linuxfoundation.org
> > > Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > > <haiyangz@microsoft.com>; Stephen Hemminger
> > > <sthemmin@microsoft.com>; linux-kernel@vger.kernel.org;
> > > devel@linuxdriverproject.org; apw@canonical.com; vkuznets
> > > <vkuznets@redhat.com>; olaf@aepfle.de; jasowang@redhat.com; Michael
> > > Kelley <mikelley@microsoft.com>
> > > Subject: RE: [PATCH] [repost] Drivers: hv: vmbus: Offload the handling of
> > > channels to two workqueues
> > >
> > > > From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> > > > Sent: Wednesday, November 28, 2018 11:45 PM
> > > > >
> > > > > There is no change in this repost. I just rebased this patch to today's
> > > > > char-misc's char-misc-next branch. Previously KY posted the patch with
> > > his
> > > > > Signed-off-by (which is kept in this repost), but there was a conflict issue.
> > > > >
> > > > > Note: the patch can't be cleanly applied to char-misc's char-misc-linus
> > > branch
> > > > --
> > > > > to do that, we need to cherry-pick the supporting patch first:
> > > > > 4d3c5c69191f ("Drivers: hv: vmbus: Remove the useless API
> > > > vmbus_get_outgoing_channel()")
> > > >
> > > > That is not going to work for the obvious reason that this dependant
> > > > patch is not going to be merged into 4.20-final.
> > >
> > > It looks the dependent patch (4d3c5c69191f) is going to miss the v4.20
> > > release.
> > > This is not a big issue, as the dependent patch isn't really important.
> > >
> > > > So, what do you expect us to do here?  The only way this can be accepted
> > > > is to have it go into my -next branch, which means it will show up in
> > > > 4.21-rc1, is that ok?
> > >
> > > Is there any chance for this patch ("Drivers: hv: vmbus: Offload the handling
> > > ...") to
> > > go into v4.20?
> > >
> > > If yes, I can quickly do a rebase to char-misc's char-misc-linus branch,
> > > because actually the conflict can be very easily fixed. And I can help to fix any
> > > conflict when the dependent patch is backported to v4.20.1.
> > 
> > This patch fixes an important bug while the patch this depends on is not
> > critical.
> > I suggest we revert the patch that this patch depends on
> > and we can submit a new version of this patch that can go in now - into 4.20
> > release.
> > 
> > K. Y
> 
> I agree.
> 
> Hi Greg,
> Please let us know what we can do to try to push this important fix into v4.20.
> 
> Actually it's straightforward, though it looks big. And, we ave done a full testing
> with the patch.

Ok, you all need to figure this out on your own, sorry.  Please give me
a patch that I can actually apply to the tree if you need it merged into
4.20-final.  This shouldn't be tough, you all have been doing this long
enough by now...

I have no bandwidth to do this myself for you,

greg k-h
