Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACB9C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62911217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549988467;
	bh=2HMe8DI7Wr6lW8obRpDZoBKFRyZ9MsGnT60qDsaAFZY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UZaPxc3Thx+Yzaz4MJn3DDvZ7Rw81qMIHiB432ZYUl9E3g0WdxakeC+XgGh2gty0+
	 eMYCJCFIM6yg84guq7jvk9CabtrxnDDkGXZe2mAPMf2n2KAJTcCX4fkjfa/41Pqr3h
	 EyUe2scTerctv5rWNcgDRE5SZFNP6xo71hYAcZ0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbfBLQVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:21:05 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46389 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfBLQVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:21:05 -0500
Received: by mail-ot1-f65.google.com with SMTP id w25so5237690otm.13;
        Tue, 12 Feb 2019 08:21:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Do9rfiLxIAhp7ZjItRDSZ03DtQyTyuV/ANb87gWojQs=;
        b=PbG9XnKfGX8/SR91hcEsF4PtglcYQLcm44axq7E8pPrbOfZ6geUWjruThE8ZqGwr91
         zxYixluQRlurTOjp2ch9H2jEqtaHRwDJXc6tjkIztq9GaXRxAXaDEoqUodfpAfp9NCMv
         hquvREIrS5Gl0JMnyfO8SzX9B3urkgl6dgygDRFLFKvewmx+yXF1GVmpxVz58ThZ3LeT
         NcfzzTkY8s6LxG1BtyvU5qSzIDDTFiezl70s3gX9WrIUEUbxMSqmt67D9UD7w0we5dE7
         UQCF4po4GkScr4Ni8L5rLvsRw95RwupeKtEx4aAjUHxe8ZOlX7L8EMFW7QGzIOpql6+w
         Ny3A==
X-Gm-Message-State: AHQUAubtLzWO1QZT0kZSxjYr/3wfnENGz1MZZb8cnCGC+Bgg74mC1pj5
        J4CzhdpdXiX3rtkivfiN5+ax4pjRj0K7S2QipJo=
X-Google-Smtp-Source: AHgI3IawrDb+QRaJHQl5/YdYpVvGqDhk7y+QAqnE2xJBh94alX1xE+m8lUN4wYUhnVq5v4X+dOw6xcl0IhXAFxHA3Yo=
X-Received: by 2002:a9d:7990:: with SMTP id h16mr4432605otm.222.1549988464008;
 Tue, 12 Feb 2019 08:21:04 -0800 (PST)
MIME-Version: 1.0
References: <5510642.nRbR3bcduN@aspire.rjw.lan> <20190212140924.GA14444@kroah.com>
 <CAPDyKFoSGO5Y8wOF8Jd=b7DDSz6Lb2M4+pn7EXOJ4U_AFz+4gQ@mail.gmail.com> <20190212150618.GB19188@kroah.com>
In-Reply-To: <20190212150618.GB19188@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Feb 2019 17:20:52 +0100
Message-ID: <CAJZ5v0judv8gvK53Zidn=OEkbgms-5mgQL2URpdfKCrO2nkXoQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] driver core: Fixes related to device links
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
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

On Tue, Feb 12, 2019 at 4:06 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Feb 12, 2019 at 03:52:53PM +0100, Ulf Hansson wrote:
> > On Tue, 12 Feb 2019 at 15:09, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Feb 12, 2019 at 01:01:13PM +0100, Rafael J. Wysocki wrote:
> > > > Hi Greg at al,
> > > >
> > > > These fix two issues on top of the recent device links material in
> > > > driver-core/driver-core-next.
> > > >
> > > > The first one fixes a race condition that may trigger when
> > > > __pm_runtime_set_status() is used incorrectly (that is, when it is
> > > > called with PM-runtime enabled for the target device and working).
> > > >
> > > > The second one fixes a supplier PM-runtime usage counter imbalance
> > > > resulting from adding and removing (e.g. in the error code path) a
> > > > stateless device link to it from within the consumer driver's probe
> > > > callback.
> > > >
> > > > Please refer to the patch changelogs for details.
> > >
> > > Looks good, all now queued up, thanks.
> >
> > Greg, please don't get me wrong, but ~1.5 hours isn't sufficient for
> > me to review/test submitted patches.
> >
> > I have been trying to collaborate (review/test) device links related
> > code with Rafael, but what's the point if you queue up the patches,
> > before I even got the change to look at them. Shall I interpret it as
> > you don't care about me reviewing this, then just tell me so I don't
> > have to waste my time.
>
> As they are just in my -testing branch, I can easily drop them now if
> you find problems.  I didn't realize that Rafael was wanting you to
> review this as they were marked as "fixes:" for previous patches.

Sorry for the confusion.

From my perspective they fix issues on top of the previous commits as
indicated by the Fixes: tags and they work on my systems, but even
though *I* think that they are all good, there still may be problems
with them that I don't see.  As usual. :-)

I guess I should have sent them as RFC this time.

Cheers,
Rafael
