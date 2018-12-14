Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F4AC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20102080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544824949;
	bh=Xr+Lz27jUrQWOlcWPdqsznHh3qyhbXL1SkP3Xg/000g=;
	h=In-Reply-To:Subject:To:References:From:Cc:Date:List-ID:From;
	b=ogwNIo7lfx7qe1mGVutSMwS7MJjCK0l5mtN4T3Jz5dkUxDGnu+5w2AkW/nw2RrZMI
	 V0tUTTlOJCML2wTjDo+fPsVHHvt2t4PuJlgqjy9cAph8Zg3+Y6LCDH6bt5LnAvXbqO
	 6qz13bVmOdtgta9b3SjIGR8VK3t8CX2HhaGtgIAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbeLNWC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:02:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:53624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731263AbeLNWC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:02:26 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95F02206C0;
        Fri, 14 Dec 2018 22:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544824946;
        bh=Xr+Lz27jUrQWOlcWPdqsznHh3qyhbXL1SkP3Xg/000g=;
        h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
        b=qXAfPIZseaaJUofwERvW1ix0T3TdYcqPRGjbWyscaN8J4h6xWPZHqO5vE0tWmP2Tv
         uHLg7XcRwZqLiBIloObhooZfSUgywQ5gO/RCNou8SIVy0s5Ygcu6o3TQogrjxaqoEo
         hCT6BjX9rEzdt7l6CE/zSFXgdx/J6YEPPXQ9nncw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181210073240.32278-5-weiyi.lu@mediatek.com>
Subject: Re: [PATCH v3 03/12] clk: mediatek: add configurable pcwibits and fmin to mtk_pll_data
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>
References: <20181210073240.32278-1-weiyi.lu@mediatek.com> <20181210073240.32278-5-weiyi.lu@mediatek.com>
Message-ID: <154482494548.19322.11090762587126084086@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Cc:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, stable@vger.kernel.org,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>
Date:   Fri, 14 Dec 2018 14:02:25 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Weiyi Lu (2018-12-09 23:32:31)
> diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pl=
l.c
> index f0ff5f535c7e..81400601f107 100644
> --- a/drivers/clk/mediatek/clk-pll.c
> +++ b/drivers/clk/mediatek/clk-pll.c
> @@ -69,11 +71,13 @@ static unsigned long __mtk_pll_recalc_rate(struct mtk=
_clk_pll *pll, u32 fin,
>  {
>         int pcwbits =3D pll->data->pcwbits;
>         int pcwfbits;
> +       int ibits;
>         u64 vco;
>         u8 c =3D 0;
> =20
>         /* The fractional part of the PLL divider. */
> -       pcwfbits =3D pcwbits > INTEGER_BITS ? pcwbits - INTEGER_BITS : 0;
> +       ibits =3D pll->data->pcwibits ? pll->data->pcwibits : INTEGER_BIT=
S;
> +       pcwfbits =3D pcwbits > ibits ? pcwbits - ibits : 0;

This is practically unreadable. It should be changed to an if statement.

> =20
>         vco =3D (u64)fin * pcw;
> =20
> @@ -167,9 +171,10 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll=
 *pll, u32 pcw,
>  static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *=
postdiv,
>                 u32 freq, u32 fin)
>  {
> -       unsigned long fmin =3D 1000 * MHZ;
> +       unsigned long fmin =3D pll->data->fmin ? pll->data->fmin : (1000 =
* MHZ);
>         const struct mtk_pll_div_table *div_table =3D pll->data->div_tabl=
e;
>         u64 _pcw;
> +       int ibits;
>         u32 val;
> =20
>         if (freq > pll->data->fmax)
> @@ -193,7 +198,8 @@ static void mtk_pll_calc_values(struct mtk_clk_pll *p=
ll, u32 *pcw, u32 *postdiv,
>         }
> =20
>         /* _pcw =3D freq * postdiv / fin * 2^pcwfbits */
> -       _pcw =3D ((u64)freq << val) << (pll->data->pcwbits - INTEGER_BITS=
);
> +       ibits =3D pll->data->pcwibits ? pll->data->pcwibits : INTEGER_BIT=
S;
> +       _pcw =3D ((u64)freq << val) << (pll->data->pcwbits - ibits);

Similar comment. Readability is low here.

