Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9A1C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1B52081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549280440;
	bh=AJnz+hopl9VXf8GFvCSGe6uCRtcixTV/Zx+y/389MrQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BEZEQIZys8ex9nHeYLBFyqU2XE0WOWqHsTjFKdcc56vJ5l07/DQ/KayVDezCZ+wo/
	 jdTByri4iu3fqschCl+WjwSLiEUaRcSClH4j1bT8al659sAriTLSrQXBuvsXK6e89T
	 75k1lB3sUn348XD6dD89P0h961/0VL7UWordstFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfBDLki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:40:38 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38999 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfBDLkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 06:40:37 -0500
Received: by mail-ot1-f68.google.com with SMTP id n8so12391306otl.6;
        Mon, 04 Feb 2019 03:40:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wO6ynLtmevmpRD5fUtnHjwlN+hSKcwlOqadHdNO2Oxw=;
        b=odFibkwkQ0H53lZDZ6iAd/nbYuRuxfHi/U+KlVKR2FjoDFm2aybHwsCkVzMeZCWmKI
         YLlGCLpgTVwyC5uPUtsbpD2d5Rqu6GP8jaDBHEYln81D+K4uuvjkCMfVzPb+NSz9LlZ/
         mcavCFdzparIx3g8Y4heF9jmGgEVufm9yJB6yRo7KZl7ofXb61MusF6FTMAD3clWx3nB
         rKrhq4WhPQM+KktOk4d2TxqHVrxMQu0I1Xahp2P7xDha67MmNzyn9bvH5Z4FbhCV3jli
         BLaQKfZ7HdR2J7RasOPtxt7UpE9ClSG8G9WPSFek7rA3Qi/G+UERsCTURf01woXyPBUy
         Y/OQ==
X-Gm-Message-State: AHQUAub/ACoNOdvC6qQTKm6qutdkA+ghOjpP+Y4a/jg6cs+M/akmmumi
        JptqubpG2L6yDnbHwZxy0zqGDDHfwtOIQgZ1f7Q=
X-Google-Smtp-Source: AHgI3IZEzT7koAYOlJN8RqGkyLnVikvTD3mATQ8HSrXba9UXikgZWlX35WidnllusEqDou1zK4j35ndn6UhllAks25U=
X-Received: by 2002:aca:c591:: with SMTP id v139mr4725047oif.76.1549280437058;
 Mon, 04 Feb 2019 03:40:37 -0800 (PST)
MIME-Version: 1.0
References: <1952449.TVsm6CJCTy@aspire.rjw.lan> <CAPDyKFqG-wN+=9i4X+BeREekzKNt0icE==P60Cu1FhsGRNcJjg@mail.gmail.com>
In-Reply-To: <CAPDyKFqG-wN+=9i4X+BeREekzKNt0icE==P60Cu1FhsGRNcJjg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 4 Feb 2019 12:40:25 +0100
Message-ID: <CAJZ5v0g0BC900-u1wivAWqq=XomPgpfpz7s=sWgvCML+2MwLgg@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] driver core: Fix some device links issues and add
 "consumer autoprobe" flag
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 4:18 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 1 Feb 2019 at 02:04, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > Hi Greg at al,
> >
> > This is a combination of the two device links series I have posted
> > recently (https://lore.kernel.org/lkml/2493187.oiOpCWJBV7@aspire.rjw.lan/
> > and https://lore.kernel.org/lkml/2405639.4es7pRLqn0@aspire.rjw.lan/) rebased
> > on top of your driver-core-next branch.
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
> > On top of this the series makes device links support the "composite device"
> > use case in the DRM subsystem mentioned above (essentially, the last patch
> > in the series is for that purpose).
> >
>
> Rafael, Greg, I have reviewed patch 1 -> 7, they all look good to me.
>
> If not too late, feel free to add for the first 7 patches:
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks!

> Although, I want to point out one problem that I have found when using
> device links. I believe it's already there, even before this series,
> but just wanted to described it for your consideration.
>
> This is what happens:
> I have a platform driver is being probed. During ->probe() the driver
> adds a device link like this:
>
> link = device_link_add(consumer-dev, supplier-dev, DL_FLAG_STATELESS |
> DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
>
> At some point later in ->probe(), the driver realizes that it must
> remove the device link, either because it encountered an error or
> simply because it doesn't need the device link to be there anymore.
> Thus it calls:
>
> device_link_del(link);
>
> When probe finished of the driver, the runtime PM usage count for the
> supplier-dev remains increased to 1 and thus it never becomes runtime
> suspended.

OK, so this is a tricky one.

With this series applied, if the link actually goes away after the
cleanup device_link_del(), device_link_free() should take care of
dropping the PM-runtime count of the supplier.  If it doesn't do that,
there is a mistake in the code that needs to be fixed.

However, if the link doesn't go away after the cleanup
device_link_del(), the supplier's PM-runtime count will not be
dropped, because the core doesn't know whether or not the
device_link_del() has been called by the same entity that caused the
supplier's PM-runtime count to be incremented.  For example, if the
consumer device is suspended after the device_link_add() that
incremented the supplier's PM-runtime count and then suspended again,
the link's rpm_active refcount is one already and so the supplier's
PM-runtime count should not be dropped.

Arguably, device_link_del() could be made automatically drop the
supplier's PM-runtime count by one if the link's rpm_active refcount
is not one, but there will be failing scenarios in that case too
AFAICS.
