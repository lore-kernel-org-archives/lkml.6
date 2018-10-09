Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9A0C65BD6
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49354213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="08yVeUgo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49354213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeJJEKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:10:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:40452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725748AbeJJEKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 00:10:54 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4E41213A2;
        Tue,  9 Oct 2018 20:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539118327;
        bh=Hkq7UK/xxfWcHd6VgR70r3z/I2A5gFw3W+VSCg8VF7Q=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=08yVeUgoYoQOPes9jWOTuNKvURFT/b3qWEjbbodFmuOXlRBdy/HaAF1w6fKeBaopb
         ywTljhguqAihYebqXeWz04bmM3xl2ZO1ll05ZFkko3qiXbYF3pZMdojTrZkgSGj/GF
         bHIQYjMMhb5pUbT9QxVsXk/TTYXS660rEOvCRKvs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <ba0d7d92-5ad9-2dcf-c5a5-21332df193f0@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1538654546-31204-1-git-send-email-tdas@codeaurora.org>
 <1538654546-31204-2-git-send-email-tdas@codeaurora.org>
 <153896666821.119890.13143150697797456341@swboyd.mtv.corp.google.com>
 <ba0d7d92-5ad9-2dcf-c5a5-21332df193f0@codeaurora.org>
Message-ID: <153911832719.119890.11984877060665330428@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v6] clk: qcom: Add lpass clock controller driver for SDM845
Date:   Tue, 09 Oct 2018 13:52:07 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-10-09 10:26:38)
> Hello Stephen,
> =

> On 10/8/2018 8:14 AM, Stephen Boyd wrote:
> > Quoting Taniya Das (2018-10-04 05:02:26)
> >> Add support for the lpass clock controller found on SDM845 based devic=
es.
> >> This would allow lpass peripheral loader drivers to control the clocks=
 to
> >> bring the subsystem out of reset.
> >> LPASS clocks present on the global clock controller would be registered
> >> with the clock framework based on the device tree flag. Also do not ga=
te
> >> these clocks if they are left unused.
> > =

> > Why not gate them? This statement states what the code is doing, not why
> > it's doing it which is the more crucial information that should be
> > described in the commit text. Also, please add a comment about it to the
> > code next to the flag.
> > =

> > I am concerned that it doesn't make any sense though, so probably it
> > shouldn't be marked as CLK_IGNORE_UNUSED and it's papering over some
> > other larger bug that needs to be fixed.
> > =

> =

> It does not have any bug, it is just that to access these lpass =

> registers we would need the GCC lpass registers to be enabled. I would =

> update the same in the commit text.
> =

> During clock late_init these clocks should not be accessed to check the =

> clock status as they would result in unclocked access. The client would =

> request these clocks in the correct order and it would not have any issue.
> =


That seems like the bug right there. If the LPASS registers can't be
accessed unless the clks in GCC are enabled then this driver needs to
turn the clks on before reading/writing registers. Marking the clks as
ignore unused is skipping around the real problem.

> =

> >>
> >> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> >> ---
> >> diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm8=
45.c
> >> index 08d593e..6379b8b 100644
> >> --- a/drivers/clk/qcom/gcc-sdm845.c
> >> +++ b/drivers/clk/qcom/gcc-sdm845.c
> >> @@ -3583,6 +3611,13 @@ static int gcc_sdm845_probe(struct platform_dev=
ice *pdev)
> >>          if (ret)
> >>                  return ret;
> >>
> >> +       if (!of_property_read_bool(pdev->dev.of_node, "qcom,lpass-prot=
ected")) {
> >> +               gcc_sdm845_clocks[GCC_LPASS_Q6_AXI_CLK] =3D
> >> +                       &gcc_lpass_q6_axi_clk.clkr;
> >> +               gcc_sdm845_clocks[GCC_LPASS_SWAY_CLK] =3D
> >> +                       &gcc_lpass_sway_clk.clkr;

For all intents and purposes could we not just mark these two as
CLK_IS_CRITICAL and then let the LPASS turn these on and off when it
cares (does it ever do so)? Or even just turn them on once in probe here
with direct register writes and then not care anymore to touch them
again? Or do we need to turn these clks on again later on when the
subsystem crashes to read/write the registers and cycle the clks back on
and off?

> >> +       }
> >> +
> >>          return qcom_cc_really_probe(pdev, &gcc_sdm845_desc, regmap);
> >>   }
> >>
> >> diff --git a/drivers/clk/qcom/lpasscc-sdm845.c b/drivers/clk/qcom/lpas=
scc-sdm845.c
> >> new file mode 100644
> >> index 0000000..f7b9b0f
> >> --- /dev/null
> >> +++ b/drivers/clk/qcom/lpasscc-sdm845.c
> >> +               },
> >> +       },
> >> +};
> >> +
> >> +static int lpass_clocks_sdm845_probe(struct platform_device *pdev, in=
t index,
> >> +                                    const struct qcom_cc_desc *desc)
> >> +{
> >> +       struct regmap *regmap;
> >> +       struct resource *res;
> >> +       void __iomem *base;
> >> +
> >> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, index);
> >> +       base =3D devm_ioremap_resource(&pdev->dev, res);
> >> +       if (IS_ERR(base))
> >> +               return PTR_ERR(base);
> >> +
> >> +       regmap =3D devm_regmap_init_mmio(&pdev->dev, base, desc->confi=
g);
> >> +       if (IS_ERR(regmap))
> >> +               return PTR_ERR(regmap);
> > =

> > If this happens again in the future we should move this into the
> > common.c file and let qcom_cc_probe_index() exist.
> > =

> =

> Yes, I agree, could submit a patch to add the new function and then =

> clean it up.

Ok, but please don't do anything now because we don't care yet.

