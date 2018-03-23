Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752481AbeCWQ5B convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 12:57:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752440AbeCWQ46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 12:56:58 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC7E2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Dong Aisheng <aisheng.dong@nxp.com>, linux-clk@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1521602391-30356-3-git-send-email-aisheng.dong@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, hdegoede@redhat.com, b.zolnierkie@samsung.com,
        linux@armlinux.org.uk, linux-fbdev@vger.kernel.org, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <1521602391-30356-1-git-send-email-aisheng.dong@nxp.com>
 <1521602391-30356-3-git-send-email-aisheng.dong@nxp.com>
Message-ID: <152182421754.178046.7553203878044979411@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V2 2/4] clk: add new APIs to operate on all available clocks
Date: Fri, 23 Mar 2018 09:56:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dong Aisheng (2018-03-20 20:19:49)
> @@ -50,6 +52,38 @@ static int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
>         return ret;
>  }
>  EXPORT_SYMBOL(of_clk_bulk_get);
> +
> +static int __must_check of_clk_bulk_get_all(struct device_node *np,
> +                                           struct clk_bulk_data **clks)
> +{
> +       struct clk_bulk_data *clk_bulk;
> +       int num_clks;
> +       int ret;
> +
> +       num_clks = of_clk_get_parent_count(np);
> +       if (!num_clks)
> +               return 0;
> +
> +       clk_bulk = kcalloc(num_clks, sizeof(*clk_bulk), GFP_KERNEL);

Can be kmalloc_array? of_clk_bulk_get() already clears things out
appropriately.

> +       if (!clk_bulk)
> +               return -ENOMEM;
> +
> +       ret = of_clk_bulk_get(np, num_clks, clk_bulk);
> +       if (ret) {
> +               kfree(clk_bulk);
> +               return ret;
> +       }
> +
> +       *clks = clk_bulk;
> +
> +       return num_clks;
> +}
> +#else
> +static int __must_check of_clk_bulk_get_all(struct device_node *np,
> +                                           struct clk_bulk_data **clks)
> +{
> +       return -ENOENT;
> +}
>  #endif

This else can probably be dropped too.

>  
>  void clk_bulk_put(int num_clks, struct clk_bulk_data *clks)
> @@ -90,6 +124,29 @@ int __must_check clk_bulk_get(struct device *dev, int num_clks,
>  }
>  EXPORT_SYMBOL(clk_bulk_get);
>  
> +void clk_bulk_put_all(int num_clks, struct clk_bulk_data *clks)
> +{
> +       if (IS_ERR_OR_NULL(clks))
> +               return;
> +
> +       clk_bulk_put(num_clks, clks);
> +
> +       kfree(clks);
> +}
> +EXPORT_SYMBOL(clk_bulk_put_all);
> +
> +int __must_check clk_bulk_get_all(struct device *dev,
> +                                 struct clk_bulk_data **clks)
> +{
> +       struct device_node *np = dev_of_node(dev);
> +
> +       if (!np)
> +               return 0;
> +
> +       return of_clk_bulk_get_all(np, clks);
> +}
> +EXPORT_SYMBOL(clk_bulk_get_all);

Looks better!
