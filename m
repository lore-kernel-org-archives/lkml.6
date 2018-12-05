Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92B7C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDFF20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544042562;
	bh=56xfK0f4Jt74vV+P9zWL3U/Bkp/4KRIX7RZj0NEPRr0=;
	h=To:From:In-Reply-To:Cc:References:Subject:Date:List-ID:From;
	b=01flRPcFYJ3AXLSTn+8KdcM3kVFAPJu5/3YawfLxUZdBCord/hHxRb64UHzYC0UOL
	 m+DN1+3uTTR6XGstapFjzN5PJ+xfI+P2JyjzyJgA4TPSTfNAzWb3mxLH6J7e7sWV2Y
	 zdbZOEp03OxxkhIuvE0j7vcefkIolfLlXLVB9Lyc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DDFF20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbeLEUml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:42:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:55414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728138AbeLEUmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 15:42:37 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F7DB20850;
        Wed,  5 Dec 2018 20:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544042556;
        bh=56xfK0f4Jt74vV+P9zWL3U/Bkp/4KRIX7RZj0NEPRr0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=MVdjBsO1hVkzpxirhypwazW4HjjQKAJKXwRrZu/mcqwA22pBB2uIh5p5MJ/QV8Ayc
         fQHZYj8nE8Z2guy8DHNw+MEsrtINut/GAkRbgZgEh0BDb+J9lfXNyJbLDQ6ZLy609P
         cwBkwHuoPrHWgrDIp+UAMsGGT6Nyjx7ceshKPU2Y=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Tali Perry <tali.perry1@gmail.com>, avifishman70@gmail.com,
        brendanhiggins@google.com, mturquette@baylibre.com,
        tmaimon77@gmail.com, venture@google.com, yuenn@google.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181205194702.257430-3-tali.perry1@gmail.com>
Cc:     openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tali Perry <tali.perry1@gmail.com>
References: <20181205194702.257430-1-tali.perry1@gmail.com>
 <20181205194702.257430-3-tali.perry1@gmail.com>
Message-ID: <154404255553.88331.5492676494542176052@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v1 1/1] clk: npcm: get fixed input clks from DT
Date:   Wed, 05 Dec 2018 12:42:35 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tali Perry (2018-12-05 11:47:02)
> ---

No commit text? No Signed-off-by?

Sorry, I don't understand what this patch is for or what's going on.

>  drivers/clk/clk-npcm7xx.c | 64 +++++++++++++++++++++++++++++++++++++++--=
------
>  1 file changed, 53 insertions(+), 11 deletions(-)
> =

> diff --git a/drivers/clk/clk-npcm7xx.c b/drivers/clk/clk-npcm7xx.c
> index 27a86b7a34db..25f8ccaa3d2f 100644
> --- a/drivers/clk/clk-npcm7xx.c
> +++ b/drivers/clk/clk-npcm7xx.c
> @@ -8,17 +8,23 @@
>   */
>  =

>  #include <linux/module.h>
> +#include <linux/clk.h>
>  #include <linux/clk-provider.h>
> +#include <linux/device.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
>  #include <linux/of_address.h>
> +#include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/err.h>
> +#include <linux/rational.h>
>  #include <linux/bitfield.h>
> -
>  #include <dt-bindings/clock/nuvoton,npcm7xx-clock.h>
>  =

> +

I don't get it. Please don't send random whitespace changes in a patch.

>  struct npcm7xx_clk_pll {
>         struct clk_hw   hw;
>         void __iomem    *pllcon;
> @@ -44,7 +50,8 @@ static unsigned long npcm7xx_clk_pll_recalc_rate(struct=
 clk_hw *hw,
>         u64 ret;
>  =

>         if (parent_rate =3D=3D 0) {
> -               pr_err("%s: parent rate is zero", __func__);
> +               pr_err("%s: parent rate is zero. reg=3D%s\n", __func__,
> +                      hw->init->name);

Why do we care?

>                 return 0;
>         }
>  =

> @@ -544,12 +552,14 @@ static void __init npcm7xx_clk_init(struct device_n=
ode *clk_np)
>         void __iomem *clk_base;
>         struct resource res;
>         struct clk_hw *hw;
> +       struct clk *clk;
>         int ret;
>         int i;
>  =

> +       clk_base =3D NULL;
>         ret =3D of_address_to_resource(clk_np, 0, &res);
>         if (ret) {
> -               pr_err("%pOFn: failed to get resource, ret %d\n", clk_np,
> +               pr_err("%s: failed to get resource, ret %d\n", clk_np->na=
me,
>                         ret);
>                 return;
>         }

Drop this change as it's making things worse.

> @@ -558,9 +568,10 @@ static void __init npcm7xx_clk_init(struct device_no=
de *clk_np)
>         if (!clk_base)
>                 goto npcm7xx_init_error;
>  =

> -       npcm7xx_clk_data =3D kzalloc(struct_size(npcm7xx_clk_data, hws,
> -                                  NPCM7XX_NUM_CLOCKS), GFP_KERNEL);
> -       if (!npcm7xx_clk_data)
> +       npcm7xx_clk_data =3D kzalloc(sizeof(*npcm7xx_clk_data->hws) *
> +               NPCM7XX_NUM_CLOCKS + sizeof(npcm7xx_clk_data), GFP_KERNEL=
);
> +
> +       if (!npcm7xx_clk_data->hws)
>                 goto npcm7xx_init_np_err;
>  =

>         npcm7xx_clk_data->num =3D NPCM7XX_NUM_CLOCKS;

Drop this hunk.

