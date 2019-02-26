Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD183C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C7721873
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551216658;
	bh=sRpHekf41Wkc4rtWwxgyCQJTsEli1LAI6csERRxBRJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2mWqartqsbt9OjX+73obaPSvwFn9apXv/RSIRPz8Anxr99CNSngMd0DH/wLC0MoK9
	 FigPlKy8d1n7FP82nsmVsNy5dV3k2zaQoZR/witrlUQbjxgid2JKfgUk0NSLrRyscB
	 5KhbdZmbiAovk9tDszFTR0nugoNeCeRXZkU+Xsr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbfBZVa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 16:30:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:34586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728727AbfBZVa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 16:30:56 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAEFA21850;
        Tue, 26 Feb 2019 21:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551216655;
        bh=sRpHekf41Wkc4rtWwxgyCQJTsEli1LAI6csERRxBRJg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RTFVx471pFWYtprxBZEk1Prqn5HyV42FhWLvU1OzRT6+ve7DrgCQlbAnH8RGpVXMY
         EMqYRT7O0cbhgwMUjGyq9jf3V3V/ks5V8ZyLzoLWk653aE4ugKB9kKObt5dN5lCAke
         keo1syzqjOnNzBy8CkpYnjx5oBjDFoxOZXDLewUU=
Date:   Tue, 26 Feb 2019 13:30:54 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vgem: fix use-after-free when
 drm_gem_handle_create() fails
Message-ID: <20190226213053.GC218103@gmail.com>
References: <CACT4Y+bnxrCTD=s9X6+JdjkV_gS=qZ99WhJsWypP88af3HzMhw@mail.gmail.com>
 <20190226204726.92256-1-ebiggers@kernel.org>
 <155121487959.17933.15702334870310780013@skylake-alporthouse-com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155121487959.17933.15702334870310780013@skylake-alporthouse-com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 09:01:29PM +0000, Chris Wilson wrote:
> Quoting Eric Biggers (2019-02-26 20:47:26)
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > If drm_gem_handle_create() fails in vgem_gem_create(), then the
> > drm_vgem_gem_object is freed twice: once when the reference is dropped
> > by drm_gem_object_put_unlocked(), and again by __vgem_gem_destroy().
> > 
> > This was hit by syzkaller using fault injection.
> > 
> > Fix it by skipping the second free.
> > 
> > Reported-by: syzbot+e73f2fb5ed5a5df36d33@syzkaller.appspotmail.com
> > Fixes: 5ba6c9ff961a ("drm/vgem: Fix mmaping")
> 
> That's the wrong fixes line, it's
> Fixes: af33a9190d02 ("drm/vgem: Enable dmabuf import interfaces")
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> Sadly I reviewed it so I'm still culpable, but the fix is correct as the
> put purposely frees it on error.
> 

You're right; I misread the code at that commit.
I'll resend with the correct tags.

> > Cc: stable@vger.kernel.org
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> > ---
> >  drivers/gpu/drm/vgem/vgem_drv.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
> > index 5930facd6d2d8..70646d9da1596 100644
> > --- a/drivers/gpu/drm/vgem/vgem_drv.c
> > +++ b/drivers/gpu/drm/vgem/vgem_drv.c
> > @@ -189,15 +189,13 @@ static struct drm_gem_object *vgem_gem_create(struct drm_device *dev,
> >                 return ERR_CAST(obj);
> >  
> >         ret = drm_gem_handle_create(file, &obj->base, handle);
> > +
> >         drm_gem_object_put_unlocked(&obj->base);
> > +
> 
> The pattern in the other GEM drivers is not to have these extra
> newlines.
> 
> Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
> 
> >         if (ret)
> > -               goto err;
> > +               return ERR_PTR(ret);
> >  
> >         return &obj->base;
> > -
> > -err:
> > -       __vgem_gem_destroy(obj);
> > -       return ERR_PTR(ret);
> >  }
> >  
> >  static int vgem_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
> > -- 
> > 2.21.0.rc2.261.ga7da99ff1b-goog
> > 
