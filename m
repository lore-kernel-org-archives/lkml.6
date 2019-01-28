Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF42C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57EB9207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfA1I7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:59:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfA1I7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:59:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C3038666E;
        Mon, 28 Jan 2019 08:59:52 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-116.ams2.redhat.com [10.36.116.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF0A660123;
        Mon, 28 Jan 2019 08:59:51 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 25CE9A1E7; Mon, 28 Jan 2019 09:59:51 +0100 (CET)
Date:   Mon, 28 Jan 2019 09:59:51 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH v3 17/23] drm/qxl: use generic fbdev emulation
Message-ID: <20190128085951.gkap3by26xgkbwaa@sirius.home.kraxel.org>
References: <20190118122020.27596-1-kraxel@redhat.com>
 <20190118122020.27596-18-kraxel@redhat.com>
 <e31c0fdd-315a-59cf-e7fe-dfd6a064f6ee@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e31c0fdd-315a-59cf-e7fe-dfd6a064f6ee@tronnes.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 28 Jan 2019 08:59:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 06:25:27PM +0100, Noralf Trønnes wrote:
> 
> 
> Den 18.01.2019 13.20, skrev Gerd Hoffmann:
> > Switch qxl over to the new generic fbdev emulation.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  drivers/gpu/drm/qxl/qxl_display.c | 7 -------
> >  drivers/gpu/drm/qxl/qxl_drv.c     | 2 ++
> >  2 files changed, 2 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
> > index ef832f98ab..9c751f01e3 100644
> > --- a/drivers/gpu/drm/qxl/qxl_display.c
> > +++ b/drivers/gpu/drm/qxl/qxl_display.c
> > @@ -1221,18 +1221,11 @@ int qxl_modeset_init(struct qxl_device *qdev)
> >  	qxl_display_read_client_monitors_config(qdev);
> >  
> >  	drm_mode_config_reset(&qdev->ddev);
> > -
> > -	/* primary surface must be created by this point, to allow
> > -	 * issuing command queue commands and having them read by
> > -	 * spice server. */
> > -	qxl_fbdev_init(qdev);
> >  	return 0;
> >  }
> >  
> >  void qxl_modeset_fini(struct qxl_device *qdev)
> >  {
> > -	qxl_fbdev_fini(qdev);
> > -
> >  	qxl_destroy_monitors_object(qdev);
> >  	drm_mode_config_cleanup(&qdev->ddev);
> >  }
> > diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> > index 13c8a662f9..3fce7d16df 100644
> > --- a/drivers/gpu/drm/qxl/qxl_drv.c
> > +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> > @@ -93,6 +93,8 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> >  	if (ret)
> >  		goto modeset_cleanup;
> >  
> > +	drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, 0, "qxl");
> 
> I couldn't find that this was part of old fbdev code, so it would be
> nice to mention it in the commit message.

It actually is, but a bit hidden because it doesn't use a helper you can
easily grep for.  Instead sets fb_info->apertures->ranges[0] in
qxlfb_create(), which has the same effect.

cheers,
  Gerd

