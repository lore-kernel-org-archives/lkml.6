Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E72AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51F5214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RSk7rytN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D51F5214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbeJKAZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:25:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35756 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeJKAZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:25:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id v133-v6so2807987pgb.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 10:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=RpyMeL0PjIc4aV9NLlIN4yVIlWOI5PtPMviTKqnNBns=;
        b=RSk7rytNk6JcxVG5Q+exibsts8yeV2WKUXAfccajJYx4FHf5UeAqWMoWM8XfKfGpzw
         pl0EzjEd/ejVwCbnFqFf2UWDNBnrBseaGjgiOVnoSVM0uQaIvs8z59uVGvJy1WquKkXI
         EsMWgPPXscc11I1eYrhaK3WCuRPOWxk07mv6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=RpyMeL0PjIc4aV9NLlIN4yVIlWOI5PtPMviTKqnNBns=;
        b=rkGD9mtLeQ4vNWhrVotfHVagbJuFnARBWemPoZV6CP2eOjurkiMLqFqDJ+qITQ4Vh4
         fAVrPiGJ+kEx5huKfiX+TQCCGy25SSY3BGHE+5CG8P7Wo/awPTLwYBbBabKjS74t9ECg
         ecx6M5Nwljggntrd43cBXBkYv14HK4R6WW5ksyZbZH9+xoATYAX+ER0VhWSh2IcPyR5t
         S8PaXjJlBn+AByZk81EdB7ZTSQv8f6naRcO2pvwnNBYI2FAJll3WqXXuhoCGP4me7dD2
         KNRDaZsTaFyhN6sPoF0R95/2kMuuCuQ2EisR3CBg4r8c0eSU37cwmB2ztP0xqawInJgD
         4B7g==
X-Gm-Message-State: ABuFfoid50dtw2jUltT5GgvqqlzphhTcYMKkrLdAxV1rvPGol2ts0wde
        wu7/v38fts0dLW3rQGsawa6LyA==
X-Google-Smtp-Source: ACcGV63cn9rdKiR8UTi1u7uNtIyl+0ekIN/Y8k+0pN9RkTC3cYgqsYwBLqqra/2K5w62CFMEwUsqbA==
X-Received: by 2002:a62:5919:: with SMTP id n25-v6mr7376963pfb.117.1539190949870;
        Wed, 10 Oct 2018 10:02:29 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id g6-v6sm37520468pgf.33.2018.10.10.10.02.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 10:02:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Linus Walleij <linus.walleij@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <CACRpkdaVttmazoVofRn=egUtRRLE9xTz0jnCnTkf7sQWED0v3w@mail.gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        evgreen@chromium.org, Thierry Reding <treding@nvidia.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
References: <20181008163216.97436-1-swboyd@chromium.org>
 <20181008163216.97436-2-swboyd@chromium.org>
 <CACRpkdaVttmazoVofRn=egUtRRLE9xTz0jnCnTkf7sQWED0v3w@mail.gmail.com>
Message-ID: <153919094779.119890.4753836996500844280@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/4] gpio: Assign gpio_irq_chip::parents to non-stack pointer
Date:   Wed, 10 Oct 2018 10:02:27 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Linus Walleij (2018-10-10 05:05:18)
> On Mon, Oct 8, 2018 at 6:32 PM Stephen Boyd <swboyd@chromium.org> wrote:
> =

> >
> > Let's leave around one unsigned int in the gpio_irq_chip struct for the
> > single parent irq case and repoint the 'parents' array at it. This way
> > code is left mostly intact to setup parents and we waste an extra few
> > bytes per structure of which there should be only a handful in a system.
> >
> > Cc: Evan Green <evgreen@chromium.org>
> > Cc: Thierry Reding <treding@nvidia.com>
> > Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> > Fixes: e0d897289813 ("gpio: Implement tighter IRQ chip integration")
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> =

> OMG critical fix. I fixed up the thing the kbuild robot was complaining
> about with some vanilla kerneldoc and applied for fixes since it's kind
> of urgent.
> =

> Please check the result.
> =


Looks good. Thanks!

