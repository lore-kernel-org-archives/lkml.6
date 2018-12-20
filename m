Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6769FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CD0218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b76zvRHu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387581AbeLTTeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 14:34:15 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:35261 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729825AbeLTTeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 14:34:14 -0500
Received: by mail-ua1-f66.google.com with SMTP id d2so950833ual.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 11:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wSgF32GgudHEHzGZDuRsuOoMJp9dJetEXkqrIYMfTO8=;
        b=b76zvRHuMfq66HK2UcmG94k5oqgheep2w0e4DgyzmFb7cMZPQPHA0XMd2IdpaOA/Ch
         Cs8MFZMQE4g837a/0G5+UglTxhYmlj5INUgMZ8dmYx+44mFqozjQeTuDA8pwRE639tgG
         7W2ZKl5CZahZqs4ElBPuuew7/h9c1TjaSfAUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wSgF32GgudHEHzGZDuRsuOoMJp9dJetEXkqrIYMfTO8=;
        b=dWq1MLBJ4fC4P2Cf07+kaTJMXVrERsaqioOxboVU1oElLr43navBx7lmVzrvL6bnW0
         TAQ7yEPgUiQOGL20glSele84aRIi7XTJtEchcjZbVxuLZ314lU1D5KTGYyVR3lYDaxx4
         mPkjsKhxcUtl7fciHLDsB7HoL6V0ZtQ9sLTCxZ5qePL+XASaMQW4yIIbXrug0beFoD2g
         FalikuIuNnIq/WFPQhLEyABlrF92208usZGQ7+cE00UH4Vjb5E8HVHg0uylNDRbXMLej
         VsLUMh9ervPDf97PDOWS5QbxyY1a7VSchQxAHqkkxDt1vs6fiMWJmEsd7zVzPqv5kwXe
         nKGQ==
X-Gm-Message-State: AA+aEWZIuKFGtZALG6BxO3BfPTgr94wb3DsXmWd6cFV5TRXYfVf+PICm
        5hDmvssawdjVA4vgeRXihPS7EXagYKM=
X-Google-Smtp-Source: AFSGD/U8Qp3/oO5fcMGYbAE350OWuRlVutDMCREK99UrYpZpXVB/98t/4UdypO8Jj2D+hYCcdsAGyA==
X-Received: by 2002:ab0:13d3:: with SMTP id n19mr12060499uae.37.1545334453043;
        Thu, 20 Dec 2018 11:34:13 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id w83sm5574047vke.22.2018.12.20.11.34.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 11:34:12 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id n13so1812097vsk.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 11:34:12 -0800 (PST)
X-Received: by 2002:a67:f943:: with SMTP id u3mr5656774vsq.149.1545334107562;
 Thu, 20 Dec 2018 11:28:27 -0800 (PST)
MIME-Version: 1.0
References: <20181220173026.3857-1-jcrouse@codeaurora.org> <20181220173026.3857-2-jcrouse@codeaurora.org>
In-Reply-To: <20181220173026.3857-2-jcrouse@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 20 Dec 2018 11:28:15 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WX3ZFJCh2_xiWDb_0N9cu2SiAxh3qbfkxK335_yXrOmg@mail.gmail.com>
Message-ID: <CAD=FV=WX3ZFJCh2_xiWDb_0N9cu2SiAxh3qbfkxK335_yXrOmg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] drm/msm/a6xx: Add support for an interconnect path
To:     Jordan Crouse <jcrouse@codeaurora.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Clark <robdclark@gmail.com>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Johan Hovold <johan@kernel.org>,
        Colin Ian King <colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 20, 2018 at 9:30 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> Try to get the interconnect path for the GPU and vote for the maximum
> bandwidth to support all frequencies. This is needed for performance.
> Later we will want to scale the bandwidth based on the frequency to
> also optimize for power but that will require some device tree
> infrastructure that does not yet exist.
>
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

There is very little difference between this an the previous version
[1].  Maybe could have kept Rob Clark's Acked-by?  The only change
was:

-       gpu->icc_path = of_icc_get(dev, "gfx-mem");
+       gpu->icc_path = of_icc_get(dev, NULL);

Also: I assume that this is still intended to go through Georgi's tree?

[1] https://lkml.kernel.org/r/20181207170656.13208-1-jcrouse@codeaurora.org

-Doug
