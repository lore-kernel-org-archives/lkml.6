Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB51C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB772146D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1I0vb3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB772146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbeJBFA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 01:00:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbeJBFA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 01:00:58 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 574D9208AE;
        Mon,  1 Oct 2018 22:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538432458;
        bh=hR1NYSOXeoOIabyX7fzvQ8WKvSAcZZqEMAbWNaqbRjg=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=e1I0vb3s+vnHW+9ItpBNIkCNJfEkz8mb/UMfu5TVSRxgz9/o4LqEbdPq7qFNjQhb6
         DC9EtVyj3Q0FpotjwG8wh/leM8vlPudArQupLNTlhSSRpWZYrmuPxYfrDqZiAc3sJW
         vGPXgW/j/9pLHRtS7vADqQC+U301nKlw4EDy/cKI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CADHB5bARkELSG8HnpYNYOrwohUaXzLUJH0wfPfa-3FJZkqTCUw@mail.gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, linux@armlinux.org.uk,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?utf-8?q?Guilherme_G=2E_Sim=C3=B5es?= 
        <guilherme.simoes@lsitec.org.br>,
        Jon maddog Hall <jon.maddog.hall@gmail.com>,
        mkzuffo@lsi.usp.br,
        =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        mark.rutland@arm.com, linux@cubietech.com, support@cubietech.com,
        catalin.marinas@arm.com,
        Michael Turquette <mturquette@baylibre.com>,
        will.deacon@arm.com, thomas liau <thomas.liau@actions-semi.com>,
        darren@cubietech.com, robh+dt@kernel.org,
        jeff.chen@actions-semi.com, pn@denx.de, mp-cs@actions-semi.com,
        Laisa Costa - LSI-TEC <laisa.costa@lsitec.org.br>
References: <CADHB5bARkELSG8HnpYNYOrwohUaXzLUJH0wfPfa-3FJZkqTCUw@mail.gmail.com>
Message-ID: <153843245769.119890.9097758867796937511@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 03/03] clk: actions: Add Actions Semi S500 SoC clock support
Date:   Mon, 01 Oct 2018 15:20:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Edgar Bernardi Righi (2018-09-04 08:39:48)
> Basic clock support for S500 SoC was implemented using the Actions
> Semi Owl clock driver.
> This patch also adds custom delay support to Actions Semi OWL pll clock d=
river.
> The default delay (50us) is not enough for Actions Semi Owl S500 SoC.
> It needs up to 150us.
> A new field called "delay" was added to "struct owl_pll_hw". The rest
> of the code was updated accordingly.
> Old macros "OWL_PLL_HW", "OWL_PLL" and "OWL_PLL_NO_PARENT" were kept,
> but updated with an extra argument to set a custom "delay".
> S700 and S900 code was updated with a default 50us delay.
> Tested on a Lemaker Guitar board.
> =

> Signed-off-by: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
> =

> diff --git a/drivers/clk/actions/Kconfig b/drivers/clk/actions/Kconfig
> index dc38c85a4833..3debd758a918 100644
> --- a/drivers/clk/actions/Kconfig
> +++ b/drivers/clk/actions/Kconfig
> @@ -8,6 +8,11 @@ if CLK_ACTIONS
> =

>  # SoC Drivers
> =

> +config CLK_OWL_S500
> +    bool "Support for the Actions Semi OWL S500 clocks"
> +    depends on ARCH_ACTIONS || COMPILE_TEST
> +    default ARCH_ACTIONS
> +
>  config CLK_OWL_S700
>      bool "Support for the Actions Semi OWL S700 clocks"
>      depends on (ARM64 && ARCH_ACTIONS) || COMPILE_TEST
> diff --git a/drivers/clk/actions/Makefile b/drivers/clk/actions/Makefile
> index 78c17d56f991..97ab285c2821 100644
> --- a/drivers/clk/actions/Makefile
> +++ b/drivers/clk/actions/Makefile
> @@ -9,5 +9,6 @@ clk-owl-y            +=3D owl-composite.o
>  clk-owl-y            +=3D owl-pll.o
> =

