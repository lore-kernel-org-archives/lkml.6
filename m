Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3B3C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09F02086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549011952;
	bh=610v/lemD9TOWHGY9fJB82erHgdXINZ4i2QcbFPGrRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TvkQnYulRfaKd9rhlir+I6Kb7x3bz141wYJxekImrverxeKckyOczCVG+5P6/5pBr
	 uAMcwQn03G5HYY8vMbTokNOBA1UliXiM7E9ccVZ5C5w+cnfDklBrhagHo9b7OTqH9i
	 X/8lQ6VaTPNUw5IoCkGBBt45wyPclZ4vLUl5GJ8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfBAJFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:05:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:54552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfBAJFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:05:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CC5320869;
        Fri,  1 Feb 2019 09:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549011948;
        bh=610v/lemD9TOWHGY9fJB82erHgdXINZ4i2QcbFPGrRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MZAG2aVV76KPaC2my5ZPkpmmFQwv5KqMKytwqoknAVnQAxAUwRouQAyr38yXmKCnN
         CJpNDlA8hX3wuZZHymzv5645pmV/D8iE3F+Ux8eS+aHY1N6BspDk7naWowL62hTuQr
         7JQvE2cAGeQ8wRUv73VW5iZ6BLlyymzjb6IG+Uu8=
Date:   Fri, 1 Feb 2019 10:05:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
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
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2 0/9] driver core: Fix some device links issues and add
 "consumer autoprobe" flag
Message-ID: <20190201090536.GA17484@kroah.com>
References: <1952449.TVsm6CJCTy@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1952449.TVsm6CJCTy@aspire.rjw.lan>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 01:44:59AM +0100, Rafael J. Wysocki wrote:
> Hi Greg at al,
> 
> This is a combination of the two device links series I have posted
> recently (https://lore.kernel.org/lkml/2493187.oiOpCWJBV7@aspire.rjw.lan/
> and https://lore.kernel.org/lkml/2405639.4es7pRLqn0@aspire.rjw.lan/) rebased
> on top of your driver-core-next branch.
> 
> Recently I have been looking at the device links code because of the
> recent discussion on possibly using them in the DRM subsystem (see for
> example https://marc.info/?l=linux-pm&m=154832771905309&w=2) and I have
> found a few issues in that code which should be addressed by this patch
> series.  Please refer to the patch changelogs for details.
> 
> None of the problems addressed here should be manifesting themselves in
> mainline kernel today, but if there are more device links users in the
> future, they most likely will be encountered sooner or later.  Also they
> need to be fixed for the DRM use case to be supported IMO.
> 
> On top of this the series makes device links support the "composite device"
> use case in the DRM subsystem mentioned above (essentially, the last patch
> in the series is for that purpose).

All now queued up, thanks!

greg k-h
