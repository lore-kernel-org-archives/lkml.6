Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725D0C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD5D2083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAgFsP2K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CD5D2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeHaVmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 17:42:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbeHaVmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 17:42:54 -0400
Received: from localhost (unknown [104.132.0.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB70B20837;
        Fri, 31 Aug 2018 17:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535736862;
        bh=P+FS6F8pnbg0nJKzYAGqeE/zqh+YPdCKyYkNdNzgZW0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=cAgFsP2K7Wmxifj+5K+/v0PyzwLXtTqHgET4CaAvRONmX2krMWUoyGSFekGmU8mVp
         yAhfy+SfQnosIw6kFr7EoSjPwIvGCZ76w1JQ/Dgv+H2Ayes8sRJ5PGeXhAmGgHKXvV
         b4vmvu8RccLP8dYPaQd+Gq92NThJAmhXVu6bUVXg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Tony Xie <tony.xie@rock-chips.com>, heiko@sntech.de
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1535081762-20844-1-git-send-email-tony.xie@rock-chips.com>
Cc:     broonie@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, linux-clk@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com, tony.xie@rock-chips.com
References: <1535081441-20718-1-git-send-email-tony.xie@rock-chips.com>
 <1535081762-20844-1-git-send-email-tony.xie@rock-chips.com>
Message-ID: <153573686206.93865.11806745452503167124@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 5/5] clk: RK808: add RK809 and RK817 support.
Date:   Fri, 31 Aug 2018 10:34:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tony Xie (2018-08-23 20:36:02)
> diff --git a/drivers/clk/clk-rk808.c b/drivers/clk/clk-rk808.c
> index 6461f28..c5d3492 100644
> --- a/drivers/clk/clk-rk808.c
> +++ b/drivers/clk/clk-rk808.c
> @@ -96,6 +96,66 @@ static int rk808_clkout2_is_prepared(struct clk_hw *hw)
> +
> +static int rk817_clkout2_is_prepared(struct clk_hw *hw)
> +{
> +       struct rk808_clkout *rk808_clkout =3D container_of(hw,
> +                                                        struct rk808_clk=
out,
> +                                                        clkout2_hw);
> +       struct rk808 *rk808 =3D rk808_clkout->rk808;
> +       unsigned int val;
> +
> +       int ret =3D regmap_read(rk808->regmap, RK817_SYS_CFG(1), &val);
> +
> +       if (ret < 0)
> +               return ret;

The clk core handles the return value here as true or false. Probably
should return 0 here.

> +
> +       return (val & RK817_CLK32KOUT2_EN) ? 1 : 0;
> +}
> +
> +static const struct clk_ops rk817_clkout2_ops =3D {
> +       .prepare =3D rk817_clkout2_prepare,
> +       .unprepare =3D rk817_clkout2_unprepare,
> +       .is_prepared =3D rk817_clkout2_is_prepared,
> +       .recalc_rate =3D rk808_clkout_recalc_rate,
> +};
> +
> +static const struct clk_ops *rkpmic_get_ops(long variant)

Use the enum here for 'variant'? Then the case statement here will
complain loudly for unhandled cases.

> +{
> +       switch (variant) {
> +       case RK809_ID:
> +       case RK817_ID:
> +               return &rk817_clkout2_ops;
> +       case RK805_ID:
> +       case RK808_ID:
> +       case RK818_ID:
> +               return &rk808_clkout2_ops;
> +       }
> +
> +       return &rk808_clkout2_ops;
> +}
> +
>  static int rk808_clkout_probe(struct platform_device *pdev)
>  {
>         struct rk808 *rk808 =3D dev_get_drvdata(pdev->dev.parent);
> @@ -127,7 +187,7 @@ static int rk808_clkout_probe(struct platform_device =
*pdev)
>                 return ret;
>  =

>         init.name =3D "rk808-clkout2";
> -       init.ops =3D &rk808_clkout2_ops;
> +       init.ops =3D rkpmic_get_ops(rk808->variant);
>         rk808_clkout->clkout2_hw.init =3D &init;
>  =

>         /* optional override of the clockname */
> -- =

> 1.9.1
> =

>=20
