Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753775AbeEHA2Z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 20:28:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753525AbeEHA2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 20:28:23 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Taniya Das <tdas@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <a926924f-2033-acd6-67cb-210a5e487ebb@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1525428158-29147-1-git-send-email-tdas@codeaurora.org>
 <1525428158-29147-2-git-send-email-tdas@codeaurora.org>
 <152545267793.138124.15345698220033125655@swboyd.mtv.corp.google.com>
 <a926924f-2033-acd6-67cb-210a5e487ebb@codeaurora.org>
Message-ID: <152573930157.138124.12994299541712205183@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [v8] clk: qcom: clk-rpmh: Add QCOM RPMh clock driver
Date: Mon, 07 May 2018 17:28:21 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w480SUtN031897

Quoting Taniya Das (2018-05-07 03:48:06)
> Hello Stephen,
> 
> Could you please let me know your comments on the below.
> 
> On 5/4/2018 10:21 PM, Stephen Boyd wrote:
> > Quoting Taniya Das (2018-05-04 03:02:38)
> >> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> >> new file mode 100644
> >> index 0000000..944fe04
> >> --- /dev/null
> >> +++ b/drivers/clk/qcom/clk-rpmh.c
> >> @@ -0,0 +1,334 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> >> + */
> >> +
> >> +};
> >> +
> >> +struct clk_rpmh_desc {
> >> +       struct clk_hw **clks;
> >> +       size_t num_clks;
> >> +};
> > 
> > This could be replaced with the clk_hw_onecell_data struct and then the
> > only problem becomes the const part which seems pretty impossible to fix
> > at this point. One "workaround" is to memdup the structure. Ugh.
> > 
> 
> Will be okay, if I can the following?
> 
> _probe...
> {
>         struct clk_rpmh_desc *hw_desc_data;
>         ....
> 
>         hw_desc_data = kmemdup(desc, sizeof(*desc), GFP_KERNEL);
> 
>         ...
>         ret = devm_of_clk_add_hw_provider(&pdev->dev,     of_clk_rpmh_hw_get, 
> hw_desc_data);
>          ....
> 
> }
> 
> And also I fix the "getter" function.

I'd rather see the check for out of bounds number just go away, unless
that's helping something. The kmemdup() doesn't look good.
