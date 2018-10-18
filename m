Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3FFC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C2B20645
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qQWixRSE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C2B20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbeJRVMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 17:12:36 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47988 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbeJRVMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 17:12:35 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9IDBVtA032407;
        Thu, 18 Oct 2018 08:11:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539868291;
        bh=tNKHaLbiXAKag0pQ+sB+nV7oIJT+MDhVrReDl26LdAA=;
        h=Date:From:To:Subject:References:In-Reply-To;
        b=qQWixRSE7+U/pMOo7wIvmAIw8RXJ9F/7wk9gBdUI/C9pHcjAXDUfnSaCyAZeFce+n
         CyePxt7kDqSDoj9pLp5GDHmBHy7zyzdxjdwh5NwaEQgQr6/XvCZkCYnpTQ/lqb0LKw
         muX9kxqsxt8DpFZqUPo+NV3qvGkR//KgBhDxC6ts=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9IDBVNl002989;
        Thu, 18 Oct 2018 08:11:31 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 18
 Oct 2018 08:11:30 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 18 Oct 2018 08:11:30 -0500
Received: from ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with SMTP id w9IDBUhS001720;
        Thu, 18 Oct 2018 08:11:30 -0500
Date:   Thu, 18 Oct 2018 08:11:30 -0500
From:   Benoit Parrot <bparrot@ti.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jyri Sarha <jsarha@ti.com>
Subject: Re: [Patch v4 5/8] drm/omap: Add global state as a private atomic
 object
Message-ID: <20181018131130.GB1566@ti.com>
References: <20181012201703.29065-1-bparrot@ti.com>
 <20181012201703.29065-6-bparrot@ti.com>
 <20181016122946.GU31561@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181016122946.GU31561@phenom.ffwll.local>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Vetter <daniel@ffwll.ch> wrote on Tue [2018-Oct-16 14:29:46 +0200]:
> On Fri, Oct 12, 2018 at 03:17:00PM -0500, Benoit Parrot wrote:
> > Global shared resources (like hw overlays) for omapdrm are implemented
> > as a part of atomic state using the drm_private_obj infrastructure
> > available in the atomic core.
> > 
> > omap_global_state is introduced as a drm atomic private object. The two
> > funcs omap_get_global_state() and omap_get_existing_global_state() are
> > the two variants that will be used to access omap_global_state.
> > 
> > Signed-off-by: Benoit Parrot <bparrot@ti.com>
> > ---
> >  drivers/gpu/drm/omapdrm/omap_drv.c | 97 +++++++++++++++++++++++++++++++++++++-
> >  drivers/gpu/drm/omapdrm/omap_drv.h | 23 +++++++++
> >  2 files changed, 119 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
> > index 2921cc90f2d8..94658ec79c76 100644
> > --- a/drivers/gpu/drm/omapdrm/omap_drv.c
> > +++ b/drivers/gpu/drm/omapdrm/omap_drv.c
> > @@ -129,6 +129,94 @@ static const struct drm_mode_config_funcs omap_mode_config_funcs = {
> >  	.atomic_commit = drm_atomic_helper_commit,
> >  };
> >  
> > +/* Global/shared object state funcs */
> > +
> > +/*
> > + * This is a helper that returns the private state currently in operation.
> > + * Note that this would return the "old_state" if called in the atomic check
> > + * path, and the "new_state" after the atomic swap has been done.
> > + */
> > +struct omap_global_state *
> > +omap_get_existing_global_state(struct omap_drm_private *priv)
> > +{
> > +	return to_omap_global_state(priv->glob_obj.state);
> > +}
> > +
> > +/*
> > + * This acquires the modeset lock set aside for global state, creates
> > + * a new duplicated private object state.
> > + */
> > +struct omap_global_state *__must_check
> > +omap_get_global_state(struct drm_atomic_state *s)
> > +{
> > +	struct omap_drm_private *priv = s->dev->dev_private;
> > +	struct drm_private_state *priv_state;
> > +	int ret;
> > +
> > +	if (!drm_modeset_is_locked(&priv->glob_obj_lock)) {
> > +		ret = drm_modeset_lock(&priv->glob_obj_lock, s->acquire_ctx);
> > +		if (ret) {
> > +			DBG("getting priv->glob_obj_lock (%p) failed %d",
> > +			    &priv->glob_obj_lock, ret);
> > +			return ERR_PTR(ret);
> > +		}
> > +	}
> > +
> > +	priv_state = drm_atomic_get_private_obj_state(s, &priv->glob_obj);
> 
> One of the refactors I had in mind (and which would be possible now that
> private state structs are implemented as properly structs, instead of void
> * pointers): Add a drm_modeset_lock to drm_private_obj and avoid having to
> duplicate that over all implementations. Not everyone wants a per-obj
> lock, but no one will be hurt by having a per-obj lock - drm_modeset_lock
> is very extensible in that way. And we could drop the custom locking code
> everyone has to roll themselves.

Thanks for the feedback. I was wondering the same when I was "duplicating"
this code. I will take this under advisement, but I would probably see that
as a separate patch set, either before or after this one :) 

Benoit

> 
> Just a drive-by refactor idea.
> -Daniel
