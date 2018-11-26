Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932BBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5520720672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5520720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbeK0Hcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 02:32:53 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36089 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbeK0Hcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 02:32:53 -0500
Received: by mail-qk1-f194.google.com with SMTP id o125so13238458qkf.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 12:37:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=VHLgVH8k0qVB5vuFVG167QXO5UKSibVmkgWmCZArFwI=;
        b=DdrLz1JIFH+wl6Xf/Mos9lHJA1tdOKjWHjLxBjjrOiZTDkWWeRemDUVGx6owee8Unq
         5Sv78wurKOKFgJdfZKAQgz2gcjNFnoYf867pGda1Q5RiwbbeGnLvJ1lDFAkmRxjhgrGX
         aUp/x8oUheSQmM9D8Sr2zNW2GNI9akZwpzSy1seMCWYcL/6BPfSEhqhhw/7c6N3zgZnO
         RvwOiChs72MqR3pzxO40FC6JyFmWpNK5P8OEgBVpw6BXxZsB3jP4/SgFiUp4jEdebA10
         Rzt7+4oh8RPupL084HjIw74XZQIwPo5U+ulQc5kucuUjhzOVWh6daKPnKgMsW/4Ir5qf
         yfZw==
X-Gm-Message-State: AA+aEWb/sKhgNonlEeLuSE+KmGRHANgWM+4CyepNnomOQnHvaSuSXExC
        t3qQ6/mypwuVVTOUM4LU3jcDeA==
X-Google-Smtp-Source: AFSGD/Us+oursy0az3VlxXgVCAxquJYClVJgzYdQByKtndG81xYes1AmjB9UbV1cZ/pKMNsrmO94/w==
X-Received: by 2002:a37:5a05:: with SMTP id o5mr26333541qkb.126.1543264653378;
        Mon, 26 Nov 2018 12:37:33 -0800 (PST)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id v186sm826920qkd.13.2018.11.26.12.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 12:37:32 -0800 (PST)
Message-ID: <6f8b276f708404762557046065bfd8f4f07880dc.camel@redhat.com>
Subject: Re: [PATCH] drm/dp_mst: Skip validating ports during destruction,
 just ref
From:   Lyude Paul <lyude@redhat.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Dave Airlie <airlied@linux.ie>,
        Jerry Zuo <Jerry.Zuo@amd.com>
Date:   Mon, 26 Nov 2018 15:37:31 -0500
In-Reply-To: <CAKMK7uFAjG-tLMdUz7xf4E+1Lthnzx+cshobVG5BES9Mt=-fEg@mail.gmail.com>
References: <20181113224613.28809-1-lyude@redhat.com>
         <CAKMK7uFAjG-tLMdUz7xf4E+1Lthnzx+cshobVG5BES9Mt=-fEg@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-22 at 09:34 +0100, Daniel Vetter wrote:
> On Tue, Nov 13, 2018 at 11:47 PM Lyude Paul <lyude@redhat.com> wrote:
> > Jerry Zuo pointed out a rather obscure hotplugging issue that it seems I
> > accidentally introduced into DRM two years ago.
> > 
> > Pretend we have a topology like this:
> > 
> > > - DP-1: mst_primary
> >    |- DP-4: active display
> >    |- DP-5: disconnected
> >    |- DP-6: active hub
> >       |- DP-7: active display
> >       |- DP-8: disconnected
> >       |- DP-9: disconnected
> > 
> > If we unplug DP-6, the topology starting at DP-7 will be destroyed but
> > it's payloads will live on in DP-1's VCPI allocations and thus require
> > removal. However, this removal currently fails because
> > drm_dp_update_payload_part1() will (rightly so) try to validate the port
> > before accessing it, fail then abort. If we keep going, eventually we
> > run the MST hub out of bandwidth and all new allocations will start to
> > fail (or in my case; all new displays just start flickering a ton).
> > 
> > We could just teach drm_dp_update_payload_part1() not to drop the port
> > ref in this case, but then we also need to teach
> > drm_dp_destroy_payload_step1() to do the same thing, then hope no one
> > ever adds anything to the that requires a validated port reference in
> > drm_dp_destroy_connector_work(). Kind of sketchy.
> > 
> > So let's go with a more clever solution: any port that
> > drm_dp_destroy_connector_work() interacts with is guaranteed to still
> > exist in memory until we say so. While said port might not be valid we
> > don't really care: that's the whole reason we're destroying it in the
> > first place! So, teach drm_dp_get_validated_port_ref() to use the all
> > mighty current_work() function to avoid attempting to validate ports
> > from the context of mgr->destroy_connector_work. I can't see any
> > situation where this wouldn't be safe, and this avoids having to play
> > whack-a-mole in the future of trying to work around port validation.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Fixes: 263efde31f97 ("drm/dp/mst: Get validated port ref in
> > drm_dp_update_payload_part1()")
> > Reported-by: Jerry Zuo <Jerry.Zuo@amd.com>
> > Cc: Jerry Zuo <Jerry.Zuo@amd.com>
> > Cc: Harry Wentland <Harry.Wentland@amd.com>
> > Cc: <stable@vger.kernel.org> # v4.6+
> 
> Hm, sounds very similar to the bug I pointed out in your "make vcpi
> alloc more atomic" series. Will this all interact nicely with the
> solution we've worked out there (where we need to delay at least the
> kfree(port) until the last vcpi allocation is released?
Yes, it seems to work fine in my tests

> -Daniel
> 
> > ---
> >  drivers/gpu/drm/drm_dp_mst_topology.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > index 529414556962..08978ad72f33 100644
> > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > @@ -1023,9 +1023,20 @@ static struct drm_dp_mst_port
> > *drm_dp_mst_get_port_ref_locked(struct drm_dp_mst_
> >  static struct drm_dp_mst_port *drm_dp_get_validated_port_ref(struct
> > drm_dp_mst_topology_mgr *mgr, struct drm_dp_mst_port *port)
> >  {
> >         struct drm_dp_mst_port *rport = NULL;
> > +
> >         mutex_lock(&mgr->lock);
> > -       if (mgr->mst_primary)
> > -               rport = drm_dp_mst_get_port_ref_locked(mgr->mst_primary,
> > port);
> > +       /*
> > +        * Port may or may not be 'valid' but we don't care about that
> > when
> > +        * destroying the port and we are guaranteed that the port pointer
> > +        * will be valid until we've finished
> > +        */
> > +       if (current_work() == &mgr->destroy_connector_work) {
> > +               kref_get(&port->kref);
> > +               rport = port;
> > +       } else if (mgr->mst_primary) {
> > +               rport = drm_dp_mst_get_port_ref_locked(mgr->mst_primary,
> > +                                                      port);
> > +       }
> >         mutex_unlock(&mgr->lock);
> >         return rport;
> >  }
> > --
> > 2.19.1
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> 
-- 
Cheers,
	Lyude Paul

