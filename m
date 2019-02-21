Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A93C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29502080D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfBUNG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:06:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48332 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbfBUNGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:06:25 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7A73F300561F;
        Thu, 21 Feb 2019 13:06:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-228.ams2.redhat.com [10.36.116.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 788581001DD2;
        Thu, 21 Feb 2019 13:06:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id A2C3E11A9A; Thu, 21 Feb 2019 14:06:23 +0100 (CET)
Date:   Thu, 21 Feb 2019 14:06:23 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] drm/qxl: kick out vgacon
Message-ID: <20190221130623.rjtmtoe2qf7dgy2t@sirius.home.kraxel.org>
References: <20190221113534.20764-1-kraxel@redhat.com>
 <20190221113534.20764-3-kraxel@redhat.com>
 <20190221122011.GP2665@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221122011.GP2665@phenom.ffwll.local>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 21 Feb 2019 13:06:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 01:20:11PM +0100, Daniel Vetter wrote:
> On Thu, Feb 21, 2019 at 12:35:34PM +0100, Gerd Hoffmann wrote:
> > Problem:  qxl switches from native mode back into vga compatibility mode
> > when it notices someone is accessing vga registers.  And vgacon does
> > exactly that before fbcon takes over.  So make sure we kick out vgacon
> > early enough that it wouldn't disturb us.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  drivers/gpu/drm/qxl/qxl_drv.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> > index bb81e310eb..08446561aa 100644
> > --- a/drivers/gpu/drm/qxl/qxl_drv.c
> > +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> > @@ -95,6 +95,7 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> >  		goto modeset_cleanup;
> >  
> >  	drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, 0, "qxl");
> > +	drm_fb_helper_kick_out_vgacon();
> 
> I was thinking of checking whether pdev is a VGA class device and whether
> it decodes vga access, and in that case automatically calling
> kick_out_vgacon from remove_conflicting_pci_framebuffer. Since that's what
> drivers want anyway, and those who don't can open code it.
> 
> Or is there an issue with that?

It'll need more careful testing to make sure we don't have unwanted side
effects when just doing it for everyone.  And I guess most drivers don't
care much because their hardware ignores vga port writes once they are
switched out of vga text mode.

Dunno why i915 needs this.

In case of qxl it is more a historical leftover.  The very first qxl
device revision had no explicit qxl command to switch from qxl native
mode back to vga compatibility mode, vga port access was used for that
instead.  It's long fixed, but the qxl device still has that quirk for
compatibility with very old guest drivers.

cheers,
  Gerd

