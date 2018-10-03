Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF30C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B54213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="NYdw5n5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B54213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbeJCQBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 12:01:46 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41957 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeJCQBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 12:01:45 -0400
Received: by mail-ed1-f68.google.com with SMTP id f38-v6so4647312edd.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 02:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=U/v++O4Fp8FMAXDS06EdJEZBug3Y5Dw8P2Zp1+Tq25o=;
        b=NYdw5n5cXMTIAUoAeZu4rQDXHFIs/CdBNQxs/7TFaHpVQB9JQxEFT8VJQ91gwUCT+/
         vsNvNqR+E1rJpgT/Hgbyr4/aSt/4x41de9jEbu3i07zvYE5k6/gEfs8ZLifbLz6VackA
         5pgV1zNms9oN1w4ef7UfpTRNMVPTPup5sBlB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=U/v++O4Fp8FMAXDS06EdJEZBug3Y5Dw8P2Zp1+Tq25o=;
        b=Gx0aFMFREijtvWymFkoe8kInlAkQtLnCNjIZdLn2K0boY5Z12+qzfKUdrZLtQUeChj
         nqDdlroTUSg3D13DZaaiJzK0Q6rKf6hdyHAHhkgBtKuE2FcYJ3DiuqxBJCVi0aqCoFXI
         uPV2rqTQg6Pinl9K/5oSfYagKdDfdIOBtJixn+f0neSBhKd0WXbdHhYROAnjltgb4eGv
         Fd2hnWmFbM0IpDdJot1PGDqKNrqeXHkv2DyDcN4X7L+Y7/l+iSVBxf399ftMISWG9MJm
         yC2oC37TMr/htc+gMYrm+IgF+q9WNFGwmrnrouVVYCQw9pksKubuNCr2w04l/J4Xpdim
         Nakw==
X-Gm-Message-State: ABuFfohjCtIqQdpncaOdG/yEavTcm5wVHSIKr4JeRNFBSfNkShWxsAQh
        qhSXjjcOu8ipAe4nj3uHNLp9+A==
X-Google-Smtp-Source: ACcGV63b4kbM6JRvozMsYVsmGa3+SuobJt9f4s8aGhfjqwvv525E2PLfwS5x+O9N7QxK8iCrv9Knkw==
X-Received: by 2002:a50:eb42:: with SMTP id z2-v6mr1222307edp.126.1538558053339;
        Wed, 03 Oct 2018 02:14:13 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id l12-v6sm320479edn.77.2018.10.03.02.14.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 02:14:12 -0700 (PDT)
Date:   Wed, 3 Oct 2018 11:14:10 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        sean@poorly.run, airlied@linux.ie, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/edid: Add 6 bpc quirk for BOE panel in HP Pavilion
 15-n233sl
Message-ID: <20181003091410.GE23685@phenom.ffwll.local>
Mail-Followup-To: Kai-Heng Feng <kai.heng.feng@canonical.com>,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        sean@poorly.run, airlied@linux.ie, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20181002152911.4370-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002152911.4370-1-kai.heng.feng@canonical.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 11:29:11PM +0800, Kai-Heng Feng wrote:
> There's another panel that reports "DFP 1.x compliant TMDS" but it
> supports 6bpc instead of 8 bpc.
> 
> Apply 6 bpc quirk for the panel to fix it.
> 
> BugLink: https://bugs.launchpad.net/bugs/1794387
> Cc: <stable@vger.kernel.org> # v4.8+
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied to drm-misc-fixes, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/drm_edid.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 3c9fc99648b7..1e2b9407c8d0 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -113,6 +113,9 @@ static const struct edid_quirk {
>  	/* AEO model 0 reports 8 bpc, but is a 6 bpc panel */
>  	{ "AEO", 0, EDID_QUIRK_FORCE_6BPC },
>  
> +	/* BOE model on HP Pavilion 15-n233sl reports 8 bpc, but is a 6 bpc panel */
> +	{ "BOE", 0x78b, EDID_QUIRK_FORCE_6BPC },
> +
>  	/* CPT panel of Asus UX303LA reports 8 bpc, but is a 6 bpc panel */
>  	{ "CPT", 0x17df, EDID_QUIRK_FORCE_6BPC },
>  
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
