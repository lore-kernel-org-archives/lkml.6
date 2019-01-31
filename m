Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26F1C282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D32218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548959797;
	bh=kh+DCS38nQzm2H80U31YN0MVmNJhkeniHj620CJKtdQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cTzJb1gqyuKteCi9n0vv+Clj9FbELGzeYEXuuEe5k7uvS+jMaFzguHFzauuujWYUX
	 79SpG43Wo9EKV+U5vagSXV+3rvYJCEWuukV/jeXaJ9Zx1VjUsvGqLJQQuulrMMG5s9
	 ur5BY9VfbtV2plEsW2dbPVPCJImbAmS9f6/C1TfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfAaSgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:36:31 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45583 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbfAaSgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:36:31 -0500
Received: by mail-oi1-f193.google.com with SMTP id y1so3559874oie.12;
        Thu, 31 Jan 2019 10:36:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MB5RyipThStATvyXwlPu3v2jQVZ8FeAuu3uuc9iNAKQ=;
        b=KygZxf17Z5ZqPmWdu3Il9DQWumKnC6brnt3Ct2AdpOde7OJuTZnbdMek0oGAnLEY2H
         ND4bGpppAAX/SDJQX7VBSxmcXEkgfDzr3DFCqo8fGgpPdfG/e+qSUi9cq9D4TU/nAXpr
         FFsjkW7udyKN5YK5QPY1U658F/oa+tpB57Ib7mgym8FxgWHOpgonU3k8xas9N/2Iqo36
         /7kEicLNDBGOHdH9iLnm2T5BlCnQ01XMUJAZKyYljDt/dSMv9UWmANFlyKMqQKqIo/qJ
         7wGtYIv/QObBQ05Gi0+AMxIqkzmictN9TA49Ayxlpwwyibv6tJYEfVj9sxsc4cedhaq5
         qwMg==
X-Gm-Message-State: AJcUukeQKKdKhjOnY2ZcsX3TMXhtgCGwVA2KKqr/zRLWF7jCmbslhjQg
        PUZCI7MaBazwwtXKVXShY1XffJOFuPcyaDcWyvM=
X-Google-Smtp-Source: ALg8bN4xfv8ChfNfB1sGvCG/BNvI6fAs5a9pzioGo2NflvD0PF6DgSUzyleEtQbCTJI5rGdyejTP3PeKxaG0h3tRXUU=
X-Received: by 2002:a54:4d01:: with SMTP id v1mr15425996oix.246.1548959789728;
 Thu, 31 Jan 2019 10:36:29 -0800 (PST)
MIME-Version: 1.0
References: <2493187.oiOpCWJBV7@aspire.rjw.lan> <CAJZ5v0hsBNYZ7mu6SrhBY+LiOQZKz2K_3OtsCb9Jt8QR1YRhOA@mail.gmail.com>
 <20190131132247.GA6837@kroah.com> <20190131132409.GA16084@kroah.com>
 <CAJZ5v0geMbgNKBFT104o4Jf38q7yo46ha+qFbd+9Mbr+P8n--A@mail.gmail.com> <20190131182407.GA6191@kroah.com>
In-Reply-To: <20190131182407.GA6191@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 31 Jan 2019 19:36:18 +0100
Message-ID: <CAJZ5v0hbUahUbExUMY6-A2DZ6AK2aXh00UTTaiRvtPW9RBVeVg@mail.gmail.com>
Subject: Re: [PATCH 0/6] driver core: Fix some issues related to device links
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 7:24 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jan 31, 2019 at 05:02:05PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Jan 31, 2019 at 2:24 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Jan 31, 2019 at 02:22:47PM +0100, Greg Kroah-Hartman wrote:
> > > > On Thu, Jan 31, 2019 at 11:09:51AM +0100, Rafael J. Wysocki wrote:
> > > > > On Thu, Jan 24, 2019 at 12:25 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > > > >
> > > > > > Hi Greg at al,
> > > > > >
> > > > > > Recently I have been looking at the device links code because of the
> > > > > > recent discussion on possibly using them in the DRM subsystem (see for
> > > > > > example https://marc.info/?l=linux-pm&m=154832771905309&w=2) and I have
> > > > > > found a few issues in that code which should be addressed by this patch
> > > > > > series.  Please refer to the patch changelogs for details.
> > > > > >
> > > > > > None of the problems addressed here should be manifesting themselves in
> > > > > > mainline kernel today, but if there are more device links users in the
> > > > > > future, they most likely will be encountered sooner or later.  Also they
> > > > > > need to be fixed for the DRM use case to be supported IMO.
> > > > > >
> > > > > > This series does not fix all issues in device links that have become
> > > > > > apparent (generally speaking, the idea of returning an existing link
> > > > > > in case there is one already for the given consumer-supplier pair
> > > > > > doesn't play well with stateful links and their flags), so there will
> > > > > > be a follow-up series of patches to clean that up.  Still, I don't see
> > > > > > a reason to sit on these fixes while working on the other patches, so
> > > > > > here they go.
> > > > >
> > > > > Any concerns regarding this lot?
> > > > >
> > > > > [Please note that patch 5 in the series was replaced with the v2 at
> > > > > https://patchwork.kernel.org/patch/10781205/]
> > > > >
> > > > > If not, and if you don't mind, I would like to queue it up next week,
> > > > > possibly along with the follow-up material posted on Monday
> > > > > (https://lore.kernel.org/lkml/2405639.4es7pRLqn0@aspire.rjw.lan/) if
> > > > > that is not problematic, so it gets some linux-next coverage before
> > > > > the next merge window.
> > > >
> > > > Can I queue it up in my tree, given that I have a number of other driver
> > > > core patches in there, and I don't know how the merge issues will be if
> > > > we start to diverge.
> > > >
> > > > Or do you need this for some other work?
> > >
> > > To make this clearer, I have no objection to take this through my tree
> > > now, along with your second set of patches.  Is that ok?
> >
> > Yes, it is, AFAICS.  Thank you!
> >
> > Do you need me to resend all of this as one series?
>
> Yes, can you please do that.  Also, can you rebase it against my
> driver-core-next branch as right now, patch 1/6 has conflicts due to
> other patches that are in my tree :(

I'll do that, thanks!

Cheers,
Rafael
