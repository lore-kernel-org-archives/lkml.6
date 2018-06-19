Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A9DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EEB12083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EEB12083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937639AbeFSL20 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:28:26 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41929 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937396AbeFSL2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:28:24 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5F1C520799; Tue, 19 Jun 2018 13:28:22 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id F25B820734;
        Tue, 19 Jun 2018 13:28:11 +0200 (CEST)
Date:   Tue, 19 Jun 2018 13:28:11 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        linux-kbuild@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        "linux-stable #4 . 14+" <stable@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 1/3] mtd: rawnand: denali_dt: add more clocks based
 on IP datasheet
Message-ID: <20180619132811.45bf6454@bbrezillon>
In-Reply-To: <1529025532-22087-2-git-send-email-yamada.masahiro@socionext.com>
References: <1529025532-22087-1-git-send-email-yamada.masahiro@socionext.com>
        <1529025532-22087-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Fri, 15 Jun 2018 10:18:50 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> According to the Denali User's Guide, this IP needs three clocks:
> 
>  - clk: controller core clock
> 
>  - clk_x: bus interface clock
> 
>  - ecc_clk: clock at which ECC circuitry is run
> 
> Currently, denali_dt.c requires a single anonymous clock and its
> frequency.  However, the driver needs to get the frequency of "clk_x"
> not "clk".  This is confusing because people tend to assume the
> anonymous clock means the core clock.  In fact, I got a report of
> SOCFPGA breakage because the timing parameters are calculated based
> on a wrong frequency.
> 
> Instead of the cheesy implementation, the clocks in the real hardware
> should be represented in the driver and the DT-binding.
> 
> However, adding new clocks would break the existing platforms.  For the
> backward compatibility, the driver still accepts a single clock just as
> before.  If clk_x is missing, clk_x_rate is set to a hardcoded value.
> This is fine for existing DT of Socionext UniPhier, and also fixes the
> issue of Altera (Intel) SOCFPGA because both platforms use 200 MHz for
> the bus interface clock.
> 
> Fixes: 1bb88666775e ("mtd: nand: denali: handle timing parameters by setup_data_interface()")

Sorry for changing my mind, but I think this patch is doing more than
just fixing a bug. The bugfix should IMO be limited to unconditionally
setting ->clk_x_rate to 200000000 since this is what was done before
commit 1bb88666775e. And the remaining changes should go in nand/next.

Regards,

Boris

