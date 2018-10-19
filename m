Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10620ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08D320869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="YMs2+oue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A08D320869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeJSPPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 11:15:04 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40665 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbeJSPPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 11:15:04 -0400
Received: by mail-ed1-f66.google.com with SMTP id r1-v6so30505914edd.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 00:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kaEGokuhv8pMca0nDlWtHGZFWMpnPaIOF7+4tQRcLtg=;
        b=YMs2+oue6NF68fuZEvZtz5eQsE5FrOk120oa5cjfToE2GTjhM7iDIphgglUuQBBtR+
         NMGoI4+AIzldY7GB3hEK3jMdwb9AwScLq5gbyAs0V0qAN8fkR/ozWrhT0QBRB4Rkjs0Z
         cTTebsLsqlshjlazMEPhoZMLVTqYu5amh+xbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=kaEGokuhv8pMca0nDlWtHGZFWMpnPaIOF7+4tQRcLtg=;
        b=Ck2q3q+daiGvn9FCVu5e77UY0KlIso+udwXnNYv2FQNzXoO735FlqRqmiOUqjJemGH
         VQNN2FSw8kAOZGnWTSHQAB+PsGMi5d+ONoPaBO75WGX/aUzb6PsxXgguU7+CHSB2v8ag
         cOif0LmF3KCR/v9NmFLiua9tWtx/wcFYYZORZNT9rci/66SKb8LdfREAwKuiEHQERNp7
         GZu9lBeTVksRMC9c586CHuNOEgUAIF6tliwmRyFLe5x/FM6gtJD+M9FoUUHtL/nulJku
         viZ7k6WO+ghOHdhGEh6aLewEvEfRLt+PHN9jJskLIyS5M2S1pO1qlqIPi80bCrCeihSx
         stbQ==
X-Gm-Message-State: ABuFfogEE1cWLYt7xcoo9NTDKqYw4xrhRJ4DYjYJOrCcBiwR6AydV0Rb
        C0lga+Oi9SfJkRvIqDwu3FAOJg==
X-Google-Smtp-Source: ACcGV61PPgkiNehAeUKU43u3GXbGvpjRrPnTH4tMlM8fNCqJzpjnDM+JYpD+hPgrzsElS+FBo2s1Rw==
X-Received: by 2002:a50:b404:: with SMTP id b4-v6mr5374141edh.141.1539933015227;
        Fri, 19 Oct 2018 00:10:15 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 38-v6sm9319777edz.33.2018.10.19.00.10.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 00:10:14 -0700 (PDT)
Date:   Fri, 19 Oct 2018 09:10:12 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Benoit Parrot <bparrot@ti.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jyri Sarha <jsarha@ti.com>
Subject: Re: [Patch v4 5/8] drm/omap: Add global state as a private atomic
 object
Message-ID: <20181019071012.GQ31561@phenom.ffwll.local>
Mail-Followup-To: Benoit Parrot <bparrot@ti.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>
References: <20181012201703.29065-1-bparrot@ti.com>
 <20181012201703.29065-6-bparrot@ti.com>
 <20181016122946.GU31561@phenom.ffwll.local>
 <20181018131130.GB1566@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018131130.GB1566@ti.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 08:11:30AM -0500, Benoit Parrot wrote:
> Daniel Vetter <daniel@ffwll.ch> wrote on Tue [2018-Oct-16 14:29:46 +0200]:
> > On Fri, Oct 12, 2018 at 03:17:00PM -0500, Benoit Parrot wrote:
> > > Global shared resources (like hw overlays) for omapdrm are implemented
> > > as a part of atomic state using the drm_private_obj infrastructure
> > > available in the atomic core.
> > > 
> > > omap_global_state is introduced as a drm atomic private object. The two
> > > funcs omap_get_global_state() and omap_get_existing_global_state() are
> > > the two variants that will be used to access omap_global_state.
> > > 
> > > Signed-off-by: Benoit Parrot <bparrot@ti.com>
> > > ---
> > >  drivers/gpu/drm/omapdrm/omap_drv.c | 97 +++++++++++++++++++++++++++++++++++++-
> > >  drivers/gpu/drm/omapdrm/omap_drv.h | 23 +++++++++
> > >  2 files changed, 119 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
> > > index 2921cc90f2d8..94658ec79c76 100644
> > > --- a/drivers/gpu/drm/omapdrm/omap_drv.c
> > > +++ b/drivers/gpu/drm/omapdrm/omap_drv.c
> > > @@ -129,6 +129,94 @@ static const struct drm_mode_config_funcs omap_mode_config_funcs = {
> > >  	.atomic_commit = drm_atomic_helper_commit,
> > >  };
> > >  
> > > +/* Global/shared object state funcs */
> > > +
> > > +/*
> > > + * This is a helper that returns the private state currently in operation.
> > > + * Note that this would return the "old_state" if called in the atomic check
> > > + * path, and the "new_state" after the atomic swap has been done.
> > > + */
> > > +struct omap_global_state *
> > > +omap_get_existing_global_state(struct omap_drm_private *priv)
> > > +{
> > > +	return to_omap_global_state(priv->glob_obj.state);
> > > +}
> > > +
> > > +/*
> > > + * This acquires the modeset lock set aside for global state, creates
> > > + * a new duplicated private object state.
> > > + */
> > > +struct omap_global_state *__must_check
> > > +omap_get_global_state(struct drm_atomic_state *s)
> > > +{
> > > +	struct omap_drm_private *priv = s->dev->dev_private;
> > > +	struct drm_private_state *priv_state;
> > > +	int ret;
> > > +
> > > +	if (!drm_modeset_is_locked(&priv->glob_obj_lock)) {
> > > +		ret = drm_modeset_lock(&priv->glob_obj_lock, s->acquire_ctx);
> > > +		if (ret) {
> > > +			DBG("getting priv->glob_obj_lock (%p) failed %d",
> > > +			    &priv->glob_obj_lock, ret);
> > > +			return ERR_PTR(ret);
> > > +		}
> > > +	}
> > > +
> > > +	priv_state = drm_atomic_get_private_obj_state(s, &priv->glob_obj);
> > 
> > One of the refactors I had in mind (and which would be possible now that
> > private state structs are implemented as properly structs, instead of void
> > * pointers): Add a drm_modeset_lock to drm_private_obj and avoid having to
> > duplicate that over all implementations. Not everyone wants a per-obj
> > lock, but no one will be hurt by having a per-obj lock - drm_modeset_lock
> > is very extensible in that way. And we could drop the custom locking code
> > everyone has to roll themselves.
> 
> Thanks for the feedback. I was wondering the same when I was "duplicating"
> this code. I will take this under advisement, but I would probably see that
> as a separate patch set, either before or after this one :) 

Sure. Also note that this came up with a recent vc4 patch series by Boris
Brezillion "[RFC PATCH] drm/vc4: Add a load tracker to prevent HVS
underflow errors", so maybe you folks can work together.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
