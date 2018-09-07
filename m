Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE75BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754942075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 754942075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbeIGQHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 12:07:17 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46686 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbeIGQHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 12:07:17 -0400
Received: by mail-qk1-f193.google.com with SMTP id j7-v6so9423250qkd.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 04:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e31LJ64CoqiFm20TRpYH1iGAbLuyF+mw9E9PK52/Iyg=;
        b=Mqtk36nyDWqBUNU7pCws/OvBXRneFOeQrZjV6VOZ0YkQrS3/o320kbQgh4ecCYB4gH
         FZgHK9ZuqfDwKeY95nbv/7KX7fO4JGojpjjEUAWFpfzBViTIQdz4P75bAbJVXd1S+eNv
         l+DNmL3/dEtlGcK238h6ubpUYlZ71w8WNdilNhejyOudTCSpasE88WZYQrk/7eqmupaD
         jyCjB/aiYHPA+sOHpqRSbrJjl26xfqzr26rBhiUGimpvfbFCldlCKYifAo0o4xrotBgQ
         SeY9cLvllwy27BfHvnhkc+grvglfB+HiUXLHd/9BdrQAw740X0RvIlJzFo1HNSb8biFK
         7cyw==
X-Gm-Message-State: APzg51CWo53b0Vj0XOiQwh1USUrd+XSfE2jdFpjZ1frddQycEUrCvKQk
        CqoLvutjzNbo1NPtNse8GMpc0ffVhn5xtX/vWO4=
X-Google-Smtp-Source: ANB0Vdb0DsvvSnlHrYAWcL03/ankOlpHM6bAtBw6WBz2BI+cnT8PyDGf46/3G3e/ayHehmQeNqfWQmsrbnJxM9pMDgE=
X-Received: by 2002:a37:1b91:: with SMTP id m17-v6mr5472433qkh.173.1536319606035;
 Fri, 07 Sep 2018 04:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180711144403.1022829-1-arnd@arndb.de> <105cb1cf-577a-043a-9b50-248a37090bdd@nvidia.com>
In-Reply-To: <105cb1cf-577a-043a-9b50-248a37090bdd@nvidia.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 7 Sep 2018 13:26:30 +0200
Message-ID: <CAK8P3a1w0SrxFNRwjt1nWhQPdqgt=bZ8oqGaPE=z9iHp84R5mw@mail.gmail.com>
Subject: Re: [PATCH] [v3] drm/sun4i: fix build failure with CONFIG_DRM_SUN8I_MIXER=m
To:     Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 11:41 AM Jon Hunter <jonathanh@nvidia.com> wrote:
>
>
> On 11/07/18 15:43, Arnd Bergmann wrote:
> > Having DRM_SUN4I built-in but DRM_SUN8I_MIXER as a loadable module results in
> > a link error, as we try to access a symbol from the sun8i_tcon_top.ko module:
> >
> > ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun8i-drm-hdmi.ko] undefined!
> > ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-drm.ko] undefined!
> >
> > This solves the problem by adding a silent symbol for the tcon_top module,
> > building it as a separate module in exactly the cases that we need it,
> > but in a way that it is reachable by the other modules.
> >
> > Fixes: 57e23de02f48 ("drm/sun4i: DW HDMI: Expand algorithm for possible crtcs")
> > Fixes: ef0cf6441fbb ("drm/sun4i: Add support for traversing graph with TCON TOP")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> I am seeing the following on today's -next (20180907) as well the last
> few -next versions for that matter ...
>
> ERROR: "sun8i_tcon_top_de_config" [drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!
> ERROR: "sun8i_tcon_top_set_hdmi_src" [drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!
> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!
>
> Seems like this issue has cropped up again as Arnd's fix is present. I
> am seeing this on ARM64 builds.

I have not started build testing on linux-next since the merge window, but
looking at the changes that got queued up, I find commits cf77d79b4e29
("drm/sun4i: tcon: Add another way for matching mixers with tcon") and
0305189afb32 ("drm/sun4i: tcon: Add support for R40 TCON") that both
introduced a reference to the tcon_top file from sun4i_tcon.c.

More IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP) checks in
the caller like I did in my patch would help, or alternatively one could
decide to give up and just always include the TCON_TOP.

      Arnd
