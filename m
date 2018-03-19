Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967018AbeCSQWX convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 12:22:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:56074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966924AbeCSQWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 12:22:18 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5DC2178C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Dong Aisheng <aisheng.dong@nxp.com>, linux-clk@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1516711841-25234-2-git-send-email-aisheng.dong@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, aisheng.dong@codeaurora.org,
        linux-fbdev@vger.kernel.org, yamada.masahiro@socionext.com,
        sboyd@codeaurora.org, hdegoede@redhat.com, b.zolnierkie@samsung.com,
        Dong Aisheng <aisheng.dong@nxp.com>
References: <1516711841-25234-1-git-send-email-aisheng.dong@nxp.com>
 <1516711841-25234-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <152147653725.242365.16805388526685631797@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [RFC PATCH 1/2] clk: add new APIs to operate on all available clocks
Date: Mon, 19 Mar 2018 09:22:17 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dong Aisheng (2018-01-23 04:50:40)
> This patch introduces of_clk_bulk_get_all and clk_bulk_x_all APIs
> to users who just want to handle all available clocks from device tree
> without need to know the detailed clock information likes clock numbers
> and names. This is useful in writing some generic drivers to handle clock
> part.
> 
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> ---
> A few question may need discuss:
> 1)  This patch is written based on of_clk_bulk_get.
> [V4,1/1] clk: bulk: add of_clk_bulk_get()
> https://patchwork.kernel.org/patch/9971527/
> Stepen once said we may not need it, but i guess as we already
> have clk_bulk_get, there may be guys who want of_clk_bulk_get as
> well if they need specify the clock count information, becaues
> of_clk_bulk_get_all will not check the count.
> And of_clk_bulk_get is also helpful when implementing
> of_clk_bulk_get_all.

Hmm ok. It's ok to implement it on top of of_clk_bulk_get I suppose, but
maybe that API can be kept private until someone can prove they need it
because they don't have a struct device pointer. Can you pick that patch
from the list and resend in the series?

> 
> 2) It only implements the DT type clk_get_all as i see
> Stephen said we probably may not need to implement non-dt
> type as there're still no users.

Good.

> 
> If we do want to implement non-dt type as well, we could revise
> the patch to add it too.
> ---
>  drivers/clk/clk-bulk.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/clk.h    | 61 ++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 124 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c
> index 1c1a79d..bac2aae 100644
> --- a/drivers/clk/clk-bulk.c
> +++ b/drivers/clk/clk-bulk.c
> @@ -17,9 +17,11 @@
>   */
>  
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>  #include <linux/device.h>
>  #include <linux/export.h>
>  #include <linux/of.h>
> +#include <linux/slab.h>
>  
>  #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
>  int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
> @@ -50,6 +52,45 @@ int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
>         return ret;
>  }
>  EXPORT_SYMBOL(of_clk_bulk_get);
> +
> +struct clk_bulk __must_check *of_clk_bulk_get_all(struct device_node *np)
> +{
> +       struct clk_bulk *clk_bulk;
> +       int num_clks;
> +       int ret;
> +
> +       num_clks = of_clk_get_parent_count(np);
> +       if (!num_clks)
> +               return NULL;
> +
> +       clk_bulk = kzalloc(sizeof(*clk_bulk) +
> +                          num_clks * sizeof(struct clk_bulk_data),
> +                          GFP_KERNEL);
> +       if (!clk_bulk)
> +               return ERR_PTR(-ENOMEM);
> +
> +       clk_bulk->num_clks = num_clks;
> +       ret = of_clk_bulk_get(np, clk_bulk->num_clks, clk_bulk->clks);
> +       if (ret) {
> +               kfree(clk_bulk);
> +               return ERR_PTR(ret);
> +       }

Has this been tested? clk_bulk->clks probably points to junk?

> +
> +       return clk_bulk;
> +}
> +EXPORT_SYMBOL(of_clk_bulk_get_all);
> +
> +void of_clk_bulk_put_all(struct clk_bulk *clk_bulk)
> +{
> +       if (IS_ERR_OR_NULL(clk_bulk))
> +               return;
> +
> +       clk_bulk_put(clk_bulk->num_clks, clk_bulk->clks);
> +
> +       kfree(clk_bulk->clks);
> +       kfree(clk_bulk);
> +}
> +EXPORT_SYMBOL(of_clk_bulk_put_all);
>  #endif

