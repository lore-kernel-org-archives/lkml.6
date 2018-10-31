Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E62AC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF71B20685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="e1XXRFP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF71B20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeJaSse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:48:34 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42749 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbeJaSsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:48:33 -0400
Received: by mail-ed1-f68.google.com with SMTP id b7-v6so13035353edd.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 02:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pWBPAPUCerHExLmV17rkZPmN4Migybs7RpwxuO6c4v4=;
        b=e1XXRFP3Ei7qH3iHkdkpFiyVGFQEJ/Dh6mHBI995tTcAivc1C4W5mbe1i/PYX+GiLe
         vAQRwe6g53alz1AfPQndohp0Juxa8NSvSFMtf+xnacoaWXZc/NkWTL1n4FwyIXFFSAvt
         SAPlaKWgoeaY72coZZF8bXHu2xZSdevpxztDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=pWBPAPUCerHExLmV17rkZPmN4Migybs7RpwxuO6c4v4=;
        b=Zwx7KfeYIEgjK8ZXvN0vgrWM3Y2ATEXmHHHUndE5RWV6FkBpDD+LqR6OROWx3mJPGo
         pz8b01DSgmOx/kYTO3GG6Rgsx22m10Mui2G1nO3B8yGHqPR6xxuFqxw+F62q4wueVMus
         f9vH3XFPZRnnyWALRmDt6v2a0XhVp5nqewLs06lGQ1XHfZN2jpP+RjihmoXB/TBJG+7d
         o47ySq8Oa3PZF6lvy/FbEGcqOmVoJD7CSOfKvXiPdIpoapBbKW9hV2NTtxuMiC59OXpR
         tetl4PCkqKdPYO5Fg7lAZYQPJFnBDJ5SyPzs7SedusXamduPlTNLo+wbjkten2SylBV/
         qohw==
X-Gm-Message-State: AGRZ1gLqHIIZTg4B/zPok/ObSldkdKmGbbZJ0QlamMBZXpPyoKlYHBlt
        Y5vCX08y2Ij7VIiz4mRzHKYhvA==
X-Google-Smtp-Source: AJdET5dKVsRGSQE/cTm81+HnZOH8RrCMJ5K6KoY4tfC9ixFy8M1KkbdNQT+5dQOERAgEwDmjmWbP4Q==
X-Received: by 2002:a50:9a81:: with SMTP id p1-v6mr1484541edb.112.1540979467767;
        Wed, 31 Oct 2018 02:51:07 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t19-v6sm8327039edd.68.2018.10.31.02.51.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 02:51:05 -0700 (PDT)
Date:   Wed, 31 Oct 2018 10:51:03 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Haneen Mohammed <hamohammed.sa@gmail.com>
Cc:     Sean Paul <sean@poorly.run>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] MAINTAINERS: Add entry for VKMS
Message-ID: <20181031095103.GU21967@phenom.ffwll.local>
Mail-Followup-To: Haneen Mohammed <hamohammed.sa@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20181022012701.7a2rkmot2bj37xfb@smtp.gmail.com>
 <20181022123142.GE154175@art_vandelay>
 <20181030231227.GA10773@haneenDRM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030231227.GA10773@haneenDRM>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 02:12:27AM +0300, Haneen Mohammed wrote:
> On Mon, Oct 22, 2018 at 08:31:42AM -0400, Sean Paul wrote:
> > On Sun, Oct 21, 2018 at 10:27:01PM -0300, Rodrigo Siqueira wrote:
> > > Add maintainers and reviewers for VKMS driver
> > > 
> > > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > 
> > Acked-by: Sean Paul <sean@poorly.run>
> > 
> 
> Reviewed-by: Haneen Mohammed <hamohammed.sa@gmail.com>

Rodrigo, are you all set up with commit rights for drm-misc now?
-Daniel

> 
> > > ---
> > > Changes in v2:
> > >   - Insert the section in alphabetical order
> > > 
> > >  MAINTAINERS | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 39c3f6682ace..56572f0968ce 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -4733,6 +4733,16 @@ S:	Odd Fixes
> > >  F:	drivers/gpu/drm/udl/
> > >  T:	git git://anongit.freedesktop.org/drm/drm-misc
> > >  
> > > +DRM DRIVER FOR VIRTUAL KERNEL MODESETTING (VKMS)
> > > +M:	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > > +R:	Haneen Mohammed <hamohammed.sa@gmail.com>
> > > +R:	Daniel Vetter <daniel@ffwll.ch>
> > > +T:	git git://anongit.freedesktop.org/drm/drm-misc
> > > +S:	Maintained
> > > +L:	dri-devel@lists.freedesktop.org
> > > +F:	drivers/gpu/drm/vkms/
> > > +F:	Documentation/gpu/vkms.rst
> > > +
> > >  DRM DRIVER FOR VMWARE VIRTUAL GPU
> > >  M:	"VMware Graphics" <linux-graphics-maintainer@vmware.com>
> > >  M:	Sinclair Yeh <syeh@vmware.com>
> > > -- 
> > > 2.19.1
> > > 
> > 
> > -- 
> > Sean Paul, Software Engineer, Google / Chromium OS

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
