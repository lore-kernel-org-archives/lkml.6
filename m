Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968906AbeE3J22 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:28:28 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:38103 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750869AbeE3J2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:28:19 -0400
Date: Tue, 29 May 2018 17:13:32 +0100
From: Simon Horman <horms@verge.net.au>
To: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 2/5] crypto: ccree: better clock handling
Message-ID: <20180529161332.vqdtcbj54mel2tdk@verge.net.au>
References: <1527171551-21979-1-git-send-email-gilad@benyossef.com>
 <1527171551-21979-3-git-send-email-gilad@benyossef.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527171551-21979-3-git-send-email-gilad@benyossef.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 03:19:07PM +0100, Gilad Ben-Yossef wrote:
> Use managed clock handling, differentiate between no clock (possibly OK)
> and clock init failure (never OK) and correctly handle clock detection
> being deferred.
> 
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/crypto/ccree/cc_driver.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/ccree/cc_driver.c b/drivers/crypto/ccree/cc_driver.c
> index 6f93ce7..b266657 100644
> --- a/drivers/crypto/ccree/cc_driver.c
> +++ b/drivers/crypto/ccree/cc_driver.c
> @@ -190,6 +190,7 @@ static int init_cc_resources(struct platform_device *plat_dev)
>  	u64 dma_mask;
>  	const struct cc_hw_data *hw_rev;
>  	const struct of_device_id *dev_id;
> +	struct clk *clk;
>  	int rc = 0;
>  
>  	new_drvdata = devm_kzalloc(dev, sizeof(*new_drvdata), GFP_KERNEL);
> @@ -219,7 +220,24 @@ static int init_cc_resources(struct platform_device *plat_dev)
>  	platform_set_drvdata(plat_dev, new_drvdata);
>  	new_drvdata->plat_dev = plat_dev;
>  
> -	new_drvdata->clk = of_clk_get(np, 0);
> +	clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(clk))
> +		switch (PTR_ERR(clk)) {
> +		/* Clock is optional so this might be fine */
> +		case -ENOENT:
> +			break;
> +
> +		/* Clock not available, let's try again soon */
> +		case -EPROBE_DEFER:
> +			return -EPROBE_DEFER;
> +
> +		default:
> +			dev_err(dev, "Error getting clock: %ld\n",
> +				PTR_ERR(clk));
> +			return PTR_ERR(clk);
> +		}
> +	new_drvdata->clk = clk;
> +
>  	new_drvdata->coherent = of_dma_is_coherent(np);
>  
>  	/* Get device resources */
> -- 
> 2.7.4
> 