My goal was to make device drivers pass in their struct device to
clk_bulk_get_all() and then have that call into a private DT helper
function like of_clk_bulk_get_all(). With your patch 2 that could still
be done so let's go that direction?

>  
>  void clk_bulk_put(int num_clks, struct clk_bulk_data *clks)
> @@ -107,6 +148,12 @@ void clk_bulk_unprepare(int num_clks, const struct clk_bulk_data *clks)
>  }
>  EXPORT_SYMBOL_GPL(clk_bulk_unprepare);
>  
> +void inline clk_bulk_unprepare_all(const struct clk_bulk *clk_bulk)
> +{
> +       clk_bulk_unprepare(clk_bulk->num_clks, clk_bulk->clks);
> +}
> +EXPORT_SYMBOL_GPL(clk_bulk_unprepare_all);

Do we really need these _all APIs though?

> +
>  /**
>   * clk_bulk_prepare - prepare a set of clocks
>   * @num_clks: the number of clk_bulk_data
> @@ -139,6 +186,11 @@ int __must_check clk_bulk_prepare(int num_clks,
>  }
>  EXPORT_SYMBOL_GPL(clk_bulk_prepare);
>  
> +int inline __must_check clk_bulk_prepare_all(const struct clk_bulk *clk_bulk)

inline won't help much here. Maybe these wrappers should go into the
header file?

> +{
> +       return clk_bulk_prepare(clk_bulk->num_clks, clk_bulk->clks);
> +}
> +
>  #endif /* CONFIG_HAVE_CLK_PREPARE */
>  
>  /**
> @@ -158,6 +210,12 @@ void clk_bulk_disable(int num_clks, const struct clk_bulk_data *clks)
>  }
>  EXPORT_SYMBOL_GPL(clk_bulk_disable);
>  
> +void inline clk_bulk_disable_all(const struct clk_bulk *clk_bulk)

ditto

> +{
> +       return clk_bulk_disable(clk_bulk->num_clks, clk_bulk->clks);
> +}
> +EXPORT_SYMBOL_GPL(clk_bulk_disable_all);
> +
>  /**
>   * clk_bulk_enable - ungate a set of clocks
>   * @num_clks: the number of clk_bulk_data
> @@ -188,3 +246,9 @@ int __must_check clk_bulk_enable(int num_clks, const struct clk_bulk_data *clks)
>         return  ret;
>  }
>  EXPORT_SYMBOL_GPL(clk_bulk_enable);
> +
> +int inline __must_check clk_bulk_enable_all(const struct clk_bulk *clk_bulk)

again

> +{
> +       return clk_bulk_enable(clk_bulk->num_clks, clk_bulk->clks);
> +}
> +EXPORT_SYMBOL_GPL(clk_bulk_enable_all);
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 09ae760..ccafda1 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -92,6 +92,21 @@ struct clk_bulk_data {
>         struct clk              *clk;
>  };
>  
> +/**
> + * struct clk_bulk - bulk clk structure
> + *
> + * @num_clks: the number of avaliable clocks in this bulk
> + * @clks: struct clk_bulk_data * to store the associated clock
> + *
> + * The CLK APIs provide a series of clk_bulk_x_all() API calls as
> + * a convenience to consumers which require multiple clks.  This
> + * structure is used to manage data for these calls.
> + */
> +struct clk_bulk {
> +       int num_clks;
> +       struct clk_bulk_data *clks;
> +};

This could go away, and we could return the number of clks from
clk_bulk_get_all() as a positive number, 0 if there are none, and a
negative number if something failed. Then we don't need the _all
variants or a wrapper struct. It would be nice to avoid the extra
variants just because we need to tell it the number of clks to handle.
