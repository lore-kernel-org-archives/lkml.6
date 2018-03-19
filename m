Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030709AbeCSUbb convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:31:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030521AbeCSUbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 16:31:25 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED98620838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Rob Herring <robh+dt@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
        Stephen Boyd <sboyd@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <f1445b95864af04f1f90d3be96d0a485d1bb4560.1520327262.git.ryder.lee@mediatek.com>
Cc: Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Garlic Tseng <garlic.tseng@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
References: <cover.1520327262.git.ryder.lee@mediatek.com>
 <f1445b95864af04f1f90d3be96d0a485d1bb4560.1520327262.git.ryder.lee@mediatek.com>
Message-ID: <152149148431.242365.4625152577833480987@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v4 3/6] clk: mediatek: add audsys support for MT2701
Date: Mon, 19 Mar 2018 13:31:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ryder Lee (2018-03-06 01:09:28)
> +
> +static const struct of_device_id of_match_clk_mt2701_aud[] = {
> +       { .compatible = "mediatek,mt2701-audsys", },
> +       {}
> +};
> +
> +static int clk_mt2701_aud_probe(struct platform_device *pdev)
> +{
> +       struct clk_onecell_data *clk_data;
> +       struct device_node *node = pdev->dev.of_node;
> +       int r;
> +
> +       clk_data = mtk_alloc_clk_data(CLK_AUD_NR);
> +
> +       mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
> +                              clk_data);
> +
> +       r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +       if (r) {
> +               dev_err(&pdev->dev,
> +                       "could not register clock provider: %s: %d\n",
> +                       pdev->name, r);
> +
> +               return r;
> +       }

This fails to remove the clk provider when devm_of_platform_populate()
returns an error.

> +
> +       return devm_of_platform_populate(&pdev->dev);
> +}
> +
> +static struct platform_driver clk_mt2701_aud_drv = {
> +       .probe = clk_mt2701_aud_probe,
> +       .driver = {
> +               .name = "clk-mt2701-aud",
> +               .of_match_table = of_match_clk_mt2701_aud,
> +       },
> +};
> +
> +builtin_platform_driver(clk_mt2701_aud_drv);
