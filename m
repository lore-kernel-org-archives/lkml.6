Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61592C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD582184D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551194509;
	bh=kKTn3uaDi9PW9CugT+eHHnul9cQaYA87j+tjFs0ixeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wzAcw/QGCYvmPT6L4Lq7wANXsVr0GzoCwMlUJk3lmb2598TXLepv91qTVkwpqUgkD
	 Wy6fIvkn8PhM4YPahxGB4Ix/ynIdiIb0PB+Tdh+4sNFQsVPgN1EHIedC4T5gNxb5Hw
	 dhtjGsxerFHRa48nQFyMYr+iZwRvPpAqWQmorMgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfBZPVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:21:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:53256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbfBZPVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:21:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CDE0217F5;
        Tue, 26 Feb 2019 15:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551194507;
        bh=kKTn3uaDi9PW9CugT+eHHnul9cQaYA87j+tjFs0ixeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fMEd23Faec4YNSKeuiJSAUo0PZdP8bNDslvA+2HvusjRoxQ0PpISm+KOjZeL7wlgB
         qousZgwSsKivQS4en1BdX29gW8pmFLRjAHRExqyc75B4CeNeBUX8xmnOfmGmS88WpB
         5COj22Pr6uJI69g5nNxypvzrMe+9wlyGKKI/GtNw=
Date:   Tue, 26 Feb 2019 16:21:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        Peter Chen <peter.chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] usb: chipidea: tegra: Fix missed
 ci_hdrc_remove_device()
Message-ID: <20190226152144.GA17948@kroah.com>
References: <20190224153622.8877-1-digetx@gmail.com>
 <VI1PR04MB5327FE97DC8C68B4D56DE0A98B7A0@VI1PR04MB5327.eurprd04.prod.outlook.com>
 <20190225080715.4965810a@dimatab>
 <20190226105615.GA12397@kroah.com>
 <e7693387-9ac5-b2d8-0a0f-d507dfe05830@gmail.com>
 <20190226145857.GB26080@kroah.com>
 <d5e80295-977e-79b0-4f27-2134c52a6e6e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5e80295-977e-79b0-4f27-2134c52a6e6e@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 06:08:17PM +0300, Dmitry Osipenko wrote:
> 26.02.2019 17:58, Greg Kroah-Hartman пишет:
> > On Tue, Feb 26, 2019 at 05:33:05PM +0300, Dmitry Osipenko wrote:
> >> 26.02.2019 13:56, Greg Kroah-Hartman пишет:
> >>> On Mon, Feb 25, 2019 at 08:07:15AM +0300, Dmitry Osipenko wrote:
> >>>> В Mon, 25 Feb 2019 02:27:19 +0000
> >>>> Peter Chen <peter.chen@nxp.com> пишет:
> >>>>
> >>>>>  
> >>>>>>
> >>>>>> Fixes: dfebb5f43a78827a ("usb: chipidea: Add support for
> >>>>>> Tegra20/30/114/124")  
> >>>>>
> >>>>> I suppose you need to apply at stable tree too, right?
> >>>>>
> >>>>
> >>>> It is enough to have the "Fixes" tag to get patch backported into all
> >>>> relevant kernel versions.
> >>>
> >>> No it is not.  My scripts do NOT trigger off of the fixes: tag, please
> >>> read:
> >>>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> >>> for how to do this properly.
> >>
> >> Okay, my bad then. Maybe this is something that could warned by checkpatch.. adding Joe and Andy to the thread.
> > 
> > Why?  It's allowed to put fixes: tags for a patch that does not belong
> > in a stable tree.  That happens all the time, and is encouraged.  Look
> > at some of the stuff in linux-next now, we have Fixes: for commits that
> > are still in linux-next as well, because we do not rebase our trees.
> > When they all merge into Linus's tree, all is good.
> > 
> > So this is not something that checkpatch needs to do anything about.
> 
> At least that might help in cases like this if maintainer is also oblivious.

If the maintainer is "oblivious", they are not going to be running
checkpatch :)

Remember, the "Fixes:" tag is a relatively new thing compared to the cc:
stable tag, which has been a documented requirement for over a decade.
Yes, some subsystems do not even do cc: stable, but that is because
those subsystem maintainers do not want to do it, or do not care.
Again, checkpatch is not going to help them.

checkpatch is not a panacea, people still have to use their brains.

greg k-h
