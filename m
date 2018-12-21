Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61BFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA6D21928
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545432480;
	bh=oRyKYDLBkCt8PohvGhKj7Ezcv2YNCnLOR+AO7rpNPHg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hNSf15sG/1Vels600Ml7LO831HwwB/BA3OUJsZ2/PSOZYAENpTrnGrPNkK9OkLerK
	 l86nqtlLOj7z2Q6T4OaaqUJ86mZhBF3sepC4iDVrtqRJWOv505Gc97xZM2jpyKSHIB
	 wKjASZEKhRermvij5uEc3R8/0mpgRFsF4LyZnJWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389170AbeLUWr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 17:47:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:41422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbeLUWr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 17:47:59 -0500
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8D8B21970
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 22:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545432477;
        bh=oRyKYDLBkCt8PohvGhKj7Ezcv2YNCnLOR+AO7rpNPHg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=btkXoLL614+KGQguZ9tGRiIzzCdv5LOYKHUu4SgVXHG+YnmZk9apf61aPMRv5SK53
         HuyTKFo4/XSl+8hf5fyXSmzeSIp1ecQksBGrX9nlwOycMqrP8hLJ5cjXFao7grDkb1
         3oyIjilc/NGhglzv6FXp/u4ugy9MZQhFU8uE1Nws=
Received: by mail-wr1-f46.google.com with SMTP id q18so6748744wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 14:47:57 -0800 (PST)
X-Gm-Message-State: AJcUukcQLm47/4SLaGXv+T/sAIdypL5aWuTKblYdWE4+rzY265OBAyVK
        xJlmP7nFDlh/9PC7mSo0+iBl0kTmUFOjh2UVw9NaYg==
X-Google-Smtp-Source: ALg8bN4C+prqO/IZ6AbgZGngaUmdOVbjWlIi5AQimgFalbCx4TTFDuRhKuC2nhGtv+MidDVEiLOD+wi+wavrXZ9T0uQ=
X-Received: by 2002:adf:cd0e:: with SMTP id w14mr4463016wrm.218.1545432476043;
 Fri, 21 Dec 2018 14:47:56 -0800 (PST)
MIME-Version: 1.0
References: <20181220102247.4911-1-a.hajda@samsung.com> <CGME20181220102259eucas1p2f748c68e01cd4e09a266da879722e218@eucas1p2.samsung.com>
 <20181220102247.4911-2-a.hajda@samsung.com> <20181220111403.GB10978@kroah.com>
 <b9f7cb75-62a0-20f6-0e5b-1553852d81b2@samsung.com>
In-Reply-To: <b9f7cb75-62a0-20f6-0e5b-1553852d81b2@samsung.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 21 Dec 2018 16:47:44 -0600
X-Gmail-Original-Message-ID: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
Message-ID: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] driver core: add probe_err log helper
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 5:38 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> On 20.12.2018 12:14, Greg Kroah-Hartman wrote:
> > On Thu, Dec 20, 2018 at 11:22:45AM +0100, Andrzej Hajda wrote:
> >> During probe every time driver gets resource it should usually check for error
> >> printk some message if it is not -EPROBE_DEFER and return the error. This
> >> pattern is simple but requires adding few lines after any resource acquisition
> >> code, as a result it is often omited or implemented only partially.
> >> probe_err helps to replace such code sequences with simple call, so code:
> >>      if (err != -EPROBE_DEFER)
> >>              dev_err(dev, ...);
> >>      return err;
> >> becomes:
> >>      return probe_err(dev, err, ...);
> > Can you show a driver being converted to use this to show if it really
> > will save a bunch of lines and make things simpler?  Usually you are
> > requesting lots of resources so you need to do more than just return,
> > you need to clean stuff up first.
>
>
> I have posted sample conversion patch (generated by cocci) in previous
> version of this patchset [1].
>
> I did not re-posted it again as it is quite big patch and it will not be
> applied without prior splitting it per subsystem.
>
> Regarding stuff cleaning: devm_* usually makes it unnecessary, but also
> even with necessary cleaning you can profit from probe_err, you just
> calls it without leaving probe - you have still handled correctly probe
> deferring.
>
> Here is sample usage (taken from beginning of the mentioned patch):
>
> ---
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 4b900fc659f7..52e891fe1586 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -581,11 +581,8 @@ int ahci_platform_init_host(struct platform_device *pdev,
>         int i, irq, n_ports, rc;
>
>         irq = platform_get_irq(pdev, 0);
> -       if (irq <= 0) {
> -               if (irq != -EPROBE_DEFER)
> -                       dev_err(dev, "no irq\n");
> -               return irq;
> -       }
> +       if (irq <= 0)
> +               return probe_err(dev, irq, "no irq\n");

Shouldn't platform_get_irq (or what it calls) print the error message
(like we do for kmalloc), rather than every driver? We could get rid
of lots of error strings that way. I guess there are cases where no
irq is not an error and we wouldn't want to always print an error. In
some cases like that, we have 2 versions of the function.

Not what you're addressing here exactly, but what I'd like to see is
the ability to print the exact locations generating errors in the
first place. That would require wrapping all the error code
assignments and returns (or at least the common sources). If we're
going to make tree wide changes, then that might be the better place
to put the effort. If we had that, then maybe we'd need a lot fewer
error messages in drivers. I did a prototype implementation and
coccinelle script a while back that I could dust off if there's
interest. It was helpful in finding the source of errors, but did have
some false positives printed.

Rob
