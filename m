Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A060C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A29420B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549446986;
	bh=7857HyMi+HGYA7Ywq3HGG1Hw67fYKxMjbVMe0XxEQps=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nry4tiAHb60gUfpMn+IwZijArQMcplTI2gqmf+6bwNDwFYlBMyNjySlxVvatS8VSI
	 3yAbFzn9NROL34jhtAMvVmJ1vbl7cAeO47Wo/yerKeRbrBYghoOJ/uM4yx4z1PGoK3
	 wLwxd201Pgj3BKOD+gWc9pQ7AdehoixSYvSz2U/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbfBFJ4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 04:56:24 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45490 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfBFJ4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 04:56:24 -0500
Received: by mail-ot1-f65.google.com with SMTP id 32so10800466ota.12;
        Wed, 06 Feb 2019 01:56:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eoc/WWCn19tq7HGo1SiAh/m3WRI5CuxD/5M1Hdn2Iho=;
        b=eYpRBxig9eZZ8nnCbIyfYmTEnaudz4cI/11EfUWU8npzX5h3jSyOl6SpAQcOENbbpL
         fmE7auPPiRqN0x5pmKG5dfK+nvzCqFlQBAQvKFupXsf5tyrJRRorzfzjtFTx2Oyw99y9
         VS51ag/lKLtdxy57HE6/dwofMATwWHR6EjQ595iFZHIUt4upGA/47HA1t4bbfhM3LT9v
         ZG9h2sAGOUq6L7KpCMTC8T3kFoO4+5XcC6xS3m0qQn1MbOJM9KdwAbwHu3cu+v/eQxPl
         5M2xdtjij3m5LHsNuFooBEFQhWnHIxoK/ovMDIhuqNsN28WFZKxYl/QkjTHXuzgyNZQW
         vzaQ==
X-Gm-Message-State: AHQUAuZ4miSt7XD+LHQg8y7Mw8dEy6dquNNTjun6r0mneAXvSgXP1bG+
        htOQMd7wkSpZTR7xjxcr4ZIwK7Ik5VNUwXbp5i0=
X-Google-Smtp-Source: AHgI3IaS8NOoblC99gBChWFRRLmKTByC05R9jnYCQw2pguhkNDxOlk2m+ZFbDb8VB5DcoVwD3/gcjZV2URkss99BsZw=
X-Received: by 2002:a9d:2062:: with SMTP id n89mr4886943ota.244.1549446983432;
 Wed, 06 Feb 2019 01:56:23 -0800 (PST)
MIME-Version: 1.0
References: <1952449.TVsm6CJCTy@aspire.rjw.lan> <CAJZ5v0jOVLZDoW5BAy9obp7AptTYzKikFo7Qd15kNt5Y9=vXRQ@mail.gmail.com>
 <CAPDyKFrq-r-rFDDB3yU=W4mOF2-A4xGGomqFqUba6MVWZugHmQ@mail.gmail.com> <24600564.pMaimVIQbW@aspire.rjw.lan>
In-Reply-To: <24600564.pMaimVIQbW@aspire.rjw.lan>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 Feb 2019 10:56:11 +0100
Message-ID: <CAJZ5v0gBYyoumVkLTuEcHsFE8QKEXdYuhDRGwmvoKPhx7gPvgQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] driver core: Fix some device links issues and add
 "consumer autoprobe" flag
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Tue, Feb 5, 2019 at 12:27 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Tuesday, February 5, 2019 9:15:49 AM CET Ulf Hansson wrote:
> > On Mon, 4 Feb 2019 at 12:45, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Mon, Feb 4, 2019 at 12:40 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Fri, Feb 1, 2019 at 4:18 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

[cut]

> > >
> > > For example, if the consumer device is suspended after the
> > > device_link_add() that incremented the supplier's PM-runtime count and
> > > then resumed again, the rpm_active refcount will be greater than one
> > > because of the last resume and not because of the initial link
> > > creation.  In that case, dropping the supplier's PM-runtime count on
> > > link deletion may not work as expected.
> >
> > I see what your are saying and I must admit, by looking at the code,
> > that it has turned into being rather complicated. Assuming of good
> > reasons, of course.
> >
> > Anyway, I will play a little bit more with my tests to see what I can find out.
> >
> > >
> > > > Arguably, device_link_del() could be made automatically drop the
> > > > supplier's PM-runtime count by one if the link's rpm_active refcount
> > > > is not one, but there will be failing scenarios in that case too
> > > > AFAICS.
> >
> > Let's see.
>
> So for the record, below is the (untested) patch I'm thinking about.
>
> Having considered this for some time, I think that it would be better to
> try to drop the supplier's PM-runtime usage counter on link removal even if
> the link doesn't go away then.  That would be more consistent at least IMO.

So I can't convince myself that this is the case.

Either way, if there are two callers of device_link_add() for one
consumer-supplier pair trying to add a stateless link between them and
one of these callers passes DL_FLAG_RPM_ACTIVE set in the flags to it,
there may be issues regardless of what device_link_del() and
device_link_remove() do.  However, if they decrement the link's
rpm_active refcount (and possibly the supplier's PM-runtime usage
counter too), the supplier may be suspended prematurely, whereas in
the other case (no decrementation of rpm_active, which how the code
works after this series) it may just be prevented from suspending.  To
me, the former is worse than the latter.

Moreover, there is a workaround for the latter issue that seems to be
easy enough: it is sufficient to let the consumer runtime suspend
after calling device_link_add() to create the link (with
DL_FLAG_RPM_ACTIVE set) and before trying to remove it.

Because of the above, I'm just going to post a patch to document the
current behavior of the code as a known limitation.
