Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CE9ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C312154B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZtIomkps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C312154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389528AbeIUOry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 10:47:54 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:47071 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732768AbeIUOry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 10:47:54 -0400
Received: by mail-ed1-f67.google.com with SMTP id k14-v6so10083773edr.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 02:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=aV+hg3kAaccrnJcxmP5yva3Jsyr78U9KPBTDO/6rjgI=;
        b=ZtIomkps/+IPvcY8FAR8GPnDjFOfJZasTqGVnfyPaIiBQt77sS352P1O2r+FnumAaz
         GTH23C23I8o2J8lMrdFByW6a2J+eLHHPtJwaD77ZOM2bmnMdu2ZKYv5zS6PDhwGjl/N1
         DFxzODlh3ksoha5SK+s+I4NAmIcTO5cdY3734=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=aV+hg3kAaccrnJcxmP5yva3Jsyr78U9KPBTDO/6rjgI=;
        b=aHjMPYPUhxptOFugd0pOUYPiySFfLjMRYcEzGrnzeqGABScwPoR/Mnf4/XWqNcfXoK
         eFrqF1TqPTxEde/L0l9cIq2FtoWLn14BEfjhy/nhEyEJIr5J5BceqekhYsWEBkfFOTAj
         LNq//KEsX4o0QAYlmKYz31Bsa43YQHMhMepGe7T1Lj+qvz42H2+gUGlWSdTLwkbRXDc+
         pYkZbSYVv+WocdCZu6Y12US7CZ400NNU1TB7WbLALP2v8Ed5cRSrPaURTxi2ovQ4+92x
         54sRutgGz5aS8xnXcgcAZ1ADZz+8Rnk7KbZCuXyBvAiz3Qg8azL55xwrdMaj7nFoB14X
         j1Mw==
X-Gm-Message-State: APzg51Bj7Fa0H9gw9UrtEfXdwemI6/Sd9EnNyn9EgrpXKuVuPeP1iTdv
        UpyE8kT39ltH3Pfkn7envf9u6g+MeTRlwg==
X-Google-Smtp-Source: ANB0Vda4alWxSm1bEoY9OyYKZYTyKU+i4HcD+d/0jXZdoBjEkauquOykQnBiHtuhvVIXfDNxX3AONQ==
X-Received: by 2002:a50:d2d7:: with SMTP id q23-v6mr10265495edg.183.1537520399595;
        Fri, 21 Sep 2018 01:59:59 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id z56-v6sm4057580edz.54.2018.09.21.01.59.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 01:59:58 -0700 (PDT)
Date:   Fri, 21 Sep 2018 10:59:56 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, David Airlie <airlied@linux.ie>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/probe_helper: Don't bother probing when connectors
 are forced off
Message-ID: <20180921085956.GX11082@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20180917174344.22011-1-lyude@redhat.com>
 <20180917175545.GP5565@intel.com>
 <54c01a13f382aacd7cd4d75a642630053f54b8f1.camel@redhat.com>
 <20180917181641.GQ5565@intel.com>
 <8773991abd73242bc4ff27c5f1ac35eaaf40a72c.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8773991abd73242bc4ff27c5f1ac35eaaf40a72c.camel@redhat.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 05:12:04PM -0400, Lyude Paul wrote:
> On Mon, 2018-09-17 at 21:16 +0300, Ville Syrjälä wrote:
> > On Mon, Sep 17, 2018 at 02:10:02PM -0400, Lyude Paul wrote:
> > > On Mon, 2018-09-17 at 20:55 +0300, Ville Syrjälä wrote:
> > > > On Mon, Sep 17, 2018 at 01:43:44PM -0400, Lyude Paul wrote:
> > > > > Userspace asked them to be forced off, so why would we care about what a
> > > > > probe tells us?
> > > > 
> > > > I believe there should be force checks in the callers already.
> > > > Or are we missing some?
> > > 
> > > JFYI, what triggered me to send this patch are these error messages that
> > > come
> > > from nouveau when a hotplug happens on a port that we've forced off:
> > > 
> > > [ 1903.918104] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for DP-
> > > 2
> > > [ 1903.918123] [drm:drm_helper_hpd_irq_event [drm_kms_helper]]
> > > [CONNECTOR:61:DP-2] status updated from disconnected to disconnected
> > > 
> > > That being said; I'm sure there are probably some checks missing, but I
> > > don't
> > > really see the purpose in calling the driver's probe functions at all if
> > > they're
> > > just supposed to return the status we forced.
> > 
> > Digging through my cobweb ridden local git repository I found this:
> > 
> > commit bbd17813a7c7d0210c619365707044d0fb29e3f0
> > Author: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > Date:   Mon Jun 10 15:28:55 2013 +0300
> > 
> >     drm: Ignore forced connectors in drm_helper_hpd_irq_event()
> >     
> >     drm_helper_hpd_irq_event() calls the connector's .detect() function
> >     even for forced connectors. If the returned status doesn't match the
> >     forced status, we will send the hotplug event, causing userspace to
> >     re-probe all the connectors. Eventually we should end up back where
> >     we started when drm_helper_probe_single_connector_modes() overwrites
> >     the connector status with the forced status.
> >     
> >     We can avoid all that pointles work if we just skip forced connectors
> >     in drm_helper_hpd_irq_event().
> >     
> >     Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > 
> > diff --git a/drivers/gpu/drm/drm_crtc_helper.c
> > b/drivers/gpu/drm/drm_crtc_helper.c
> > index ed1334e27c33..4fc2ad76c107 100644
> > --- a/drivers/gpu/drm/drm_crtc_helper.c
> > +++ b/drivers/gpu/drm/drm_crtc_helper.c
> > @@ -1086,6 +1086,10 @@ void drm_helper_hpd_irq_event(struct drm_device *dev)
> >  	mutex_lock(&dev->mode_config.mutex);
> >  	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
> >  
> > +		/* Ignore forced connectors. */
> > +		if (connector->force)
> > +			continue;
> > +
> >  		/* Only handle HPD capable connectors. */
> >  		if (!(connector->polled & DRM_CONNECTOR_POLL_HPD))
> >  			continue;
> > 
> > 
> > I guess I never sent it out.
> 
> Ahhh, to be honest though this patch isn't really enough.
> drm_helper_hpd_irq_event() isn't going to be used by all drivers (I may remove
> some usage of it in nouveau in the near future, even) so I still think it would
> be a better idea to just add this into drm_helper_probe_detect() and
> drm_helper_probe_detect_ctx() so everything gets covered

Atm all connector->force handling is outside of drm_helper_probe_detect. I
guess we could try to push (some) of it into this helper, if that's
useful. There seems to be some duplication already. But adding a redundant
check like you do here feels a bit funky.  Maybe makes more sense in
context of the nouveau stuff you're working on?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
