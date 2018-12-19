Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA60C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51019218F0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545231904;
	bh=ZRQ0eu16f5oAPxPyA5eKjBCN2sadEwOj0SLRuZ9s1Yg=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=GYwfPS4Lzx4EAsWnJL7LiJ5gfBvuspDe8x9ovsHrb+T+r4qr4g0Bcm2pl3RWaxdcM
	 eUzgaTej8Y1ra1Tlb8HYnwCPloqe450SKjRIlIW8rcjUpCI1YQJtlj0Y4nCVYtmSHY
	 s7Tod/o/c23y266MA5PonMuH7YBoIwHDha9Clwr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbeLSPFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:05:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:37164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727071AbeLSPFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:05:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FD4D20874;
        Wed, 19 Dec 2018 15:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545231902;
        bh=ZRQ0eu16f5oAPxPyA5eKjBCN2sadEwOj0SLRuZ9s1Yg=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=GY46YC+EqnLETSXH1afaUzvkxZfL3QPUL1WrUP6w7Qm+7JxLnW5dn/Y+dUi+4t+Pd
         SiKp7DBQQpkb0Q8cfygO9ZU+u9vudsbCSYsyVZ0moRiX7QHr7FSZy7OvfhstV860Ss
         mWC93Pxltj6zOTLr2fxAM1ohB4tYp2rWOY840HHs=
Date:   Wed, 19 Dec 2018 16:04:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ramalingam C <ramalingam.c@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        seanpaul@chromium.org, tomas.winkler@intel.com,
        uma.shankar@intel.com, ville.syrjala@linux.intel.com,
        chris@chris-wilson.co.uk,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 04/39] component: alloc component_match without any
 comp to match
Message-ID: <20181219150459.GA25653@kroah.com>
References: <1544673701-6353-1-git-send-email-ramalingam.c@intel.com>
 <1544673701-6353-5-git-send-email-ramalingam.c@intel.com>
 <20181219134245.GB21184@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219134245.GB21184@phenom.ffwll.local>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 02:42:45PM +0100, Daniel Vetter wrote:
> On Thu, Dec 13, 2018 at 09:31:06AM +0530, Ramalingam C wrote:
> > If all the components associated to a component master is not added
> > to the component framework due to the HW capability or Kconfig
> > selection, component_match will be NULL at
> > component_master_add_with_match().
> > 
> > To avoid this, component_match_alloc() is added to the framework,
> > to allcoate the struct component_match with zero associated components.
> > Hence component master can be added with a component_match with zero
> > associated components.
> > 
> > This helps the component master bind call to get triggered,
> > even if no component is registered for that particular master.
> > 
> > This is meant for big PCI device drivers where small/optional
> > features are external components, and based on usecases different
> > combination of components are build as entire driver.
> > 
> > In such PCI device driver Load, if we use the component master for
> > waiting for few  components(features) availability, only if they are
> > supported by the underlying HW, then we need to allocate memory for
> > component_match using the API introduced in this change before
> > the call to component_master_add_with_match.
> > 
> > v2:
> >   No Change.
> > 
> > Signed-off-by: Ramalingam C <ramalingam.c@intel.com>
> > Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Kate Stewart <kstewart@linuxfoundation.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Philippe Ombredanne <pombredanne@nexb.com>
> > Cc: linux-kernel@vger.kernel.org
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> Greg, I expect the i915 feature that needs this will only land in 4.22.
> I'm also not aware of anyone else using this (all the other component
> users always use components). How do you want to get this landed?
> 
> I think either getting this into 4.21, or an ack for merging through drm
> trees would work well for us.

I have no objection to you taking this through the drm tree.  As I
really do not know the component code at all (that would be Russell
King), feel free to add my:

	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

as it looks sane to me.

thanks,

greg k-h
