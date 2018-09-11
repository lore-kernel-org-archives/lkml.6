Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D93C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F5520839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F5520839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbeIKULb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:11:31 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:46195 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbeIKULb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:11:31 -0400
Received: by mail-ua1-f68.google.com with SMTP id u11-v6so20872067uan.13;
        Tue, 11 Sep 2018 08:11:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SZceYUH15uGloSr0raN/TOgjhR0tnis97TnXtTyPIm0=;
        b=Mqp3ViP2Li+jIhDExq8XXND6AUqdqt4XuhyHt2X894Fk6HmvsbYs6SxitgZS+6gerF
         V8CxzfW1M6KqAqykHiP+N2uCPqFAXd9eGaeiP4lo2R3ZcEF9bMiN3hfP93S1/4l/RC2m
         nivti8ywyeCXTm4fsQDdycpXLbcZ8sA/01vrEsl9zLz9K1YchMc/RoAsWkiDbZioWBV3
         x1gPB3X2H5SddtABaZVKsX1IYDP/IqFGR1b23D0HGzG8zlHUcfu43Su1vIGQjsq2B6CO
         yyCslfK8+1ISEsYc8B6LYNb6sWJLF+p0SetPOl9KQiuxljx7eZ/TBy4dSR6zvtc1n/Sl
         k2tg==
X-Gm-Message-State: APzg51Cck6nCuAL2tmIYO9lQ2iwh6/+nxovDNrTFw6WwL4xY29LYD2CA
        CM7kjRKqtZL7nfdYjumWd6m/5d2wml95DGdhC3Q=
X-Google-Smtp-Source: ANB0VdYgbgtZ4ty4Bbt9Co4+w9O0nAQyAhcQGqkuZUOGOs/yqBnSrlv79Xt2tI2nECyoLF0RUAuvjSFoLURqjs2V9EQ=
X-Received: by 2002:ab0:60c6:: with SMTP id g6-v6mr9752010uam.41.1536678706281;
 Tue, 11 Sep 2018 08:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180911150020.53768-1-hangdianqj@163.com>
In-Reply-To: <20180911150020.53768-1-hangdianqj@163.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Sep 2018 17:11:34 +0200
Message-ID: <CAMuHMdWjKLqRPW=mUEk8LxWoSQSgw25p60PPL9WE=d12YfD-4g@mail.gmail.com>
Subject: Re: [PATCH] Iommu: ipmmu-vmsa: replace spin_lock_irqsave with
 spin_lock in ISR
To:     hangdianqj@163.com
Cc:     Joerg Roedel <joro@8bytes.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC linux-renesas-soc

On Tue, Sep 11, 2018 at 5:01 PM jun qian <hangdianqj@163.com> wrote:
>
> As you are already in ISR, it is unnecessary to call spin_lock_irqsave.
>
> Signed-off-by: jun qian <hangdianqj@163.com>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 22b94f8a9a04..afa23d53502c 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -569,9 +569,8 @@ static irqreturn_t ipmmu_irq(int irq, void *dev)
>         struct ipmmu_vmsa_device *mmu = dev;
>         irqreturn_t status = IRQ_NONE;
>         unsigned int i;
> -       unsigned long flags;
>
> -       spin_lock_irqsave(&mmu->lock, flags);
> +       spin_lock(&mmu->lock);
>
>         /*
>          * Check interrupts for all active contexts.
> @@ -583,7 +582,7 @@ static irqreturn_t ipmmu_irq(int irq, void *dev)
>                         status = IRQ_HANDLED;
>         }
>
> -       spin_unlock_irqrestore(&mmu->lock, flags);
> +       spin_unlock(&mmu->lock);
>
>         return status;
>  }
> --
> 2.17.1
