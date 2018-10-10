Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B955C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36EF21479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RPl/HDsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D36EF21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeJJSoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 14:44:06 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:47046 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeJJSoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 14:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dObbFQZGyXzlMbr1j4fSYsXXVzEUnB0sOQd04tUNgqo=; b=RPl/HDsVX0HPAkWr1phrarQFu
        jSQSHJGWcswygngA76vjNW23ArKTgo+a7uJs88JteuvED3sDe+CgHZuFP4vSag8dN8tKSJmF6mwf2
        xekN/7Whqm20LHZMl5HyCNase5P0Q6caA21mYT6UmGIp/zzY267VcS5GrmsqokfjAlMZg=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:40686)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gACZB-0006OF-Lb; Wed, 10 Oct 2018 12:22:13 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gACZ4-0001B8-GC; Wed, 10 Oct 2018 12:22:06 +0100
Date:   Wed, 10 Oct 2018 12:22:01 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Stefan Agner <stefan@agner.ch>
Cc:     Lucas Stach <l.stach@pengutronix.de>, p.zabel@pengutronix.de,
        airlied@linux.ie, gregkh@linuxfoundation.org, rafael@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/imx: make sure to cleanup DRM before unbinding
 components
Message-ID: <20181010112201.GO30658@n2100.armlinux.org.uk>
References: <83a28282a3f745a4cd4ca77d0593ad2e61359a5d.1539120077.git.stefan@agner.ch>
 <e08eff2ed53b441c8a6c41758c00c1c91dc48d2c.1539120077.git.stefan@agner.ch>
 <20181010103829.GN30658@n2100.armlinux.org.uk>
 <11a452de8e6b39c80ae8ff6b2cdc4cc8@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11a452de8e6b39c80ae8ff6b2cdc4cc8@agner.ch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 01:02:16PM +0200, Stefan Agner wrote:
> [adding Lucas]
> 
> On 10.10.2018 12:38, Russell King - ARM Linux wrote:
> > On Tue, Oct 09, 2018 at 11:30:49PM +0200, Stefan Agner wrote:
> >> In situations where a component fails to bind, a previously
> >> successfully bound component might already registered itself
> >> with the DRM framework (e.g. an encoder). When the master
> >> component then calls drm_mode_config_cleanup, we end up in a
> >> use after free sitution.
> >>
> >> Use the cleanup callback to make sure all framework level
> >> cleanup is done by the time we unbind components.
> > 
> > I'm not sure about this approach - the idea about the component bind
> > and unbind callbacks is that unbind undoes _everything_ that bind has
> > done, so everything is correctly ordered.  If bind registers something,
> > unbind should unregister it.
> > 
> > What seems to be going on is that imx is registering stuff in bind()
> > but not unregistering it in unbind().
> 
> Yes indeed, if that can be fixed this seems to be the better approach to
> me.
> 
> > 
> > Since imx was one of the drivers that the component helper was
> > created for, if it's now crashing, that's a regression in the imx
> > driver.  Looking at the commit log, I'd say:
> > 
> > commit 8e3b16e2117409625b89807de3912ff773aea354
> > Author: Lucas Stach <l.stach@pengutronix.de>
> > Date:   Thu Aug 11 11:18:49 2016 +0200
> > 
> >     drm/imx: don't destroy mode objects manually on driver unbind
> > 
> >     Instead let drm_mode_config_cleanup() do the work when taking down
> >     the master device. This requires all cleanup functions to be
> >     properly hooked up to the mode object .destroy callback.
> > 
> >     Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> >     Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > 
> > is probably responsible for introducing this problem, since the
> > explicit calls were added by me when imx was stuck in staging due to
> > the problems that the component helper solved.
> 
> The commit above does not revert cleanly today, but a quick fixing
> seemed to resolve the problem I am seeing...
> 
> > 
> > I think what we have here are different opinions on how cleanup
> > should be handled.
> 
> In the regular case using the framework cleanup function before calling
> component_unbind_all() works fine.
> 
> Its really only the case where a subcomponent fails to bind where unbind
> happens before calling drm_mode_config_cleanup(drm). I guess Lucas was
> not aware of that special case...?

As long as ->unbind undoes everything that ->bind does, it's not a
problem.

WRT using devres groups in one of your previous mails on this topic,
consider what would happen if you use devm_* APIs in the bind callback
and the component helper did not use devres groups.

Any resources taken in the bind callback would not be freed until the
device was unbound from the driver by the driver model.  This means
each time the bind callback gets called, new sets of resources are
attempted to be acquired.  If some resources are exclusive, the first
bind attempt would succeed, but the second attempt would fail with
-EBUSY for example.  In the case of memory, the allocated memory
would not be freed, but new memory would be allocated each time a
bind was attempted.

The alternative would be that devres must not be used at all in the
bind/unbind callbacks - but then we'll be subject to the same error-
prone cleanup that we see with driver probe functions prior to devres.

Consider what the LDB bind/unbind callbacks would look like if devres
was not permitted, and how the memory for the imx_ldb structure would
be managed - you'd need some sort of ref-counting on the imx_ldb
structure, and management of that in the encoder and optional connector
destroy functions so you know when all embedded encoders and connectors
in that structure have been "destroyed" by drm_mode_config_cleanup(),
and hence it's safe to free the data structure.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
