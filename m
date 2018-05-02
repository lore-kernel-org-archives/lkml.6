Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752396AbeEBPaL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:30:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751917AbeEBPaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:30:05 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Taniya Das <tdas@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1525258277-3478-3-git-send-email-tdas@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
References: <1525258277-3478-1-git-send-email-tdas@codeaurora.org>
 <1525258277-3478-3-git-send-email-tdas@codeaurora.org>
Message-ID: <152527500426.138124.18419525952886399750@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: qcom: clk-rpmh: Add QCOM RPMh clock driver
Date: Wed, 02 May 2018 08:30:04 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w42FUFeY026027

Quoting Taniya Das (2018-05-02 03:51:17)
> +               ret = devm_clk_hw_register(&pdev->dev, hw_clks[i]);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "failed to register %s\n",
> +                                       hw_clks[i]->init->name);
> +                       goto err;
> +               }
> +
> +               rpmh_clk->dev = &pdev->dev;
> +       }
> +
> +       ret = devm_of_clk_add_hw_provider(&pdev->dev, of_clk_rpmh_hw_get,
> +                                     (void *) desc);

Drop the void cast.

> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed to add clock provider\n");
> +               goto err;
> +       }
> +
> +       dev_dbg(&pdev->dev, "Registered RPMh clocks\n");
> +
> +       return 0;
> +err:
> +       if (rpmh_client)
> +               rpmh_release(rpmh_client);
> +
> +       return ret;
> +}
> +
> +static int clk_rpmh_remove(struct platform_device *pdev)
> +{
> +       const struct clk_rpmh_desc *desc =
> +                       of_device_get_match_data(&pdev->dev);
> +       struct clk_hw **hw_clks = desc->clks;
> +       struct clk_rpmh *rpmh_clk = to_clk_rpmh(hw_clks[0]);
> +
> +       rpmh_release(rpmh_clk->rpmh_client);
> +
> +       return 0;
> +}

I'll review Lina's series again. Still hoping to drop the client thing.
