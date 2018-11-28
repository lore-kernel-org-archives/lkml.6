Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F044EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFBF42081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OVkJxEi+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFBF42081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbeK1RBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 12:01:34 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:36819 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbeK1RBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 12:01:34 -0500
Received: by mail-vk1-f193.google.com with SMTP id t132so4891466vkc.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YIEOICfAOcSxFte3dGP1jONEZjEnps1LBJNeBrnplXE=;
        b=OVkJxEi+orHfcTN7CD9KQKHtFLeuyJq0xypf56qjVRBT14aCINQYZi9T0qhohQoLUa
         mNTjZK28I5ML286lC/fkRTdKd2Dz5iLsgWHdbfJLVHTRumWMtGGuCdinelwiFmTB+LTi
         pLILYMdaLvLyHidf5vi9bHytKt9Kad62veT68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YIEOICfAOcSxFte3dGP1jONEZjEnps1LBJNeBrnplXE=;
        b=sVGoYwzI424h3L9Yv23FVZXpWE4cI+F456FNsByb8Q5ZxbGsPCHsD7AIIiosm0z/nm
         +wA4xX0iZxXG+0O6bCP6NFH4uCgZ0O0iPzbyBpd6/rGFM1DlGGRN3gQeJRlNvjlPyjuD
         O4gj0fhCnrdRP7FhexWIbl/DQXVY5/NUCeOJFjpe0g9WyA7QyvqkbPJshkzgW/DL0J8+
         zX2TXlCVf1HGd94jR6ZTY1eX/FG4r7foSuiZKV+zgPCqwE0GHzG0yU9zSLNhC+bqvDAL
         7hRPRkU+QlCUr/hYwUJmKu0HTJzGMEpImE29+JcFk7oXq8yJvlThaIMJ2a/Oo5XD+Gng
         P9sw==
X-Gm-Message-State: AA+aEWakJzyRGkE0QnKjmaE42NaC79R2iYmvFRBPmX3kJ3w9BvnNHbuP
        Qi0szZcw3SKtC0FdmZAe66YZeshau7o=
X-Google-Smtp-Source: AFSGD/UmZH82FlHTOVx+YRxY9FhJC287nTjZXK1oIsi8A81d+Fppz2gZ62KvONm17PgSEgCFr5uyQA==
X-Received: by 2002:a1f:f0d:: with SMTP id 13mr14689982vkp.21.1543384865083;
        Tue, 27 Nov 2018 22:01:05 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id w140sm1784384vkw.2.2018.11.27.22.01.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 22:01:03 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id b74so15323016vsd.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:01:03 -0800 (PST)
X-Received: by 2002:a67:1505:: with SMTP id 5mr13647556vsv.20.1543384862839;
 Tue, 27 Nov 2018 22:01:02 -0800 (PST)
MIME-Version: 1.0
References: <20181126231159.122298-1-mka@chromium.org> <20181126231159.122298-4-mka@chromium.org>
In-Reply-To: <20181126231159.122298-4-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 27 Nov 2018 22:00:50 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X5r1CCSeTDXy_cYOBDf4ExNe276pFQSC6T+WWg2=SchA@mail.gmail.com>
Message-ID: <CAD=FV=X5r1CCSeTDXy_cYOBDf4ExNe276pFQSC6T+WWg2=SchA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] drm/msm/dsi: 28nm 8960 PHY: Get ref clock from the DT
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 26, 2018 at 3:12 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> @@ -409,8 +410,9 @@ static void dsi_pll_28nm_destroy(struct msm_dsi_pll *pll)
>  static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm)
>  {
>         char *clk_name, *parent_name, *vco_name;
> +       const char *ref_clk_name = __clk_get_name(pll_28nm->vco_ref_clk);

IMO for the 28nm PHY driver you should probably make things work OK
even if the "ref" clock wasn't supplied.  In the spirit of the stable
device tree it would be nice (even if nobody actually ships device
trees separate from kernels).  ...and also it makes the whole thing
easier to land.  If you add compatibility here then the code and
device tree patch can go in separately.

Depending on what others think you could potentially spit some type of
warning in the logs if the ref clock wasn't specified though.

-Doug
