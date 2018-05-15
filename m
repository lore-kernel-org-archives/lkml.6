Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbeEOVxR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:53:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750748AbeEOVxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:53:15 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Dinh Nguyen <dinguyen@kernel.org>, linux-clk@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1525271313-24427-1-git-send-email-dinguyen@kernel.org>
Cc: dinguyen@kernel.org, mturquette@baylibre.com,
        linux-kernel@vger.kernel.org
References: <1525271313-24427-1-git-send-email-dinguyen@kernel.org>
Message-ID: <152642119396.237094.8796686281263472736@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/2] clk: socfpga: stratix10: use platform driver APIs
Date: Tue, 15 May 2018 14:53:13 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4FLrKtk029047

Quoting Dinh Nguyen (2018-05-02 07:28:32)
> +       struct resource *res;
>         void __iomem *base;
>  
> -       base = of_iomap(np, 0);
> -       if (!base) {
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       base = devm_ioremap_resource(dev, res);
> +       if (IS_ERR(base)) {
>                 pr_err("%s: failed to map clock registers\n", __func__);
> -               goto err;
> +               return ERR_CAST(base);
>         }
>  
> -       clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
> +       clk_data = devm_kzalloc(dev, sizeof(*clk_data), GFP_KERNEL);
>         if (!clk_data)
> -               goto err;
> +               return ERR_CAST(clk_data);

I had to make these ERR_PTR(-ENOMEM), but otherwise I applied this to
clk-next.
