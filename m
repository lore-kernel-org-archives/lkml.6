Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 19A45C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEFBF208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEfbFlYb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEFBF208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933382AbeFLHoO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:44:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933183AbeFLHoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:44:12 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA9BD20693;
        Tue, 12 Jun 2018 07:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528789452;
        bh=boJl4BiFj3GCQcXfQ1Sm+ig3YG4CRoOiKbLZesvjy14=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=iEfbFlYbi0lPStpWLQeDRSvUeDxDsX10DxzkwZefX1wf+iZtgP8ot4LuFhHkJ7pST
         HQDj38Qg4LUK42uHA49vI7fB0M7eU/RSKc3DSwqxZtv3RbnyEhlupdRj4y06V2sS9z
         G7BAPhz7zyLuoVkywkrI/oz3N9WYummhR4sRHM5E=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        broonie@kernel.org, lee.jones@linaro.org, lgirdwood@gmail.com,
        mark.rutland@arm.com, mazziesaccount@gmail.com,
        mturquette@baylibre.com, robh+dt@kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <d99c8762b0fbbcb18ec4f4d104191364c0ea798c.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
References: <cover.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
 <d99c8762b0fbbcb18ec4f4d104191364c0ea798c.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
Message-ID: <152878945117.16708.12422348324182290971@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 4/4] clk: bd71837: Add driver for BD71837 PMIC clock
Date:   Tue, 12 Jun 2018 00:44:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matti Vaittinen (2018-06-04 06:19:13)
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 41492e980ef4..e693496f202a 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -279,6 +279,13 @@ config COMMON_CLK_STM32H7
>         ---help---
>           Support for stm32h7 SoC family clocks
>  =

> +config COMMON_CLK_BD71837
> +       tristate "Clock driver for ROHM BD71837 PMIC MFD"
> +       depends on MFD_BD71837
> +       help
> +         This driver supports ROHM BD71837 PMIC clock.
> +
> +

Drop one newline above.

>  source "drivers/clk/bcm/Kconfig"
>  source "drivers/clk/hisilicon/Kconfig"
>  source "drivers/clk/imgtec/Kconfig"
> diff --git a/drivers/clk/clk-bd71837.c b/drivers/clk/clk-bd71837.c
> new file mode 100644
> index 000000000000..5ba6c05c5a98
> --- /dev/null
> +++ b/drivers/clk/clk-bd71837.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 ROHM Semiconductors
> +// bd71837.c  -- ROHM BD71837MWV clock driver
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/mfd/bd71837.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>
> +
> +

Drop one newline above.

> +struct bd71837_clk {
> +       struct clk_hw hw;
> +       uint8_t reg;
> +       uint8_t mask;

Use u8 instead of uint8_t.

> +       unsigned long rate;
> +       struct platform_device *pdev;
> +       struct bd71837 *mfd;
> +};
> +
> +static int bd71837_clk_set(struct clk_hw *hw, int status)
> +{
> +       struct bd71837_clk *c =3D container_of(hw, struct bd71837_clk, hw=
);
> +
> +       return bd71837_update_bits(c->mfd, c->reg, c->mask, status);

Any reason we can't use a regmap?

> +}
> +
> +static void bd71837_clk_disable(struct clk_hw *hw)
> +{
> +       int rv;
> +       struct bd71837_clk *c =3D container_of(hw, struct bd71837_clk, hw=
);
> +
> +       rv =3D bd71837_clk_set(hw, 0);
> +       if (rv)
> +               dev_dbg(&c->pdev->dev, "Failed to disable 32K clk (%d)\n"=
, rv);
> +}
> +
> +static int bd71837_clk_enable(struct clk_hw *hw)
> +{
> +       return bd71837_clk_set(hw, 1);
> +}
> +
> +static int bd71837_clk_is_enabled(struct clk_hw *hw)
> +{
> +       struct bd71837_clk *c =3D container_of(hw, struct bd71837_clk, hw=
);
> +
> +       return c->mask & bd71837_reg_read(c->mfd, c->reg);

Didn't I ask for local variable for reg_read result?

> +}
> +
> +static unsigned long bd71837_clk_recalc_rate(struct clk_hw *hw,
> +                                            unsigned long parent_rate)
> +{
> +       struct bd71837_clk *c =3D container_of(hw, struct bd71837_clk, hw=
);
> +
> +       return c->rate;
> +}
> +
> +static const struct clk_ops bd71837_clk_ops =3D {
> +       .recalc_rate =3D &bd71837_clk_recalc_rate,
> +       .prepare =3D &bd71837_clk_enable,
> +       .unprepare =3D &bd71837_clk_disable,
> +       .is_prepared =3D &bd71837_clk_is_enabled,
> +};
> +
> +static int bd71837_clk_probe(struct platform_device *pdev)
> +{
> +       struct bd71837_clk *c;
> +       int rval =3D -ENOMEM;
> +       struct bd71837 *mfd =3D dev_get_drvdata(pdev->dev.parent);
> +       struct clk_init_data init =3D {
> +               .name =3D "bd71837-32k-out",
> +               .ops =3D &bd71837_clk_ops,
> +       };
> +
> +       c =3D devm_kzalloc(&pdev->dev, sizeof(*c), GFP_KERNEL);
> +       if (!c)
> +               goto err_out;
> +
> +       c->reg =3D BD71837_REG_OUT32K;
> +       c->mask =3D BD71837_OUT32K_EN;
> +       c->rate =3D BD71837_CLK_RATE;

The PMIC has an 'XIN' pin that would be the clk input for this chip, and
the output clk, this driver, would specify that xin clock as the parent.
The 'xin' clock would then be listed in DT as a fixed-rate clock. That
way this driver doesn't hardcode the frequency.

> +       c->mfd =3D mfd;
> +       c->pdev =3D pdev;
> +
> +       of_property_read_string_index(pdev->dev.parent->of_node,
> +                                             "clock-output-names", 0,
> +                                             &init.name);
> +
> +       c->hw.init =3D &init;

Do this next to all the other c-> things?

> +
> +       rval =3D devm_clk_hw_register(&pdev->dev, &c->hw);
> +       if (rval) {
> +               dev_err(&pdev->dev, "failed to register 32K clk");
> +               goto err_out;
> +       }
> +
> +       if (pdev->dev.parent->of_node) {
> +               rval =3D of_clk_add_hw_provider(pdev->dev.parent->of_node,
> +                                            of_clk_hw_simple_get,
> +                                            &c->hw);
> +               if (rval) {
> +                       dev_err(&pdev->dev, "adding clk provider failed\n=
");
> +                       goto err_out;

Just return rval instead of goto and then remove err_out label.

> +               }
> +       }
> +
> +       rval =3D clk_hw_register_clkdev(&c->hw, init.name, NULL);

This leaks a clkdev lookup. Sad we don't have a devm version. Maybe it
should be added. But I really doubt this chip will be used with clkdev
lookups so please remove clkdev until you have a user who needs it.

> +       if (rval) {
> +               dev_err(&pdev->dev, "failed to register clkdev for bd7183=
7");
> +               goto err_clean_provider;
> +       }
> +
> +       platform_set_drvdata(pdev, c);
> +
> +       return 0;
> +
> +err_clean_provider:
> +       of_clk_del_provider(pdev->dev.parent->of_node);
> +err_out:
> +       return rval;
> +}
> +
> +static int bd71837_clk_remove(struct platform_device *pdev)
> +{
> +       if (pdev->dev.parent->of_node)
> +               of_clk_del_provider(pdev->dev.parent->of_node);

Use devm so this can go away. Or is devm not used because the parent
of_node is the provider? That's annoying.

> +       return 0;
> +}
> +
