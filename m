Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9813C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96FEB218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548940972;
	bh=ilxnVz7GrDSS5qnrFHE9gEYjOay6p99BdwDs4Kpcdl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l5ek1S2FYI7d2UVj7jy2GTYU3wDG18GIxZaTVRg4ZXEAqjR0NxTDdagSkbPKUy9Ux
	 lI7Bit6OqEHAtF40F7M03l14cuumdeyy+W3kmkiVYh/aSMVkC+urd1yiZclR2UxtAV
	 PKV8e3MNEQtt/ZP2N0aQMfCu96qIeG0BLZyxQiyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387440AbfAaNWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:22:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:32822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727452AbfAaNWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:22:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51346218D3;
        Thu, 31 Jan 2019 13:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548940969;
        bh=ilxnVz7GrDSS5qnrFHE9gEYjOay6p99BdwDs4Kpcdl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VlptDDEZ6yAtoGG6AAhe7zaROptz9cR3ddQqCm+yq0lO4nrlyiepzZJuUFuPukETd
         4Hxbd6qwfJy74PBGZV4T2at6SJl1uLNettzrkPvDQlQ3R5iUCq7jZ4OtAtG9jCzn/S
         U2rL55Ih+mzjBp8x/PN7zDzodp+4h7OfmjZfSO5E=
Date:   Thu, 31 Jan 2019 14:22:47 +0100
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
Message-ID: <20190131132247.GA6837@kroah.com>
References: <2493187.oiOpCWJBV7@aspire.rjw.lan>
 <CAJZ5v0hsBNYZ7mu6SrhBY+LiOQZKz2K_3OtsCb9Jt8QR1YRhOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hsBNYZ7mu6SrhBY+LiOQZKz2K_3OtsCb9Jt8QR1YRhOA@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 11:09:51AM +0100, Rafael J. Wysocki wrote:
> On Thu, Jan 24, 2019 at 12:25 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > Hi Greg at al,
> >
> > Recently I have been looking at the device links code because of the
> > recent discussion on possibly using them in the DRM subsystem (see for
> > example https://marc.info/?l=linux-pm&m=154832771905309&w=2) and I have
> > found a few issues in that code which should be addressed by this patch
> > series.  Please refer to the patch changelogs for details.
> >
> > None of the problems addressed here should be manifesting themselves in
> > mainline kernel today, but if there are more device links users in the
> > future, they most likely will be encountered sooner or later.  Also they
> > need to be fixed for the DRM use case to be supported IMO.
> >
> > This series does not fix all issues in device links that have become
> > apparent (generally speaking, the idea of returning an existing link
> > in case there is one already for the given consumer-supplier pair
> > doesn't play well with stateful links and their flags), so there will
> > be a follow-up series of patches to clean that up.  Still, I don't see
> > a reason to sit on these fixes while working on the other patches, so
> > here they go.
> 
> Any concerns regarding this lot?
> 
> [Please note that patch 5 in the series was replaced with the v2 at
> https://patchwork.kernel.org/patch/10781205/]
> 
> If not, and if you don't mind, I would like to queue it up next week,
> possibly along with the follow-up material posted on Monday
> (https://lore.kernel.org/lkml/2405639.4es7pRLqn0@aspire.rjw.lan/) if
> that is not problematic, so it gets some linux-next coverage before
> the next merge window.

Can I queue it up in my tree, given that I have a number of other driver
core patches in there, and I don't know how the merge issues will be if
we start to diverge.

Or do you need this for some other work?

thanks,

greg k-h
