Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0D0C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794ED21726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="R0AcGvk0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfAVULg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:11:36 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:41715 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAVULf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:11:35 -0500
Received: by mail-yb1-f195.google.com with SMTP id j10so9102880ybj.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 12:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cd/Kll3hrf2nv3O8WApmpzdWK/2k6tmrKzhbGksoZB8=;
        b=R0AcGvk07fM2T8w7VFPbN+e+0Een55XaVTxsFDEjZaTjqwGMKPa/4yezvvS/4hDPGZ
         cBV3GYqpRwrhAMPLJnFoRqa2Llf71KSoqWG27UPEkm0ukpfRRA6IkS9xgMFyo44LnxBG
         82Ca1A2JDXxvCdPgsLYCm03JekgFcX7utFtQGZ175VzszYXrs9aVphHdaPjNX12PCZXS
         OkpjQBzxBO0J70JbEfpFH41sJN1vp3BySPNHxxiCbCvlyujzUdeRgl7x+f2r74ZIgk5o
         dI8SM3lvn5PPpzeF89+DmPazLJO9l4nsPJKmuyC2ZACh95oifKYFRJfs9pp3kccZSgRo
         V2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cd/Kll3hrf2nv3O8WApmpzdWK/2k6tmrKzhbGksoZB8=;
        b=X9buzuBi65ys/Lxqa1eylCxWZl+bpPoESDrLiich8oVJdZ8ajb4PWPBnwlgS7pMM1L
         D+9rqoUJboQQ80qJcmalujWEhIEULsbiWzsmQSrUq9r/GWdL6Nq0ivkR9PT5j/ckf+MP
         OIB//Tzq1BhZvvLcuGeLBTAljlAFPrHek6IOI0iJCkat2vaq2iA84tJhivoqyc+pGWdC
         YbI0zSW89pvzX49tvHtbJJmmdS0ECZ0nAtgWDC+vOVOJ0HVZuYuVYEeoA/5rPQIZ6xnu
         d8N7kOqA9TfSIhPFzgV4xecr+Td+CEAo+tmFfBlvm4z0Pq/cG53aSGiMM1M2gEHnCPNy
         JB3A==
X-Gm-Message-State: AJcUukd0sgVFOHNVew/mYCEgGuMJCyYrqKzMXGEI0lVWRyCOuKe3yJl3
        AIAmuoI5ltIZiOut7e1+3kJ2xA==
X-Google-Smtp-Source: ALg8bN4GwUmuxGTFvb5szYgCGHysFA3fC1P4ceyPFY83naf13mA7tPbaCGkLCHL4zWzOAMruAkeDOA==
X-Received: by 2002:a25:3d07:: with SMTP id k7mr7508060yba.404.1548187893562;
        Tue, 22 Jan 2019 12:11:33 -0800 (PST)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id b11sm7470129ywb.0.2019.01.22.12.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 12:11:32 -0800 (PST)
Date:   Tue, 22 Jan 2019 15:11:32 -0500
From:   Sean Paul <sean@poorly.run>
To:     Jayant Shekhar <jshekhar@codeaurora.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, abhinavk@codeaurora.org,
        robdclark@gmail.com, nganji@codeaurora.org, seanpaul@chromium.org,
        hoegsberg@chromium.org, jsanka@codeaurora.org,
        chandanu@codeaurora.org
Subject: Re: [Freedreno] [v1] drm/msm/dpu: Remove unused enum and comment
 from dpu mdss
Message-ID: <20190122201132.GJ114153@art_vandelay>
References: <1545159233-21580-1-git-send-email-jshekhar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545159233-21580-1-git-send-email-jshekhar@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 12:23:53AM +0530, Jayant Shekhar wrote:
> Remove enum dpu_iommu_domain from dpu mdss as its unused.
> 
> Remove unnecessary comment for variable which is already
> removed.
> 
> Signed-off-by: Jayant Shekhar <jshekhar@codeaurora.org>

Applied to dpu-staging, thanks!

Sean

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> index 68c54d2..1ab8d4a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> @@ -258,12 +258,6 @@ enum dpu_vbif {
>  	VBIF_NRT = VBIF_1
>  };
>  
> -enum dpu_iommu_domain {
> -	DPU_IOMMU_DOMAIN_UNSECURE,
> -	DPU_IOMMU_DOMAIN_SECURE,
> -	DPU_IOMMU_DOMAIN_MAX
> -};
> -
>  /**
>   * DPU HW,Component order color map
>   */
> @@ -358,7 +352,6 @@ enum dpu_3d_blend_mode {
>   * @alpha_enable: whether the format has an alpha channel
>   * @num_planes: number of planes (including meta data planes)
>   * @fetch_mode: linear, tiled, or ubwc hw fetch behavior
> - * @is_yuv: is format a yuv variant
>   * @flag: usage bit flags
>   * @tile_width: format tile width
>   * @tile_height: format tile height
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> _______________________________________________
> Freedreno mailing list
> Freedreno@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/freedreno

-- 
Sean Paul, Software Engineer, Google / Chromium OS
