Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F8BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0EE7217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550488645;
	bh=tu9aWkyLYOO27B9KLXFKNWviv4zOq3hOsOm0YXHyeYs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=grXt4tRbVuErCGVR37EHcLm+Yh7q5LkOt/BbQsXXDGqCtCFBDjBHhYOJRjG3JBnAc
	 00ANUiCUsfYDkx3h29HHpf/v7qE15WiFNGACmFYkRAqWc9nDgFLVhAoM3dK7eQSTdV
	 RlFUmPM71k/5yStRi2gbqeWycny4DznBrbqzapZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730529AbfBRLRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 06:17:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:33968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbfBRLRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 06:17:23 -0500
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E317C2184E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 11:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550488642;
        bh=tu9aWkyLYOO27B9KLXFKNWviv4zOq3hOsOm0YXHyeYs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=097ZCIhb9D69+q7mBtwAv1b3RxNZJra6SvyQUTFFhYjeDaEOEM3slW+dIRdGoFD7f
         pMDBEKjDRAewYpHGCGDlkQaucL5BSJbpK8BEtbY9f7tXsz7++/TNnUjDXXfnzu/PJf
         hrcWWln6bnWKldZ/hvkO45NUO0MwUL4O6g8WDfuM=
Received: by mail-lj1-f170.google.com with SMTP id g11-v6so14037027ljk.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 03:17:21 -0800 (PST)
X-Gm-Message-State: AHQUAuZa2N4GV/WjbyEXhZ1XD6jSQz1pejf0FSwCh9MqErhea0+NS1Z8
        7XA6k/Cn1o7A1g518UPmurbhogu74J2G6iwLsrA=
X-Google-Smtp-Source: AHgI3IbVYFU0xsYR+OrKTHIqeM+PYmcfeUml1sHeiimBuho9J6QLBMJ2xtPoALOT+5Z98dFnyhBp0xhAjRAerWoe6Us=
X-Received: by 2002:a2e:7615:: with SMTP id r21-v6mr13757434ljc.131.1550488640043;
 Mon, 18 Feb 2019 03:17:20 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190215144828epcas2p267aae592d0ebaaaa297ba1543463c204@epcas2p2.samsung.com>
 <20190215144809.28007-1-s.nawrocki@samsung.com> <20190215144809.28007-2-s.nawrocki@samsung.com>
In-Reply-To: <20190215144809.28007-2-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 18 Feb 2019 12:17:08 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdTWanSMJC0cmrkNuR3mjCVg+K8e2EvV=F6X0bj_7v3cA@mail.gmail.com>
Message-ID: <CAJKOXPdTWanSMJC0cmrkNuR3mjCVg+K8e2EvV=F6X0bj_7v3cA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: samsung: i2s: Fix multiple "IIS multi" devices initialization
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2019 at 15:48, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> On some SoCs (e.g. Exynos5433) there are multiple "IIS multi audio
> interfaces" and the driver will try to register there multiple times
> same platform device for the secondary FIFO, which of course fails
> miserably.  To fix this we derive the secondary platform device name
> from the primary device name. The secondary device name will now
> be <primary_dev_name>-sec instead of fixed "samsung-i2s-sec".
>
> The fixed platform_device_id table entry is removed as the secondary
> device name is now dynamic and device/driver matching is done through
> driver_override.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/i2s.c    | 49 +++++++++++++++++++++++++-------------
>  sound/soc/samsung/odroid.c |  2 +-
>  2 files changed, 33 insertions(+), 18 deletions(-)
>
> diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
> index e36c44e2f1bb..4a6dd86459bc 100644
> --- a/sound/soc/samsung/i2s.c
> +++ b/sound/soc/samsung/i2s.c
> @@ -1339,20 +1339,34 @@ static int i2s_register_clock_provider(struct samsung_i2s_priv *priv)
>  /* Create platform device for the secondary PCM */
>  static int i2s_create_secondary_device(struct samsung_i2s_priv *priv)
>  {
> -       struct platform_device *pdev;
> +       struct platform_device *pdev_sec;
> +       const char *devname;
>         int ret;
>
> -       pdev = platform_device_register_simple("samsung-i2s-sec", -1, NULL, 0);
> -       if (!pdev)
> +       devname = devm_kasprintf(&priv->pdev->dev, GFP_KERNEL, "%s-sec",
> +                                dev_name(&priv->pdev->dev));
> +       if (!devname)
>                 return -ENOMEM;
>
> -       ret = device_attach(&pdev->dev);
> +       pdev_sec = platform_device_alloc(devname, -1);
> +       if (!pdev_sec)
> +               return -ENOMEM;
> +
> +       pdev_sec->driver_override = "samsung-i2s";

This is wrong, see:
https://patchwork.kernel.org/project/linux-samsung-soc/list/?series=81639&state=*

Although there is ongoing discussion whether the drivers should use
driver_override at all:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1934411.html

Best regards,
Krzysztof
