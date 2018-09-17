Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5D3ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B662086E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B662086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbeIRClL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 22:41:11 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45075 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbeIRClL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 22:41:11 -0400
Received: by mail-qk1-f193.google.com with SMTP id z125-v6so9818282qkb.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 14:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:mime-version
         :content-transfer-encoding;
        bh=9JcuwktUPxGorXIdDuG7FppZmYysYFYmhEz2Cf2OeXQ=;
        b=VkqISfxBcXrWkYjs106aXGMr3HcKYrKoujDV3B+IAebUXX3cf7tLJvQhbjB4Wr6TZi
         GEPx8qpfCx2+jcZ308WufKHIl9ry6o6B8idZcZLVum+TrIi8oshzmsnXY5uOTE4Ycxq8
         HV3sH4zo5OrQQ/XVVRfx6ZiB9W9uuCBs8FQHwYd4TUBraWwq3qD+bUr9Iwz9t22Pwl+V
         PqdV2o78RVw6CkTtnv7VTah53yDsyj3Zjpn/OEja+oOQWeBquzXS71bbI6bQ+LxFQShk
         j75YAdo63vGEYWVvGS67E65tRJQvgC7gIjmXGxSmX/4P2ml88RooH0L8HsoyXrUIv8CB
         T7sg==
X-Gm-Message-State: APzg51C7QGyx7lsgX1qL76mwngUgeI6nbZqcKKJyD0r/R/eM6HaDLnzZ
        TUDkmg1xHKVNxKeS9E2KGiFL6zPDi1E=
X-Google-Smtp-Source: ANB0VdZoM7jPhQXci8bpqqUmg5MbOp+gaYYHxrMToTOh5fKMnOWwi0ua9n01H8PxUjK4LVHRDtkQxA==
X-Received: by 2002:a37:c845:: with SMTP id c66-v6mr17602350qkj.65.1537218726209;
        Mon, 17 Sep 2018 14:12:06 -0700 (PDT)
Received: from whitewolf.lyude.net (pool-72-74-165-95.bstnma.fios.verizon.net. [72.74.165.95])
        by smtp.gmail.com with ESMTPSA id d138-v6sm8765229qke.18.2018.09.17.14.12.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 14:12:05 -0700 (PDT)
Message-ID: <8773991abd73242bc4ff27c5f1ac35eaaf40a72c.camel@redhat.com>
Subject: Re: [PATCH] drm/probe_helper: Don't bother probing when connectors
 are forced off
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Date:   Mon, 17 Sep 2018 17:12:04 -0400
In-Reply-To: <20180917181641.GQ5565@intel.com>
References: <20180917174344.22011-1-lyude@redhat.com>
         <20180917175545.GP5565@intel.com>
         <54c01a13f382aacd7cd4d75a642630053f54b8f1.camel@redhat.com>
         <20180917181641.GQ5565@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-17 at 21:16 +0300, Ville Syrjälä wrote:
> On Mon, Sep 17, 2018 at 02:10:02PM -0400, Lyude Paul wrote:
> > On Mon, 2018-09-17 at 20:55 +0300, Ville Syrjälä wrote:
> > > On Mon, Sep 17, 2018 at 01:43:44PM -0400, Lyude Paul wrote:
> > > > Userspace asked them to be forced off, so why would we care about what a
> > > > probe tells us?
> > > 
> > > I believe there should be force checks in the callers already.
> > > Or are we missing some?
> > 
> > JFYI, what triggered me to send this patch are these error messages that
> > come
> > from nouveau when a hotplug happens on a port that we've forced off:
> > 
> > [ 1903.918104] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for DP-
> > 2
> > [ 1903.918123] [drm:drm_helper_hpd_irq_event [drm_kms_helper]]
> > [CONNECTOR:61:DP-2] status updated from disconnected to disconnected
> > 
> > That being said; I'm sure there are probably some checks missing, but I
> > don't
> > really see the purpose in calling the driver's probe functions at all if
> > they're
> > just supposed to return the status we forced.
> 
> Digging through my cobweb ridden local git repository I found this:
> 
> commit bbd17813a7c7d0210c619365707044d0fb29e3f0
> Author: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Date:   Mon Jun 10 15:28:55 2013 +0300
> 
>     drm: Ignore forced connectors in drm_helper_hpd_irq_event()
>     
>     drm_helper_hpd_irq_event() calls the connector's .detect() function
>     even for forced connectors. If the returned status doesn't match the
>     forced status, we will send the hotplug event, causing userspace to
>     re-probe all the connectors. Eventually we should end up back where
>     we started when drm_helper_probe_single_connector_modes() overwrites
>     the connector status with the forced status.
>     
>     We can avoid all that pointles work if we just skip forced connectors
>     in drm_helper_hpd_irq_event().
>     
>     Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> diff --git a/drivers/gpu/drm/drm_crtc_helper.c
> b/drivers/gpu/drm/drm_crtc_helper.c
> index ed1334e27c33..4fc2ad76c107 100644
> --- a/drivers/gpu/drm/drm_crtc_helper.c
> +++ b/drivers/gpu/drm/drm_crtc_helper.c
> @@ -1086,6 +1086,10 @@ void drm_helper_hpd_irq_event(struct drm_device *dev)
>  	mutex_lock(&dev->mode_config.mutex);
>  	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
>  
> +		/* Ignore forced connectors. */
> +		if (connector->force)
> +			continue;
> +
>  		/* Only handle HPD capable connectors. */
>  		if (!(connector->polled & DRM_CONNECTOR_POLL_HPD))
>  			continue;
> 
> 
> I guess I never sent it out.

Ahhh, to be honest though this patch isn't really enough.
drm_helper_hpd_irq_event() isn't going to be used by all drivers (I may remove
some usage of it in nouveau in the near future, even) so I still think it would
be a better idea to just add this into drm_helper_probe_detect() and
drm_helper_probe_detect_ctx() so everything gets covered

> 

