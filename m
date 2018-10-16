Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8299EC5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 400D52148D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w7Krw6le"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 400D52148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeJQHtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:49:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbeJQHtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:49:39 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB6BC2087B;
        Tue, 16 Oct 2018 23:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539734208;
        bh=oKe7QxLUfj1/MdLF9T4pb/texIP+mwJjYnvVrtwDb1Y=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=w7Krw6leOtTJJcjIMaL7cv8CvijuM7tMFiUU/3dQt4sOvjq/HNxon+xL29rGvz9Zb
         qrtVtzDINFk1kAQK8zTstHStciM4rtrjdWVGAx5kCsmQ3ns9GBKAhrt6UrQbKN7z0s
         fq+6IwjfKKySjGpzpcXdDvoKJPRR2RJGXTMGgwsM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     ilia.lin@gmail.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180614215358.11264-9-ilia.lin@gmail.com>
Cc:     Ilia Lin <ilialin@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180614215358.11264-1-ilia.lin@gmail.com>
 <20180614215358.11264-9-ilia.lin@gmail.com>
Message-ID: <153973420806.5275.356235896596182005@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v13 8/8] clk: qcom: Add ACD path to CPU clock driver for msm8996
Date:   Tue, 16 Oct 2018 16:56:48 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting ilia.lin@gmail.com (2018-06-14 14:53:55)
> @@ -176,6 +183,9 @@ static struct clk_alpha_pll pwrcl_alt_pll =3D {
>         },
>  };
>  =

> +void __iomem *base;
> +static void qcom_cpu_clk_msm8996_acd_init(void __iomem *base);
> +

Why are we doing this?

> @@ -393,6 +404,10 @@ qcom_cpu_clk_msm8996_register_clks(struct device *de=
v, struct regmap *regmap)
>         clk_alpha_pll_configure(&perfcl_alt_pll, regmap, &altpll_config);
>         clk_alpha_pll_configure(&pwrcl_alt_pll, regmap, &altpll_config);
>  =

> +       /* Enable alt PLLs */
> +       clk_prepare_enable(pwrcl_alt_pll.clkr.hw.clk);
> +       clk_prepare_enable(perfcl_alt_pll.clkr.hw.clk);

Are the alt PLLs CLK_IS_CRITICAL?

> +
>         ret =3D clk_notifier_register(pwrcl_pmux.clkr.hw.clk, &pwrcl_pmux=
.nb);
>         if (ret)
>                 return ret;
> @@ -402,10 +417,48 @@ qcom_cpu_clk_msm8996_register_clks(struct device *d=
ev, struct regmap *regmap)
>         return ret;
>  }
>  =

> +#define CPU_AFINITY_MASK 0xFFF
> +#define PWRCL_CPU_REG_MASK 0x3
> +#define PERFCL_CPU_REG_MASK 0x103
> +
> +#define L2ACDCR_REG 0x580ULL
> +#define L2ACDTD_REG 0x581ULL
> +#define L2ACDDVMRC_REG 0x584ULL
> +#define L2ACDSSCR_REG 0x589ULL
> +
> +static DEFINE_SPINLOCK(acd_lock);
> +
> +static void qcom_cpu_clk_msm8996_acd_init(void __iomem *base)
> +{
> +       u64 hwid;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&acd_lock, flags);
> +
> +       hwid =3D read_cpuid_mpidr() & CPU_AFINITY_MASK;
> +
> +       kryo_l2_set_indirect_reg(L2ACDTD_REG, 0x00006A11);
> +       kryo_l2_set_indirect_reg(L2ACDDVMRC_REG, 0x000E0F0F);
> +       kryo_l2_set_indirect_reg(L2ACDSSCR_REG, 0x00000601);
> +
> +       if (PWRCL_CPU_REG_MASK =3D=3D (hwid | PWRCL_CPU_REG_MASK)) {
> +               writel(0xF, base + PWRCL_REG_OFFSET + SSSCTL_OFFSET);
> +               wmb();
> +               kryo_l2_set_indirect_reg(L2ACDCR_REG, 0x002C5FFD);
> +       }
> +
> +       if (PERFCL_CPU_REG_MASK =3D=3D (hwid | PERFCL_CPU_REG_MASK)) {
> +               kryo_l2_set_indirect_reg(L2ACDCR_REG, 0x002C5FFD);
> +               writel(0xF, base + PERFCL_REG_OFFSET + SSSCTL_OFFSET);
> +               wmb();

Please add comments to the barriers here so we know what they're doing.
I guess the first one is ordering writel with the indirect register
access, but the other one I don't know what it's doing.

> +       }
> +
> +       spin_unlock_irqrestore(&acd_lock, flags);
> +}
> +
>  static int qcom_cpu_clk_msm8996_driver_probe(struct platform_device *pde=
v)
>  {
>         int ret;
> -       void __iomem *base;

Ok but still, why?

>         struct resource *res;
>         struct regmap *regmap;
>         struct clk_hw_onecell_data *data;
> @@ -429,6 +482,8 @@ static int qcom_cpu_clk_msm8996_driver_probe(struct p=
latform_device *pdev)
>         if (ret)
>                 return ret;
>  =

> +       qcom_cpu_clk_msm8996_acd_init(base);
> +
>         data->hws[0] =3D &pwrcl_pmux.clkr.hw;
>         data->hws[1] =3D &perfcl_pmux.clkr.hw;
>         data->num =3D 2;
> -- =

> 2.11.0
>=20
