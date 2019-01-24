Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E01C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91FD821872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="g8eksxfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbfAXO6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 09:58:45 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:41814 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbfAXO6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 09:58:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7oV9QCyX8RJrbmmYPRIV15Y8OWNVz/GC1F5VpiAlBwE=; b=g8eksxfSlJXALOVTodAN7Pp/Y
        54+MwnDog0Lmk9+sA1xAAmr1zANMURe386ayU77FBxWWOX/vjC1dq6vvi6QbP6ttHaToDBEwWAbIu
        6t/FlZOzd9NcZaYSbK2DpZTnuLWh27NkkGqYDIWRx0o4hOwLqSC1rjFKvhv/CvsPOqrYg=;
Received: from e5254000004ec.dyn.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:47922 helo=shell.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gmgSi-0003CQ-O8; Thu, 24 Jan 2019 14:58:36 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1gmgSi-0000u4-2b; Thu, 24 Jan 2019 14:58:36 +0000
Date:   Thu, 24 Jan 2019 14:58:35 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH 0/6] driver core: Fix some issues related to device links
Message-ID: <20190124145835.2oy2tniepzpeekl2@e5254000004ec.dyn.armlinux.org.uk>
References: <2493187.oiOpCWJBV7@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2493187.oiOpCWJBV7@aspire.rjw.lan>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 12:13:06PM +0100, Rafael J. Wysocki wrote:
> Hi Greg at al,
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
> This series does not fix all issues in device links that have become
> apparent (generally speaking, the idea of returning an existing link
> in case there is one already for the given consumer-supplier pair
> doesn't play well with stateful links and their flags), so there will
> be a follow-up series of patches to clean that up.  Still, I don't see
> a reason to sit on these fixes while working on the other patches, so
> here they go.

Hi Rafael,

I've just given these a quick boot, unbind and rebind test with my
DRM case, and nothing seems to have regressed on the face of it.

Tested-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
