Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C1DC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1B32098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q1HGTmfo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1B32098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbeJRUHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 16:07:00 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41145 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbeJRUHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 16:07:00 -0400
Received: by mail-ot1-f66.google.com with SMTP id c32so29479420otb.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 05:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n+K43WPR+neDVJD7aQ8qArYYHZs7oftfWLvp6tW4k2Q=;
        b=Q1HGTmfoF9XIW5zCIRWbuXi6dzra0MohMt7P2rQy4FzT6AWhCm1dezF9FK6fh0G+Ew
         QNj2k2o6a9kjeSZbqxshDArQfVHMZXxNsdb7nFwoTGvh9aDv+g0sQs8FTFJtG6mhK+cM
         UrwGOU2BYllxNfl9sBnJfcG1Eje48BeOOtIVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n+K43WPR+neDVJD7aQ8qArYYHZs7oftfWLvp6tW4k2Q=;
        b=GELlhxuFDfYKmXA3+TMVJdp7s69pbIEG9gEKhgcaU38y+HN0MrL5lgsHGEzBPz+rHf
         BYksqjf+ohrAuWJX9FseMJmxbPOi4x9F8ym6cCKY994+dn7I05PgvvMlWPNJRFjsPAsR
         uQ57O0X4Aw1lGEj8tiPyFqOK6gVTvsJnlEEKPAdoqb7UuKXq7Jasn/O53hCEgCVEx6Q+
         KTYz2VBnwxc2FAZN1CoGa1IR9mMIj2ou0FqAn1Qt8hljbXwPD9k/bY70pkfrTapVvHj0
         lXjg/nnoBY+fE4flVmiOH5W4XiSnhBJcyYj/wgZ0wmlZpwCuMl0bTlT+7VUXVMH5Wp3t
         7PjA==
X-Gm-Message-State: ABuFfogR5yK4pcSyOogYLxtWsLaETxJwe5zZMgod2JXkSqkVK92FFD4i
        wk7ECarBrJmM97D2fABmmqDlG3L5xBK24SAF/p82yw==
X-Google-Smtp-Source: ACcGV62YwKlsW3SbuhfKUyot2CL0/DbAgWgrpeIg9hr+IPdHv3KXnL1OfcCmVASl6n3UkNiOPh/+bDUTMZZwc/z8DHk=
X-Received: by 2002:a9d:48f1:: with SMTP id a46mr20290255otj.84.1539864377363;
 Thu, 18 Oct 2018 05:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20181012094639.1585-1-benjamin.gaignard@linaro.org>
In-Reply-To: <20181012094639.1585-1-benjamin.gaignard@linaro.org>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Thu, 18 Oct 2018 14:06:06 +0200
Message-ID: <CA+M3ks5-jsDuusbueNTZ+QHQn0bG2Ly1b4VrYHE6H9Pe_HQqhA@mail.gmail.com>
Subject: Re: [PATCH] drm/sti: make crct disable atomic
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven. 12 oct. 2018 =C3=A0 11:47, Benjamin Gaignard
<benjamin.gaignard@linaro.org> a =C3=A9crit :
>
> Wait until the next vblank to be sure that crtc has been disabled.
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Applied on drm-misc-next

> ---
>  drivers/gpu/drm/sti/sti_crtc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/sti/sti_crtc.c b/drivers/gpu/drm/sti/sti_crt=
c.c
> index 5824e6aca8f4..61c2379fba87 100644
> --- a/drivers/gpu/drm/sti/sti_crtc.c
> +++ b/drivers/gpu/drm/sti/sti_crtc.c
> @@ -40,6 +40,8 @@ static void sti_crtc_atomic_disable(struct drm_crtc *cr=
tc,
>         DRM_DEBUG_DRIVER("\n");
>
>         mixer->status =3D STI_MIXER_DISABLING;
> +
> +       drm_crtc_wait_one_vblank(crtc);
>  }
>
>  static int
> --
> 2.15.0
>


--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
