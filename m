Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23101ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09FC2083A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wqX4Wh3h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09FC2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbeJSDYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 23:24:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbeJSDYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 23:24:04 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EA6D21476;
        Thu, 18 Oct 2018 19:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539890496;
        bh=H+mBwA2ReuoBbN11cOj7/ExoCDTpjlqOL2a8gqdrhx4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wqX4Wh3hxAJebP3g5eCNizliUrLZQLE2rtaXzH1Yu3YDNABfOTeWLyMO2phSdHtMT
         RYUfRtHNjB6QNDm5wh4tEyhejJkEqMjiV16Aa989W26vGZcAKKxc2BVh0w/x/nfCSV
         SDQnWeA1T4IFmak4pvkD1IpS3VA62fylPZE3rCJ4=
Received: by mail-ed1-f51.google.com with SMTP id y19-v6so29296271edd.2;
        Thu, 18 Oct 2018 12:21:36 -0700 (PDT)
X-Gm-Message-State: ABuFfoir5yW+z0ObHzGEQI7xCvsVGuP7eNQkNQFo61fQAhYCUhsf7NWe
        qhQxSGe2fjJ9ZKQ/O7AW6/9XxbzQusvnfOPnqkE=
X-Google-Smtp-Source: ACcGV61zsraGJ/iBBXX0hkWR5RpISxJAhtAG4p0pObloAAdl8eq4NJYlDcSE1y5a7FJJpCBwFvdKfg58HxcLyYWUdjM=
X-Received: by 2002:a50:92fd:: with SMTP id l58-v6mr4363946eda.200.1539890494684;
 Thu, 18 Oct 2018 12:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <1467735814-23518-1-git-send-email-ricardo.ribalda@gmail.com> <1467735814-23518-11-git-send-email-ricardo.ribalda@gmail.com>
In-Reply-To: <1467735814-23518-11-git-send-email-ricardo.ribalda@gmail.com>
From:   Alan Tull <atull@kernel.org>
Date:   Thu, 18 Oct 2018 14:20:58 -0500
X-Gmail-Original-Message-ID: <CANk1AXRvJQtcmAysrkfAGurGUGVHSq55=8PZARGYsEZNv2zt0g@mail.gmail.com>
Message-ID: <CANk1AXRvJQtcmAysrkfAGurGUGVHSq55=8PZARGYsEZNv2zt0g@mail.gmail.com>
Subject: Re: [PATCH v5 8/8] clk: fixed-rate: Convert into a module platform driver
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     mturquette@baylibre.com, sboyd@codeaurora.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-clk@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 5, 2016 at 11:45 AM Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:

I've stumbled across a of_node_get/put imbalance that happens when the
fixed rate clock is added and deleted using device tree.  The cause is
that this driver calls of_clk_add_provider() when probed, but doesn't
call of_clk_del_provider() when removed.

It looks like a lot of clock drivers share that issue:

$ cd drivers/clk/
$ git grep -l of_clk_add_provider * | xargs grep -L of_clk_del_provider | wc -l
131

It should be a one line fix, but for many files.

I'm not a clock subsystem expert, so please let me know whether I'm
missing something here.

Thanks,
Alan

>
> Adds support for fixed-rate clock providers which have not been
> enabled via of_clk_init().
>
> This is required by Device trees overlays that introduce clocks
> providers.
>
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
>  drivers/clk/clk-fixed-rate.c | 69 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 65 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
> index 2edb39342a02..e64ba2315880 100644
> --- a/drivers/clk/clk-fixed-rate.c
> +++ b/drivers/clk/clk-fixed-rate.c
> @@ -15,6 +15,7 @@
>  #include <linux/io.h>
>  #include <linux/err.h>
>  #include <linux/of.h>
> +#include <linux/platform_device.h>
>
>  /*
>   * DOC: basic fixed-rate clock that cannot gate
> @@ -160,15 +161,16 @@ EXPORT_SYMBOL_GPL(clk_hw_unregister_fixed_rate);
>  /**
>   * of_fixed_clk_setup() - Setup function for simple fixed rate clock
>   */
> -void of_fixed_clk_setup(struct device_node *node)
> +struct clk *_of_fixed_clk_setup(struct device_node *node)
>  {
>         struct clk *clk;
>         const char *clk_name = node->name;
>         u32 rate;
>         u32 accuracy = 0;
> +       int ret;
>
>         if (of_property_read_u32(node, "clock-frequency", &rate))
> -               return;
> +               return ERR_PTR(-EIO);
>
>         of_property_read_u32(node, "clock-accuracy", &accuracy);
>
> @@ -176,9 +178,68 @@ void of_fixed_clk_setup(struct device_node *node)
>
>         clk = clk_register_fixed_rate_with_accuracy(NULL, clk_name, NULL,
>                                                     0, rate, accuracy);
> -       if (!IS_ERR(clk))
> -               of_clk_add_provider(node, of_clk_src_simple_get, clk);
> +       if (IS_ERR(clk))
> +               return clk;
> +
> +       ret = of_clk_add_provider(node, of_clk_src_simple_get, clk);
> +       if (ret) {
> +               clk_unregister(clk);
> +               return ERR_PTR(ret);
> +       }
> +
> +       return clk;
> +}
> +
> +void of_fixed_clk_setup(struct device_node *node)
> +{
> +       _of_fixed_clk_setup(node);
>  }
>  EXPORT_SYMBOL_GPL(of_fixed_clk_setup);
>  CLK_OF_DECLARE(fixed_clk, "fixed-clock", of_fixed_clk_setup);
> +
> +static int of_fixed_clk_remove(struct platform_device *pdev)
> +{
> +       struct clk *clk = platform_get_drvdata(pdev);
> +
> +       if (clk)
> +               clk_unregister_fixed_rate(clk);
> +
> +       return 0;
> +}
> +
> +static int of_fixed_clk_probe(struct platform_device *pdev)
> +{
> +       struct clk *clk;
> +
> +       /*
> +        * This function is not executed when of_fixed_clk_setup
> +        * succeeded.
> +        */
> +
> +       clk = _of_fixed_clk_setup(pdev->dev.of_node);
> +
> +       if (IS_ERR(clk))
> +               return PTR_ERR(clk);
> +
> +       platform_set_drvdata(pdev, clk);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id of_fixed_clk_ids[] = {
> +       { .compatible = "fixed-clock" },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, of_fixed_clk_ids);
> +
> +static struct platform_driver of_fixed_clk_driver = {
> +       .driver = {
> +               .name = "of_fixed_clk",
> +               .of_match_table = of_fixed_clk_ids,
> +       },
> +       .probe = of_fixed_clk_probe,
> +       .remove = of_fixed_clk_remove,
> +};
> +
> +builtin_platform_driver(of_fixed_clk_driver);
>  #endif
> --
> 2.8.1
>
