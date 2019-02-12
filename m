Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D332EC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A448217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549983914;
	bh=VFjY7CSJwTJ7U+sq9QG7Bb/BFahrSX+uCUbnuHx3dWc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=u+pi0U59UsgQNGKZt8zZOzlCb36BTSRMmVbEFl25DWbybmxF7ZYu6RB77W7t6UNH2
	 ADHUzFQy+MKu3TN8dJhTmEuEZ9FqSIXjvWP1iS5g1twdoCZBU1mhFv/2/r6TuMeN/o
	 3hE+SqW8Um+fuA4GhqkUNDihAD0sxhmVGVrbCx/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbfBLPFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:05:13 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36922 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfBLPFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:05:12 -0500
Received: by mail-ot1-f68.google.com with SMTP id b3so4893287otp.4;
        Tue, 12 Feb 2019 07:05:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VFjY7CSJwTJ7U+sq9QG7Bb/BFahrSX+uCUbnuHx3dWc=;
        b=PyF7HK+e9HUX9YBL78AuA2CARhLWKmJQezuVGFZ5CXjY2sUz+UqOu65IVJKwQshOvq
         pn6RXXsjLxg0UEL8WcdUFUWL4Ffyi1Gxnqwvgbn6LC/QQgr9I1/eDjWIKmpGNMHHii+i
         YLWl696/JOJGuAc24mgH1Z7esW81FJvNEUVzGu6QzXnFl5Rd2PRT++aE0y9MYdXj9sqf
         xVd1PQaxB0+WBDd+lCdEBKo82WeohDt6hkC+RMvvuJ2TcN9BVneh70EizNwaB5ieY26L
         4IUoqA59j5J5Ks4OLk9loBiTIKnJT6anpUVNtZLMuS1bISGU5C90sx69OFFzeDCHxdsf
         hJow==
X-Gm-Message-State: AHQUAua51Rs7h3NrBP/An2e6xSAOe6Ctsx1ymCe7OLKVlG5mmv4O49gZ
        eVWFOwkberQZPMHdGRP2LMnQLhQ53QLnSkPckIs=
X-Google-Smtp-Source: AHgI3IaBzK9H65WGExffk1IcvSFooH5uSAuGqgUu9u0pP8negSAda7gR8gQoY0R2fe1dPvb5bd3mdHiDLviuu9FvxZ4=
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr4377444otl.343.1549983911722;
 Tue, 12 Feb 2019 07:05:11 -0800 (PST)
MIME-Version: 1.0
References: <5510642.nRbR3bcduN@aspire.rjw.lan> <20190212140924.GA14444@kroah.com>
 <CAPDyKFoSGO5Y8wOF8Jd=b7DDSz6Lb2M4+pn7EXOJ4U_AFz+4gQ@mail.gmail.com>
In-Reply-To: <CAPDyKFoSGO5Y8wOF8Jd=b7DDSz6Lb2M4+pn7EXOJ4U_AFz+4gQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Feb 2019 16:04:59 +0100
Message-ID: <CAJZ5v0iNXHAYOq-tAHp4U+tbOQXxF43cgF08KM8EAwOtc7Re7A@mail.gmail.com>
Subject: Re: [PATCH 0/2] driver core: Fixes related to device links
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 3:53 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 12 Feb 2019 at 15:09, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Feb 12, 2019 at 01:01:13PM +0100, Rafael J. Wysocki wrote:
> > > Hi Greg at al,
> > >
> > > These fix two issues on top of the recent device links material in
> > > driver-core/driver-core-next.
> > >
> > > The first one fixes a race condition that may trigger when
> > > __pm_runtime_set_status() is used incorrectly (that is, when it is
> > > called with PM-runtime enabled for the target device and working).
> > >
> > > The second one fixes a supplier PM-runtime usage counter imbalance
> > > resulting from adding and removing (e.g. in the error code path) a
> > > stateless device link to it from within the consumer driver's probe
> > > callback.
> > >
> > > Please refer to the patch changelogs for details.
> >
> > Looks good, all now queued up, thanks.
>
> Greg, please don't get me wrong, but ~1.5 hours isn't sufficient for
> me to review/test submitted patches.
>
> I have been trying to collaborate (review/test) device links related
> code with Rafael, but what's the point if you queue up the patches,
> before I even got the change to look at them. Shall I interpret it as
> you don't care about me reviewing this, then just tell me so I don't
> have to waste my time.

I certainly do care about that.

Moreover, if you find any issues in the patches, they still can be
dropped or incremental fixes on top of them can be done.

Your work and feedback here is much appreciated, please don't drop the ball. :-)
