Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2FAC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1D9218C3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549474291;
	bh=HGubEtjIHhsvq9MuLdRsz8HHicpY8WIhrCPqCiQFXTk=;
	h=Cc:Subject:In-Reply-To:From:To:References:Date:List-ID:From;
	b=SCJf/n4ZNy6BlPx4vKDtBuBt7982+wWp+O8xw1Txw6gMkLfsF0GojYYeQwnDl0Soc
	 TKWb8YRohSUJggA0auZ4DtHZKS6PhFpgE8Pt0KzTJaP37eiTEi3sfOS5wBso8Yba7V
	 zt6evEHwaZzNRCxbrRtvaQ043EF7ruXBlHWe/n1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbfBFRb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:31:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:49722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbfBFRb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:31:29 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D1822186A;
        Wed,  6 Feb 2019 17:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549474288;
        bh=HGubEtjIHhsvq9MuLdRsz8HHicpY8WIhrCPqCiQFXTk=;
        h=Cc:Subject:In-Reply-To:From:To:References:Date:From;
        b=Reyug6fd3OUcYvbvFhTk+MfA57kNbREfhXEYkoxak7jkY7uD/y+gxJyv89r3ESgHv
         4o1btrZ7IvQ2sJuYUgAmsT4n48npD4z8a6gEuYLiSHOq1Zgo7muTg5grLEdY4OYq8a
         rHv0njcYEvx6bM1hfQflDa7UgvHI4tmW1gu6pvfs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
User-Agent: alot/0.8
Cc:     Guenter Roeck <linux@roeck-us.net>,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, sre@kernel.org, lgirdwood@gmail.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        wim@linux-watchdog.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v7 05/10] clk: bd718x7: Support ROHM BD70528 clk block
In-Reply-To: <88c49b30bbb4b1f3ecc24d333647585e2c82f4e4.1549444366.git.matti.vaittinen@fi.rohmeurope.com>
From:   Stephen Boyd <sboyd@kernel.org>
Message-ID: <154947428734.74891.4523492147164733315@swboyd.mtv.corp.google.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mazziesaccount@gmail.com
References: <cover.1549444366.git.matti.vaittinen@fi.rohmeurope.com> <88c49b30bbb4b1f3ecc24d333647585e2c82f4e4.1549444366.git.matti.vaittinen@fi.rohmeurope.com>
Date:   Wed, 06 Feb 2019 09:31:27 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matti Vaittinen (2019-02-06 01:39:38)
> @@ -86,9 +87,21 @@ static int bd71837_clk_probe(struct platform_device *p=
dev)
>                 dev_err(&pdev->dev, "No parent clk found\n");
>                 return -EINVAL;
>         }
> -
> -       c->reg =3D BD718XX_REG_OUT32K;
> -       c->mask =3D BD718XX_OUT32K_EN;
> +       switch (mfd->chip_type) {
> +       case ROHM_CHIP_TYPE_BD71837:
> +       case ROHM_CHIP_TYPE_BD71847:
> +

Nitpick: why the extra newline above?

> +               c->reg =3D BD718XX_REG_OUT32K;
> +               c->mask =3D BD718XX_OUT32K_EN;
> +               break;
> +       case ROHM_CHIP_TYPE_BD70528:
> +               c->reg =3D BD70528_REG_CLK_OUT;
> +               c->mask =3D BD70528_CLK_OUT_EN_MASK;
> +               break;
> +       default:
> +               dev_err(&pdev->dev, "Unknown clk chip\n");
> +               return -EINVAL;
> +       }
>         c->mfd =3D mfd;
>         c->pdev =3D pdev;
>         c->hw.init =3D &init;
