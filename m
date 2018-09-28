Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A743C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33FF20779
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wj+yQNF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33FF20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbeI2BQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 21:16:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbeI2BQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 21:16:16 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07ADE20779;
        Fri, 28 Sep 2018 18:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538160670;
        bh=njgA11u1fE+U+6upKApf35uDlHDTGnG9sRrWf7wzz38=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Wj+yQNF3QZHhzA+R5+w34iap8uSmUeuBK0YLk4LuOzhwR0j2NLYAjhaBZkuRukiHV
         3fOY3ZEgXtGkCuq+7cEYzA/d3JJrsKBmXjoFkXEJsOqlIhW/nRn7GAIeF7Ze56B0Ly
         nb8aUF+UfLI8d0GKOtJbqfxMBXdDgTE0agsEkBGA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1537266338-18661-3-git-send-email-tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        Taniya Das <tdas@codeaurora.org>
References: <1537266338-18661-1-git-send-email-tdas@codeaurora.org>
 <1537266338-18661-3-git-send-email-tdas@codeaurora.org>
Message-ID: <153816066933.119890.2976485722156069351@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 2/2] clk: qcom: Add lpass clock controller driver for SDM845
Date:   Fri, 28 Sep 2018 11:51:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-09-18 03:25:38)
> @@ -3469,6 +3495,8 @@ enum {
>         [GCC_QSPI_CORE_CLK_SRC] =3D &gcc_qspi_core_clk_src.clkr,
>         [GCC_QSPI_CORE_CLK] =3D &gcc_qspi_core_clk.clkr,
>         [GCC_QSPI_CNOC_PERIPH_AHB_CLK] =3D &gcc_qspi_cnoc_periph_ahb_clk.=
clkr,
> +       [GCC_LPASS_Q6_AXI_CLK] =3D NULL,
> +       [GCC_LPASS_SWAY_CLK] =3D NULL,
>  };
>  =

>  static const struct qcom_reset_map gcc_sdm845_resets[] =3D {
> @@ -3583,6 +3611,13 @@ static int gcc_sdm845_probe(struct platform_device=
 *pdev)
>         if (ret)
>                 return ret;
>  =

> +       if (of_property_read_bool(pdev->dev.of_node, "qcom,lpass-protecte=
d")) {

Shouldn't this be negated? So that we only add the clks when lpass isn't
protected?

> +               gcc_sdm845_clocks[GCC_LPASS_Q6_AXI_CLK] =3D
> +                       &gcc_lpass_q6_axi_clk.clkr;
> +               gcc_sdm845_clocks[GCC_LPASS_SWAY_CLK] =3D
> +                       &gcc_lpass_sway_clk.clkr;
> +       }
> +
>         return qcom_cc_really_probe(pdev, &gcc_sdm845_desc, regmap);