> Cc: linux-stable <stable@vger.kernel.org> #4.14+
> Reported-by: Richard Weinberger <richard@nod.at>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v3:
>   - Change the patch order so that the bug-fix one comes the first
> 
> Changes in v2:
>   - Split patches into sensible chunks
> 
>  .../devicetree/bindings/mtd/denali-nand.txt        |  5 +++
>  drivers/mtd/nand/raw/denali_dt.c                   | 49 ++++++++++++++++++++--
>  2 files changed, 50 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/denali-nand.txt b/Documentation/devicetree/bindings/mtd/denali-nand.txt
> index 0ee8edb..f33da87 100644
> --- a/Documentation/devicetree/bindings/mtd/denali-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/denali-nand.txt
> @@ -8,6 +8,9 @@ Required properties:
>    - reg : should contain registers location and length for data and reg.
>    - reg-names: Should contain the reg names "nand_data" and "denali_reg"
>    - interrupts : The interrupt number.
> +  - clocks: should contain phandle of the controller core clock, the bus
> +    interface clock, and the ECC circuit clock.
> +  - clock-names: should contain "nand", "nand_x", "ecc"
>  
>  Optional properties:
>    - nand-ecc-step-size: see nand.txt for details.  If present, the value must be
> @@ -31,5 +34,7 @@ nand: nand@ff900000 {
>  	compatible = "altr,socfpga-denali-nand";
>  	reg = <0xff900000 0x20>, <0xffb80000 0x1000>;
>  	reg-names = "nand_data", "denali_reg";
> +	clocks = <&nand_clk>, <&nand_x_clk>, <&nand_ecc_clk>;
> +	clock-names = "nand", "nand_x", "ecc";
>  	interrupts = <0 144 4>;
>  };
> diff --git a/drivers/mtd/nand/raw/denali_dt.c b/drivers/mtd/nand/raw/denali_dt.c
> index cfd33e6..ce6239d 100644
> --- a/drivers/mtd/nand/raw/denali_dt.c
> +++ b/drivers/mtd/nand/raw/denali_dt.c
> @@ -27,7 +27,9 @@
>  
>  struct denali_dt {
>  	struct denali_nand_info	denali;
> -	struct clk		*clk;
> +	struct clk *clk;	/* core clock */
> +	struct clk *clk_x;	/* bus interface clock */
> +	struct clk *clk_ecc;	/* ECC circuit clock */
>  };
>  
>  struct denali_dt_data {
> @@ -114,24 +116,61 @@ static int denali_dt_probe(struct platform_device *pdev)
>  	if (IS_ERR(denali->host))
>  		return PTR_ERR(denali->host);
>  
> -	dt->clk = devm_clk_get(&pdev->dev, NULL);
> +	/*
> +	 * A single anonymous clock is supported for the backward compatibility.
> +	 * New platforms should support all the named clocks.
> +	 */
> +	dt->clk = devm_clk_get(&pdev->dev, "nand");
> +	if (IS_ERR(dt->clk))
> +		dt->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(dt->clk)) {
>  		dev_err(&pdev->dev, "no clk available\n");
>  		return PTR_ERR(dt->clk);
>  	}
> +
> +	dt->clk_x = devm_clk_get(&pdev->dev, "nand_x");
> +	if (IS_ERR(dt->clk_x))
> +		dt->clk_x = NULL;
> +
> +	dt->clk_ecc = devm_clk_get(&pdev->dev, "ecc");
> +	if (IS_ERR(dt->clk_ecc))
> +		dt->clk_ecc = NULL;
> +
>  	ret = clk_prepare_enable(dt->clk);
>  	if (ret)
>  		return ret;
>  
> -	denali->clk_x_rate = clk_get_rate(dt->clk);
> +	ret = clk_prepare_enable(dt->clk_x);
> +	if (ret)
> +		goto out_disable_clk;
> +
> +	ret = clk_prepare_enable(dt->clk_ecc);
> +	if (ret)
> +		goto out_disable_clk_x;
> +
> +	if (dt->clk_x) {
> +		denali->clk_x_rate = clk_get_rate(dt->clk_x);
> +	} else {
> +		/*
> +		 * Hardcode the clock rates for the backward compatibility.
> +		 * This works for both SOCFPGA and UniPhier.
> +		 */
> +		dev_notice(&pdev->dev,
> +			   "necessary clock is missing. default clock rates are used.\n");
> +		denali->clk_x_rate = 200000000;
> +	}
>  
>  	ret = denali_init(denali);
>  	if (ret)
> -		goto out_disable_clk;
> +		goto out_disable_clk_ecc;
>  
>  	platform_set_drvdata(pdev, dt);
>  	return 0;
>  
> +out_disable_clk_ecc:
> +	clk_disable_unprepare(dt->clk_ecc);
> +out_disable_clk_x:
> +	clk_disable_unprepare(dt->clk_x);
>  out_disable_clk:
>  	clk_disable_unprepare(dt->clk);
>  
> @@ -143,6 +182,8 @@ static int denali_dt_remove(struct platform_device *pdev)
>  	struct denali_dt *dt = platform_get_drvdata(pdev);
>  
>  	denali_remove(&dt->denali);
> +	clk_disable_unprepare(dt->clk_ecc);
> +	clk_disable_unprepare(dt->clk_x);
>  	clk_disable_unprepare(dt->clk);
>  
>  	return 0;

