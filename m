Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755904AbeCSWzZ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 18:55:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755731AbeCSWzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 18:55:23 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD0D204EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Amit Nischal <anischal@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1520493495-3084-2-git-send-email-anischal@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Nischal <anischal@codeaurora.org>
References: <1520493495-3084-1-git-send-email-anischal@codeaurora.org>
 <1520493495-3084-2-git-send-email-anischal@codeaurora.org>
Message-ID: <152150012178.254778.7302484360542115877@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 1/4] clk: qcom: Clear hardware clock control bit of RCG
Date: Mon, 19 Mar 2018 15:55:21 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Nischal (2018-03-07 23:18:12)
> For upcoming targets like sdm845, POR value of the hardware clock control
> bit is set for most of root clocks which needs to be cleared for software
> to be able to control. For older targets like MSM8996, this bit is reserved
> bit and having POR value as 0 so this patch will work for the older targets
> too. So update the configuration mask to take care of the same to clear
> hardware clock control bit.
> 
> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
> ---
>  drivers/clk/qcom/clk-rcg2.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> index bbeaf9c..e63db10 100644
> --- a/drivers/clk/qcom/clk-rcg2.c
> +++ b/drivers/clk/qcom/clk-rcg2.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (c) 2013, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2013, 2018, The Linux Foundation. All rights reserved.

It would be nice if lawyers over there could avoid forcing copyright
date updates when less than half the file changes.

>   *
>   * This software is licensed under the terms of the GNU General Public
>   * License version 2, as published by the Free Software Foundation, and
> @@ -42,6 +42,7 @@
>  #define CFG_MODE_SHIFT         12
>  #define CFG_MODE_MASK          (0x3 << CFG_MODE_SHIFT)
>  #define CFG_MODE_DUAL_EDGE     (0x2 << CFG_MODE_SHIFT)
> +#define CFG_HW_CLK_CTRL_MASK   BIT(20)
> 
>  #define M_REG                  0x8
>  #define N_REG                  0xc
> @@ -276,7 +277,7 @@ static int clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_tbl *f)
>         }
> 
>         mask = BIT(rcg->hid_width) - 1;
> -       mask |= CFG_SRC_SEL_MASK | CFG_MODE_MASK;
> +       mask |= CFG_SRC_SEL_MASK | CFG_MODE_MASK | CFG_HW_CLK_CTRL_MASK;
>         cfg = f->pre_div << CFG_SRC_DIV_SHIFT;
>         cfg |= rcg->parent_map[index].cfg << CFG_SRC_SEL_SHIFT;
>         if (rcg->mnd_width && f->n && (f->m != f->n))

Is there going to be a future patch to update the RCGs to indicate they
support hardware control or not?
