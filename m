Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B148C5AE5E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E78D2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QjhZlXAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbfARXFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 18:05:16 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41693 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729910AbfARXFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 18:05:16 -0500
Received: by mail-lf1-f67.google.com with SMTP id c16so11649435lfj.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 15:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/K6x1sgeqVJVfiHFK0y8DH1I8j6da/Rzsjk1ZeG7CAo=;
        b=QjhZlXAlp29UqMm4hpwWlSzY6aWdxZXa+RpJmeCn1qVIuKIO9gWdtyExCYYXgqYZqn
         7cjY1+tCcAwN6XIAEssXswio0PF1VzBcXd3rykp8gex/WGSplaoG0GIXhzE4dblaHQjf
         e2qeIV6CYVzt1kjJQVQtM4oifoVVVeFXrS/8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/K6x1sgeqVJVfiHFK0y8DH1I8j6da/Rzsjk1ZeG7CAo=;
        b=coaW0soxJz6JTyOTs5zAupYv1b8Z5VhuqmBsL8k/JS41FRSy5u4pNkNo84LFjjyBfc
         OS9+iLdQDNkMRdw/aPqFwHGpUOCtNa0ui+hm9rTBNz38tsTSek4F873C2BRpmCNBoqFV
         WZlPb6zuNG74yun29LgVCVV9wxT5WK0A+BtRtyM1Kcc8h3BvipxTyg8S0PCnC1aVqemL
         1T442zpv1EefIR3ESHKAAY6MQ8+V1CZLRx78n7D7YoJTbBsKGFFn0yBBdpUfmitaIMpM
         g41cqxqXCUscZ861+BRA2U2NQGwyh2PZqFygEIIsfqQqI4+8/PIRRe2URrrEsqbjFMr8
         jjwQ==
X-Gm-Message-State: AJcUukffJjNOCzbo7mLJbzpv0QDxf0Stp/qyy5upYKJiMELsu/014ONT
        ScM5rSHGNetfNK1H99TT3P33xKIa2V0=
X-Google-Smtp-Source: ALg8bN6IxwD9ZTMQ8qdGDTsIGiVwwHCYbHJgdcYsExz1i9k+fyxOML4VOp+AXrccxicWVaWJoshIvg==
X-Received: by 2002:a19:945b:: with SMTP id w88mr13004789lfd.15.1547852713118;
        Fri, 18 Jan 2019 15:05:13 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id z15-v6sm1074679ljb.9.2019.01.18.15.05.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 15:05:12 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id a8so11660825lfk.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 15:05:11 -0800 (PST)
X-Received: by 2002:a19:1019:: with SMTP id f25mr13494513lfi.54.1547852711182;
 Fri, 18 Jan 2019 15:05:11 -0800 (PST)
MIME-Version: 1.0
References: <1547843058-27933-1-git-send-email-jcrouse@codeaurora.org>
In-Reply-To: <1547843058-27933-1-git-send-email-jcrouse@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 18 Jan 2019 15:04:34 -0800
X-Gmail-Original-Message-ID: <CAE=gft6RWRkSZCOrKu=qqTerfmXRW5_kNt2NG4xdfxtTn6KxYA@mail.gmail.com>
Message-ID: <CAE=gft6RWRkSZCOrKu=qqTerfmXRW5_kNt2NG4xdfxtTn6KxYA@mail.gmail.com>
Subject: Re: [PATCH v6] drm/msm/a6xx: Add support for an interconnect path
To:     Jordan Crouse <jcrouse@codeaurora.org>
Cc:     freedreno@lists.freedesktop.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Colin Ian King <colin.king@canonical.com>,
        Sharat Masetty <smasetty@codeaurora.org>,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Jonathan Marek <jonathan@marek.ca>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 12:24 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> Try to get the interconnect path for the GPU and vote for the maximum
> bandwidth to support all frequencies. This is needed for performance.
> Later we will want to scale the bandwidth based on the frequency to
> also optimize for power but that will require some device tree
> infrastructure that does not yet exist.
>
> v6: use icc_set_bw() instead of icc_set()
> v5: Remove hardcoded interconnect name and just use the default
> v4: Don't use a port string at all to skip the need for names in the DT
> v3: Use macros and change port string per Georgi Djakov
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>
>  drivers/gpu/drm/msm/Kconfig             |  1 +
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 20 ++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  9 +++++++++
>  drivers/gpu/drm/msm/msm_gpu.h           |  3 +++
>  4 files changed, 33 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> index cf549f1..78c9e5a5 100644
> --- a/drivers/gpu/drm/msm/Kconfig
> +++ b/drivers/gpu/drm/msm/Kconfig
> @@ -5,6 +5,7 @@ config DRM_MSM
>         depends on ARCH_QCOM || SOC_IMX5 || (ARM && COMPILE_TEST)
>         depends on OF && COMMON_CLK
>         depends on MMU
> +       depends on INTERCONNECT || !INTERCONNECT
>         select QCOM_MDT_LOADER if ARCH_QCOM
>         select REGULATOR
>         select DRM_KMS_HELPER
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 5beb83d..c48fe46 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -2,6 +2,7 @@
>  /* Copyright (c) 2017-2018 The Linux Foundation. All rights reserved. */
>
>  #include <linux/clk.h>
> +#include <linux/interconnect.h>
>  #include <linux/pm_opp.h>
>  #include <soc/qcom/cmd-db.h>
>
> @@ -84,6 +85,9 @@ bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu)
>
>  static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
>  {
> +       struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
> +       struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> +       struct msm_gpu *gpu = &adreno_gpu->base;
>         int ret;
>
>         gmu_write(gmu, REG_A6XX_GMU_DCVS_ACK_OPTION, 0);
> @@ -106,6 +110,12 @@ static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
>                 dev_err(gmu->dev, "GMU set GPU frequency error: %d\n", ret);
>
>         gmu->freq = gmu->gpu_freqs[index];
> +
> +       /*
> +        * Eventually we will want to scale the path vote with the frequency but
> +        * for now leave it at max so that the performance is nominal.
> +        */
> +       icc_set_bw(gpu->icc_path, 0, MBps_to_icc(7216));
>  }
>
>  void a6xx_gmu_set_freq(struct msm_gpu *gpu, unsigned long freq)
> @@ -705,6 +715,8 @@ int a6xx_gmu_reset(struct a6xx_gpu *a6xx_gpu)
>
>  int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
>  {
> +       struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> +       struct msm_gpu *gpu = &adreno_gpu->base;
>         struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
>         int status, ret;
>
> @@ -720,6 +732,9 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
>         if (ret)
>                 goto out;
>
> +       /* Set the bus quota to a reasonable value for boot */
> +       icc_set_bw(gpu->icc_path, 0, MBps_to_icc(3072));

Does the comment mention boot because this resume call happens during
init? How come this number is different from the one in
__a6xx_gmu_set_freq? Also, you're setting an average bandwidth of 0, I
guess you don't know really what your average is, and the hardware is
fine with that setting. Is that true?
-Evan
