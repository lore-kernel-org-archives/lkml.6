Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27F3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3E3218AE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MO2mrfIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbfBZA0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 19:26:33 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40498 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbfBZA0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 19:26:32 -0500
Received: by mail-lf1-f65.google.com with SMTP id a8so2512319lfi.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/cHvJz/lFIgbpCR1endu87T6pP0PHpJtFHp0QcdQTyo=;
        b=MO2mrfIGnMt0DrgiT3cbOzkV8YHPyYhrBJ4ZMTuNLD2o3UtuIo6Q+7rprD6GIw+y/c
         edfwxRfiVaLszBWXr0qn8UAToIcRs3wJwSD30LRc/f08p8VVfqakAxaARyXDO4YUdgBY
         THuRgKZxfjnQ5Y9SX4lGZU+RkZyVyOxwR4HOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/cHvJz/lFIgbpCR1endu87T6pP0PHpJtFHp0QcdQTyo=;
        b=Ck2WWwF448KUiSW2pWbXSp/LuZvvKjpVRV1LWfi3ilQURG5i1s6V2mu8nbDJVGMR7V
         hNbvXxh/fkmrNJzTsQ56wQOPXjRmXnhR7koJ/CfPvAAxqcKxk9AIXdG5UrtjdyoHa0iL
         qtU2EsrDXuGmMLTZs4gzmKLgCuufmHMHSu6i1axdEIaWg8ZgAJJoU6R6TV/ucnJojHz/
         0lVsMoKUFq/Cb+pDWF4yI3F2dOxS7UkSiH/z3gahQaGQRBDiN9SdlSLA1q6RTZwsoF7s
         P87G86VC74tuTx/36rwdVWnSv+ONHxaeujrh+ZRayzBDEnFWZjS9esc/JBYALjtBj6I7
         Aggw==
X-Gm-Message-State: AHQUAuYnctIeppdqtgy7O3Gavyd5/xvFOaZkBkKcvhB0VHIQlaXGoegc
        vitKjTK6pHPj4SvwlkfergRq31faVeQ=
X-Google-Smtp-Source: AHgI3IYy1XSHv433jmsT1+9t3qsHl4bN/f9GZ+hfHpWPVG2WWl2QjGxNpjTaoxKToRvTLpIqwXFA4g==
X-Received: by 2002:a19:ec0c:: with SMTP id b12mr12506486lfa.27.1551140790066;
        Mon, 25 Feb 2019 16:26:30 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id u15sm1640936lja.73.2019.02.25.16.26.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 16:26:30 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id d24so8871904ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:26:29 -0800 (PST)
X-Received: by 2002:a2e:99c9:: with SMTP id l9mr11485651ljj.60.1551139025774;
 Mon, 25 Feb 2019 15:57:05 -0800 (PST)
MIME-Version: 1.0
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com> <1546318276-18993-12-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546318276-18993-12-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 25 Feb 2019 15:56:29 -0800
X-Gmail-Original-Message-ID: <CAE=gft4Z_C0NRmP0A_rnDzvB3txt3cGV=rvZhJOQZk_1qahiQQ@mail.gmail.com>
Message-ID: <CAE=gft4Z_C0NRmP0A_rnDzvB3txt3cGV=rvZhJOQZk_1qahiQQ@mail.gmail.com>
Subject: Re: [PATCH 11/13] iommu/mediatek: Use builtin_platform_driver
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
        yingjoe.chen@mediatek.com, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 8:53 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> MediaTek IOMMU should wait for smi larb which need wait for the
> power domain(mtk-scpsys.c) and the multimedia ccf who both are
> module init. Thus, subsys_initcall for MediaTek IOMMU is not helpful.
> Switch to builtin_platform_driver.
>
> Meanwhile, the ".remove" can be removed. Move its content to
> ".shutdown".
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c    | 23 ++---------------------
>  drivers/iommu/mtk_iommu_v1.c | 16 ++--------------
>  2 files changed, 4 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 735ae8d..2798b12 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -690,7 +690,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>         return component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
>  }
>
> -static int mtk_iommu_remove(struct platform_device *pdev)
> +static void mtk_iommu_shutdown(struct platform_device *pdev)
>  {
>         struct mtk_iommu_data *data = platform_get_drvdata(pdev);
>
> @@ -703,12 +703,6 @@ static int mtk_iommu_remove(struct platform_device *pdev)
>         clk_disable_unprepare(data->bclk);
>         devm_free_irq(&pdev->dev, data->irq, data);
>         component_master_del(&pdev->dev, &mtk_iommu_com_ops);
> -       return 0;
> -}
> -
> -static void mtk_iommu_shutdown(struct platform_device *pdev)
> -{
> -       mtk_iommu_remove(pdev);

Is there a reason all these things are happening in shutdown()? Don't
we normally just not clean things up and let the machine turn off?
Normally I'm a big advocate of proper symmetric teardown, so it hurts
a little to ask.
