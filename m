Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66BBC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4D82086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZprpHbm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C4D82086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbeKQKA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 05:00:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:55806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbeKQKA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 05:00:58 -0500
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C09D208E7;
        Fri, 16 Nov 2018 23:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542411991;
        bh=hVHTLWoTi6h7twdkc5Il2QJdnN+zlk6t2gN1o1xiu7o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pZprpHbm4l4F6xFYfKohURsdwr1wGketAu9LAMMUxg0u9sPxbRzl3YSJ0DrO1UII9
         zCpueg6nuA+ECWps7g2Qm2tTKVYNJJrREQQn1jUc0gZ16Y1HNrwdvWKyecPPkZBuPc
         i4LwvKysUca5HGBncqcUXfLsQIvAVYrUSpRHxYBo=
Received: by mail-wm1-f46.google.com with SMTP id r11-v6so173527wmb.2;
        Fri, 16 Nov 2018 15:46:31 -0800 (PST)
X-Gm-Message-State: AGRZ1gLx3OSczR/7pTfvZ45JfJ7kyCkkECCrj8OuEU6JeCJoqYa1REQ4
        NG4htUqBI/KyeKSSnUtIjVL6c/2FWaIH0s0TuWY=
X-Google-Smtp-Source: AFSGD/Xfxywgd49qaqDyIdS3NQnQFt6V5XMqepubJ61UOrMATYmYCffYuZSvA5sZk+pR08vlvO60iDnLqAmzVPzsMms=
X-Received: by 2002:a1c:8d86:: with SMTP id p128-v6mr209011wmd.48.1542411989877;
 Fri, 16 Nov 2018 15:46:29 -0800 (PST)
MIME-Version: 1.0
References: <20181116220540.17222-1-robh@kernel.org> <20181116220540.17222-4-robh@kernel.org>
In-Reply-To: <20181116220540.17222-4-robh@kernel.org>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Fri, 16 Nov 2018 15:46:19 -0800
X-Gmail-Original-Message-ID: <CAGp9LzpgZsj79Tf5Hee45Wt6ag+WHV0SMWd6qvvtj4G3pzAZKQ@mail.gmail.com>
Message-ID: <CAGp9LzpgZsj79Tf5Hee45Wt6ag+WHV0SMWd6qvvtj4G3pzAZKQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: Convert to using %pOFn instead of device_node.name
To:     robh@kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 2:06 PM Rob Herring <robh@kernel.org> wrote:
>
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Cc: Sean Wang <sean.wang@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Sean Wang <sean.wang@kernel.org>

> ---
>  drivers/pinctrl/mediatek/pinctrl-paris.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
> index d2179028f134..7ff5ffa88198 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-paris.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
> @@ -419,8 +419,8 @@ static int mtk_pctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
>
>         pins = of_find_property(node, "pinmux", NULL);
>         if (!pins) {
> -               dev_err(hw->dev, "missing pins property in node %s .\n",
> -                       node->name);
> +               dev_err(hw->dev, "missing pins property in node %pOFn .\n",
> +                       node);
>                 return -EINVAL;
>         }
>
> --
> 2.19.1
>
