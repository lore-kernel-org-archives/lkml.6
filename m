Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3363CC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20902082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SbNWfSqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E20902082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbeLAJ3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:29:45 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35169 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLAJ3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:29:45 -0500
Received: by mail-pf1-f195.google.com with SMTP id z9so3468133pfi.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 14:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AaHUNzHZjdvii4QW8EE7VJEzORSyjjnCvfEOzUa3Tz0=;
        b=SbNWfSqDGyV/2bqLLU4S3khJ12n7EdFx2GCHiREjh9Rxh94mxVs51rfvPX6FE61/0s
         ksWcweWGEtXpH34Z3CAjxIb7/99wIu6JOBFGCqy2m/9zRLe7ntae7jgjhluMvnOMhLac
         FUmJE3f7O2qa/+gx4hJavCRH+afXGY/F1/Yyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AaHUNzHZjdvii4QW8EE7VJEzORSyjjnCvfEOzUa3Tz0=;
        b=CtfHvFSnmzHjTYhJAB9nJBr6MP5wVbXaLnI8pt6+lb8eE+Yes6u4IGbaG5t4JfO3z6
         sMioVH/mH8A2WFfrQbSwBQAMaDF3QAcxoMIUHU4C4s+fMI4wnQ89UKw5Nvj2X4brSHzA
         e22+uca1nQrIH9Ct98LPY2EaM0jHYnjnH3g4X61AsDwGSrXmqqyYL5FQEaCVbMDlvpxA
         t7Cmh52SlnHE+UxuNslVzo0XmU/ZMYU8MAVhcGAIb6U6eo/xnBgYJWTi/+rjiu+e+q09
         /t1n6XtRLu/qzUGqqWBKkwocKyYs/WwqK/Ej3noRibb9xYYhZsMLZG+Fk3b+vvnefHZ9
         ggpg==
X-Gm-Message-State: AA+aEWbLBOeOWAy5oZvS2i4takRKLf8abnpTyRBLpQefRMjau6rUpYkG
        5iiblWtEeiYG6N5p1hvPn7dEnw==
X-Google-Smtp-Source: AFSGD/U9Au3Twmvj3GvUvjiIwwy+yjqBZlCkgGMciLFVmkZzukA9Pge8sw8XGWUecK7Pb4Ob80qm1g==
X-Received: by 2002:a63:6bc1:: with SMTP id g184mr6400610pgc.25.1543616338895;
        Fri, 30 Nov 2018 14:18:58 -0800 (PST)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id p24sm15601120pfk.155.2018.11.30.14.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 14:18:58 -0800 (PST)
Date:   Fri, 30 Nov 2018 14:18:57 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
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
Subject: Re: [PATCH v2 2/7] drm/msm/dsi: 14nm PHY: Get ref clock from the DT
Message-ID: <20181130221857.GC22824@google.com>
References: <20181126231159.122298-1-mka@chromium.org>
 <20181126231159.122298-3-mka@chromium.org>
 <CAD=FV=WNHUL+W1ozoRaCCd=-OcAD3QmqZaNLK0PNJQVbDqdaLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=WNHUL+W1ozoRaCCd=-OcAD3QmqZaNLK0PNJQVbDqdaLQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 09:56:46PM -0800, Doug Anderson wrote:
> Hi,
> 
> On Mon, Nov 26, 2018 at 3:12 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > Get the ref clock of the PHY from the device tree instead of
> > hardcoding its name and rate.
> 
> In the case of the 14nm PHY I think it's OK that you break
> compatibility with old device tree files (as this patch does) since
> the 14nm support was added sorta recently and "git grep" shows no
> users in linuxnext.  You should note that you're breaking
> compatibility with old DTS files in the commit message here so that if
> someone crawls out of the woodwork it will be easy for them to
> understand what happened.

ok, I'll add the note

> > +       pll_14nm->vco_ref_clk = devm_clk_get(&pdev->dev, "ref");
> > +       if (IS_ERR(pll_14nm->vco_ref_clk)) {
> > +               ret = PTR_ERR(pll_14nm->vco_ref_clk);
> > +               if (ret != EPROBE_DEFER)
> 
> Shouldn't this check against -EPROBE_DEFER, not against EPROBE_DEFER?
> It's negative.  Presumably this same feedback needs to be applied to
> the whole patch series.

You are right, will fix it throughout the series, thanks!

> Other than that this looks good to me and you can feel free to add my
> Reviewed-by tag FWIW.

Great, thanks for the review!

Matthias
