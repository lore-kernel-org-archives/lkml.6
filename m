Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE03EC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9C220881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HTvkBGP6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387971AbfAaQDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:03:49 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45643 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfAaQDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:03:48 -0500
Received: by mail-vs1-f67.google.com with SMTP id x28so2231737vsh.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 08:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dfkb2JVbRDTEbj1zSGa+POfZs3pStSG55ZC3VHRiOkI=;
        b=HTvkBGP6bPF70CtpCEmhX1jTzjlerKIEBopJ3TENVCW+hbWgrWzC+tjWuj4MSytQ5S
         hk8NJ7/CQs+vmANbU05MmbTXhj6vDcPq943G4CZnYnWfuAXSwII5g/Nb/YVcPvJqtKPH
         7kdULbfT1To5TobCuxkHFN0tlmOw1NyhudXT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dfkb2JVbRDTEbj1zSGa+POfZs3pStSG55ZC3VHRiOkI=;
        b=NNuHQBmv8VuxEbpJtpN/SZM7TWAVcCvTgiTJTOfFMth0dPlksTZNJPHNOkDKu6hI8G
         28X0BeyarwHln0mC/zoH9vQKij6iMdCvSUuR0IPHrxNPsPP06o9OPimaDj0gjJzsDaoL
         ukMRcxt3HCCP7U8SUyoezzdwFJIStT9Bs/Fkbzazf9wWIkEBrQn9oXP569UbyRQCGdgm
         waLJjUzTr/sIwo212ijLuUPcFdOYX2185g93GUU8lilO/MuHzhIMLYnxuqM8nb//HOh7
         iHnCDdE8TwLKBCX72RNSegIrVUQ0GBSh+1koEjucHMCqtAMzqiA/f7yqcj/9JOLKBfNI
         4yZw==
X-Gm-Message-State: AJcUukd/4NFujtMfrIk87Kdn/qrxQ2rJOm0OKq/ltLpZZkwGqszm4HVf
        N9/ZDaHpmvy83b9BYTmbfTMrTOd56cB9OeWEQxhncA==
X-Google-Smtp-Source: ALg8bN41EZScf3vVgGuMEUkMKk4ZnQZv8XMmmKkN2urZTsBRtDJIs56Iag4DvsgqS2ga05uinlnJsV6keGUqD/OyQEA=
X-Received: by 2002:a67:b245:: with SMTP id s5mr14627592vsh.200.1548950627580;
 Thu, 31 Jan 2019 08:03:47 -0800 (PST)
MIME-Version: 1.0
References: <2493187.oiOpCWJBV7@aspire.rjw.lan> <CAJZ5v0hsBNYZ7mu6SrhBY+LiOQZKz2K_3OtsCb9Jt8QR1YRhOA@mail.gmail.com>
 <20190131132247.GA6837@kroah.com> <20190131132409.GA16084@kroah.com>
In-Reply-To: <20190131132409.GA16084@kroah.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 31 Jan 2019 17:03:11 +0100
Message-ID: <CAPDyKFr6gehF1iXq6BnUmfg3duDmCtXpQg97euAvH_dyJ785gg@mail.gmail.com>
Subject: Re: [PATCH 0/6] driver core: Fix some issues related to device links
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
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

On Thu, 31 Jan 2019 at 14:24, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jan 31, 2019 at 02:22:47PM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Jan 31, 2019 at 11:09:51AM +0100, Rafael J. Wysocki wrote:
> > > On Thu, Jan 24, 2019 at 12:25 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > >
> > > > Hi Greg at al,
> > > >
> > > > Recently I have been looking at the device links code because of the
> > > > recent discussion on possibly using them in the DRM subsystem (see for
> > > > example https://marc.info/?l=linux-pm&m=154832771905309&w=2) and I have
> > > > found a few issues in that code which should be addressed by this patch
> > > > series.  Please refer to the patch changelogs for details.
> > > >
> > > > None of the problems addressed here should be manifesting themselves in
> > > > mainline kernel today, but if there are more device links users in the
> > > > future, they most likely will be encountered sooner or later.  Also they
> > > > need to be fixed for the DRM use case to be supported IMO.
> > > >
> > > > This series does not fix all issues in device links that have become
> > > > apparent (generally speaking, the idea of returning an existing link
> > > > in case there is one already for the given consumer-supplier pair
> > > > doesn't play well with stateful links and their flags), so there will
> > > > be a follow-up series of patches to clean that up.  Still, I don't see
> > > > a reason to sit on these fixes while working on the other patches, so
> > > > here they go.
> > >
> > > Any concerns regarding this lot?
> > >
> > > [Please note that patch 5 in the series was replaced with the v2 at
> > > https://patchwork.kernel.org/patch/10781205/]
> > >
> > > If not, and if you don't mind, I would like to queue it up next week,
> > > possibly along with the follow-up material posted on Monday
> > > (https://lore.kernel.org/lkml/2405639.4es7pRLqn0@aspire.rjw.lan/) if
> > > that is not problematic, so it gets some linux-next coverage before
> > > the next merge window.
> >
> > Can I queue it up in my tree, given that I have a number of other driver
> > core patches in there, and I don't know how the merge issues will be if
> > we start to diverge.
> >
> > Or do you need this for some other work?
>
> To make this clearer, I have no objection to take this through my tree
> now, along with your second set of patches.  Is that ok?
>

Greg, Rafael,

FWIW, I intend to review these patches during tomorrow, or at latest
on Monday as I have been a bit busy lately.

Kind regards
Uffe
