Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66DFC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 23:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9278E218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 23:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548371304;
	bh=bmN1g2T6Tinw0e04LBn5sJjOZKvK7K5n9NXrCI00tfQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=a4HLu3BKp8i6kuTPSWZf7ZWlENkevHXOUhY6mHnHS1V+Ve0UFnhY4zTOpJRTLZD2r
	 Klo6KMME0kmjG7Gt6D8uVqmzHRFaUX4IWcrs5gl8FVgiSyRkTUwRpZL2GUcUyNjY3m
	 rrO+T+1lfzfFvwVdZD8q/XoTbaBZyE75Pjpw/zNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfAXXIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 18:08:17 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38071 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfAXXIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 18:08:17 -0500
Received: by mail-oi1-f196.google.com with SMTP id a77so6327393oii.5;
        Thu, 24 Jan 2019 15:08:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0i3y+ZRKsVXXhbyWwMHCDtrJdmccb2+jfS37cek1J4g=;
        b=U6awMOMd84xfXh7Zwqha9gnK4P25a4W4ARj5NnPrrlX8eyh20d3tmqzKooQBJrB0za
         4dKSHztqUGwPji6sMkt4Tprz+JPix7JmdM+m3/jGqwCe5hHmILuhWkwdMKrG8rjaSkq6
         L6GL36d00Urq61gwspz1xvpJNPdoQ344QW85wozilJTC0ibL8L5TmRRhrb8r2B5WdEeO
         YAgJAct30Fj3mYHMaND5XvRcue6VJC7NkRP8WEjJdKRmIAHuHbHZV6/fCTVuplMBDK0o
         rZn/bw1WAGVBREdSKUCKnzpgpu0L200vgd/Cr8peMWjX8lhSECDaoZbyPUTVHx4cX/eE
         TWMA==
X-Gm-Message-State: AJcUukd/rIlTEApru9HqQfmMJeLkIX2o2yVrsJ6SLzlLOZz3gY/aC2ts
        JM2CNo0yoz3whNGp6H/PedYwUk4x5HXI2HHKcP8DSQ==
X-Google-Smtp-Source: ALg8bN49BOkCwDFuLA/onaBddXL5SMha6531YdISwKWN/n8aFuZKfd0FNED8bzUAyH5dygRJYZgR72Ex0EzgsbudJLM=
X-Received: by 2002:aca:368a:: with SMTP id d132mr2660422oia.193.1548371293189;
 Thu, 24 Jan 2019 15:08:13 -0800 (PST)
MIME-Version: 1.0
References: <2493187.oiOpCWJBV7@aspire.rjw.lan> <20190124145835.2oy2tniepzpeekl2@e5254000004ec.dyn.armlinux.org.uk>
In-Reply-To: <20190124145835.2oy2tniepzpeekl2@e5254000004ec.dyn.armlinux.org.uk>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Jan 2019 00:08:01 +0100
Message-ID: <CAJZ5v0ihp8pFib6YCoSq47H0srRh57Kj_00VPby6zVuxLswRuQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] driver core: Fix some issues related to device links
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 3:58 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Thu, Jan 24, 2019 at 12:13:06PM +0100, Rafael J. Wysocki wrote:
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
> Hi Rafael,
>
> I've just given these a quick boot, unbind and rebind test with my
> DRM case, and nothing seems to have regressed on the face of it.
>
> Tested-by: Russell King <rmk+kernel@armlinux.org.uk>

Thank you!
