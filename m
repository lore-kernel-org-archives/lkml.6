Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F30EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DE02148D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="FnNrJ8cc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DE02148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392127AbeHPSy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 14:54:59 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:38136 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729847AbeHPSy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 14:54:59 -0400
Received: by mail-yb0-f193.google.com with SMTP id d18-v6so793750ybq.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 08:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=peJ+wE5iF2gfMtMWATFxjd4ZanGZeiaq/5iSBGh6K1M=;
        b=FnNrJ8ccO2jMNxoGGj7yNm27vZ7T5vxIL8qdwniuGUeXAVBeDWdX2DqgJYMo1ByKGF
         cNmlsrRZIHH9BkfPzcQvBD2e5mAi9Fu1qQAN/6WidFe0oD0rrh3Kb8aP+/dp61uITkH0
         ataP9ktAPC3mPuGchu6GGRRQdfWrrEDvBKZN3q+Jk1UpfzJ5FFwiqsKTsjfWVMG9+rqy
         haa8hyj+ryGrraLpW1MCGrtClNEnCyC59WUVrRKdOaP9CUP1i2Uym5VLOCm8fgk8LClR
         1M7B5mi1Xmv+yVxQELSbo2zEN0uieS5k6BNqtHodDCC46/gr6MSQ3Mh8d+y21tvMeClV
         iqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=peJ+wE5iF2gfMtMWATFxjd4ZanGZeiaq/5iSBGh6K1M=;
        b=Y9SrNpihc6RRhSVeniTJ9VjalJelyZuRDP85SFo2ZqoadMqaOBqJjdji/JpiWzmDhE
         rf4Mb18lL443pY4VOfXIrX5lIe5NmAfNl//Vv69elel0RLvV4G/7Lal7A7BjF+nS6Enx
         lbNPHysq48KhTPvePAgevxS2cqCMgPemDewHW+ziW21rGTV8UrTgjzdytkVOa3Fsw8lZ
         lI2h7BE2pU16vhH7LKUQBOBln98jKsZ6hOSt7e2zsyBEw1PHQFhocWIxkOArwNuXFE2+
         hTxCnRGAO2ms4z4nkktzce9Uv/eaK501yMsCJz6gapZpwjvS1iHsbaOF83gAxh+oBN3D
         25Cg==
X-Gm-Message-State: AOUpUlG2mRAtkKwOT1st/qq+mtrd290hmUEL5JZ8X/Dwf0mPBkLkdk4W
        Am/NZPYyu46SPDOw68e+erECxw==
X-Google-Smtp-Source: AA+uWPyiTVxlbpqfg2ppz8knZ0mEJBG416gRIwFde2e3euOere9T4Qy9a0zjNBuEI2ia02gky/Ea7g==
X-Received: by 2002:a25:2acd:: with SMTP id q196-v6mr17706818ybq.40.1534434939143;
        Thu, 16 Aug 2018 08:55:39 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id l204-v6sm10325505ywe.50.2018.08.16.08.55.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 08:55:38 -0700 (PDT)
Date:   Thu, 16 Aug 2018 11:55:38 -0400
From:   Sean Paul <sean@poorly.run>
To:     Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: drm-misc: Change seanpaul's email address
Message-ID: <20180816155538.GR164269@art_vandelay>
References: <20180815153604.90152-1-sean@poorly.run>
 <20180816073248.GZ21634@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816073248.GZ21634@phenom.ffwll.local>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 09:32:48AM +0200, Daniel Vetter wrote:
> On Wed, Aug 15, 2018 at 11:35:29AM -0400, Sean Paul wrote:
> > Since chromium.org is now enforcing DMARC, my mails are going to
> > people's spam folders. While this development might be desirable
> > for people I communicate with, it's undesirable for me :-)
> > 
> > Cc: Dave Airlie <airlied@linux.ie>
> > Cc: Gustavo Padovan <gustavo@padovan.org>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Signed-off-by: Sean Paul <sean@poorly.run>
> > ---
> >  MAINTAINERS | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 93f189f0d60d..5eaa1c91d4a4 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4662,7 +4662,7 @@ F:	include/linux/vga*
> >  DRM DRIVERS AND MISC GPU PATCHES
> >  M:	Gustavo Padovan <gustavo@padovan.org>
> >  M:	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > -M:	Sean Paul <seanpaul@chromium.org>
> > +M:	Sean Paul <sean@poorly.run>
> 
> Glorious domain :-)
> 
> Aside: ffwll.ch has been running with dkim since a while, seems to work
> correctly. You just need non-strict dkim enforcement, which at least for
> gapps is the default.
> 
> But even then Linus' gmail inbox throws my mails away every once in a
> while, so email clearly doesn't work.

My (completely incorrect, i'm sure) understanding is that DKIM is fine, but
DMARC is the problem.

It seems Mailman was altering some (or all) of my messages which caused DMARC
to fail. At the very least the "Prevent duplicate messages" setting in mailman
strips users cc from the headers. So if any one of the recipients has this
setting enabled, the headers are munged, DMARC fails, and emails go to spam.

> 
> </rant>
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Thanks, pushed to -misc-next-fixes

Sean

> >  W:	https://01.org/linuxgraphics/gfx-docs/maintainer-tools/drm-misc.html
> >  S:	Maintained
> >  T:	git git://anongit.freedesktop.org/drm/drm-misc
> > -- 
> > Sean Paul, Software Engineer, Google / Chromium OS
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Sean Paul, Software Engineer, Google / Chromium OS