>  # SoC support
> +obj-$(CONFIG_CLK_OWL_S500)    +=3D owl-s500.o
>  obj-$(CONFIG_CLK_OWL_S700)    +=3D owl-s700.o
>  obj-$(CONFIG_CLK_OWL_S900)    +=3D owl-s900.o
> diff --git a/drivers/clk/actions/owl-pll.c b/drivers/clk/actions/owl-pll.c
> index 058e06d7099f..02437bdedf4d 100644
> --- a/drivers/clk/actions/owl-pll.c
> +++ b/drivers/clk/actions/owl-pll.c
> @@ -179,7 +179,7 @@ static int owl_pll_set_rate(struct clk_hw *hw,
> unsigned long rate,
> =

>      regmap_write(common->regmap, pll_hw->reg, reg);
> =

> -    udelay(PLL_STABILITY_WAIT_US);
> +    udelay(pll_hw->delay);
> =

>      return 0;
>  }
> diff --git a/drivers/clk/actions/owl-pll.h b/drivers/clk/actions/owl-pll.h
> index 0aae30abd5dc..f465475a333f 100644
> --- a/drivers/clk/actions/owl-pll.h
> +++ b/drivers/clk/actions/owl-pll.h
> @@ -26,7 +26,8 @@ struct owl_pll_hw {
>      u8            shift;
>      u8            width;
>      u8            min_mul;
> -    u8            max_mul;
> +    u8            max_mul;
> +    u32         delay;

Please whitespace align this with the above struct members.

>      const struct clk_pll_table *table;
>  };
> =

> @@ -36,7 +37,7 @@ struct owl_pll {
>  };
> =

