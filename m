Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936142AbeCSTjG convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 15:39:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031169AbeCSSV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 14:21:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152A2204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Jolly Shah <jolly.shah@xilinx.com>, linux-clk@vger.kernel.org,
        mark.rutland@arm.com, michal.simek@xilinx.com, mturquette@baylibre.com,
        robh+dt@kernel.org, sboyd@codeaurora.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1519856861-31384-2-git-send-email-jollys@xilinx.com>
Cc: rajanv@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jolly Shah <jolly.shah@xilinx.com>, Jolly Shah <jollys@xilinx.com>,
        Tejas Patel <tejasp@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
References: <1519856861-31384-1-git-send-email-jollys@xilinx.com>
 <1519856861-31384-2-git-send-email-jollys@xilinx.com>
Message-ID: <152148371542.242365.18433130635050412528@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/3] drivers: clk: Add clk_get_children support
Date: Mon, 19 Mar 2018 11:21:55 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jolly Shah (2018-02-28 14:27:39)
> From: Jolly Shah <jolly.shah@xilinx.com>
> 
> This API helps to determine the users for any clock.

Ok, but why do you need it?

> 
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> Signed-off-by: Tejas Patel <tejasp@xilinx.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  drivers/clk/clk.c            | 28 ++++++++++++++++++++++++++++
>  include/linux/clk-provider.h |  1 +
>  2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 0f686a9..947a18b 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -274,6 +274,34 @@ struct clk_hw *clk_hw_get_parent(const struct clk_hw *hw)
>  }
>  EXPORT_SYMBOL_GPL(clk_hw_get_parent);
>  
> +static unsigned int sibling;

Looks very thread unsafe!

> +
> +static void clk_show_subtree(struct clk_core *c,
> +                            int level)
> +{
> +       struct clk_core *child;
> +
> +       if (!c)
> +               return;
> +
> +       if (level == 1)
> +               sibling++;
> +
> +       hlist_for_each_entry(child, &c->children, child_node)
> +               clk_show_subtree(child, level + 1);
> +}
> +
> +unsigned int clk_get_children(char *name)
> +{
> +       struct clk_core *core;
> +       struct clk *pclk = __clk_lookup(name);
> +
> +       sibling = 0;
> +       core = pclk->core;
> +       clk_show_subtree(core, 0);
> +       return sibling;
> +}
> +
>  static struct clk_core *__clk_lookup_subtree(const char *name,
>                                              struct clk_core *core)
>  {
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index f711be6..e94dfb2 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -745,6 +745,7 @@ unsigned int __clk_get_enable_count(struct clk *clk);
>  unsigned long clk_hw_get_rate(const struct clk_hw *hw);
>  unsigned long __clk_get_flags(struct clk *clk);
>  unsigned long clk_hw_get_flags(const struct clk_hw *hw);
> +unsigned int clk_get_children(char *name);

And uses a string lookup instead of having the clk_hw pointer in hand.
No thanks.
