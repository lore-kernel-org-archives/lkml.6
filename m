Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7F5ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5862214FA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5862214FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbeIQX0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 19:26:40 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36336 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeIQX0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 19:26:40 -0400
Received: by mail-qk1-f194.google.com with SMTP id 93-v6so9497167qks.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 10:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:mime-version
         :content-transfer-encoding;
        bh=TN7CoNVRxkkc2OfSEN32PH+BA+43BOLkU5uiUmlNJtk=;
        b=B6H6o/l5L7b/CFHViFn5iagyGJq3caGdzhYNvfOFQYt4G5igp8s2bwdwJrB68xjmtL
         U9iENjV+4i9hfF66KchId7HcghekfgZwUsUKqjG2KgGmy72o58Nv6frqUB+dc3g0Qxto
         8AsHbxJ9fsM7AW5XdGhmifn0O44vDHnAyC1EbOHONlixvntsiLgYU/gCz7EeM0s3pXjs
         2+CrhuZh+v0KpcBkDvGX7TIc7UgvpQBQTWI3jr8MoaJJsoRvTQfp8ZloXIi4fzKjHHu3
         sBz0jeUJtereFaIevJjfBBYHPG7ElJWc4EUGm5nYvfl9rZp0gkcCzuyYoVmIdZGN5nc9
         uzcg==
X-Gm-Message-State: APzg51DWKrXE29ljOx6tam/JQaG7XzTYDCeG/8co88qStbcDR0H/XF/I
        f8j2CuTGYLyRPNDiDVEA24CO9Q==
X-Google-Smtp-Source: ANB0VdYTIjWEwVV4VOYfxAB2oOYOyM6MqBgIDMji0LlqmgJq2PNahywrjkngLDQEmuYeaXOmhcap8A==
X-Received: by 2002:a37:84c4:: with SMTP id g187-v6mr18225208qkd.49.1537207093453;
        Mon, 17 Sep 2018 10:58:13 -0700 (PDT)
Received: from whitewolf.lyude.net (pool-72-74-165-95.bstnma.fios.verizon.net. [72.74.165.95])
        by smtp.gmail.com with ESMTPSA id g39-v6sm11450844qtb.90.2018.09.17.10.58.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 10:58:12 -0700 (PDT)
Message-ID: <2efaff3aeb732a2d3bf2ca184063d5b923aa5002.camel@redhat.com>
Subject: Re: [PATCH] drm/probe_helper: Don't bother probing when connectors
 are forced off
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Date:   Mon, 17 Sep 2018 13:58:12 -0400
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

JFYI, this is to fix "DDC responded but no EDID" errors from nouveau, which
presumably come from the fact that having a connector forced off disables
reading it's EDID. It's possible we are missing something in
nouveau_connector_detect(), but I'm confused as to why we would want to call
->probe() at all in the first place
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

