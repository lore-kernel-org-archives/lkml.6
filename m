Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752296AbeCWQxQ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 12:53:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751691AbeCWQxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 12:53:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF592177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Dong Aisheng <aisheng.dong@nxp.com>, linux-clk@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1521602391-30356-2-git-send-email-aisheng.dong@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, hdegoede@redhat.com, b.zolnierkie@samsung.com,
        linux@armlinux.org.uk, linux-fbdev@vger.kernel.org, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Russell King <linux@arm.linux.org.uk>
References: <1521602391-30356-1-git-send-email-aisheng.dong@nxp.com>
 <1521602391-30356-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <152182399342.178046.13139513462419815903@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V2 1/4] clk: bulk: add of_clk_bulk_get()
Date: Fri, 23 Mar 2018 09:53:13 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dong Aisheng (2018-03-20 20:19:48)
> diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c
> index 4c10456..4b357b2 100644
> --- a/drivers/clk/clk-bulk.c
> +++ b/drivers/clk/clk-bulk.c
> @@ -19,6 +19,38 @@
>  #include <linux/clk.h>
>  #include <linux/device.h>
>  #include <linux/export.h>
> +#include <linux/of.h>
> +
> +#if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)

Do we need these defines? of_clk_get() is a stub function when these
configs are false.

> +static int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
> +                                       struct clk_bulk_data *clks)
> +{
> +       int ret;
> +       int i;
> +
> +       for (i = 0; i < num_clks; i++)
> +               clks[i].clk = NULL;
> +
> +       for (i = 0; i < num_clks; i++) {
> +               clks[i].clk = of_clk_get(np, i);
> +               if (IS_ERR(clks[i].clk)) {
> +                       ret = PTR_ERR(clks[i].clk);
> +                       pr_err("%pOF: Failed to get clk index: %d ret: %d\n",
> +                              np, i, ret);
> +                       clks[i].clk = NULL;
> +                       goto err;
> +               }
> +       }
> +
> +       return 0;
> +
> +err:
> +       clk_bulk_put(i, clks);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL(of_clk_bulk_get);

It's static, so don't export it.
