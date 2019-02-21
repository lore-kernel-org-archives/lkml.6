Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79A6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA6520880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550783048;
	bh=LVNSGutw7y8qvRN3QsA20dH6WHZDVoufvm82CD+w6gQ=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=IxgchGC1+i3o1+jUH8+e2XRWLaYkuPyUtlBpaMBMmizNa1WOE/N6TyrUP88Q2Ce8l
	 sq+4XZNWaIPB8ujz8FzGQMyVf7NTTLnqNU8GfwzutTJIzKYp0Q6H9ITtkYtbLhGA+z
	 2VDU6fXpPoRnPFM6I1uAydtzpmIeo1bt8FYqNkYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfBUVEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 16:04:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:55390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbfBUVEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 16:04:06 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26F302080F;
        Thu, 21 Feb 2019 21:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550783045;
        bh=LVNSGutw7y8qvRN3QsA20dH6WHZDVoufvm82CD+w6gQ=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=sNM5Vu7ilTa3f7UdkLZ1o5snZMvOqjji+L6HdMtkkmP6TTqkUZZOSiixzLW9zJKBZ
         9PO0Y6R/WSaipiUjz3rAqHfktSzW/Ik9uSnDfrF/jU1djkPZrzxJIvB1Wzh+MlKqic
         Q/niMtzbXMlMfO0th/FqlD/+EJMBTxl+ajtDAVNk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RESEND] clk: imx: Refactor entire sccg pll clk
Message-ID: <155078304428.77512.12422358164048389195@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1550481854-14338-1-git-send-email-abel.vesa@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1550481854-14338-1-git-send-email-abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Mike Turquette <mturquette@baylibre.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Date:   Thu, 21 Feb 2019 13:04:04 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2019-02-18 01:24:33)
> Make the entire combination of plls to be one single clock. The parents u=
sed
> for bypasses are specified each as an index in the parents list.
> The determine_rate does a lookup throughout all the possible combinations
> for all the divs and returns the best possible 'setup' which in turn is u=
sed
> by set_rate later to set up all the divs and bypasses.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Tested-by: Lucas Stach <l.stach@pengutronix.de>
> Acked-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>=20
> This is basically just a resend of the following:
> https://lkml.org/lkml/2019/1/29/874
>=20
> There are no changes. Just added T-b and A-b tags from Lucas.
>=20
> Waiting for review.

Spoke too soon. I've kicked this out of the tree. This doesn't compile
and spews a bunch of sparse warnings on arm32. Presumably because the
use of unsigned long was assuming 64 bits in size? Please write portable
code and fix these sparse warnings. Probably all the unsigned long usage
should be u64?

drivers/clk/imx/clk-sccg-pll.c:142:53: warning: decimal constant 2400000000=
 is between LONG_MAX and ULONG_MAX. For C99 that means long long, C90 compi=
lers are very likely to produce unsigned long (and a warning) here
drivers/clk/imx/clk-sccg-pll.c:199:48: warning: decimal constant 2400000000=
 is between LONG_MAX and ULONG_MAX. For C99 that means long long, C90 compi=
lers are very likely to produce unsigned long (and a warning) here
drivers/clk/imx/clk-sccg-pll.c:138:17: error: incompatible types in compari=
son expression (different type sizes)
drivers/clk/imx/clk-sccg-pll.c:144:25: error: incompatible types in compari=
son expression (different type sizes)
drivers/clk/imx/clk-sccg-pll.c:180:17: error: incompatible types in compari=
son expression (different type sizes)
drivers/clk/imx/clk-sccg-pll.c:217:17: error: incompatible types in compari=
son expression (different type sizes)
drivers/clk/imx/clk-sccg-pll.c:239:17: error: incompatible types in compari=
son expression (different type sizes)
drivers/clk/imx/clk-sccg-pll.c:138:17: warning: shift too big (32) for type=
 unsigned long
drivers/clk/imx/clk-sccg-pll.c:144:25: warning: shift too big (32) for type=
 unsigned long
drivers/clk/imx/clk-sccg-pll.c:180:17: warning: shift too big (32) for type=
 unsigned long
drivers/clk/imx/clk-sccg-pll.c:217:17: warning: shift too big (32) for type=
 long
drivers/clk/imx/clk-sccg-pll.c:239:17: warning: shift too big (32) for type=
 unsigned long
In file included from arch/arm/include/asm/div64.h:127:0,
                 from include/linux/kernel.h:207,
                 from include/asm-generic/bug.h:18,
                 from arch/arm/include/asm/bug.h:60,
                 from include/linux/bug.h:5,
                 from include/linux/io.h:23,
                 from include/linux/clk-provider.h:9,
                 from drivers/clk/imx/clk-sccg-pll.c:11:
