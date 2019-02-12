Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31CAC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD199222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550004038;
	bh=vjjmB3q5kxynqTfBl4fMXnJzLtFOe/CWMrbnP/HvubI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xL7g61wBoLBrIarDseX7z35Pg0T6XPJvKUAeoI4jIvRA8ggjx49gg+MMMOuiUEs9q
	 HvheICiDVulNkN3RW014F2ZFGqhFJWFZTUY5N40rRFLdAu6R5JrF8sLH2BOWTn825H
	 fnfg1nO32+o5mOKkgp8pvW8oLElGHvmC3ddFlFVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731459AbfBLUkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:40:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:48514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728097AbfBLUkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:40:37 -0500
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEB6C222C1;
        Tue, 12 Feb 2019 20:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550004036;
        bh=vjjmB3q5kxynqTfBl4fMXnJzLtFOe/CWMrbnP/HvubI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QfKA6/6/PzAH/1DTX5KyhQZjfr82FQxTeLuAkVGfvNPh0B5ZeDW8YW0zkx2oYKF8x
         js6uiZtrNajIS0RO2RaoERpXiSG8LLpOW2CofF7tRM0Ar6Gkfs/XYQaSDu8gGWSYkl
         fig/6HVAkxpsdIZs+cf77ZjUfMX0mfPMDlK+pctE=
Received: by mail-qk1-f181.google.com with SMTP id p15so32107qkl.5;
        Tue, 12 Feb 2019 12:40:35 -0800 (PST)
X-Gm-Message-State: AHQUAuYHGGs1wXuSsUGBXp8ozX/dUZkynyOS6a7M1g2AJOohE9vhUGBF
        wuA7bnET3pKio38fkFnhuKARby9t+wTW2G6UIQ==
X-Google-Smtp-Source: AHgI3IYz2gzbmamNNYONyTiDfE0zREh3E/QtpTpAvvx3glvEe3X+ZYzmIZ6HhCz+z+2Heg/0CZQUYhYHO3QCjAjIpjc=
X-Received: by 2002:a37:5686:: with SMTP id k128mr3834629qkb.29.1550004035085;
 Tue, 12 Feb 2019 12:40:35 -0800 (PST)
MIME-Version: 1.0
References: <20190211133554.30055-1-hch@lst.de> <20190211133554.30055-7-hch@lst.de>
In-Reply-To: <20190211133554.30055-7-hch@lst.de>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 12 Feb 2019 14:40:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL+LiJTF5kZz2hXGbQcH+D4U0jAQE376VSUVMQmdg=XFA@mail.gmail.com>
Message-ID: <CAL_JsqL+LiJTF5kZz2hXGbQcH+D4U0jAQE376VSUVMQmdg=XFA@mail.gmail.com>
Subject: Re: [PATCH 06/12] dma-mapping: improve selection of
 dma_declare_coherent availability
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux IOMMU <iommu@lists.linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, x86@kernel.org,
        arcml <linux-snps-arc@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv@lists.infradead.org,
        SH-Linux <linux-sh@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 7:37 AM Christoph Hellwig <hch@lst.de> wrote:
>
> This API is primarily used through DT entries, but two architectures
> and two drivers call it directly.  So instead of selecting the config
> symbol for random architectures pull it in implicitly for the actual
> users.  Also rename the Kconfig option to describe the feature better.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arc/Kconfig            | 1 -
>  arch/arm/Kconfig            | 2 +-
>  arch/arm64/Kconfig          | 1 -
>  arch/csky/Kconfig           | 1 -
>  arch/mips/Kconfig           | 1 -
>  arch/riscv/Kconfig          | 1 -
>  arch/sh/Kconfig             | 2 +-
>  arch/unicore32/Kconfig      | 1 -
>  arch/x86/Kconfig            | 1 -
>  drivers/mfd/Kconfig         | 2 ++
>  drivers/of/Kconfig          | 3 ++-
>  include/linux/device.h      | 2 +-
>  include/linux/dma-mapping.h | 8 ++++----
>  kernel/dma/Kconfig          | 2 +-
>  kernel/dma/Makefile         | 2 +-
>  15 files changed, 13 insertions(+), 17 deletions(-)

> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index 3607fd2810e4..f8c66a9472a4 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -43,6 +43,7 @@ config OF_FLATTREE
>
>  config OF_EARLY_FLATTREE
>         bool
> +       select DMA_DECLARE_COHERENT

Is selecting DMA_DECLARE_COHERENT okay on UML? We run the unittests with UML.

Maybe we should just get rid of OF_RESERVED_MEM. If we support booting
from DT, then it should always be enabled anyways.

>         select OF_FLATTREE
>
>  config OF_PROMTREE
> @@ -83,7 +84,7 @@ config OF_MDIO
>  config OF_RESERVED_MEM
>         bool
>         depends on OF_EARLY_FLATTREE
> -       default y if HAVE_GENERIC_DMA_COHERENT || DMA_CMA
> +       default y if DMA_DECLARE_COHERENT || DMA_CMA
>
>  config OF_RESOLVE
>         bool
