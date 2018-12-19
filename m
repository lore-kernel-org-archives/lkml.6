Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7771C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7BF217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="d1Tif6nW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbeLSNUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:20:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32994 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbeLSNUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:20:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so19531685wrr.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 05:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vb2J/XUohhQsfWkBF+UeLGGR4/t8niZ9zScqvkfK6pw=;
        b=d1Tif6nWxPtJzEsihN9jWlJUIt9EvoLXfMgk1IULf3plVioIUeQ3kVV7ODbNgsvOif
         oGvxgubf/dppO506y8lM2iYvWXOEhGRs+pfkIYeqh7tKShuHE5cQD7oUwdURAutxcl40
         JtYFkOQnRyR9owztStjfFKcudz7zx1FG4vOHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=vb2J/XUohhQsfWkBF+UeLGGR4/t8niZ9zScqvkfK6pw=;
        b=T4oxdcdXcZ3CJWGkRT9nNwD38Ro3lXbbWvrGNZQzZklkFcEHqYiyUG5Lv0OIRbtz1h
         QMZjy1aoC5rYmLdEVeQn5P6mz7N/NghqFLFI9qp/0iwmsufPvbKjO8kQsyqyucchgsQ0
         fDirYFzr76zB7+IL3IjL6qB3Tdc/aN1L8xf9jy1AePupGqjtVnlQ5L8hu6GKqB9jd8fO
         Qs9ug2p6OZOWfZnH9HU5SDrCgTLJ2KMCHoMLL7lEYiFYpMhaYVK2lCr1NgdqI28N8SZN
         ZpcLK9vA8uZ1E873GzwxLb+JIztclvptC3wvlJZARKEwMZr87hEz9q8LoIJxLF6qMcEq
         u/9A==
X-Gm-Message-State: AA+aEWbZn3sPblZ3UU/1ykNyH1mTLF3xHTYker3y1O2UImdi3nwejWDd
        u1SdYmrKyclbSps6J14hs4Jau3ovkgI=
X-Google-Smtp-Source: AFSGD/Xu7qPyQfhIjM4DOt0rcHaYfgvhskTYvxbaByEzpD2pZtHtbN99skKjEJzLIVNqOd2aOUeS7A==
X-Received: by 2002:a5d:4586:: with SMTP id p6mr18156441wrq.69.1545225632668;
        Wed, 19 Dec 2018 05:20:32 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id d16sm4287959wru.52.2018.12.19.05.20.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 05:20:31 -0800 (PST)
Date:   Wed, 19 Dec 2018 14:20:29 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, Dave Airlie <airlied@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Jerry Zuo <Jerry.Zuo@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [WIP PATCH 06/15] drm/i915: Keep malloc references to MST ports
Message-ID: <20181219132029.GW21184@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Dave Airlie <airlied@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Jerry Zuo <Jerry.Zuo@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
References: <20181214012604.13746-1-lyude@redhat.com>
 <20181214012604.13746-7-lyude@redhat.com>
 <20181214093255.GO21184@phenom.ffwll.local>
 <ed0fbbed2a856e62134baa7ee88023d07f02f73c.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed0fbbed2a856e62134baa7ee88023d07f02f73c.camel@redhat.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 04:52:24PM -0500, Lyude Paul wrote:
> On Fri, 2018-12-14 at 10:32 +0100, Daniel Vetter wrote:
> > On Thu, Dec 13, 2018 at 08:25:35PM -0500, Lyude Paul wrote:
> > > So that the ports stay around until we've destroyed the connectors, in
> > > order to ensure that we don't pass an invalid pointer to any MST helpers
> > > once we introduce the new MST VCPI helpers.
> > > 
> > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > ---
> > >  drivers/gpu/drm/i915/intel_connector.c | 4 ++++
> > >  drivers/gpu/drm/i915/intel_dp_mst.c    | 2 ++
> > >  2 files changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/i915/intel_connector.c
> > > b/drivers/gpu/drm/i915/intel_connector.c
> > > index 18e370f607bc..37d2c644f4b8 100644
> > > --- a/drivers/gpu/drm/i915/intel_connector.c
> > > +++ b/drivers/gpu/drm/i915/intel_connector.c
> > > @@ -95,6 +95,10 @@ void intel_connector_destroy(struct drm_connector
> > > *connector)
> > >  	intel_panel_fini(&intel_connector->panel);
> > >  
> > >  	drm_connector_cleanup(connector);
> > > +
> > > +	if (intel_connector->port)
> > 
> > We set this as the first thing in intel_dp_add_mst_connector, so this
> > check isn't doing anything.
> 
> I think this comment might be a mistake? intel_connector_destroy() is shared
> by all of the intel connectors, so some may not have a value in
> intel_connector->port. I can move it to it's own destroy callback for MST if
> you would prefer though.

Oops, didn't look at the patch carefully enough. I think a
intel_dp_mst_connector_destroy would be useful in this case. But a bit a
bikeshed, so up to you.
-Daniel

> > 
> > > +		drm_dp_mst_put_port_malloc(intel_connector->port);
> > > +
> > >  	kfree(connector);
> > >  }
> > >  
> > > diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c
> > > b/drivers/gpu/drm/i915/intel_dp_mst.c
> > > index f05427b74e34..4d6ced34d465 100644
> > > --- a/drivers/gpu/drm/i915/intel_dp_mst.c
> > > +++ b/drivers/gpu/drm/i915/intel_dp_mst.c
> > > @@ -484,6 +484,8 @@ static struct drm_connector
> > > *intel_dp_add_mst_connector(struct drm_dp_mst_topolo
> > >  	if (ret)
> > >  		goto err;
> > >  
> > > +	drm_dp_mst_get_port_malloc(port);
> > 
> > Needs to be moved up where we assing intel_connector->port, or it'll
> > underflow on cleanup on error paths.
> > 
> > > +
> > >  	return connector;
> > >  
> > >  err:
> > > -- 
> > > 2.19.2
> > > 
> -- 
> Cheers,
> 	Lyude Paul
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
