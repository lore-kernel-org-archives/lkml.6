Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D204AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1322083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="bOrqz2oE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfBUQt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:49:58 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42244 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfBUQt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:49:57 -0500
Received: by mail-ed1-f67.google.com with SMTP id j89so14317265edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 08:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dTS9pwq3iHRUDV7Cxr89LxK3cDhDfWMH8AlxMNhO+Ms=;
        b=bOrqz2oEtxpfT07pNvJNQYq9PeEfumdWU+E0FQ/yUyeGtOLfncc6V42OsmkHlR/x8W
         HFUSQDLQQ7d31+59cDRZ57x7vCezkAL79c/qIV/fwMvSkegQcQSwslBXDmhwBkOc9uZ1
         ysn34jiU7smLuQRKU8MSoQKTWGvcjeH+1kpH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=dTS9pwq3iHRUDV7Cxr89LxK3cDhDfWMH8AlxMNhO+Ms=;
        b=NgbzhnKaF0dkxEE98Ir3TKaR/olNPESSVH2K67wSxFZ4Re91QPmGECYMX+xl3KRxvn
         4mHDSDHhrlGvCHXyOI/ikVzlmWHDvG41ST4w5wJalbzETrnDHxdQc10YTMxgvB8BNfCq
         5rXKQoad+w6k8no0gnSVgvspdpyP7OEX3EL7BqjvOV73sQKcAVqhKP1kK8AO7oKpPih+
         CKciSrfH/iKBOAVF0qOqN77xv1KnTBed8GE/n3Cguiz+igtusb961xE9rPa2gBSH2B8L
         Gur5FQLqtJzhDsbYpH3drHxMSzJUSzjnpryb7RgrNiq/LzA0jCrP8jooAut1OaABJcSG
         SHhw==
X-Gm-Message-State: AHQUAub4+pqIiWeB8joZz9yvqECP+2XQd4lDV3Rqp29UfY7q0w04jfBw
        jVwg/xxem3zpLKk5fV/tBYY3Ww==
X-Google-Smtp-Source: AHgI3IY1Sgok1id+sYcecZaBsEyy4z2xRMlN0uG91s+hBy5QdvABNjMX6Nzd1SI4gzBorPbt7UX0Ig==
X-Received: by 2002:a17:906:1611:: with SMTP id m17mr28283930ejd.237.1550767795453;
        Thu, 21 Feb 2019 08:49:55 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id i14sm4808473ejy.25.2019.02.21.08.49.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 08:49:54 -0800 (PST)
Date:   Thu, 21 Feb 2019 17:49:52 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Liviu Dudau <liviu.dudau@arm.com>
Subject: Re: [PATCH] staging/vboxvideo: Another FIXME item
Message-ID: <20190221164952.GV2665@phenom.ffwll.local>
Mail-Followup-To: Hans de Goede <hdegoede@redhat.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Liviu Dudau <liviu.dudau@arm.com>
References: <20190221155951.19855-1-daniel.vetter@ffwll.ch>
 <33679003-ce23-2ba0-d8c2-fd8187ecea36@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33679003-ce23-2ba0-d8c2-fd8187ecea36@redhat.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 05:40:05PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 21-02-19 16:59, Daniel Vetter wrote:
> > Found while grepping around.
> > 
> > Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Liviu Dudau <liviu.dudau@arm.com>
> > ---
> >   drivers/staging/vboxvideo/vbox_irq.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/staging/vboxvideo/vbox_irq.c b/drivers/staging/vboxvideo/vbox_irq.c
> > index 195484713365..89944134ea86 100644
> > --- a/drivers/staging/vboxvideo/vbox_irq.c
> > +++ b/drivers/staging/vboxvideo/vbox_irq.c
> > @@ -123,6 +123,11 @@ static void vbox_update_mode_hints(struct vbox_private *vbox)
> >   	validate_or_set_position_hints(vbox);
> >   	drm_modeset_lock_all(dev);
> > +	/*
> > +	 * FIXME: this needs to use drm_connector_list_iter and some real
> > +	 * locking for the actual data it changes, not the deprecated
> > +	 * drm_modeset_lock_all() shotgun approach.
> > +	 */
> 
> Question, are the locking expectations from the drm's core pov (for modesetting-drivers)
> *fully* (and clearly) documented somewhere?

All the things I've touched the past few years wrt locking should have
kerneldoc comments explaining the rules. For most drivers you don't need
much if any locking though, because the core+helpers take care of
everything. So yeah exists, but spread thinly around everywhere.

Above is probably fine since you don't hotplug connectors and
modeset_lock_all gives you a good chance you have enough locking.  But
modeset_lock_all is deprecated for atomic drivers, because it makes it
unclear what exactly you're protecting against. The usual BKL considered
harmful reasons. I just noticed that qxl has the same pattern, probably
similarly grown through fairly long history.
-Daniel

> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> >   	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
> >   		vbox_conn = to_vbox_connector(connector);
> > 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
