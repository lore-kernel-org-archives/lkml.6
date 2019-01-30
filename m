Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA59C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1FA20989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hTsBX6nZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbfA3TCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:02:53 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35885 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfA3TCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:02:53 -0500
Received: by mail-lj1-f195.google.com with SMTP id g11-v6so551101ljk.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 11:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ncM9ihRYoY9Br1fhJmYOdQ+HKk2h3TZyaw64RU6uDOw=;
        b=hTsBX6nZyMVwIEswxD/WcNLQml5CzOjZ/eIFeenhQo2k9utHzPfOKU6pXzOiqGfI3v
         FCIgXw7/im16Zgta/ZoxDvMysKaz+zFEGf4fXxAS0C8exFQuokKRynieGyP/ZQfKZLlO
         IPk57E1LMea0CIZ8XUDH7fJYup0061Bx3vKBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ncM9ihRYoY9Br1fhJmYOdQ+HKk2h3TZyaw64RU6uDOw=;
        b=UxyI9QMDL5MaIDe+MNC60RnmaVjLLuaKlDFP6Rl15DpWb8XvK02ybov3oT2hvfuR3B
         prVQRo7H0hjOabXbiudLLn9ek/t3FANkrY0Ghuv1/AUlFAC3vzBnJ/w7jKh3hGwPV9qm
         UtfTFqycWqxDQbgSWxXLTjcUWQvBmzDyduIF6OahMbm1aGs1jEsOyJ+Bq0rON+kYV84m
         qN5PrJjCOo9chpyfzxmjPUoQMjpSmqbfEtg2IokeDUcN/iI9ZeN/0IeJAYUT9gOdNFXB
         HIY9bzXaldYd8NcfAq0/eV2civckCMOQUAE8TWqK3R4iF/W0UasgEobog5UDbtP5XuY9
         JdCg==
X-Gm-Message-State: AJcUukeDsClHoP62gDoB/D8L3qztZ/Q+sGvOlez5A7m4ES/0FgEp7aSa
        59k3NssguMr+XvkIySDvuKyOTbS51JY=
X-Google-Smtp-Source: ALg8bN6AdzbcYPESXN2oaSbAs/wCpqRQYLyiq0Fq1e5p8Ufsku1b1c0Cea2FAiwq7VKbepAIQ27eeQ==
X-Received: by 2002:a2e:e02:: with SMTP id 2-v6mr25354992ljo.10.1548874970872;
        Wed, 30 Jan 2019 11:02:50 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id m10-v6sm407144ljj.34.2019.01.30.11.02.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 11:02:50 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id g11-v6so551072ljk.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 11:02:50 -0800 (PST)
X-Received: by 2002:a2e:6109:: with SMTP id v9-v6mr24571224ljb.126.1548874581917;
 Wed, 30 Jan 2019 10:56:21 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com> <1546314952-15990-15-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-15-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 30 Jan 2019 10:55:45 -0800
X-Gmail-Original-Message-ID: <CAE=gft58E0p3KEYLtKZBfvGysNq+CfX5LDR38incdM+tjDr-1g@mail.gmail.com>
Message-ID: <CAE=gft58E0p3KEYLtKZBfvGysNq+CfX5LDR38incdM+tjDr-1g@mail.gmail.com>
Subject: Re: [PATCH v5 14/20] iommu/mediatek: Add mmu1 support
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
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

On Mon, Dec 31, 2018 at 7:59 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> Normally the M4U HW connect EMI with smi. the diagram is like below:
>               EMI
>                |
>               M4U
>                |
>             smi-common
>                |
>        -----------------
>        |    |    |     |    ...
>     larb0 larb1  larb2 larb3
>
> Actually there are 2 mmu cells in the M4U HW, like this diagram:
>
>               EMI
>            ---------
>             |     |
>            mmu0  mmu1     <- M4U
>             |     |
>            ---------
>                |
>             smi-common
>                |
>        -----------------
>        |    |    |     |    ...
>     larb0 larb1  larb2 larb3
>
> This patch add support for mmu1. In order to get better performance,
> we could adjust some larbs go to mmu1 while the others still go to
> mmu0. This is controlled by a SMI COMMON register SMI_BUS_SEL(0x220).
>
> mt2712, mt8173 and mt8183 M4U HW all have 2 mmu cells. the default
> value of that register is 0 which means all the larbs go to mmu0
> defaultly.
>
> This is a preparing patch for adjusting SMI_BUS_SEL for mt8183.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 47 +++++++++++++++++++++++++++++------------------
>  1 file changed, 29 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 66e3615..7fcef19 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -70,27 +70,32 @@
>  #define F_MISS_FIFO_ERR_INT_EN                 BIT(6)
>  #define F_INT_CLR_BIT                          BIT(12)
>
> -#define REG_MMU_INT_MAIN_CONTROL               0x124
> -#define F_INT_TRANSLATION_FAULT                        BIT(0)
> -#define F_INT_MAIN_MULTI_HIT_FAULT             BIT(1)
> -#define F_INT_INVALID_PA_FAULT                 BIT(2)
> -#define F_INT_ENTRY_REPLACEMENT_FAULT          BIT(3)
> -#define F_INT_TLB_MISS_FAULT                   BIT(4)
> -#define F_INT_MISS_TRANSACTION_FIFO_FAULT      BIT(5)
> -#define F_INT_PRETETCH_TRANSATION_FIFO_FAULT   BIT(6)
> +#define REG_MMU_INT_MAIN_CONTROL               0x124 /* mmu0 | mmu1 */

The comment being on that line is kind of weird, since the comment
really applies to the lines below it. Maybe the comment should be on
its own line, or on the TRANSLATION_FAULT line.

Other than that,
Reviewed-by: Evan Green <evgreen@chromium.org>
