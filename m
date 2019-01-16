Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48AEC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800CA20859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="C4NHT6Pg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404256AbfAPNVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:21:47 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42476 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393175AbfAPNVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:21:46 -0500
Received: by mail-ed1-f68.google.com with SMTP id y20so5360211edw.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 05:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xbHpzTokusgalm/0iOQJVfLtqZdOjyIUIWDBI+0BAs4=;
        b=C4NHT6PgSSBLiEt9sEdkonFKKDhKK8/CYrG1W0CNUhxSbIdg1zmwlFmNjOPQ4loOmq
         UHIsnxiGFhuwfBDytX51xWDkI5zT2b7SL5wtkcNKpfZEz+FMweNS/iMkLw0idBRrb61C
         bsdsWdpifNNWgSICVMYv9DEODnLbEHAQn2Gek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=xbHpzTokusgalm/0iOQJVfLtqZdOjyIUIWDBI+0BAs4=;
        b=V72vwY8MnskDOFgxfo83KaP/2u+lCmA5jl6Pmr79mTV9dHivvggzryBpkSI63s9XTR
         zsM/vP6tJJviVVVhUaPd/NtVKZwXEkBrBczAHzojO8b4gAve0tQUxlUby3SRWTTWrLlE
         00CAUZJl9yVTZKgRJk5Njd7MEotEvfKVES+A4V3Gu4pTmIWIGQ2HGQTGdypb6rSwYHLe
         A6wKN1yjxJhbvJ/ev6sYaetWhnnzcfSLJx6IC4tnOYPxwjlI245QSAVPVwuxUzIiYsMY
         WfsEa+gkKW6MvKgvDpoCRH2CwqKJfKEzWIZIjBFQTFx6C380UcwOIBdmiLKawZ8A26n8
         Pv8w==
X-Gm-Message-State: AJcUukfMJnqj/l8JieHFECD/8XQA+pcCCAq7DtuGQIrFRAfE+CNvKOsn
        FrOARA1/qPQr6HG+8pkAuvPRcQ==
X-Google-Smtp-Source: ALg8bN6voaz9DD0VIPiw7I4o1J2o4Iy0lXwyhCO8Dji626zJo8Q0XV7UYRc/tz3fYO2bgCBU5dBmlg==
X-Received: by 2002:a50:ac19:: with SMTP id v25mr7546875edc.218.1547644904360;
        Wed, 16 Jan 2019 05:21:44 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id f35sm5869952edd.80.2019.01.16.05.21.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 05:21:43 -0800 (PST)
Date:   Wed, 16 Jan 2019 14:21:41 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Frediano Ziglio <fziglio@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [Spice-devel] [PATCH 1/3] drm/qxl: add mode/framebuffer check
 functions
Message-ID: <20190116132141.GX10517@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        Frediano Ziglio <fziglio@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
References: <20190116083521.22673-1-kraxel@redhat.com>
 <20190116083521.22673-2-kraxel@redhat.com>
 <636470684.58090538.1547630691403.JavaMail.zimbra@redhat.com>
 <20190116112800.v73xmxedt4b3gktj@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116112800.v73xmxedt4b3gktj@sirius.home.kraxel.org>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 12:28:00PM +0100, Gerd Hoffmann wrote:
> > > +static int qxl_check_mode(struct qxl_device *qdev,
> > > +			  unsigned int width,
> > > +			  unsigned int height)
> > > +{
> > > +	if (width * height * 4 > qdev->vram_size)
> > 
> > Is someone checking for integer overflows already?
> 
> Need to have a look.  This is just ...

The addfb ioctl checks for integer overflows for you.
-Daniel

> 
> > > -	if (bo->surf.stride * bo->surf.height > qdev->vram_size) {
> > > -		DRM_ERROR("Mode doesn't fit in vram size (vgamem)");
> > > -		return -EINVAL;
> > > -	}
> 
> ... that check moved into the new function.
> 
> cheers,
>   Gerd
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
