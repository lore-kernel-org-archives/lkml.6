Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCF7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E131B2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="XYIa6rhz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389212AbfAPKFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:05:37 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37323 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbfAPKFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:05:36 -0500
Received: by mail-io1-f67.google.com with SMTP id g8so4445467iok.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 02:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DUcMizAb80A83T170uqM3P6SS4+ASh9AKjkRYTOOI14=;
        b=XYIa6rhzXlR1MlUM/2wnIaWWyyQj8hgRMvpr84/uvXHKWmxI1Rmz7VTLogKZ0K2kXR
         j2uWMWPX+JF5vUINQefPQeH73OyaFsoL3hw8v+o6cGMsSvzQUwcArH4dfPc6OAz2C//N
         5AojzGawP4bvfPceCrtaVHKXkCfIbzhvV4ZPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DUcMizAb80A83T170uqM3P6SS4+ASh9AKjkRYTOOI14=;
        b=Nk7TJvU+efhePW5vLRN3IQjNjHzrrsRvPyUMKfoObRPgxHoRfy48BZMCxWWbeTUAxq
         C00etRO/4Ga0DC9u1dslNG96C2BCUUZdtGiavN5q4L/nYbJBzoNgDCE6RpZZ7nsLFIAl
         s2uabO51UY+SdSt96eiIp89hqrZ20ou1cKruW9igKladzVDJz1K/VAssyYudQiKBd9Dt
         UMSifRkzsjTTH3Vd5mDAKClDnoTmWtHeQDSXnYX1QwuObjPrhsIJdLLSHQto545HvdJT
         haOakbDwYDWuVINKw6S2YkI7d9F0kBnzhPAwU3wMGp1sQNbpuRfNfMkgW+gD9NgrPSqC
         CiMw==
X-Gm-Message-State: AJcUukcv5+xMVJ9OHNSlx5INeWvYvT7H9gOcWedbvCDPpHwIuRbbls5D
        yHj8vKOEYcagHs1mrU1c8D9wvz21J2fjL1QreikoaQ==
X-Google-Smtp-Source: ALg8bN7b5KyTuTSp0Nhmc8mUWERXdCNrjT48gqFTIQvzxQsarykEYqtL/f4xuy06i38Lzo/voGcg1qHNytveG91+dPM=
X-Received: by 2002:a6b:4001:: with SMTP id k1mr4795629ioa.34.1547633135775;
 Wed, 16 Jan 2019 02:05:35 -0800 (PST)
MIME-Version: 1.0
References: <20190115102755.16183-1-daniel.vetter@ffwll.ch>
 <20190115103829.GC18959@kroah.com> <20190115121228.GO10517@phenom.ffwll.local>
 <20190115134553.GD30742@kroah.com> <20190115151549.GP10517@phenom.ffwll.local>
 <20190115153209.GA3810@kroah.com>
In-Reply-To: <20190115153209.GA3810@kroah.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 16 Jan 2019 11:05:24 +0100
Message-ID: <CAKMK7uGQTL5JJqMa9H4h7X5OCLX7aJPsYw6FbQZ9Dnd9qqSOCA@mail.gmail.com>
Subject: Re: [PATCH 1/2] staging/vboxvideo: Don't set FBINFO_MISC_ALWAYS_SETPAR
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 4:32 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jan 15, 2019 at 04:15:49PM +0100, Daniel Vetter wrote:
> > On Tue, Jan 15, 2019 at 02:45:53PM +0100, Greg Kroah-Hartman wrote:
> > > On Tue, Jan 15, 2019 at 01:12:28PM +0100, Daniel Vetter wrote:
> > > > On Tue, Jan 15, 2019 at 11:38:29AM +0100, Greg Kroah-Hartman wrote:
> > > > > On Tue, Jan 15, 2019 at 11:27:54AM +0100, Daniel Vetter wrote:
> > > > > > It's a debug hack flag useful to work around driver bugs. That's not a
> > > > > > good idea for a new driver. Especially for a new drm driver.
> > > > > >
> > > > > > Aside: the fbdev support should probably be converted over to the new
> > > > > > generic fbdev support.
> > > > > >
> > > > > > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > Cc: Hans de Goede <hdegoede@redhat.com>
> > > > > > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > > > > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > > > > Cc: Alexander Kapshuk <alexander.kapshuk@gmail.com>
> > > > > > ---
> > > > > >  drivers/staging/vboxvideo/vbox_fb.c | 5 -----
> > > > > >  1 file changed, 5 deletions(-)
> > > > > >
> > > > >
> > > > > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > >
> > > > Since Hans wants to destage vboxvideo this cycle probably best I merge
> > > > this through drm-misc? Just to make sure it's not lost.
> > >
> > > Feel free to do so!
> >
> > Applied, thanks for your review.
> >
> > I think 2/2 is directly staging material for you (somehow
> > get_maintainers.pl didn't add you to the cc: list, not sure why ...).
>
> Can you resend it, I don't see it anywhere...

resent with you added explicitly to the Cc: list, it's

Subject: [PATCH] staging/xgifb: Needs to be converted to a drm driver
Date: Wed, 16 Jan 2019 11:04:40 +0100
Message-Id: <20190116100440.10071-1-daniel.vetter@ffwll.ch>

Cheers, Daniel

> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
