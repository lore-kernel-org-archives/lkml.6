Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F80C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DE421872
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550078066;
	bh=o45AkmZPc7WsoEj8sr1V/Y30S0WSYywOZiHs1ICTHBY=;
	h=To:In-Reply-To:Subject:References:Cc:From:Date:List-ID:From;
	b=X3iB2RxKtjNyEXAH8dnJzki7EPP3oocLg0soqlqByAHL/WFeXC4XeRO8btubocbbd
	 QVlW8ZxYD2nfqzCloAClcpg9q99U1tPM2MFU4hktcerdcmXliF056C7STQQlxP3H/C
	 T95zARKlVfPi/nVdaxdKwYt6Si7/6V9qnFhkj9ic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392798AbfBMROY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:14:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:49700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729760AbfBMROY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:14:24 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60ED120821;
        Wed, 13 Feb 2019 17:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550078063;
        bh=o45AkmZPc7WsoEj8sr1V/Y30S0WSYywOZiHs1ICTHBY=;
        h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
        b=LmtamxuT9jiIIAXCM081Bqc4MecnuvxG6wgq6XJwOLyZaTv6eVvkVYjlpKSfFWZlM
         brSHzlw80cfQAsRuQlqRQnKxTLoyc/i3WRj0z7bctcln6HRtxz6ViqtQk6rqZXWbEt
         vNZEhZoyETdHzxTeJsJ+7h6s+DXN7V+EO46knIYc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
In-Reply-To: <20190211135818.10518-1-thomas.petazzoni@bootlin.com>
User-Agent: alot/0.8
Subject: Re: [PATCH] clk: clk-gpio: add support for sleeping GPIOs in gpio-gate-clk
Message-ID: <155007806256.115909.10137511038361789251@swboyd.mtv.corp.google.com>
References: <20190211135818.10518-1-thomas.petazzoni@bootlin.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Wed, 13 Feb 2019 09:14:22 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Thomas Petazzoni (2019-02-11 05:58:18)
> The current implementation of gpio-gate-clk enables/disables the clock
> using the GPIO in the ->enable() and ->disable() clock callbacks. This
> requires the GPIO to be configurable in atomic contexts. While it is
> the case for most memory-mapped GPIO controllers, it is not the case
> for GPIO expanders on I2C or SPI.
>=20
> This commit extends the gpio-gate-clk to check whether the GPIO calls
> require sleeping or not. If sleeping is not required, the current
> implementation based on ->enable()/->disable() is kept. However, if
> sleeping is needed, we instead implement the logic in the ->prepare()
> and ->unprepare() hooks. Thanks to this, a gate clock connected to a
> GPIO on a GPIO expander can be controlled with the existing driver.
>=20
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Sounds like a good idea!

> diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
> index 6a43ce420492..f5d481713c7d 100644
> --- a/drivers/clk/clk-gpio.c
> +++ b/drivers/clk/clk-gpio.c
> @@ -61,6 +61,35 @@ const struct clk_ops clk_gpio_gate_ops =3D {
>  };
>  EXPORT_SYMBOL_GPL(clk_gpio_gate_ops);
> =20
> +static int clk_sleeping_gpio_gate_prepare(struct clk_hw *hw)
> +{
> +       struct clk_gpio *clk =3D to_clk_gpio(hw);
> +
> +       gpiod_set_value_cansleep(clk->gpiod, 1);
> +
> +       return 0;
> +}
> +
> +static void clk_sleeping_gpio_gate_unprepare(struct clk_hw *hw)
> +{
> +       struct clk_gpio *clk =3D to_clk_gpio(hw);
> +
> +       gpiod_set_value_cansleep(clk->gpiod, 0);
> +}
> +
> +static int clk_sleeping_gpio_gate_is_prepared(struct clk_hw *hw)
> +{
> +       struct clk_gpio *clk =3D to_clk_gpio(hw);
> +
> +       return gpiod_get_value_cansleep(clk->gpiod);
> +}
> +
> +const struct clk_ops clk_sleeping_gpio_gate_ops =3D {

static?

> +       .prepare =3D clk_sleeping_gpio_gate_prepare,
> +       .unprepare =3D clk_sleeping_gpio_gate_unprepare,
> +       .is_prepared =3D clk_sleeping_gpio_gate_is_prepared,
> +};
> +
>  /**
>   * DOC: basic clock multiplexer which can be controlled with a gpio outp=
ut
>   * Traits of this clock:
