Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A68C282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003212184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1K6N7yP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbfA3JM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:12:56 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45098 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbfA3JMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:12:55 -0500
Received: by mail-oi1-f194.google.com with SMTP id y1so18592019oie.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 01:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zEHiJ6X42KnikKy8hVZcznQNrRxmxs9IBM6mcXj8Ew0=;
        b=1K6N7yP76PtaXLZAW0tbpORDp96aX7KtRWaqkWEEd6AE1YW+HuY6wNLAMY0/9VMq92
         78W1QZ8sKE5E6N+dfpZBBA4KM+n48ebAHWNLLRFZ85AjXoEO3PjbpJr6dBe9MDTIJw8N
         tum5Cjm6dCShI1L5dhWIUILv+5k7L+kqEKsVLd7lwZGQFV/c6AHJMICLRv74PhwCDsir
         4HXIymV6F2GQ40GGJCyWagvsxSiRs2ybuEABYo/CwWdrQXXC2mVvxmwW7PifMkMc5a52
         jaEbtrt10Ry3r+04j8ooWFI4StjhfTOGDsMsLOejxw2gvssFIrCBXcxvlL97HctBv3aZ
         cP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zEHiJ6X42KnikKy8hVZcznQNrRxmxs9IBM6mcXj8Ew0=;
        b=lFCso558UHmpnjYgVwVBtmKsti7uFND//8f6J3ah8fSF8H7fXcfxsL80D/hvTh6UR/
         Be/Fpx8Rc01HQ3oQK5r3T8vmDy+wX2Ew1XtFzZvl3u473UXz0hX/NMjL+KMB2FS6HXFs
         fkikk6rPKrFtaKKMtRgXTI3r4EdRmcNwtohHbLYWNpELpCqde5U3JbAXKCV0BEn2KnG9
         MoGA4zaRiA7ylWoiVq6eytfKbpATwXbjcu7YnkQ0UhXde3RBhk8BjoTX89OlAtxN/QqX
         9/IqAB5D8JGMsVzAfGsNJKQdI6IafspKcpXQrF7SfCJ/b91wob9RrVPWXmmmPfxBaHar
         p4JQ==
X-Gm-Message-State: AHQUAubzSFKvWgMylb4lOGFjAOZ0Y/W67pdHgFsMN4aRmxugjH6vevzR
        iywIvBz6VSDO5H5ygU4Ae3cRKdsnkApmH0NCRZMZ7+TRE7c=
X-Google-Smtp-Source: AHgI3IYkY0jIO1cUswOSW2dlOymi/ReD6rkB+Bwxmc+b/VV5NgtDLXAgpNQKvdIQAlvdEpmCXJ9kW63OlhaqYZ4e0PM=
X-Received: by 2002:aca:bcc6:: with SMTP id m189mr12190358oif.337.1548839574635;
 Wed, 30 Jan 2019 01:12:54 -0800 (PST)
MIME-Version: 1.0
References: <20190130090722.24134-1-axel.lin@ingics.com> <20190130090722.24134-2-axel.lin@ingics.com>
In-Reply-To: <20190130090722.24134-2-axel.lin@ingics.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 30 Jan 2019 10:12:43 +0100
Message-ID: <CAMpxmJX9pSJ1L9NoyKY7wMGm2FCuC5KWxCZcfnTF_dGwdD9+AQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] regulator: max77650: Convert to use regulator_enable/disable/is_enabled_regmap
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 30 sty 2019 o 10:07 Axel Lin <axel.lin@ingics.com> napisa=C5=82(a=
):
>
> By setting enable_reg, enable_mask, enable_val and disable_val, we can
> use the regulator_enable/disable/is_enabled_regmap helpers. With this
> change, then regB field can be removed from struct max77650_regulator_des=
c.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> Hi Bartosz,
> I don't have this h/w, please help to review and test it.
>
> I think the only difference is the is_enabled checking:
> Before the patch, it returns en !=3D MAX77650_REGULATOR_DISABLED;
> After the patch, it returns en =3D=3D MAX77650_REGULATOR_ENABLED
> I'm not sure if this difference does matter or not.
>

NACK. I intend to support the FPS feature of the regulator module in
the future (see a similar thing in max77620) and I will need to extend
these callbacks as there will be more possible values here. Regmap
generics will not be enough.

Best regards,
Bartosz Golaszewski

> Thanks,
> Axel
>  drivers/regulator/max77650-regulator.c | 87 +++++++-------------------
>  1 file changed, 23 insertions(+), 64 deletions(-)
>
> diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/m=
ax77650-regulator.c
> index 5afb91400832..90c0f73f3fad 100644
> --- a/drivers/regulator/max77650-regulator.c
> +++ b/drivers/regulator/max77650-regulator.c
> @@ -13,8 +13,6 @@
>  #include <linux/regulator/driver.h>
>
>  #define MAX77650_REGULATOR_EN_CTRL_MASK                GENMASK(3, 0)
> -#define MAX77650_REGULATOR_EN_CTRL_BITS(_reg) \
> -               ((_reg) & MAX77650_REGULATOR_EN_CTRL_MASK)
>  #define MAX77650_REGULATOR_ENABLED             GENMASK(2, 1)
>  #define MAX77650_REGULATOR_DISABLED            BIT(2)
>
> @@ -41,7 +39,6 @@ enum {
>  struct max77650_regulator_desc {
>         struct regulator_desc desc;
>         unsigned int regA;
> -       unsigned int regB;
>  };
>
>  static const u32 max77651_sbb1_regulator_volt_table[] =3D {
> @@ -86,50 +83,6 @@ static const int max77650_current_limit_table[] =3D {
>         1000000, 866000, 707000, 500000,
>  };
>
> -static int max77650_regulator_is_enabled(struct regulator_dev *rdev)
> -{
> -       struct max77650_regulator_desc *rdesc;
> -       struct regmap *map;
> -       int val, rv, en;
> -
> -       rdesc =3D rdev_get_drvdata(rdev);
> -       map =3D rdev_get_regmap(rdev);
> -
> -       rv =3D regmap_read(map, rdesc->regB, &val);
> -       if (rv)
> -               return rv;
> -
> -       en =3D MAX77650_REGULATOR_EN_CTRL_BITS(val);
> -
> -       return en !=3D MAX77650_REGULATOR_DISABLED;
> -}
> -
> -static int max77650_regulator_enable(struct regulator_dev *rdev)
> -{
> -       struct max77650_regulator_desc *rdesc;
> -       struct regmap *map;
> -
> -       rdesc =3D rdev_get_drvdata(rdev);
> -       map =3D rdev_get_regmap(rdev);
> -
> -       return regmap_update_bits(map, rdesc->regB,
> -                                 MAX77650_REGULATOR_EN_CTRL_MASK,
> -                                 MAX77650_REGULATOR_ENABLED);
> -}
> -
> -static int max77650_regulator_disable(struct regulator_dev *rdev)
> -{
> -       struct max77650_regulator_desc *rdesc;
> -       struct regmap *map;
> -
> -       rdesc =3D rdev_get_drvdata(rdev);
> -       map =3D rdev_get_regmap(rdev);
> -
> -       return regmap_update_bits(map, rdesc->regB,
> -                                 MAX77650_REGULATOR_EN_CTRL_MASK,
> -                                 MAX77650_REGULATOR_DISABLED);
> -}
> -
>  static int max77650_regulator_set_voltage_sel(struct regulator_dev *rdev=
,
>                                               unsigned int sel)
>  {
> @@ -140,7 +93,7 @@ static int max77650_regulator_set_voltage_sel(struct r=
egulator_dev *rdev,
>          * If the regulator is disabled, we can program the desired
>          * voltage right away.
>          */
> -       if (!max77650_regulator_is_enabled(rdev))
> +       if (!regulator_is_enabled_regmap(rdev))
>                 return regulator_set_voltage_sel_regmap(rdev, sel);
>
>         /*
> @@ -189,7 +142,7 @@ static int max77651_regulator_sbb1_set_voltage_sel(st=
ruct regulator_dev *rdev,
>          * If the regulator is disabled, we can program the desired
>          * voltage right away.
>          */
> -       if (!max77650_regulator_is_enabled(rdev))
> +       if (!regulator_is_enabled_regmap(rdev))
>                 return regulator_set_voltage_sel_regmap(rdev, sel);
>
>         curr =3D regulator_get_voltage_sel_regmap(rdev);
> @@ -264,9 +217,9 @@ static int max77650_regulator_set_current_limit(struc=
t regulator_dev *rdev,
>  }
>
>  static const struct regulator_ops max77650_regulator_LDO_ops =3D {
> -       .is_enabled             =3D max77650_regulator_is_enabled,
> -       .enable                 =3D max77650_regulator_enable,
> -       .disable                =3D max77650_regulator_disable,
> +       .is_enabled             =3D regulator_is_enabled_regmap,
> +       .enable                 =3D regulator_enable_regmap,
> +       .disable                =3D regulator_disable_regmap,
>         .list_voltage           =3D regulator_list_voltage_linear,
>         .map_voltage            =3D regulator_map_voltage_linear,
>         .get_voltage_sel        =3D regulator_get_voltage_sel_regmap,
> @@ -275,9 +228,9 @@ static const struct regulator_ops max77650_regulator_=
LDO_ops =3D {
>  };
>
>  static const struct regulator_ops max77650_regulator_SBB_ops =3D {
> -       .is_enabled             =3D max77650_regulator_is_enabled,
> -       .enable                 =3D max77650_regulator_enable,
> -       .disable                =3D max77650_regulator_disable,
> +       .is_enabled             =3D regulator_is_enabled_regmap,
> +       .enable                 =3D regulator_enable_regmap,
> +       .disable                =3D regulator_disable_regmap,
>         .list_voltage           =3D regulator_list_voltage_linear,
>         .map_voltage            =3D regulator_map_voltage_linear,
>         .get_voltage_sel        =3D regulator_get_voltage_sel_regmap,
> @@ -289,9 +242,9 @@ static const struct regulator_ops max77650_regulator_=
SBB_ops =3D {
>
>  /* Special case for max77651 SBB1 - non-linear voltage mapping. */
>  static const struct regulator_ops max77651_SBB1_regulator_ops =3D {
> -       .is_enabled             =3D max77650_regulator_is_enabled,
> -       .enable                 =3D max77650_regulator_enable,
> -       .disable                =3D max77650_regulator_disable,
> +       .is_enabled             =3D regulator_is_enabled_regmap,
> +       .enable                 =3D regulator_enable_regmap,
> +       .disable                =3D regulator_disable_regmap,
>         .list_voltage           =3D regulator_list_voltage_table,
>         .get_voltage_sel        =3D regulator_get_voltage_sel_regmap,
>         .set_voltage_sel        =3D max77651_regulator_sbb1_set_voltage_s=
el,
> @@ -313,6 +266,10 @@ static struct max77650_regulator_desc max77650_LDO_d=
esc =3D {
>                 .n_voltages             =3D 128,
>                 .vsel_mask              =3D MAX77650_REGULATOR_V_LDO_MASK=
,
>                 .vsel_reg               =3D MAX77650_REG_CNFG_LDO_A,
> +               .enable_reg             =3D MAX77650_REG_CNFG_LDO_B,
> +               .enable_mask            =3D MAX77650_REGULATOR_EN_CTRL_MA=
SK,
> +               .enable_val             =3D MAX77650_REGULATOR_ENABLED,
> +               .disable_val            =3D MAX77650_REGULATOR_DISABLED,
>                 .active_discharge_off   =3D MAX77650_REGULATOR_AD_DISABLE=
D,
>                 .active_discharge_on    =3D MAX77650_REGULATOR_AD_ENABLED=
,
>                 .active_discharge_mask  =3D MAX77650_REGULATOR_AD_MASK,
> @@ -321,7 +278,6 @@ static struct max77650_regulator_desc max77650_LDO_de=
sc =3D {
>                 .type                   =3D REGULATOR_VOLTAGE,
>         },
>         .regA           =3D MAX77650_REG_CNFG_LDO_A,
> -       .regB           =3D MAX77650_REG_CNFG_LDO_B,
>  };
>
>  static struct max77650_regulator_desc max77650_SBB0_desc =3D {
> @@ -337,6 +293,10 @@ static struct max77650_regulator_desc max77650_SBB0_=
desc =3D {
>                 .n_voltages             =3D 64,
>                 .vsel_mask              =3D MAX77650_REGULATOR_V_SBB_MASK=
,
>                 .vsel_reg               =3D MAX77650_REG_CNFG_SBB0_A,
> +               .enable_reg             =3D MAX77650_REG_CNFG_LDO_B,
> +               .enable_mask            =3D MAX77650_REGULATOR_EN_CTRL_MA=
SK,
> +               .enable_val             =3D MAX77650_REGULATOR_ENABLED,
> +               .disable_val            =3D MAX77650_REGULATOR_DISABLED,
>                 .active_discharge_off   =3D MAX77650_REGULATOR_AD_DISABLE=
D,
>                 .active_discharge_on    =3D MAX77650_REGULATOR_AD_ENABLED=
,
>                 .active_discharge_mask  =3D MAX77650_REGULATOR_AD_MASK,
> @@ -345,7 +305,6 @@ static struct max77650_regulator_desc max77650_SBB0_d=
esc =3D {
>                 .type                   =3D REGULATOR_VOLTAGE,
>         },
>         .regA           =3D MAX77650_REG_CNFG_SBB0_A,
> -       .regB           =3D MAX77650_REG_CNFG_SBB0_B,
>  };
>
>  static struct max77650_regulator_desc max77650_SBB1_desc =3D {
> @@ -361,6 +320,10 @@ static struct max77650_regulator_desc max77650_SBB1_=
desc =3D {
>                 .n_voltages             =3D 64,
>                 .vsel_mask              =3D MAX77650_REGULATOR_V_SBB_MASK=
,
>                 .vsel_reg               =3D MAX77650_REG_CNFG_SBB1_A,
> +               .enable_reg             =3D MAX77650_REG_CNFG_LDO_B,
> +               .enable_mask            =3D MAX77650_REGULATOR_EN_CTRL_MA=
SK,
> +               .enable_val             =3D MAX77650_REGULATOR_ENABLED,
> +               .disable_val            =3D MAX77650_REGULATOR_DISABLED,
>                 .active_discharge_off   =3D MAX77650_REGULATOR_AD_DISABLE=
D,
>                 .active_discharge_on    =3D MAX77650_REGULATOR_AD_ENABLED=
,
>                 .active_discharge_mask  =3D MAX77650_REGULATOR_AD_MASK,
> @@ -369,7 +332,6 @@ static struct max77650_regulator_desc max77650_SBB1_d=
esc =3D {
>                 .type                   =3D REGULATOR_VOLTAGE,
>         },
>         .regA           =3D MAX77650_REG_CNFG_SBB1_A,
> -       .regB           =3D MAX77650_REG_CNFG_SBB1_B,
>  };
>
>  static struct max77650_regulator_desc max77651_SBB1_desc =3D {
> @@ -392,7 +354,6 @@ static struct max77650_regulator_desc max77651_SBB1_d=
esc =3D {
>                 .type                   =3D REGULATOR_VOLTAGE,
>         },
>         .regA           =3D MAX77650_REG_CNFG_SBB1_A,
> -       .regB           =3D MAX77650_REG_CNFG_SBB1_B,
>  };
>
>  static struct max77650_regulator_desc max77650_SBB2_desc =3D {
> @@ -416,7 +377,6 @@ static struct max77650_regulator_desc max77650_SBB2_d=
esc =3D {
>                 .type                   =3D REGULATOR_VOLTAGE,
>         },
>         .regA           =3D MAX77650_REG_CNFG_SBB2_A,
> -       .regB           =3D MAX77650_REG_CNFG_SBB2_B,
>  };
>
>  static struct max77650_regulator_desc max77651_SBB2_desc =3D {
> @@ -440,7 +400,6 @@ static struct max77650_regulator_desc max77651_SBB2_d=
esc =3D {
>                 .type                   =3D REGULATOR_VOLTAGE,
>         },
>         .regA           =3D MAX77650_REG_CNFG_SBB2_A,
> -       .regB           =3D MAX77650_REG_CNFG_SBB2_B,
>  };
>
>  static int max77650_regulator_probe(struct platform_device *pdev)
> --
> 2.17.1
>
