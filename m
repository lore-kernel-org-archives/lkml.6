Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC5CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F0F21850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbfBZVBj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 16:01:39 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:49719 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728303AbfBZVBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 16:01:39 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 15710755-1500050 
        for multiple; Tue, 26 Feb 2019 21:01:31 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Eric Biggers <ebiggers@kernel.org>,
        dri-devel@lists.freedesktop.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190226204726.92256-1-ebiggers@kernel.org>
Cc:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-kernel@vger.kernel.org
References: <CACT4Y+bnxrCTD=s9X6+JdjkV_gS=qZ99WhJsWypP88af3HzMhw@mail.gmail.com>
 <20190226204726.92256-1-ebiggers@kernel.org>
Message-ID: <155121487959.17933.15702334870310780013@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] drm/vgem: fix use-after-free when drm_gem_handle_create() fails
Date:   Tue, 26 Feb 2019 21:01:29 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric Biggers (2019-02-26 20:47:26)
> From: Eric Biggers <ebiggers@google.com>
> 
> If drm_gem_handle_create() fails in vgem_gem_create(), then the
> drm_vgem_gem_object is freed twice: once when the reference is dropped
> by drm_gem_object_put_unlocked(), and again by __vgem_gem_destroy().
> 
> This was hit by syzkaller using fault injection.
> 
> Fix it by skipping the second free.
> 
> Reported-by: syzbot+e73f2fb5ed5a5df36d33@syzkaller.appspotmail.com
> Fixes: 5ba6c9ff961a ("drm/vgem: Fix mmaping")

That's the wrong fixes line, it's
Fixes: af33a9190d02 ("drm/vgem: Enable dmabuf import interfaces")
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>

Sadly I reviewed it so I'm still culpable, but the fix is correct as the
put purposely frees it on error.

> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@google.com>

> ---
>  drivers/gpu/drm/vgem/vgem_drv.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
> index 5930facd6d2d8..70646d9da1596 100644
> --- a/drivers/gpu/drm/vgem/vgem_drv.c
> +++ b/drivers/gpu/drm/vgem/vgem_drv.c
> @@ -189,15 +189,13 @@ static struct drm_gem_object *vgem_gem_create(struct drm_device *dev,
>                 return ERR_CAST(obj);
>  
>         ret = drm_gem_handle_create(file, &obj->base, handle);
> +
>         drm_gem_object_put_unlocked(&obj->base);
> +

The pattern in the other GEM drivers is not to have these extra
newlines.

Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>

>         if (ret)
> -               goto err;
> +               return ERR_PTR(ret);
>  
>         return &obj->base;
> -
> -err:
> -       __vgem_gem_destroy(obj);
> -       return ERR_PTR(ret);
>  }
>  
>  static int vgem_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
> -- 
> 2.21.0.rc2.261.ga7da99ff1b-goog
> 
