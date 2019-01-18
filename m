Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E577C5AE5E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF86920823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eLRvCfr9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SpS1WvEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbfARX1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 18:27:53 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37004 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729780AbfARX1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 18:27:53 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A7B136081E; Fri, 18 Jan 2019 23:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547854071;
        bh=OiUV1qeagEbwOeJE3C1sCGOlMM6LWQBJhQHXXsYtRFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eLRvCfr9ftUObVweJ801Yjlv70KT7H2h/exnMXChRnbgm6WjjZBV4WG2YMqj0TruQ
         x0wLIG+pjOkxbn436CozPw4FK+DwVcbnbRZCKditQMIr15cy1805E2BueEHSZP3ZKc
         qLmjOoo0Mgvz3b+96yY7Aj8cejzT6Q0FHgsY8zaA=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CC5B360388;
        Fri, 18 Jan 2019 23:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547854070;
        bh=OiUV1qeagEbwOeJE3C1sCGOlMM6LWQBJhQHXXsYtRFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SpS1WvEKvVoFvCwQhhSk4e3sGGKz/NuiykcYLlyOY8WTJYMZdPcrzDVQa9mc/VaFv
         b0GOva/xJI/8vQKgLp1CO1XULTPNxFVB51FY0OBexEnjlakph0iwzCfzr2q7LU71TT
         zwQ8MBpon+CcohCok8SNflLlData2nsqO+LOvFl8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CC5B360388
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Fri, 18 Jan 2019 16:27:47 -0700
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Evan Green <evgreen@chromium.org>
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
Subject: Re: [PATCH v6] drm/msm/a6xx: Add support for an interconnect path
Message-ID: <20190118232746.GF4140@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Evan Green <evgreen@chromium.org>,
        freedreno@lists.freedesktop.org,
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
        Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Jonathan Marek <jonathan@marek.ca>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
References: <1547843058-27933-1-git-send-email-jcrouse@codeaurora.org>
 <CAE=gft6RWRkSZCOrKu=qqTerfmXRW5_kNt2NG4xdfxtTn6KxYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE=gft6RWRkSZCOrKu=qqTerfmXRW5_kNt2NG4xdfxtTn6KxYA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 03:04:34PM -0800, Evan Green wrote:
> On Fri, Jan 18, 2019 at 12:24 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> >
> > Try to get the interconnect path for the GPU and vote for the maximum
> > bandwidth to support all frequencies. This is needed for performance.
> > Later we will want to scale the bandwidth based on the frequency to
> > also optimize for power but that will require some device tree
> > infrastructure that does not yet exist.
> >
> > v6: use icc_set_bw() instead of icc_set()
> > v5: Remove hardcoded interconnect name and just use the default
> > v4: Don't use a port string at all to skip the need for names in the DT
> > v3: Use macros and change port string per Georgi Djakov
> >
> > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > ---
> >
> >  drivers/gpu/drm/msm/Kconfig             |  1 +
> >  drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 20 ++++++++++++++++++++
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  9 +++++++++
> >  drivers/gpu/drm/msm/msm_gpu.h           |  3 +++
> >  4 files changed, 33 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> > index cf549f1..78c9e5a5 100644
> > --- a/drivers/gpu/drm/msm/Kconfig
> > +++ b/drivers/gpu/drm/msm/Kconfig
> > @@ -5,6 +5,7 @@ config DRM_MSM
> >         depends on ARCH_QCOM || SOC_IMX5 || (ARM && COMPILE_TEST)
> >         depends on OF && COMMON_CLK
> >         depends on MMU
> > +       depends on INTERCONNECT || !INTERCONNECT
> >         select QCOM_MDT_LOADER if ARCH_QCOM
> >         select REGULATOR
> >         select DRM_KMS_HELPER
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > index 5beb83d..c48fe46 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > @@ -2,6 +2,7 @@
> >  /* Copyright (c) 2017-2018 The Linux Foundation. All rights reserved. */
> >
> >  #include <linux/clk.h>
> > +#include <linux/interconnect.h>
> >  #include <linux/pm_opp.h>
> >  #include <soc/qcom/cmd-db.h>
> >
> > @@ -84,6 +85,9 @@ bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu)
> >
> >  static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
> >  {
> > +       struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
> > +       struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> > +       struct msm_gpu *gpu = &adreno_gpu->base;
> >         int ret;
> >
> >         gmu_write(gmu, REG_A6XX_GMU_DCVS_ACK_OPTION, 0);
> > @@ -106,6 +110,12 @@ static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
> >                 dev_err(gmu->dev, "GMU set GPU frequency error: %d\n", ret);
> >
> >         gmu->freq = gmu->gpu_freqs[index];
> > +
> > +       /*
> > +        * Eventually we will want to scale the path vote with the frequency but
> > +        * for now leave it at max so that the performance is nominal.
> > +        */
> > +       icc_set_bw(gpu->icc_path, 0, MBps_to_icc(7216));
> >  }
> >
> >  void a6xx_gmu_set_freq(struct msm_gpu *gpu, unsigned long freq)
> > @@ -705,6 +715,8 @@ int a6xx_gmu_reset(struct a6xx_gpu *a6xx_gpu)
> >
> >  int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
> >  {
> > +       struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> > +       struct msm_gpu *gpu = &adreno_gpu->base;
> >         struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
> >         int status, ret;
> >
> > @@ -720,6 +732,9 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
> >         if (ret)
> >                 goto out;
> >
> > +       /* Set the bus quota to a reasonable value for boot */
> > +       icc_set_bw(gpu->icc_path, 0, MBps_to_icc(3072));
> 
> Does the comment mention boot because this resume call happens during
> init?

Correct. Boot refers to the GMU in this context.

> How come this number is different from the one in __a6xx_gmu_set_freq?

If you never request a bus quota from the kernel the sucker is horribly
painfully slow. I'm not sure if that is just the default reset value of
the registers or if the bootloader is doing something. In any event
the GMU doesn't always initialize if you try to bring it up with the
default bus settings so we set it to a "reasonable" quota for the 
init sequence. I admit I didn't come up with these numbers on my own;
some poor anonymous soul debugged this on the downstream kernel and
I just stole the same parameters.

As for _a6xx_gmu_set_freq() eventually we'll agree on a way to communicate
the bus bandwidth in the opp settings and we'll be able to adjust the quota
based on the frequency to save power so that's why the code is organized the way
it is so that a6xx_gmu_set_freq() won't have to be massively changed later.

> Also, you're setting an average bandwidth of 0, I
> guess you don't know really what your average is, and the hardware is
> fine with that setting. Is that true?

Yes, we only set the instantaneous bandwidth.

> -Evan

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