drivers/clk/imx/clk-sccg-pll.c: In function 'clk_sccg_divq_lookup':
include/asm-generic/div64.h:222:28: warning: comparison of distinct pointer=
 types lacks a cast
  (void)(((typeof((n)) *)0) =3D=3D ((uint64_t *)0)); \ =20
                            ^

> @@ -347,14 +319,12 @@ static int imx8mq_clocks_probe(struct platform_devi=
ce *pdev)
>         clks[IMX8MQ_AUDIO_PLL2_BYPASS] =3D imx_clk_mux("audio_pll2_bypass=
", base + 0x8, 14, 1, audio_pll2_bypass_sels, ARRAY_SIZE(audio_pll2_bypass_=
sels));
>         clks[IMX8MQ_VIDEO_PLL1_BYPASS] =3D imx_clk_mux("video_pll1_bypass=
", base + 0x10, 14, 1, video_pll1_bypass_sels, ARRAY_SIZE(video_pll1_bypass=
_sels));
> =20
> -       clks[IMX8MQ_SYS1_PLL1_OUT] =3D imx_clk_mux("sys1_pll1_out", base =
+ 0x30, 5, 1, sys1_pll1_out_sels, ARRAY_SIZE(sys1_pll1_out_sels));
> -       clks[IMX8MQ_SYS2_PLL1_OUT] =3D imx_clk_mux("sys2_pll1_out", base =
+ 0x3c, 5, 1, sys2_pll1_out_sels, ARRAY_SIZE(sys2_pll1_out_sels));
> -       clks[IMX8MQ_SYS3_PLL1_OUT] =3D imx_clk_mux("sys3_pll1_out", base =
+ 0x48, 5, 1, sys3_pll1_out_sels, ARRAY_SIZE(sys3_pll1_out_sels));
> -       clks[IMX8MQ_DRAM_PLL1_OUT] =3D imx_clk_mux("dram_pll1_out", base =
+ 0x60, 5, 1, dram_pll1_out_sels, ARRAY_SIZE(dram_pll1_out_sels));
> -       clks[IMX8MQ_SYS1_PLL2_OUT] =3D imx_clk_mux("sys1_pll2_out", base =
+ 0x30, 4, 1, sys1_pll2_out_sels, ARRAY_SIZE(sys1_pll2_out_sels));
> -       clks[IMX8MQ_SYS2_PLL2_OUT] =3D imx_clk_mux("sys2_pll2_out", base =
+ 0x3c, 4, 1, sys2_pll2_out_sels, ARRAY_SIZE(sys2_pll2_out_sels));
> -       clks[IMX8MQ_SYS3_PLL2_OUT] =3D imx_clk_mux("sys3_pll2_out", base =
+ 0x48, 4, 1, sys3_pll2_out_sels, ARRAY_SIZE(sys3_pll2_out_sels));
> -       clks[IMX8MQ_DRAM_PLL2_OUT] =3D imx_clk_mux("dram_pll2_out", base =
+ 0x60, 4, 1, dram_pll2_out_sels, ARRAY_SIZE(dram_pll2_out_sels));
> +       /* unbypass all the plls */
> +       clk_set_parent(clks[IMX8MQ_GPU_PLL_BYPASS], clks[IMX8MQ_GPU_PLL]);
> +       clk_set_parent(clks[IMX8MQ_VPU_PLL_BYPASS], clks[IMX8MQ_VPU_PLL]);
> +       clk_set_parent(clks[IMX8MQ_AUDIO_PLL1_BYPASS], clks[IMX8MQ_AUDIO_=
PLL1]);
> +       clk_set_parent(clks[IMX8MQ_AUDIO_PLL2_BYPASS], clks[IMX8MQ_AUDIO_=
PLL2]);
> +       clk_set_parent(clks[IMX8MQ_VIDEO_PLL1_BYPASS], clks[IMX8MQ_VIDEO_=
PLL1]);

Why? Can you just write the hardware registers directly instead of going
through the clk APIs during this clk registration routine? While it's
obviously easier to just call consumer APIs, it makes it weird because
this is a clk provider driver which 1) shouldn't use the consumer APIs
and 2) makes probe ordering and other things complicated to figure out.
Plus one more extra, it means that changing this code to use the clk_hw
APIs is harder.

> =20
>         /* PLL OUT GATE */
>         clks[IMX8MQ_ARM_PLL_OUT] =3D imx_clk_gate("arm_pll_out", "arm_pll=
_bypass", base + 0x28, 21);
