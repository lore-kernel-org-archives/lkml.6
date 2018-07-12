Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D5EC476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4906C2086E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SGaW+XX+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4906C2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbeGLR15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:27:57 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35166 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbeGLR14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:27:56 -0400
Received: by mail-ed1-f67.google.com with SMTP id b10-v6so22466803edi.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 10:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yAAIBTBGddkiVM6XIzTCwX8wAnjI5VL61KDOrokjHCA=;
        b=SGaW+XX+Ik8cSEvjoqa0OTnEc3/aJnL3TQBK9ox0CybKaY/r2QyHzQJ1Ke9tN2nwWI
         MVnKZcORtNKbKdETH1SYigMNhEhbaCG2ooauEXh/khdHrzLWbg4yvpT84/dw0ReEGXfD
         MC6x9lwZanA1GTLEHqtlM/Fp5B1KWgTGC6xHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=yAAIBTBGddkiVM6XIzTCwX8wAnjI5VL61KDOrokjHCA=;
        b=c7vvDwazVjhsLZRcqKpR9qK2hl+oKg2a9h1h5WS1ap+D+HoXT7feNsDw9cr9b5oWlM
         AkN0B+1c7pMdXHg4m+xXX+BXqNR/K9s853xLCAJXuMy/KkVMYrCkC6iBmjF850GyN/Eo
         YeGNwOnlRH80Cvu/k8Drin6T1YXNPMOdml4F4c4bnqWfoJ0gBTiuuenemzo/H36udT7Z
         d7q5cWmgkQPUy6teve9N5GYyu1dOwumN7YDO+A4hMLWoYaYLGekAceuSKUTyWr+NXnsx
         7ukSMvSVlRrSkEEdK4B0aYj3J4KCxNZtV+MnXdqbS3vbJ5ubYOE41VPdBc0s5Shgvfvj
         xmfg==
X-Gm-Message-State: AOUpUlGtfWxrbd+a/KdcrQ7g+RiSZtLBMdULUW5ppktMJJIVao+EqX6x
        QVJXQjVRm4ajHphIQbYAb5xt8A==
X-Google-Smtp-Source: AAOMgpeVhI7lyvxPFM7spefN7PIvBWwAZlxGUJrKyEnToULM3Z02LPyuC9sLgvF8PJxMISwJ5lB7KA==
X-Received: by 2002:aa7:d5d2:: with SMTP id d18-v6mr3561755eds.130.1531415847474;
        Thu, 12 Jul 2018 10:17:27 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id b22-v6sm10869602edn.0.2018.07.12.10.17.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 10:17:26 -0700 (PDT)
Date:   Thu, 12 Jul 2018 19:17:24 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org, Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH v2 3/3] drm/nouveau: Remove bogus crtc check in
 pmops_runtime_idle
Message-ID: <20180712171724.GR3008@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        nouveau@lists.freedesktop.org, Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>
References: <20180712170256.13018-1-lyude@redhat.com>
 <20180712170256.13018-4-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712170256.13018-4-lyude@redhat.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 01:02:54PM -0400, Lyude Paul wrote:
> This both uses the legacy modesetting structures in a racy manner, and
> additionally also doesn't even check the right variable (enabled != the
> CRTC is actually turned on for atomic).
> 
> This fixes issues on my P50 regarding the dedicated GPU not entering
> runtime suspend.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: stable@vger.kernel.org

On both patch 2&3:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

->enable vs. ->active is probably the biggest source of pain in atomic,
and beyond typing even more kerneldoc that will be ignored (there's
another series doing exactly that on the list) I have no idea what to do.
90% rule is to look at ->enable in atomic_check code (since DPMS changes
should always work) and ->active in atomic_commit code.

Wrt the legacy state: For the legacy pointers we can set them to NULL for
atomic, and Ville has done that. That's real effective at stopping drivers
from looking at the wrong thing. But for the others like this one here I
dunno what to do to effectively hide them from atomic drivers.

</rant>

Cheers, Daniel

> ---
>  drivers/gpu/drm/nouveau/nouveau_drm.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index 0f668e275ee1..c7ec86d6c3c9 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -881,22 +881,11 @@ nouveau_pmops_runtime_resume(struct device *dev)
>  static int
>  nouveau_pmops_runtime_idle(struct device *dev)
>  {
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	struct drm_device *drm_dev = pci_get_drvdata(pdev);
> -	struct nouveau_drm *drm = nouveau_drm(drm_dev);
> -	struct drm_crtc *crtc;
> -
>  	if (!nouveau_pmops_runtime()) {
>  		pm_runtime_forbid(dev);
>  		return -EBUSY;
>  	}
>  
> -	list_for_each_entry(crtc, &drm->dev->mode_config.crtc_list, head) {
> -		if (crtc->enabled) {
> -			DRM_DEBUG_DRIVER("failing to power off - crtc active\n");
> -			return -EBUSY;
> -		}
> -	}
>  	pm_runtime_mark_last_busy(dev);
>  	pm_runtime_autosuspend(dev);
>  	/* we don't want the main rpm_idle to call suspend - we want to autosuspend */
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
