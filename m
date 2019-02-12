Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB7CC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F144E21773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549983984;
	bh=wAaxleDy1dJr5eoleDULE4ZMphBg39ns8sfaYgulg84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EcOV2KeYi61Cf8gjlk/Xvgw+Cws8mQNt9DzaUHI1dEzEKmjnucF9hTByPyZZre3er
	 uPnzaEfKMHALD1aQlqjAF6ds+elgfe7gU0j7Qb7tGqK8MzYhSp2rFZx6GUO8wKsp9m
	 qGpSAUtiV3VL5nh6GV58qVeQbA2Cu1CohUinFSzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbfBLPGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:06:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:55050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbfBLPGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:06:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 636B821773;
        Tue, 12 Feb 2019 15:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549983980;
        bh=wAaxleDy1dJr5eoleDULE4ZMphBg39ns8sfaYgulg84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q/aoNHvt6Hr3m9KDS8i57rL1hPuU9jwPgs7m2UtpvG66DmNxWDBiVau6jStdnK1b0
         beNcOlb5bIiGYu4/c0ZEdP9qCuMO4XjxdLyzfuXFDQhq3NUzwmtTp+JMknH4cc5thV
         b2gfZPEeRUxykD9ATPCXzw6spw9Di9RFqTx1GVuc=
Date:   Tue, 12 Feb 2019 16:06:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
Subject: Re: [PATCH 0/2] driver core: Fixes related to device links
Message-ID: <20190212150618.GB19188@kroah.com>
References: <5510642.nRbR3bcduN@aspire.rjw.lan>
 <20190212140924.GA14444@kroah.com>
 <CAPDyKFoSGO5Y8wOF8Jd=b7DDSz6Lb2M4+pn7EXOJ4U_AFz+4gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoSGO5Y8wOF8Jd=b7DDSz6Lb2M4+pn7EXOJ4U_AFz+4gQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 03:52:53PM +0100, Ulf Hansson wrote:
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

As they are just in my -testing branch, I can easily drop them now if
you find problems.  I didn't realize that Rafael was wanting you to
review this as they were marked as "fixes:" for previous patches.

thanks,

greg k-h
