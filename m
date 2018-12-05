Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5084C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757982082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hj5T0vgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757982082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbeLELvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:51:06 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36685 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbeLELvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:51:05 -0500
Received: by mail-lj1-f196.google.com with SMTP id g11-v6so18048098ljk.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 03:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vG2mpSZLl/CbDe42vVWpfP0j2c00ShxmcQSUA4u03rs=;
        b=hj5T0vgztXxV22fg+Pp4Rk7vtJPmkeHDZ02xdzur23WCv7z4z3ukcgfiWUqGMRPSaU
         lsdeM888vQla/wuL7vJ/xqfM5m3IJKHFtbHrG+j8/ov3kWTLTYUYMP4W/kmSVKIYHbEo
         UWSqxPqYjd1bijFYdKmQYmMCMYvg1QWOIc7kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vG2mpSZLl/CbDe42vVWpfP0j2c00ShxmcQSUA4u03rs=;
        b=NKQpmA3jpjKXABrT96kSK6EKAn0907Z0yAOiguRYTvI7vhZkMKd/hy3KHyRPu5+jNs
         oU7BNZuDlbGxAthLJIm5AI5YovXZsj9hXhXhIgBOR+VS6KopR5r2egAZldS4Lb/A5h31
         aYQirS+SLX/p33gncQilL5jgNvBjI4yNGnaRueBUOC0hVwuH0083CEvpLGTnB/alCGBd
         UlSGs9FwSfFNss4BB+cYiGCZ+JhWlqn/9k2dygjHSJREjea28TwfR+qAQwP/TlruL2c1
         /ZPwNjW/JIerUqvDfl9+mjHcSsbAzPJ0QmI6Pz2VoM1FaePzGHUA+7uFgRLJzR5y1hyt
         kdqw==
X-Gm-Message-State: AA+aEWYm1mGMyAynonBwyz2AXms+y3IzzdfQprdRvaXwBhE1+b/DgGcv
        Hhu7Ue91zTsvh2AzEFKBwfOXS5wGNyDXGXnCQlpEyw==
X-Google-Smtp-Source: AFSGD/XVUv6WzRb1FHFAcHttdpsdHzNrT8e9fjkqhCkQPmzZogkzbA60K1bobTJJPUGyQATlj1CwannZb5n+xtmxPqE=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr15401253ljj.9.1544010663634;
 Wed, 05 Dec 2018 03:51:03 -0800 (PST)
MIME-Version: 1.0
References: <1543811009-15112-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1543811009-15112-1-git-send-email-paul.gortmaker@windriver.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 5 Dec 2018 12:50:51 +0100
Message-ID: <CACRpkdbaU03uDbHnRuCp0ef2Zzbb4XcAGgUCn=xBfAxuCEciOw@mail.gmail.com>
Subject: Re: [PATCH v2 00/22] mfd: demodularization of non-modular drivers
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Cory Maccarrone <darkstar6262@gmail.com>,
        David Dajun Chen <dchen@diasemi.com>,
        Dong Aisheng <dong.aisheng@linaro.org>,
        Eric Miao <eric.miao@marvell.com>,
        Graeme Gregory <gg@slimlogic.co.uk>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Haojian Zhuang <haojian.zhuang@marvell.com>,
        jinyoungp@nvidia.com,
        Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Mattias NILSSON <mattias.i.nilsson@stericsson.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Mike Rapoport <mike@compulab.co.il>,
        ext Tony Lindgren <tony@atomide.com>,
        Venu Byravarasu <vbyravarasu@nvidia.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        patches@opensource.cirrus.com,
        Support Opensource <support.opensource@diasemi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 5:24 AM Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:

> [v1 --> v2: add some more commits as requested by Lee (MFD maintainer),
>  update the 00/NN text; re-do build and link testing on new linux-next. ]
>
> This group of MFD drivers are all controlled by "bool" Kconfig settings,
> but contain various amounts of largely pointless uses of infrastructure
> related to modular operations, even though they can't be built modular.
>
> We can easily remove/replace all of it.  We are trying to make driver
> code consistent with the Makefiles/Kconfigs that control them.  This
> means not using modular functions/macros for drivers that can never be
> built as a module.  Some of the downfalls this oversight leads to are:

This series:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

IMO it is clearly the right thing to do, moving a whole bunch
of clutter out of the way so we can see clearly and the effect
of getting rid of the <linux/module.h> is a substantial improvement
in its own right.

Yours.
Linus Walleij
