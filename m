Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DB8C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 07:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364B520896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 07:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364B520896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932602AbeFQHug (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 03:50:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38279 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932451AbeFQHuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 03:50:35 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4676420799; Sun, 17 Jun 2018 09:50:34 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1231820012;
        Sun, 17 Jun 2018 09:50:34 +0200 (CEST)
Date:   Sun, 17 Jun 2018 09:50:33 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     maxime.ripard@bootlin.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/atmel-hlcdc: remove unnecessary if statement
Message-ID: <20180617095033.515bd531@bbrezillon>
In-Reply-To: <041e4264a89b5d8ab748f6dc3bf501db@agner.ch>
References: <20170807062650.9863-1-stefan@agner.ch>
        <041e4264a89b5d8ab748f6dc3bf501db@agner.ch>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jun 2018 01:34:34 +0200
Stefan Agner <stefan@agner.ch> wrote:

> Boris, Maxime,
> 
> On 07.08.2017 08:26, Stefan Agner wrote:
> > The statement always evaluates to true since the struct fields
> > are arrays. This has shown up as a warning when compiling with
> > clang:
> >   warning: address of array 'desc->layout.xstride' will always
> >       evaluate to 'true' [-Wpointer-bool-conversion]  
> 
> It seems that this patch never made it upstream. It still produces a
> warning when building with clang. Maybe you could have a look and queue?

Oops, sorry, I missed that one.

> 
> --
> Stefan
> 
> > 
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > ---
> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 21 +++++++++------------
> >  1 file changed, 9 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> > b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> > index 1124200bb280..9bd8c4888035 100644
> > --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> > +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> > @@ -854,24 +854,21 @@ static int
> > atmel_hlcdc_plane_init_properties(struct atmel_hlcdc_plane *plane,
> >  				struct atmel_hlcdc_plane_properties *props)
> >  {
> >  	const struct atmel_hlcdc_layer_desc *desc = plane->layer.desc;
> > +	int ret;
> >  
> >  	if (desc->type == ATMEL_HLCDC_OVERLAY_LAYER ||
> >  	    desc->type == ATMEL_HLCDC_CURSOR_LAYER)
> >  		drm_object_attach_property(&plane->base.base,
> >  					   props->alpha, 255);
> >  
> > -	if (desc->layout.xstride && desc->layout.pstride) {

The test should be 

	if (desc->layout.xstride[0] && desc->layout.pstride[0])

Can you send a new version with this change?

> > -		int ret;
> > -
> > -		ret = drm_plane_create_rotation_property(&plane->base,
> > -							 DRM_MODE_ROTATE_0,
> > -							 DRM_MODE_ROTATE_0 |
> > -							 DRM_MODE_ROTATE_90 |
> > -							 DRM_MODE_ROTATE_180 |
> > -							 DRM_MODE_ROTATE_270);
> > -		if (ret)
> > -			return ret;
> > -	}
> > +	ret = drm_plane_create_rotation_property(&plane->base,
> > +						 DRM_MODE_ROTATE_0,
> > +						 DRM_MODE_ROTATE_0 |
> > +						 DRM_MODE_ROTATE_90 |
> > +						 DRM_MODE_ROTATE_180 |
> > +						 DRM_MODE_ROTATE_270);
> > +	if (ret)
> > +		return ret;
> >  
> >  	if (desc->layout.csc) {
> >  		/*  