>  #define OWL_PLL_HW(_reg, _bfreq, _bit_idx, _shift,            \
> -           _width, _min_mul, _max_mul, _table)            \
> +           _width, _min_mul, _max_mul, _delay, _table)        \
>      {                                \
>          .reg        =3D _reg,                    \
>          .bfreq        =3D _bfreq,                \
> @@ -45,15 +46,16 @@ struct owl_pll {
>          .width        =3D _width,                \
>          .min_mul    =3D _min_mul,                \
>          .max_mul    =3D _max_mul,                \
> +        .delay      =3D _delay,               \
>          .table        =3D _table,                \
>      }
> =

>  #define OWL_PLL(_struct, _name, _parent, _reg, _bfreq, _bit_idx,    \
> -        _shift, _width, _min_mul, _max_mul, _table, _flags)    \
> +        _shift, _width, _min_mul, _max_mul, _delay, _table, _flags)    \
>      struct owl_pll _struct =3D {                    \
>          .pll_hw    =3D OWL_PLL_HW(_reg, _bfreq, _bit_idx, _shift,    \
>                       _width, _min_mul,            \
> -                     _max_mul, _table),            \
> +                     _max_mul, _delay, _table),        \
>          .common =3D {                        \
>              .regmap =3D NULL,                    \
>              .hw.init =3D CLK_HW_INIT(_name,            \
> @@ -64,11 +66,11 @@ struct owl_pll {
>      }
> =

>  #define OWL_PLL_NO_PARENT(_struct, _name, _reg, _bfreq, _bit_idx,    \
> -        _shift, _width, _min_mul, _max_mul, _table, _flags)    \
> +        _shift, _width, _min_mul, _max_mul, _delay, _table, _flags)    \
>      struct owl_pll _struct =3D {                    \
>          .pll_hw    =3D OWL_PLL_HW(_reg, _bfreq, _bit_idx, _shift,    \
>                       _width, _min_mul,            \
> -                     _max_mul, _table),            \
> +                     _max_mul, _delay, _table),        \
>          .common =3D {                        \
>              .regmap =3D NULL,                    \
>              .hw.init =3D CLK_HW_INIT_NO_PARENT(_name,        \
> @@ -78,7 +80,6 @@ struct owl_pll {
>      }
> =

>  #define mul_mask(m)        ((1 << ((m)->width)) - 1)
> -#define PLL_STABILITY_WAIT_US    (50)
> =

>  static inline struct owl_pll *hw_to_owl_pll(const struct clk_hw *hw)
>  {

And split this patch off from the normal driver bits so that we have a
patch to introduce configurable delays and then the patch that uses that
support for the s500 SoC.

> diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s50=
0.c
> new file mode 100644
> index 000000000000..d3aff386c200
> --- /dev/null
> +++ b/drivers/clk/actions/owl-s500.c
> @@ -0,0 +1,524 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// OWL S500 SoC clock driver
> +//
> +// Copyright (c) 2014 Actions Semi Inc.
> +// Author: David Liu <liuwei@actions-semi.com>
> +//
> +// Copyright (c) 2018 Linaro Ltd.
> +// Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +//
> +// Copyright (c) 2018 LSI-TEC - Caninos Loucos
> +// Author: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
> +
> +#include <linux/clk-provider.h>
> +#include <linux/platform_device.h>
> +
> +#include "owl-common.h"
> +#include "owl-composite.h"
> +#include "owl-divider.h"
> +#include "owl-factor.h"
> +#include "owl-fixed-factor.h"
> +#include "owl-gate.h"
> +#include "owl-mux.h"
> +#include "owl-pll.h"
> +
> +#include <dt-bindings/clock/actions,s500-cmu.h>
> +
> +#define CMU_COREPLL                    (0x0000)
> +#define CMU_DEVPLL                     (0x0004)
> +#define CMU_DDRPLL                     (0x0008)
> +#define CMU_NANDPLL                 (0x000C)
> +#define CMU_DISPLAYPLL                 (0x0010)
> +#define CMU_AUDIOPLL                 (0x0014)
> +#define CMU_TVOUTPLL                 (0x0018)
> +#define CMU_BUSCLK                     (0x001C)
> +#define CMU_SENSORCLK                 (0x0020)
> +#define CMU_LCDCLK                     (0x0024)
> +#define CMU_DSICLK                     (0x0028)
> +#define CMU_CSICLK                     (0x002C)
> +#define CMU_DECLK                     (0x0030)
> +#define CMU_BISPCLK                 (0x0034)
> +#define CMU_BUSCLK1                 (0x0038)
> +#define CMU_VDECLK                     (0x0040)
> +#define CMU_VCECLK                     (0x0044)
> +#define CMU_NANDCCLK                 (0x004C)
> +#define CMU_SD0CLK                     (0x0050)
> +#define CMU_SD1CLK                     (0x0054)
> +#define CMU_SD2CLK                     (0x0058)
> +#define CMU_UART0CLK                 (0x005C)
> +#define CMU_UART1CLK                 (0x0060)
> +#define CMU_UART2CLK                 (0x0064)
> +#define CMU_PWM4CLK                  (0x0068)
> +#define CMU_PWM5CLK                 (0x006C)
> +#define CMU_PWM0CLK                 (0x0070)
> +#define CMU_PWM1CLK                 (0x0074)
> +#define CMU_PWM2CLK                 (0x0078)
> +#define CMU_PWM3CLK                 (0x007C)
> +#define CMU_USBPLL                     (0x0080)
> +#define CMU_ETHERNETPLL             (0x0084)
> +#define CMU_CVBSPLL                 (0x0088)
> +#define CMU_LENSCLK                 (0x008C)
> +#define CMU_GPU3DCLK                 (0x0090)
> +#define CMU_CORECTL                 (0x009C)
> +#define CMU_DEVCLKEN0                 (0x00A0)
> +#define CMU_DEVCLKEN1                 (0x00A4)
> +#define CMU_DEVRST0                 (0x00A8)
> +#define CMU_DEVRST1                 (0x00AC)
> +#define CMU_UART3CLK                 (0x00B0)
> +#define CMU_UART4CLK                 (0x00B4)
> +#define CMU_UART5CLK                 (0x00B8)
> +#define CMU_UART6CLK                 (0x00BC)
> +#define CMU_SSCLK                     (0x00C0)
> +#define CMU_DIGITALDEBUG             (0x00D0)
> +#define CMU_ANALOGDEBUG             (0x00D4)
> +#define CMU_COREPLLDEBUG             (0x00D8)
> +#define CMU_DEVPLLDEBUG             (0x00DC)
> +#define CMU_DDRPLLDEBUG             (0x00E0)
> +#define CMU_NANDPLLDEBUG             (0x00E4)
> +#define CMU_DISPLAYPLLDEBUG         (0x00E8)
> +#define CMU_TVOUTPLLDEBUG             (0x00EC)
> +#define CMU_DEEPCOLORPLLDEBUG         (0x00F4)
> +#define CMU_AUDIOPLL_ETHPLLDEBUG     (0x00F8)
> +#define CMU_CVBSPLLDEBUG             (0x00FC)
> +
> +#define OWL_S500_COREPLL_DELAY        (150)
> +#define OWL_S500_DDRPLL_DELAY        (63)
> +#define OWL_S500_DEVPLL_DELAY        (28)
> +#define OWL_S500_NANDPLL_DELAY        (44)
> +#define OWL_S500_DISPLAYPLL_DELAY    (57)
> +#define OWL_S500_ETHERNETPLL_DELAY    (25)
> +#define OWL_S500_AUDIOPLL_DELAY        (100)
> +
> +static struct clk_pll_table clk_audio_pll_table[] =3D {

const?

> +    { 0, 45158400 }, { 1, 49152000 },
> +    { 0, 0 },
> +};
> +
> +static OWL_PLL_NO_PARENT(ethernet_pll_clk, "ethernet_pll_clk",
> CMU_ETHERNETPLL, 500000000, 0, 0, 0, 0, 0, OWL_S500_ETHERNETPLL_DELAY,
> NULL, CLK_IGNORE_UNUSED);
> +static OWL_PLL_NO_PARENT(core_pll_clk, "core_pll_clk", CMU_COREPLL,
> 12000000, 9, 0, 8, 4, 134, OWL_S500_COREPLL_DELAY, NULL,
> CLK_IGNORE_UNUSED);
> +static OWL_PLL_NO_PARENT(ddr_pll_clk, "ddr_pll_clk", CMU_DDRPLL,
> 12000000, 8, 0, 8, 1, 67, OWL_S500_DDRPLL_DELAY, NULL,
> CLK_IGNORE_UNUSED);
> +static OWL_PLL_NO_PARENT(nand_pll_clk, "nand_pll_clk", CMU_NANDPLL,
> 6000000, 8, 0, 7, 2, 86, OWL_S500_NANDPLL_DELAY, NULL,
> CLK_IGNORE_UNUSED);
> +static OWL_PLL_NO_PARENT(display_pll_clk, "display_pll_clk",
> CMU_DISPLAYPLL, 6000000, 8, 0, 8, 2, 126, OWL_S500_DISPLAYPLL_DELAY,
> NULL, CLK_IGNORE_UNUSED);
> +static OWL_PLL_NO_PARENT(dev_pll_clk, "dev_pll_clk", CMU_DEVPLL,
> 6000000, 8, 0, 7, 8, 126, OWL_S500_DEVPLL_DELAY, NULL,
> CLK_IGNORE_UNUSED);
> +static OWL_PLL_NO_PARENT(audio_pll_clk, "audio_pll_clk",
> CMU_AUDIOPLL, 0, 4, 0, 1, 0, 0, OWL_S500_AUDIOPLL_DELAY,
> clk_audio_pll_table, CLK_IGNORE_UNUSED);
> +
> +static const char *dev_clk_mux_p[] =3D { "hosc", "dev_pll_clk" };
> +static const char *bisp_clk_mux_p[] =3D { "display_pll_clk", "dev_clk" };
> +static const char *sensor_clk_mux_p[] =3D { "hosc", "bisp_clk" };
> +static const char *sd_clk_mux_p[] =3D { "dev_clk", "nand_pll_clk" };
> +static const char *pwm_clk_mux_p[] =3D { "losc", "hosc" };
> +static const char *ahbprediv_clk_mux_p[] =3D { "dev_clk",
> "display_pll_clk", "nand_pll_clk", "ddr_pll_clk" };
> +static const char *uart_clk_mux_p[] =3D { "hosc", "dev_pll_clk" };
> +static const char *de_clk_mux_p[] =3D { "display_pll_clk", "dev_clk" };
> +static const char *i2s_clk_mux_p[] =3D { "audio_pll_clk" };
> +static const char *hde_clk_mux_p[] =3D { "dev_clk", "display_pll_clk",
> "nand_pll_clk", "ddr_pll_clk" };
> +static const char *nand_clk_mux_p[] =3D { "nand_pll_clk",
> "display_pll_clk", "dev_clk", "ddr_pll_clk" };
> +
> +static struct clk_factor_table sd_factor_table[] =3D {
> +    /* bit0 ~ 4 */
> +    { 0, 1, 1 }, { 1, 1, 2 }, { 2, 1, 3 }, { 3, 1, 4 },
> +    { 4, 1, 5 }, { 5, 1, 6 }, { 6, 1, 7 }, { 7, 1, 8 },
> +    { 8, 1, 9 }, { 9, 1, 10 }, { 10, 1, 11 }, { 11, 1, 12 },
> +    { 12, 1, 13 }, { 13, 1, 14 }, { 14, 1, 15 }, { 15, 1, 16 },
> +    { 16, 1, 17 }, { 17, 1, 18 }, { 18, 1, 19 }, { 19, 1, 20 },
> +    { 20, 1, 21 }, { 21, 1, 22 }, { 22, 1, 23 }, { 23, 1, 24 },
> +    { 24, 1, 25 }, { 25, 1, 26 }, { 26, 1, 27 }, { 27, 1, 28 },
> +    { 28, 1, 29 }, { 29, 1, 30 }, { 30, 1, 31 }, { 31, 1, 32 },
> +
> +    /* bit8: /128 */
> +    { 256, 1, 1 * 128 }, { 257, 1, 2 * 128 }, { 258, 1, 3 * 128 }, {
> 259, 1, 4 * 128 },
> +    { 260, 1, 5 * 128 }, { 261, 1, 6 * 128 }, { 262, 1, 7 * 128 }, {
> 263, 1, 8 * 128 },
> +    { 264, 1, 9 * 128 }, { 265, 1, 10 * 128 }, { 266, 1, 11 * 128 },
> { 267, 1, 12 * 128 },
> +    { 268, 1, 13 * 128 }, { 269, 1, 14 * 128 }, { 270, 1, 15 * 128 },
> { 271, 1, 16 * 128 },
> +    { 272, 1, 17 * 128 }, { 273, 1, 18 * 128 }, { 274, 1, 19 * 128 },
> { 275, 1, 20 * 128 },
> +    { 276, 1, 21 * 128 }, { 277, 1, 22 * 128 }, { 278, 1, 23 * 128 },
> { 279, 1, 24 * 128 },
> +    { 280, 1, 25 * 128 }, { 281, 1, 26 * 128 }, { 282, 1, 27 * 128 },
> { 283, 1, 28 * 128 },
> +    { 284, 1, 29 * 128 }, { 285, 1, 30 * 128 }, { 286, 1, 31 * 128 },
> { 287, 1, 32 * 128 },
> +
> +    { 0, 0, 0 },
> +};
> +
> +static struct clk_factor_table bisp_factor_table[] =3D {
> +    { 0, 1, 1 }, { 1, 1, 2 }, { 2, 1, 3 }, { 3, 1, 4 },
> +    { 4, 1, 5 }, { 5, 1, 6 }, { 6, 1, 7 }, { 7, 1, 8 },
> +    { 0, 0, 0 },
> +};
> +
> +static struct clk_factor_table ahb_factor_table[] =3D {
> +    { 1, 1, 2 }, { 2, 1, 3 },
> +    { 0, 0, 0 },
> +};
> +
> +static struct clk_div_table rmii_ref_div_table[] =3D {
> +    { 0, 4 }, { 1, 10 },
> +    { 0, 0 },
> +};
> +
> +static struct clk_div_table i2s_div_table[] =3D {
> +    { 0, 1 }, { 1, 2 }, { 2, 3 }, { 3, 4 },
> +    { 4, 6 }, { 5, 8 }, { 6, 12 }, { 7, 16 },
> +    { 8, 24 },
> +    { 0, 0 },
> +};
> +
> +static struct clk_div_table nand_div_table[] =3D {

const? For many of these structs of numbers.

> +    { 0, 1 }, { 1, 2 }, { 2, 4 }, { 3, 6 },
> +    { 4, 8 }, { 5, 10 }, { 6, 12 }, { 7, 14 },
> +    { 8, 16 }, { 9, 18 }, { 10, 20 }, { 11, 22 },
> +    { 0, 0 },
> +};
[...]
> diff --git a/drivers/clk/actions/owl-s900.c b/drivers/clk/actions/owl-s90=
0.c
> index 7f60ed6afe63..bdee9b022f0d 100644
> --- a/drivers/clk/actions/owl-s900.c
> +++ b/drivers/clk/actions/owl-s900.c
> @@ -69,6 +69,8 @@
>  #define CMU_PWM4CLK        (0x00C8)
>  #define CMU_PWM5CLK        (0x00CC)
> =

> +#define OWL_S900_DEFPLL_DELAY    (50) // Default PLL delay in us.
> +
>  static struct clk_pll_table clk_audio_pll_table[] =3D {
>      { 0, 45158400 }, { 1, 49152000 },
>      { 0, 0 },
> @@ -80,14 +82,14 @@ static struct clk_pll_table clk_edp_pll_table[] =3D {
>  };
> =

>  /* pll clocks */
> -static OWL_PLL_NO_PARENT(core_pll_clk, "core_pll_clk", CMU_COREPLL,
> 24000000, 9, 0, 8, 5, 107, NULL, CLK_IGNORE_UNUSED);
> -static OWL_PLL_NO_PARENT(dev_pll_clk, "dev_pll_clk", CMU_DEVPLL,
> 6000000, 8, 0, 8, 20, 180, NULL, CLK_IGNORE_UNUSED);
> -static OWL_PLL_NO_PARENT(ddr_pll_clk, "ddr_pll_clk", CMU_DDRPLL,
> 24000000, 8, 0, 8, 5, 45, NULL, CLK_IGNORE_UNUSED);
> -static OWL_PLL_NO_PARENT(nand_pll_clk, "nand_pll_clk", CMU_NANDPLL,
> 6000000, 8, 0, 8, 4, 100, NULL, CLK_IGNORE_UNUSED);
> -static OWL_PLL_NO_PARENT(display_pll_clk, "display_pll_clk",
> CMU_DISPLAYPLL, 6000000, 8, 0, 8, 20, 180, NULL, CLK_IGNORE_UNUSED);
> -static OWL_PLL_NO_PARENT(assist_pll_clk, "assist_pll_clk",
> CMU_ASSISTPLL, 500000000, 0, 0, 0, 0, 0, NULL, CLK_IGNORE_UNUSED);
> -static OWL_PLL_NO_PARENT(audio_pll_clk, "audio_pll_clk",
> CMU_AUDIOPLL, 0, 4, 0, 1, 0, 0, clk_audio_pll_table,
> CLK_IGNORE_UNUSED);
> -static OWL_PLL(edp_pll_clk, "edp_pll_clk", "edp24M_clk", CMU_EDPCLK,
> 0, 9, 0, 2, 0, 0, clk_edp_pll_table, CLK_IGNORE_UNUSED);
> +static OWL_PLL_NO_PARENT(core_pll_clk, "core_pll_clk", CMU_COREPLL,
> 24000000, 9, 0, 8, 5, 107, OWL_S900_DEFPLL_DELAY, NULL,
> CLK_IGNORE_UNUSED);
> +static OWL_PLL_NO_PARENT(dev_pll_clk, "dev_pll_clk", CMU_DEVPLL,
> 6000000, 8, 0, 8, 20, 180, OWL_S900_DEFPLL_DELAY, NULL,
> CLK_IGNORE_UNUSED);
> +static OWL_PLL_NO_PARENT(ddr_pll_clk, "ddr_pll_clk", CMU_DDRPLL,
> 24000000, 8, 0, 8, 5, 45, OWL_S900_DEFPLL_DELAY, NULL,
> CLK_IGNORE_UNUSED);
> +static OWL_PLL_NO_PARENT(nand_pll_clk, "nand_pll_clk", CMU_NANDPLL,
> 6000000, 8, 0, 8, 4, 100, OWL_S900_DEFPLL_DELAY, NULL,
> CLK_IGNORE_UNUSED);
> +static OWL_PLL_NO_PARENT(display_pll_clk, "display_pll_clk",
> CMU_DISPLAYPLL, 6000000, 8, 0, 8, 20, 180, OWL_S900_DEFPLL_DELAY,
> NULL, CLK_IGNORE_UNUSED);
> +static OWL_PLL_NO_PARENT(assist_pll_clk, "assist_pll_clk",

And this should probably get another macro to allow delay to be
configured, so that older code doesn't need to change. Not touching this
driver reduces mental burden on reviewers to make sure nothing gets
broken.

> CMU_ASSISTPLL, 500000000, 0, 0, 0, 0, 0, OWL_S900_DEFPLL_DELAY, NULL,
> CLK_IGNORE_UNUSED);
