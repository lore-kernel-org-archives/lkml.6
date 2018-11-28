Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D19CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CD72082F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ErZwgbyp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0CD72082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbeK1RTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 12:19:14 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37558 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbeK1RTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 12:19:14 -0500
Received: by mail-vs1-f65.google.com with SMTP id h18so15357760vsj.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C4D1M8vP77wz6vXP94C/caQl4E0Drf2OblDOXXtprWE=;
        b=ErZwgbypFMC7LO9EH4yFj1M2Cev9+38UrOoBTxFAKT5aj6pjjYR2i5s930CqR1QL4A
         rVAJovGCOvWpvq0IUllpEqDPKdu1OQ4nHj4QH51WvDGBj6J/RzmPR8P+fAxAmF55sYl/
         gqUUQcrosAmJYQrK7JDKBBL/VtRIQUsYoF+As=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C4D1M8vP77wz6vXP94C/caQl4E0Drf2OblDOXXtprWE=;
        b=ScFr1XOEsPiNy0FxyiphcicQtOZzcIDzNIvZ8KqCW9q732wvJRnwIEoi4nF6wyjeks
         YQ9iCDl6I09RuxlVt7PtBhHfcc07TgFOrBfRBEULZZTCYBUj5/yA9ONAA9NpeBJ9jJF6
         T23XAXOkDW/hF1GjSbiZULH97Si8DCtFSCyLQR6B+DotdENBJy/gf4CEw92IxFxtQBeE
         ar5tWUTXdryT6B3GpQKYMsZnJnP/BZUue2jfYenX+4TswWx7QbbY+0M8D0WP2pOFMv6V
         6P8kvrRZZ+PHHMz+CHr8NmBFipmEVqmQsRe4t/K2gi3a4KJDG00ZMqukNjJr/XoaBC+H
         msUQ==
X-Gm-Message-State: AGRZ1gJ3VlOJCAxRmFqanCfrQ0YyQf5HK4es5J3wX9qNq7ksIXObt6TP
        oQZ2Rt7MmJUoxh1YlWumixwpeISoiN4=
X-Google-Smtp-Source: AFSGD/XpCKL11vWCEETqARAs/uFGG8vNTKbqwzqp9Q28LT2Zfhh6r9ZXU7WMxP1Nrt+rspGD6jKKnw==
X-Received: by 2002:a67:f085:: with SMTP id i5mr15163971vsl.198.1543385922626;
        Tue, 27 Nov 2018 22:18:42 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id d7sm1797545vke.12.2018.11.27.22.18.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 22:18:41 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id t17so15364176vsc.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:18:40 -0800 (PST)
X-Received: by 2002:a67:1505:: with SMTP id 5mr13663901vsv.20.1543385920244;
 Tue, 27 Nov 2018 22:18:40 -0800 (PST)
MIME-Version: 1.0
References: <20181126231159.122298-1-mka@chromium.org> <20181126231159.122298-6-mka@chromium.org>
In-Reply-To: <20181126231159.122298-6-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 27 Nov 2018 22:18:27 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VXo+cifBpdFm4WoOd6pgtdREvhWCR6QPWR3219kcU8fg@mail.gmail.com>
Message-ID: <CAD=FV=VXo+cifBpdFm4WoOd6pgtdREvhWCR6QPWR3219kcU8fg@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] drm/msm/dsi: 28nm PHY: Get ref clock from the DT
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
>
> Get the ref clock of the PHY from the device tree instead of
> hardcoding its name and rate.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - patch added to the series
> ---
>  drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c | 29 +++++++++++++++-------
>  1 file changed, 20 insertions(+), 9 deletions(-)

Generally same feedback as with "28nm 8960 PHY" patch, plus...


> @@ -81,6 +80,7 @@ struct dsi_pll_28nm {
>         struct platform_device *pdev;
>         void __iomem *mmio;
>
> +       struct clk *vco_ref_clk;
>         int vco_delay;
>
>         /* private clocks: */
> @@ -139,6 +139,7 @@ static int dsi_pll_28nm_clk_set_rate(struct clk_hw *hw, unsigned long rate,
>         struct dsi_pll_28nm *pll_28nm = to_pll_28nm(pll);
>         struct device *dev = &pll_28nm->pdev->dev;
>         void __iomem *base = pll_28nm->mmio;
> +       u64 ref_clk_rate = parent_rate;

Are you sure it's good to stash this in a u64 instead of just using
the parent_rate directly?
