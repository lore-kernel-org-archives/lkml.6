Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900DDECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59344214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59344214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbeIQXid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 19:38:33 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37356 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeIQXic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 19:38:32 -0400
Received: by mail-qt0-f196.google.com with SMTP id n6-v6so16172609qtl.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 11:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:mime-version
         :content-transfer-encoding;
        bh=PGcyZ2PDlVPgQTMAItWjNBLw7foMMz0CpChIINkWMu8=;
        b=EnZy0zktc//cRs5nC8ywUxXvq88EPBE3MDQZFk9g3OWTk396ajtylROdOdd1gtWHWe
         wnYtcaO3ilY5yfPQUYIBLC0oNAU7q5FhdOv7mqXbZi+c98SWJF58U1bFt3/xzkgWDwwI
         TIf/E5jMu3aP1hhLyk9h+t6Joa4XF1ayfJwjbxauGgo2KKFb6QBOpBT3FxYBMr7dQ9nI
         KlnEmMrKJxEYh+TFeiSYoTudr65NV5aSDlQwpZL866BluVeAm4iH5rYnmLKlHbpxhFt9
         IamLh3nyXoL9E0RVugiihgWmo/q+HX5VPkbUITg69Mt3AqROd6OcQsWMQOtF86/hbPQr
         kG3Q==
X-Gm-Message-State: APzg51AiwgasR5Re1saoMxvZtIYhm2XxFzJlW84bQurrB3GjAEaFIdLI
        pYpLliHlNxtg+lJMWr0s0O8iqQ==
X-Google-Smtp-Source: ANB0VdZSsC6eZOAajBHlze9LTxfaayEcxLKH82MXX5Lhcx7logkWuvTjpx140pHpy8GpK6p8H5EISg==
X-Received: by 2002:aed:26a3:: with SMTP id q32-v6mr18948297qtd.103.1537207803931;
        Mon, 17 Sep 2018 11:10:03 -0700 (PDT)
Received: from whitewolf.lyude.net (pool-72-74-165-95.bstnma.fios.verizon.net. [72.74.165.95])
        by smtp.gmail.com with ESMTPSA id s8-v6sm10629374qtc.71.2018.09.17.11.10.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 11:10:02 -0700 (PDT)
Message-ID: <54c01a13f382aacd7cd4d75a642630053f54b8f1.camel@redhat.com>
Subject: Re: [PATCH] drm/probe_helper: Don't bother probing when connectors
 are forced off
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Date:   Mon, 17 Sep 2018 14:10:02 -0400
In-Reply-To: <20180917175545.GP5565@intel.com>
References: <20180917174344.22011-1-lyude@redhat.com>
         <20180917175545.GP5565@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-17 at 20:55 +0300, Ville Syrjälä wrote:
> On Mon, Sep 17, 2018 at 01:43:44PM -0400, Lyude Paul wrote:
> > Userspace asked them to be forced off, so why would we care about what a
> > probe tells us?
> 
> I believe there should be force checks in the callers already.
> Or are we missing some?

JFYI, what triggered me to send this patch are these error messages that come
from nouveau when a hotplug happens on a port that we've forced off:

[ 1903.918104] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for DP-2
[ 1903.918123] [drm:drm_helper_hpd_irq_event [drm_kms_helper]] [CONNECTOR:61:DP-2] status updated from disconnected to disconnected

That being said; I'm sure there are probably some checks missing, but I don't
really see the purpose in calling the driver's probe functions at all if they're
just supposed to return the status we forced.

> 
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > ---
> >  drivers/gpu/drm/drm_probe_helper.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_probe_helper.c
> > b/drivers/gpu/drm/drm_probe_helper.c
> > index a1bb157bfdfa..56d2b5dd1f58 100644
> > --- a/drivers/gpu/drm/drm_probe_helper.c
> > +++ b/drivers/gpu/drm/drm_probe_helper.c
> > @@ -269,7 +269,9 @@ drm_helper_probe_detect_ctx(struct drm_connector
> > *connector, bool force)
> >  retry:
> >  	ret = drm_modeset_lock(&connector->dev->mode_config.connection_mutex,
> > &ctx);
> >  	if (!ret) {
> > -		if (funcs->detect_ctx)
> > +		if (connector->force == DRM_FORCE_OFF)
> > +			ret = connector_status_disconnected;
> 
> connector->force is protected by mode_config.mutex IIRC.
> 
> > +		else if (funcs->detect_ctx)
> >  			ret = funcs->detect_ctx(connector, &ctx, force);
> >  		else if (connector->funcs->detect)
> >  			ret = connector->funcs->detect(connector, force);
> > @@ -317,6 +319,9 @@ drm_helper_probe_detect(struct drm_connector *connector,
> >  	if (ret)
> >  		return ret;
> >  
> > +	if (connector->force == DRM_FORCE_OFF)
> > +		return connector_status_disconnected;
> > +
> >  	if (funcs->detect_ctx)
> >  		return funcs->detect_ctx(connector, ctx, force);
> >  	else if (connector->funcs->detect)
> > -- 
> > 2.17.1
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> 

