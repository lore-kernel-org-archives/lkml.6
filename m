Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADBAC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704DE218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548959053;
	bh=nCk8NMgJmMFf3mI4Fwdh0tAfDcVCJ+wAwPI4zdlDcn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QkJYmpua3pSP9jPnvS2SP9QlJIRt+CyJE9UEO3+7/y8Jt+oBCvpPXGhHeKyu7bGnO
	 WD3DoumBpz09zyFnB2MthB59NMF8wOp7RXII94Ptx3OPj3pXzbfSZC/1NuGkMJhIdN
	 37ot2Ig8tgkHGeRot8J5Ud/AvnTFcyJpFaFtovbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfAaSYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:24:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:46038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728372AbfAaSYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:24:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA7DE218EA;
        Thu, 31 Jan 2019 18:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548959049;
        bh=nCk8NMgJmMFf3mI4Fwdh0tAfDcVCJ+wAwPI4zdlDcn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I03jbak9IJHIQBcWcuab0iUwuseVn/B7hg9FUo5dS28voTFTfVPTfCh0CnaIiHf9v
         14EVNHIFm+wabkQXnqmM8iM/bu1QpiwDibY2tDkjivLeuHQLtIa3ocyYcBYQ7UahuQ
         17+exrnu5TyQoDP6P3TbkZHoR6nTUoCgRnRBvb10=
Date:   Thu, 31 Jan 2019 19:24:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 0/6] driver core: Fix some issues related to device links
Message-ID: <20190131182407.GA6191@kroah.com>
References: <2493187.oiOpCWJBV7@aspire.rjw.lan>
 <CAJZ5v0hsBNYZ7mu6SrhBY+LiOQZKz2K_3OtsCb9Jt8QR1YRhOA@mail.gmail.com>
 <20190131132247.GA6837@kroah.com>
 <20190131132409.GA16084@kroah.com>
 <CAJZ5v0geMbgNKBFT104o4Jf38q7yo46ha+qFbd+9Mbr+P8n--A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0geMbgNKBFT104o4Jf38q7yo46ha+qFbd+9Mbr+P8n--A@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 05:02:05PM +0100, Rafael J. Wysocki wrote:
> On Thu, Jan 31, 2019 at 2:24 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Jan 31, 2019 at 02:22:47PM +0100, Greg Kroah-Hartman wrote:
> > > On Thu, Jan 31, 2019 at 11:09:51AM +0100, Rafael J. Wysocki wrote:
> > > > On Thu, Jan 24, 2019 at 12:25 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > > >
> > > > > Hi Greg at al,
> > > > >
> > > > > Recently I have been looking at the device links code because of the
> > > > > recent discussion on possibly using them in the DRM subsystem (see for
> > > > > example https://marc.info/?l=linux-pm&m=154832771905309&w=2) and I have
> > > > > found a few issues in that code which should be addressed by this patch
> > > > > series.  Please refer to the patch changelogs for details.
> > > > >
> > > > > None of the problems addressed here should be manifesting themselves in
> > > > > mainline kernel today, but if there are more device links users in the
> > > > > future, they most likely will be encountered sooner or later.  Also they
> > > > > need to be fixed for the DRM use case to be supported IMO.
> > > > >
> > > > > This series does not fix all issues in device links that have become
> > > > > apparent (generally speaking, the idea of returning an existing link
> > > > > in case there is one already for the given consumer-supplier pair
> > > > > doesn't play well with stateful links and their flags), so there will
> > > > > be a follow-up series of patches to clean that up.  Still, I don't see
> > > > > a reason to sit on these fixes while working on the other patches, so
> > > > > here they go.
> > > >
> > > > Any concerns regarding this lot?
> > > >
> > > > [Please note that patch 5 in the series was replaced with the v2 at
> > > > https://patchwork.kernel.org/patch/10781205/]
> > > >
> > > > If not, and if you don't mind, I would like to queue it up next week,
> > > > possibly along with the follow-up material posted on Monday
> > > > (https://lore.kernel.org/lkml/2405639.4es7pRLqn0@aspire.rjw.lan/) if
> > > > that is not problematic, so it gets some linux-next coverage before
> > > > the next merge window.
> > >
> > > Can I queue it up in my tree, given that I have a number of other driver
> > > core patches in there, and I don't know how the merge issues will be if
> > > we start to diverge.
> > >
> > > Or do you need this for some other work?
> >
> > To make this clearer, I have no objection to take this through my tree
> > now, along with your second set of patches.  Is that ok?
> 
> Yes, it is, AFAICS.  Thank you!
> 
> Do you need me to resend all of this as one series?

Yes, can you please do that.  Also, can you rebase it against my
driver-core-next branch as right now, patch 1/6 has conflicts due to
other patches that are in my tree :(

thanks,

greg k-h
