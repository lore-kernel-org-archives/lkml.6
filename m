Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43817C2F3A6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1443920861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fMP/756s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfAUNGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:06:23 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40935 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727449AbfAUNGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:06:22 -0500
Received: by mail-lf1-f66.google.com with SMTP id v5so15432780lfe.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 05:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wh6rtqcOPEJtHrYy9mDdNoDWZqOoR5R3Bb2MsKxUt64=;
        b=fMP/756s/lIb6khu1FsWLzq6C29tMcVEeF8nnxSp0vmBFV1aKvDVfMQvQBoQJ+H7+q
         aHQ+XCZnVqg/vSsK0q7xDGzYWpJ44Sw9TBsTD8ZS1/ZZktUfBtCXftkiYkGf0v2+DWFD
         tUJl2eCrEu7SD9fUxFnerffulK3mBxDkAj26s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wh6rtqcOPEJtHrYy9mDdNoDWZqOoR5R3Bb2MsKxUt64=;
        b=DDs9gsxfYZNVKCfWWe8MlG/FkaoChQA6baQG1W87Byht128rjBY28oKcmozWzssr2f
         Imruo9vGt9qyghMOlfq7C5CfMERIbK9Jk3tP8GZ2aDbEH23XhpmUkzRZk93wdPBAkQT3
         sjvMDM+2b4YXEthSCFK4Sc435+KjeUfWI+G8E63C0LykQSAWgQ2gusrcnI/tyxqrtOke
         X+t4begMBzTGWj8mzfYPDAlLOdb6O/+ia+Bgp41vYoiLm88Ufdj5gedeSYgQJiaah2Pj
         AgMGly2yM9qXjQgfu80jGnSHbGNFIihgri1tpt62QwZSdjA3T2hLbS+c8Jt5jSoq4qyK
         WFhA==
X-Gm-Message-State: AJcUukdd+suflLzncGczxzHGBBF0V4gx8Oif3pcVMtEhLWdSQd8Cgrzj
        jAd0MFoC9FXNRwpC5APZwKQrentAmy7De4UPwDP8rw==
X-Google-Smtp-Source: ALg8bN7dHjNpFRD612HBwZ3luZTNTh5+6Uh4hWkSGRYdeGQngTHIVcGKAooE0qnuIyW8Izn/dT4QKZN1gT9xcVxrdO4=
X-Received: by 2002:a19:789:: with SMTP id 131mr19417273lfh.11.1548075980531;
 Mon, 21 Jan 2019 05:06:20 -0800 (PST)
MIME-Version: 1.0
References: <20190116093158.2850-1-thomas.petazzoni@bootlin.com> <20190116093158.2850-2-thomas.petazzoni@bootlin.com>
In-Reply-To: <20190116093158.2850-2-thomas.petazzoni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Jan 2019 14:06:08 +0100
Message-ID: <CACRpkdYg3mUhetVO7nFOgGkpbeK+6355p-74wLWAH09JZcN8hQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: pca953x: use a per instance irq_chip structure
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Vasut <marex@denx.de>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 10:32 AM Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:

> When a system has two PCA953x GPIO expanders, the kernel complains with:
>
> gpio gpiochip2: (0-0021): detected irqchip that is shared with multiple gpiochips: please fix the driver.
>
> Indeed, there is a single instance of "struct irq_chip" that gets
> re-used for both PCA953x instance. This commit moves the "struct
> irq_chip" to be part of the "struct pca953x_chip", so that we have one
> "struct irq_chip" per PCA953X instance.
>
> As part of this, the name of the irq_chip is also made different on a
> per-instance basis, now using the dev_name() of the I2C device. This
> changes what is visible in /proc/interrupts.
>
> Before:
>
>  47:          0          0   pca953x  10 Edge      e0100000.sdhci cd
>  48:          0          0   pca953x   6 Edge      e0101000.sdhci cd
>
> After:
>
>  47:          0          0    0-0020  10 Edge      e0100000.sdhci cd
>  48:          2          0    0-0020   6 Edge      e0101000.sdhci cd
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Patch applied.

Yours,
Linus Walleij
