Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDB5C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B8520651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="gOeBRU9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbfAOMMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:12:33 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44299 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbfAOMMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:12:32 -0500
Received: by mail-ed1-f67.google.com with SMTP id y56so2322197edd.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 04:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZgPKVk6nM5Y2qkjI2PDlif2sYTNPVusmcRMElQHa3lk=;
        b=gOeBRU9ziHFzyVv6G83cjRzxqQCnB4/mp4IIcbzDvI+npZs8yqHu3y+gMcRI3wXYlY
         6dL58FoWfOqQaUgVCbdytjHA3govC3WLJEznbGnhS4ERiApx6o3ZGy4eO7DgFhjNxM6v
         3cKMNnA3+BB8RVe4YcQlg3x6YoyCYo8xSCens=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ZgPKVk6nM5Y2qkjI2PDlif2sYTNPVusmcRMElQHa3lk=;
        b=nDeidgUo8I+lU7FeG9dxXOu+aRAKOZ5cpIIhWrF8l7yi1CYRK7N8u47C08Tz42uQFq
         XAUY9vCfmz5twNnd0dYU2Wmou0q1WaGL4F0mb/lYm2ywCW2Ihx70fy+8kxVtyobbT3mZ
         6x0qF6MCjdQFE/RB2sxV54zGMbvIT19LQfKVbscEZWqGlctJI8J1btw182ZKVbFgF393
         3V1rSdCdVeipD4lalfY7MiKE20BQvscO+UoUwuDZhor7riSk+5wOjO+jEbRZC0KYp1V4
         tdw3DmJJRapcFI4JMEQY49wAbAD3d1LqJIZz8t/wud5UT2V59SJO8JPKoO/i+vcyd69E
         OaGQ==
X-Gm-Message-State: AJcUukfdWEpS4WNIiF64suvkaYsu54V5Ml2CVnH6jj300uQGy+DmCeli
        TcelM7aJVtARlk0sSAxBR+qPgg==
X-Google-Smtp-Source: ALg8bN4JW6jOo9YFjxxjJH9OIJkaZ/72Q/VJCxviGSqxrI4BAry673WikiqaGMoDG3x14Q6Y5QLNyA==
X-Received: by 2002:a17:906:8242:: with SMTP id f2-v6mr1420639ejx.125.1547554351076;
        Tue, 15 Jan 2019 04:12:31 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id p7-v6sm2824913ejx.27.2019.01.15.04.12.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 04:12:30 -0800 (PST)
Date:   Tue, 15 Jan 2019 13:12:28 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>
Subject: Re: [PATCH 1/2] staging/vboxvideo: Don't set
 FBINFO_MISC_ALWAYS_SETPAR
Message-ID: <20190115121228.GO10517@phenom.ffwll.local>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>
References: <20190115102755.16183-1-daniel.vetter@ffwll.ch>
 <20190115103829.GC18959@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115103829.GC18959@kroah.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 11:38:29AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 15, 2019 at 11:27:54AM +0100, Daniel Vetter wrote:
> > It's a debug hack flag useful to work around driver bugs. That's not a
> > good idea for a new driver. Especially for a new drm driver.
> > 
> > Aside: the fbdev support should probably be converted over to the new
> > generic fbdev support.
> > 
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: Alexander Kapshuk <alexander.kapshuk@gmail.com>
> > ---
> >  drivers/staging/vboxvideo/vbox_fb.c | 5 -----
> >  1 file changed, 5 deletions(-)
> > 
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Since Hans wants to destage vboxvideo this cycle probably best I merge
this through drm-misc? Just to make sure it's not lost.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
